#!/bin/bash

# Play using audio jack
sudo amixer cset numid=3 1

# now really play
wget -q -O - `youtube-dl -g $1`| ffmpeg -i - -f mp3 -vn -acodec libmp3lame -| mpg123  -
