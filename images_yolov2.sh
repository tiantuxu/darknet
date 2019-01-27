# batch processing all imgs under a dir. output annotate images to another dir

ls -1 data/*.jpg | \
./darknet detector test  \
    cfg/coco.data ./cfg/yolov2.cfg ./yolov2.weights \
        -dont_show -prediction_filename "/tmp/out" 



