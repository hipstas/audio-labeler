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


# Add requirements.txt
COPY requirements.txt /home/webapp

# Install app requirements
RUN pip install -r /home/webapp/requirements.txt

EXPOSE 8000

# Create app directory
ADD . /home/webapp

# Set the default directory for our environment
ENV HOME /home/webapp
WORKDIR /home/webapp

#ENTRYPOINT ["python", "/home/webapp/app.py"]
