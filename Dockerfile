# Audio Labeling Container
FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8000 8484

ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Update OS
RUN apt-get update && apt-get install -y \
python-dev \
python-pip \
wget \
git \
python-numpy-dev \
python-numpy \
python-yaml \
&& python -m pip install -U pip \
&& pip install -U \
Flask \
Jinja2 \
unicodecsv \
numpy \
pygame

# Install FFmpeg with mp3 support
RUN add-apt-repository -y ppa:mc3man/trusty-media \
 && apt-get update -y \
 && apt-get install -y ffmpeg gstreamer0.10-ffmpeg

WORKDIR /home/audio_labeler
ENV SHELL /bin/bash

ADD setup.sh /home/audio_labeler/

ENTRYPOINT bash /home/audio_labeler/setup.sh
