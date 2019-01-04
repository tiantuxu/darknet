input=/home/xzl/videos/jackson.mp4
output=/tmp/input.rgb

ffmpeg \
-c:v h264_cuvid \
-i ${input} -c:v rawvideo \
-pix_fmt rgb24 \
-r 0.1 \
-vf scale=100:100 \
${output}

ffplay \
-f rawvideo \
-pixel_format rgb24 \
-video_size 100x100 \
-i ${output}

img=jcjimenez/darknet-docker:gpu-latest
docker run \
--runtime=nvidia \
-it \
--volume /home/xzl/videos:/root/data \
--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
--volume /media/xzl/WD-BLK-1TB/:/root/WD-BLK-1TB \
${img} \
bash

db_path=/tmp/db
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights \
-dont_show -ext_output \
${db_path}

