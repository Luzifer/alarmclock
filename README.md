# The idea

Alarmclock is a node daemon intended to get events from a special "wake up calendar". All of the events in this calendar will trigger a player to start playing a random video from youtube. Those videos should directly begin with music and not with a long prelude.

The idea behind this project was born from a [post on lifehacker](http://lifehacker.com/combine-a-raspberry-pi-with-google-calendar-for-a-smart-512265472) showing a similar setup but without youtube integration and the [standup meeting music project](https://github.com/s0enke/Standup-Meeting-Music) using a browser to play youtube videos at a specific time. As a Raspberry Pi has some caveats against flash (there is simply no flash) and I didn't managed to get it playing music from youtube using a browser I built in a workaround using [youtube-dl](https://github.com/rg3/youtube-dl/) and ffmpeg.

# Setup

- At first get a Raspberry Pi and some speakers connected to it using 3.5" audio jack
- Install [Raspbian "wheezy"](http://www.raspberrypi.org/downloads) on it
- `git clone` this repository in the home directory of the `pi` user
- Set up external depencies
  - Create a calendar in your Google account
  - Make this calendar global readable
  - Add some events for your alarms in the calendar
- Configure the script by cloning `settings.json.dist` to `settings.json` and editing it
  - The `calendar_id` is provided by the 'calendar settings' page of google calendar
  - To get the `api_key` you have to create a project at [Google APIs console](https://code.google.com/apis/console/) and enable calendar-api-access for it
- Execute the `raspbian-setup.sh` script to install depencies and create cron jobs, init-scripts, etc.
