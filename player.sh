#!/bin/bash

wget -q -O - `youtube-dl -g $1`| ffmpeg -i - -f mp3 -vn -acodec libmp3lame -| mpg123  -
