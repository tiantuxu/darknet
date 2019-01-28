
./darknet detector test  \
    cfg/coco.data ./cfg/yolov3-1088.cfg ./yolov3.weights \
        -dont_show -prediction_filename "/tmp/out" \
    -n_db_samples 10 \
	/data/videos/youtube/calgary-pm/db/calgary-pm-2019-01-25-18.02.13.done



