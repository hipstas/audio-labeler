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
ENV SHELL /bin/bash

ADD setup.sh /home/audio_labeler/

ENTRYPOINT bash /home/audio_labeler/setup.sh
