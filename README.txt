Preparing Videos and decode to images
Transcode & Take out 10 min video sample (Optional)
$ ffmpeg -c:v h264_cuvid -i input.mp4 -ss 00:00:00 -t 00:10:00 -vf scale=608:608 -c:v h264_nvenc output.mp4


Decode to images
$ ffmpeg -i input.mp4 ./path/to/images/%7d.jpg 

Generate filename lists, and the text file will be in ./data/train.txt:
Remember to change path to images in generate-name.py
$ python genearte-name.py

Run it!
https://github.com/pjreddie/darknet/issues/723
Can change to all availble cfg under./cfg
$ ./darknet detector test cfg/imagenet22k.dataset cfg/yolov3.cfg yolov3.weights -dont_show -ext_output < data/train.txt > result.txt

Inference results is in result.txt
