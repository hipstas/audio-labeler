# Audio Labeling Container
FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install Python
RUN apt-get install -y python-dev python-pip

# Add requirements.txt
ADD requirements.txt /webapp

# Install uwsgi Python web server
RUN pip install uwsgi
# Install app requirements
RUN pip install -r /webapp/requirements.txt

# Create app directory
ADD . /webapp

# Set the default directory for our environment
ENV HOME /webapp
WORKDIR /webapp

# Expose port 8000 for uwsgi
EXPOSE 8000

ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:app", "--processes", "1", "--threads", "8"]
