# Audio Labeling Container
FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8000
ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y \
python-dev \
python-pip \
git \
&& python -m pip install -U pip \
&& pip install -U \
Flask \
Jinja2

# Set the default directory for our environment
ENV SHELL /bin/bash
WORKDIR /webapp

CMD cd /webapp/ \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/app.py \
&& mkdir static \
&& cd static \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/style.css \
&& mkdir ../templates \
&& cd ../templates \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_action.html \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_audio.html \
&& wget https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_video.html
