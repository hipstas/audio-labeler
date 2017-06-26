# Audio Labeler

First, install [Docker CE](https://www.docker.com/community-edition) and/or [Docker Toolbox](https://www.docker.com/products/docker-toolbox).

Create the directory `~/Desktop/audio_labeler/media` (on the desktop or elswhere) and add audio files to it (MP3 and WAV).

Open a new terminal window and enter the following commands to kill the current Docker image (if running), then download and launch the latest container build.

```
docker rm -f audio_labeler

docker pull hipstas/audio-labeler

docker run -it --name audio_labeler -p 8000:8000 -v ~/Desktop/audio_labeler:/home/audio_labeler hipstas/audio-labeler bash
```

Point your browser to [localhost:8000](localhost:8000) and begin labeling. The application will output all data to the file `output_table.csv` in the `audio_labeler` directory.
