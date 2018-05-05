# rover-ffmpegberry

docker build -t ffberry .

/root/ffmpeg_sources/ffmpeg/ffmpeg -i fisheye_grid_input.jpg -i fisheye_grid_xmap.pgm -i fisheye_grid_ymap.pgm -lavfi remap out.png

docker run -it ffmpeg bash

docker run -it --device=/dev/bus/usb/`lsusb | grep Ricoh|awk {'print $2'}`/`lsusb | grep Ricoh|awk {'print $4'}|sed 's/:$//'` -p 8080:8080 --cap-add=ALL --privileged -v /lib/modules:/lib/modules -v=/dev:/dev -v /my_projects_repo/rover-ffmpegberry/temp:/temp ffmpeg bash

# Stream camera

docker run -it --device=/dev/bus/usb/`lsusb | grep Ricoh|awk {'print $2'}`/`lsusb | grep Ricoh|awk {'print $4'}|sed 's/:$//'` --cap-add=ALL --privileged -v /lib/modules:/lib/modules -v=/dev:/dev localffmpeg bash

/root/bin/ffmpeg -f v4l2 -i /dev/video0 <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -preset medium -crf 26 -threads 0 <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -vb 150000 -g 60 -vprofile baseline -level 2.1 -acodec aac -ab 64000 -ar 48000 -ac 2 -vbsf h264_mp4toannexb -strict experimental -f mpegts <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -vb 150000 -g 60 -vprofile baseline -level 2.1 -vbsf h264_mp4toannexb -strict experimental -f mpegts <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -vb 150000 -g 60 -vprofile baseline -level 2.1 -vbsf h264_mp4toannexb -strict experimental <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -vb 150000 -g 60 -level 2.1 -vbsf h264_mp4toannexb -strict experimental <http://192.168.2.6:8090/feed1.ffm>

/root/bin/ffmpeg -re -f video4linux2 -r 15 -i /dev/video0 -vcodec libx264 -vb 150000 -g 60 -level 2.1 -vbsf h264_mp4toannexb -strict experimental -codec copy <http://192.168.2.6:8090/feed1.ffm>

# ffserver

docker run -it -v /my_project_repos/rover-ffmpegberry/ffserver:/my -p 8090:8090 localffmpeg bash

/root/bin/ffserver -f /my/server.conf -loglevel debug
