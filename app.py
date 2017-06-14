# We need to import request to access the details of the POST request
# and render_template, to render our templates (form and response)
# we'll use url_for to get some URLs for the app on the templates
from flask import Flask, render_template, request, url_for
import unicodecsv
import random
import os
import thread
import subprocess
import glob
import fnmatch
from moviepy.audio.io import AudioFileClip
#from pydub import AudioSegment
import timeit

os.chdir('/home/audio_labeler/')


## Returns duration of any media file using ffprobe
def media_duration(media_path):
    return float(subprocess.check_output(['ffprobe', '-v', 'quiet', '-of', 'csv=p=0', '-show_entries', 'format=duration', media_path]).strip())

## Creating a list of file IDs in the "clips" directory
#complete_clip_ids = list(set([item.split('____')[0] for item in os.listdir('clips') if '____' in item]))


## Creating a list of every media file in the "media" directory

media_paths=[]

for root, dirnames, filenames in os.walk('/home/audio_labeler/media'):
    for filename in fnmatch.filter(filenames, '*'):
        media_paths.append(os.path.join(root, filename))

media_paths = [item for item in media_paths if item.lower()[-4:] in ('.mp3','.mp4','.wav')]

# Initialize the Flask application
app = Flask(__name__)
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

# Define a route for the default URL, which loads the form
@app.route('/',methods=['POST','GET'])
def form():
    ## Dealing with form data from the last round, if applicable
    try:
        classname=request.form['classname']
        if request.form['button'] == 'Apply Label':
            write_classname = classname
        else:
            write_classname = request.form['button']
        audio_file_id=request.form['audio_file_id']
        start_time=request.form['start_time']
        with open('/home/audio_labeler/output_table.csv','a') as fo:
            label_duration = 1
            fo.write(audio_file_id+',')
            fo.write(str(float(start_time))+',')
            fo.write(str(float(label_duration))+',')
            fo.write('''"''' + write_classname + '''"\n''')
    except:
        classname=''

    ## Launching new round
    #audio_filename=random.choice([item for item in os.listdir('/home/audio_labeler/clips') if item[-4:].lower() in ('.mp3','.wav','.mp4')])
    media_path = random.choice(media_paths)
    audio_file_id = media_path.split('/')[-1][:-4]
    duration = media_duration(media_path)
    start_time = int((random.random()*duration))-5
    snd = AudioFileClip.AudioFileClip(media_path)
    snd.subclip(start_time,start_time+5).write_audiofile('/home/audio_labeler/static/temp.wav')
    response = render_template('form_audio.html', audio_file_id=audio_file_id, start_time=start_time, classname=classname)
    response.headers['X-UA-Compatible'] = 'IE=Edge,chrome=1'
    response.headers['Cache-Control'] = 'public, max-age=0'
    return response


# Run the app
if __name__ == '__main__':
    app.run(threaded=True,
        host="0.0.0.0",
        port=int("8000")
    )
