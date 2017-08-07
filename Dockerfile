# Audio Labeling Container
FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8000 8484

ENV SHELL /bin/bash
ENV PYTHONWARNINGS="ignore:a true SSLContext object"

COPY ./setup.sh /home/
RUN mkdir -p /home/audio_labeler/

# Update OS
RUN apt-get update && apt-get install -y \
software-properties-common \
build-essential \
python-dev \
python-pip \
wget \
git \
python-numpy-dev \
python-numpy \
python-yaml \
python-pygame \
gunicorn \
&& python -m pip install -U pip \
&& pip install -U \
setuptools \
Flask \
Jinja2 \
unicodecsv \
numpy \
pandas \
moviepy \
pydub

# Install FFmpeg with mp3 support
RUN add-apt-repository -y ppa:mc3man/trusty-media \
 && apt-get update -y \
 && apt-get install -y ffmpeg gstreamer0.10-ffmpeg

COPY ./wsgi.py /home/audio_labeler/
COPY ./app.py /home/
COPY ./wsgi.py /home/

WORKDIR /home/audio_labeler/
ENTRYPOINT ["bash","/home/setup.sh"]
