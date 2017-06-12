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
ADD . /home/webapp

# Add requirements.txt
COPY requirements.txt /home/webapp

# Install uwsgi Python web server
#RUN pip install uwsgi

# Install app requirements
RUN pip install -r /home/webapp/requirements.txt

# Set the default directory for our environment
ENV HOME /home/webapp
WORKDIR /home/webapp

ENTRYPOINT ["python", "/home/webapp/app.py"]

EXPOSE 8000

#ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:app", "--processes", "1", "--threads", "8"]
