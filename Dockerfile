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
&& python -m pip install -U pip \
&& pip install -U \
Flask \
Jinja2 \
unicodecsv

WORKDIR /home/audio_labeler

RUN cd /home/audio_labeler/ \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/app.py \
&& mkdir static \
&& cd static \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/style.css \
&& mkdir ../templates \
&& mkdir static/media

RUN cd /home/audio_labeler/templates \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_action.html \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_audio.html \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_video.html


ENV SHELL /bin/bash

CMD python app.py
