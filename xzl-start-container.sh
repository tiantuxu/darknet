# launch docker. use this to compile
#img=jcjimenez/darknet-docker:gpu-latest
img=xzl-darknet:latest
docker run \
    --runtime=nvidia \
    -it --rm \
    --volume /data/videos:/data/videos \
    --volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
    --volume /media/xzl/WD-BLK-1TB/:/root/WD-BLK-1TB \
    ${img} \
    bash
