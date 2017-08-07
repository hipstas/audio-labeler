#!/bin/bash

cd /home/audio_labeler/
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/app.py

mkdir -p media
mkdir -p templates
mkdir -p static/wavesurfer
mkdir -p static/output

cd static
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/style.css

cd /home/audio_labeler/templates
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_action.html
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_audio.html
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_video.html

cd /home/audio_labeler/static/wavesurfer
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/app.css
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/app.js
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/ribbon.css
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/style.css
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/wavesurfer.min.js
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/wavesurfer.minimap.min.js
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/wavesurfer.regions.js
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/wavesurfer.regions.min.js
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/wavesurfer/wavesurfer.timeline.min.js

cd /home/audio_labeler/
python app.py
#gunicorn --workers 10 --bind 0.0.0.0:80 wsgi
