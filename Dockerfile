FROM armv7/armhf-ubuntu:16.04
MAINTAINER Daniel Floris <daniel.floris@gmail.com>

RUN apt-get update

# dependencies
RUN apt-get install -y autoconf automake build-essential
RUN apt-get install -y libass-dev libfreetype6-dev \
  libtheora-dev libtool
RUN apt-get install -y libvorbis-dev pkg-config texinfo zlib1g-dev
  # Note: Server users can omit the ffplay and x11grab dependencies: libsdl2-dev libva-dev libvdpau-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev.

RUN mkdir /ffmpeg_sources

RUN apt-get install yasm -y

RUN apt-get install libx264-dev -y

RUN apt-get install libx265-dev -y

# RUN apt-get install libfdk-aac-dev -y

RUN apt-get install libvpx-dev -y

# RUN apt install curl -y --no-install-recommends
# ADD http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 /ffmpeg_sources
# ADD curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
RUN mkdir /root/ffmpeg_sources
COPY ThetaS_remap_files/ /
COPY ffmpeg-snapshot.tar.bz2 /root/ffmpeg_sources
# RUN ls -la /root
# RUN ls -la /root/ffmpeg_sources
# RUN ls -la /root/ffmpeg_sources/ffmpeg

WORKDIR /root/ffmpeg_sources
# RUN ls -la
RUN tar xjvf ffmpeg-snapshot.tar.bz2

# RUN sed -i '/REGISTER_FILTER(ZSCALE,         zscale,         vf)/a REGISTER_FILTER(PROJECTION, projection, vf);' /root/ffmpeg_sources/ffmpeg/libavfilter/allfilters.c

WORKDIR /root/ffmpeg_sources/ffmpeg

RUN PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  # --enable-libfdk-aac \
  --enable-libfreetype \
  # --enable-libmp3lame \
  # --enable-libopus \
  # --enable-libtheora \
  # --enable-libvorbis \
  # --enable-libvpx \
  # --enable-libx264 \
  # --enable-remap \
  # --enable-libx265 \
  --enable-nonfree
RUN PATH="$HOME/bin:$PATH" make && \
    make install && \
    hash -r
#
# COPY ThetaS_remap_files/ /
#
# WORKDIR ThetaS_remap_files
#
#
# # software-properties-common
# # RUN add-apt-repository ppa:jonathonf/ffmpeg-3
# # RUN apt update
# # # RUn apt list --upgradable
# # RUN apt install -y fontconfig-config=2.11.94-0ubuntu1.1
# # RUN apt install -y libfontconfig1
# # RUN apt install -y libass5
# # RUN apt install -y libbluray1
# # RUN apt install -y libavdevice-ffmpeg56 libavfilter-ffmpeg5 libavformat-ffmpeg56 libffms2-4
# # RUN apt install -y ffmpeg libav-tools x264 x265
# #
# # RUN apt install -y bzip2
# # RUN apt install -y v4l-utils
# # RUN apt-get install libjpeg8-dev imagemagick libv4l-dev -y
# # RUN ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
