input=/home/xzl/videos/jackson.mp4
output=/tmp/input.rgb
dboutput=/home/xzl/videos/db-jpg/

# output raw
ffmpeg \
-c:v h264_cuvid \
-i ${input} -c:v rawvideo \
-pix_fmt rgb24 \
-r 0.1 \
-vf scale=100:100 \
${output}

# raw to stdout
ffmpeg \
-c:v h264_cuvid \
-i ${input} -c:v rawvideo \
-pix_fmt rgb24 \
-r 0.1 \
-vf scale=100:100 \
-f rawvideo - \
> ${output}

ffplay \
-f rawvideo \
-pixel_format rgb24 \
-video_size 100x100 \
-i ${output}

# pipe to ffplay
ffmpeg -c:v h264_cuvid -i ${input} -c:v rawvideo -pix_fmt rgb24 -r 0.1 -vf \
    scale=100:100 -f rawvideo - | ffplay \
-f rawvideo \
-pixel_format rgb24 \
-video_size 100x100 \
-i - 

# pipe to my prog
export width=608
export height=608
ffmpeg -c:v h264_cuvid -i ${input} -c:v rawvideo -pix_fmt rgb24 -r 1 -vf \
    scale=608:608 -f rawvideo - | \
./test-db-build.bin  --raw -v - -d ${dboutput} -w ${width} -h ${height}

#output jpgs

ffmpeg \
-c:v h264_cuvid \
-i ${input} \
-vf fps=1/300 \
-r .1 \
-vf scale=608:608 \
${output} \
~/videos/jpgs/img%07d.jpg

img=jcjimenez/darknet-docker:gpu-latest
docker run \
--runtime=nvidia \
-it \
--volume /home/xzl/videos:/root/data \
--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
--volume /media/xzl/WD-BLK-1TB/:/root/WD-BLK-1TB \
${img} \
bash

#db_path=/tmp/db
db_path=/root/data/db-jpg
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights \
-dont_show -ext_output \
${db_path}

# --- debugging
cgdb ./darknet

r detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights \
-dont_show -ext_output \
/root/data/db
