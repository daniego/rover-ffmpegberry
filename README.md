# rover-ffmpegberry

docker build -t ffberry .

/root/ffmpeg_sources/ffmpeg/ffmpeg -i fisheye_grid_input.jpg -i fisheye_grid_xmap.pgm -i fisheye_grid_ymap.pgm -lavfi remap out.png

docker run -it ffmpeg bash

docker run -it --device=/dev/bus/usb/`lsusb | grep Ricoh|awk {'print $2'}`/`lsusb | grep Ricoh|awk {'print $4'}|sed 's/:$//'` -p 8080:8080 --cap-add=ALL --privileged -v /lib/modules:/lib/modules -v=/dev:/dev -v /my_projects_repo/rover-ffmpegberry/temp:/temp ffmpeg bash
