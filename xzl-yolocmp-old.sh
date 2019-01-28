#!/bin/bash

# Run this script from dbpath where data.mdb is

# this is silly because each start of darknet is slow. 
# however it works with stock darknet out of box...

# BUG: predictions.jpg may cause race condition

#dbdir=/data/videos/youtube/reef/db/reef-2019-01-24-14.54.02.done
#prefix=reef # used for output dir, etc

#dbdir=/data/videos/youtube/calgary/db/calgary-2019-01-24-15.09.35.done
#prefix=calgary

#dbdir=/data/videos/youtube/beach/db/beach-2019-01-24-14.49.26.done
#prefix=beach

#dbdir=/data/videos/youtube/calgary-1088/db/calgary-2019-01-24-15.09.35.done
#prefix=calgary-1088

#dbdir=/data/videos/youtube/calgary-pm/db/calgary-pm-2019-01-25-18.02.13.done
#prefix=calgary-pm

#imgdir=/tmp/img-${prefix}
#resdir=/tmp/res-${prefix}

dbdir=${PWD}
imgdir=${PWD}/img
resdir=${PWD}/res

N=20 # number of imgs to sample

# static config
darknet=/home/xzl/darknet # darknet *path*. stock is fine

mkdir -p ${imgdir} ${resdir}
rm -rf ${imgdir}/* ${resdir}/*

# sample images from db...
/data/xzl/video-streamer/src/micro/lmdb-img-dumper.bin \
    -v ${imgdir} -d ${dbdir} \
    -s ${N}

# yolov3. expensive
#cd ${darknet}
#for f in ${imgdir}/*.jpg; do
#    ./darknet detector test cfg/coco.data cfg/yolov3-1088.cfg yolov3.weights $f
#    mv predictions.jpg ${resdir}/"$(basename "$f" .jpg)-yolov3.jpg"
#done
#cd -

cd ${darknet}
for f in ${imgdir}/*.jpg; do
    ./darknet detector test cfg/coco.data cfg/yolov3-tiny-1088.cfg yolov3-tiny.weights $f
    mv predictions.jpg ${resdir}/"$(basename "$f" .jpg)-yolov3tiny.jpg"
done
cd -

cd ${darknet}
for f in ${imgdir}/*.jpg; do
    ./darknet detector test cfg/coco.data cfg/yolov2-1088.cfg yolov2.weights $f
    mv predictions.jpg ${resdir}/"$(basename "$f" .jpg)-yolov2.jpg"
done
cd -
