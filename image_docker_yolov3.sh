# from outside of a container ...
img=xzl-darknet:latest
docker run \
--runtime=nvidia \
-it \
--rm \
--volume /data/videos:/data/videos \
--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
-w /root/darknet-tiantu \
${img} \
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights \
    -dont_show -prediction_filename myoutput\
    data/dog.jpg -i 0 -thresh 0.25

