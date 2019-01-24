#!/bin/bash

# this is silly because each start of darknet is slow. 
# however it works with stock darknet out of box...

inputdir=/tmp/out
outputdir=/tmp/res

for f in ${inputdir}/*.jpg; do
    ./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights $f
    mv predictions.jpg ${outputdir}/"$(basename "$f" .jpg)-yolov3.jpg"
done


for f in ${inputdir}/*.jpg; do
    ./darknet detector test cfg/coco.data cfg/yolov3-tiny.cfg yolov3-tiny.weights $f
    mv predictions.jpg ${outputdir}/"$(basename "$f" .jpg)-yolov3tiny.jpg"
done

