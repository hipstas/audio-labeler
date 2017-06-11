# Audio Labeling Container

FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8080
ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Install dependencies
RUN apt-get update && apt-get install -y \
 wget \
 git \
 software-properties-common \
 build-essential \
 zip \
 unzip \
 python2.7 \
 python-pip \
 python-dev \
 npm \
 && python -m pip install -U pip \
 && pip install -U \
 setuptools \
 pyOpenSSL \
 ndg-httpsclient \
 requests \
 unicodecsv \
 numpy \
 pandas \
 matplotlib \
 pathlib \
 pygame

# Install FFmpeg with mp3 support
#RUN add-apt-repository -y ppa:mc3man/trusty-media \
# && apt-get update -y \
# && apt-get install -y ffmpeg gstreamer0.10-ffmpeg

# Configure container startup
ENV SHELL /bin/bash
WORKDIR /home/audio_labeling_shared
