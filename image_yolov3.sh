

./darknet detector test ./cfg/coco.data ./cfg/yolov3.cfg ./yolov3.weights \
    -dont_show -prediction_filename myoutput\
    data/dog.jpg -i 0 -thresh 0.25



