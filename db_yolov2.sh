
./darknet detector test  \
    cfg/coco.data ./cfg/yolov2.cfg ./yolov2.weights \
        -dont_show -prediction_filename "/tmp/out" \
    -n_db_samples 10 \
    /home/xzl/videos/db-eagle/eagle2.done



