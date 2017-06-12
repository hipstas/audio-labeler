# We need to import request to access the details of the POST request
# and render_template, to render our templates (form and response)
# we'll use url_for to get some URLs for the app on the templates
from flask import Flask, render_template, request, url_for
import unicodecsv
import random
import os
import thread

#def start_server():
#	os.chdir('static/media')
#	os.system('python -m SimpleHTTPServer 8484')

#thread.start_new_thread(start_server, ())


# Initialize the Flask application
app = Flask(__name__)

# Define a route for the default URL, which loads the form
@app.route('/')
def form():
    mediapath='static/media/'+random.choice([item for item in os.listdir('static/media') if item[-4:].lower() in ('.mp3','.wav','.mp4')])
    if mediapath[-4:].lower()=='.mp4':
        return render_template('form_video.html',mediapath=mediapath)
    else:
        return render_template('form_audio.html',mediapath=mediapath)

# Define a route for the action of the form, for example '/submit/'
# We are also defining which type of requests this route is
# accepting: POST requests in this case
@app.route('/submit/', methods=['POST'])
def submit():
    name=request.form['classname']
    mediapath=request.form['mediapath']

    with open(mediapath[:-4]+'.csv','a') as fo:
        fo.write(name+',')
        fo.write(mediapath+'\n')

    mediapath='static/media/'+random.choice([item for item in os.listdir('static/media') if item[-4:].lower() in ('.mp3','.wav','.mp4')])

    return render_template('form_action.html', mediapath=mediapath)

# Run the app :)
if __name__ == '__main__':
  app.run(threaded=True,
        host="0.0.0.0",
        port=int("8000")
  )
