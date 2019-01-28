#!/bin/bash

# Run this script from dbpath where data.mdb is

# this is silly because each start of darknet is slow. 
# however it works with stock darknet out of box...

dbdir=${PWD}
#resdir=/home/xzl/Dropbox/_Huge_Media_Files_/yolo/
resdir=${PWD}

resdir=${resdir}/`basename ${PWD}`-res/

videodir=/mnt/gpubox/media/teddyxu/WD-4TB/xzl/videos

N=20 # number of imgs to sample

# static config
darknet=/home/xzl/darknet-tiantu # darknet *path*. stock is fine

mkdir -p ${resdir}
rm -rf ${resdir}/*

# yolov3. expensive. in GPU container
#img=xzl-darknet:latest
#docker run \
#--runtime=nvidia \
#-it \
#--rm \
#--volume /data/videos:/data/videos \
#--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
#-w /root/darknet-tiantu \
#${img} \
#./darknet detector test cfg/coco.data cfg/yolov3-1088.cfg yolov3.weights \
#    -dont_show -prediction_filename "${resdir}/yolov3-" \
#    -n_db_samples $N \
#    ${dbdir}
    

# yolov2. in GPU container
img=xzl-darknet:latest
docker run \
--runtime=nvidia \
-it \
--rm \
--volume /mnt/gpubox/media/teddyxu/WD-4TB/xzl/videos:/data/videos \
--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
-w /root/darknet-tiantu \
${img} \
./darknet detector test cfg/coco.data cfg/yolov2-1088.cfg yolov2.weights \
    -dont_show -prediction_filename "${resdir}/yolov2" \
    -n_db_samples $N \
    ${dbdir}


# yolov3-tiny. in GPU container
img=xzl-darknet:latest
docker run \
--runtime=nvidia \
-it \
--rm \
--volume /mnt/gpubox/media/teddyxu/WD-4TB/xzl/videos:/data/videos \
--volume /home/xzl/darknet-tiantu/:/root/darknet-tiantu \
-w /root/darknet-tiantu \
${img} \
./darknet detector test cfg/coco.data cfg/yolov3-tiny-1088.cfg yolov3-tiny.weights \
    -dont_show -prediction_filename "${resdir}/yolov3tiny" \
    -n_db_samples $N \
    ${dbdir}
    

# add annotation 
for m in yolov2 yolov3tiny; do
    for f in ${resdir}/$m-*.jpg; do
        echo "annotate $f"
        convert -font helvetica -fill yellow -pointsize 36 -draw "text 15,50 '$m'" $f $f.out
        mv -f $f.out $f # overwrite the old one
    done
done

# stitich them ...
# https://stackoverflow.com/questions/20075087/how-to-merge-images-in-command-line
# convert image1.png image2.png image3.png -append result/result-sprite.png
# convert yolov2-1.jpg yolov3tiny-1.jpg -append result.jpg
# add text
# convert -font helvetica -fill blue -pointsize 36 -draw "text 15,50 '$TEXT'" image1.jpg image2.jpg

# XXX stitch very ad hoc
for f in ${resdir}/yolov2-*.jpg; do
    b=`basename $f .jpg`
    id=$(echo $b | sed 's/yolov2-//g')
    echo "combine results for $id"     # e.g. 181
    convert ${resdir}/yolov2-$id.jpg ${resdir}/yolov3tiny-$id.jpg +append ${resdir}/combined-$id.jpg
done

# XXX clean images? 
for m in yolov2 yolov3tiny; do
    rm -f ${resdir}/$m-*.jpg; 
done

# xdg-open ${resdir} &


