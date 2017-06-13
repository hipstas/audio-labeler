cd /home/audio_labeler/
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/app.py

mkdir -p media
mkdir -p templates
mkdir -p static

cd static
wget -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/static/style.css
cd /home/audio_labeler/templates
wget  -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_action.html
wget  -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_audio.html
wget  -N https://raw.githubusercontent.com/stevemclaugh/audio-labeling-container/master/templates/form_video.html
cd /home/audio_labeler/
python app.py
