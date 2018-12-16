# YOLOv2 & YOLOv3 for Consecutive Video Streams

### Requiremets: 
* **Linux GCC>=4.9**
* **CUDA >= 7.5**
* **CuDNN >= 5.1**
* **OpenCV 3.3.0**
* **ffmpeg (with NVIDIA Support)**: https://developer.nvidia.com/ffmpeg

### Build
```
$ export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}} 
$ export LD_LIBRARY_PATH=/usr/local/cuda8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
$ make
```
### Get YOLO weights
Download [YOLOv2](https://pjreddie.com/media/files/yolov2.weights) or
[YOLOv3](https://pjreddie.com/media/files/yolov3.weights) weights

### Video Preparation
Preparing Videos and decode to images: Transcode to 608x608 & Take out 10 min video sample (Optional)
```
$ ffmpeg -c:v h264_cuvid -i input.mp4 -ss 00:00:00 -t 00:10:00 -vf scale=608:608 -c:v h264_nvenc output.mp4
```

### Image Generation
Decode and save as images, with filenames defined in frame sequences
```
$ ffmpeg -i input.mp4 ./path/to/images/%7d.jpg 
```
Generate filename lists, and the text file will be in ./data/train.txt; Remember to change path to images in generate-name.py
```
$ python genearte-name.py
```

### Run it!
Note: Can change to all availble cfg under./cfg
```
$ ./darknet detector test cfg/imagenet22k.dataset cfg/yolov3.cfg yolov3.weights -dont_show -ext_output < data/train.txt > result.txt
```

### Inference results is in result.txt
