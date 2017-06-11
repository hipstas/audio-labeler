from flask import Flask
from flask_wtf import FlaskForm
from wtforms import StringField

app = Flask(__name__)

class FlaskForm(Form):
    text = StringField('Text')


@app.route("/")
def hello():
    form = FlaskForm(csrf_enabled=False)
    return form


if __name__ == "__main__":
app.run()
