# Audio Labeling Container
FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y \
python-dev \
python-pip \
git

# Create app directory
ADD . /webapp

# Add requirements.txt
COPY requirements.txt /webapp

# Install uwsgi Python web server
RUN pip install uwsgi

# Install app requirements
RUN pip install -r /webapp/requirements.txt

# Set the default directory for our environment
ENV HOME /webapp
WORKDIR /webapp

CMD git clone https://github.com/stevemclaugh/audio-labeling-container.git
CMD python audio-labeling-container/app.py


#ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:app", "--processes", "1", "--threads", "8"]
