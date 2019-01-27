

./darknet detector test  \
    cfg/coco.data ./cfg/yolov2.cfg ./yolov2.weights \
        -dont_show -prediction_filename myoutput \
    data/dog.jpg -i 0 -thresh 0.2



