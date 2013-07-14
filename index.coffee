googleapis = require('googleapis')
dateformat = require('dateformat')
spawn = require('child_process').spawn
settings = require('./settings')

next_event = null
last_alarm = null

fetch_next_event = () ->
  googleapis.discover('calendar', 'v3').execute (err, client) ->
    params =
      'calendarId': settings.calendar_id
      'orderBy': 'startTime'
      'timeMin': dateformat(new Date(), 'isoUtcDateTime')
      'singleEvents': true
      'maxResults': 10
      'key': settings.api_key
    client.calendar.events.list(params).execute (err, response) =>
      if response.items
        n = null
        for item in response.items
          if n == null
            n = item
            continue

          n_date = new Date(n.start.dateTime)
          i_date = new Date(item.start.dateTime)

          if n_date > i_date
            n = item
        if next_event == null or next_event.id != n.id
          next_event = n
          console.log "Found next wake event on #{next_event.start.dateTime}"
      else
        console.log 'No events could be found. Cache remains empty.'
        next_event = null

wake_next_event = () ->
  event_date = new Date(next_event.start.dateTime)
  now = new Date()
  sound = settings.youtube_urls[Math.floor(Math.random() * settings.youtube_urls.length)]
  if event_date < now and last_alarm != next_event.id
    last_alarm = next_event.id
    console.log "Starting playback of #{sound}"
    player = spawn './player.sh', [sound]
    player.on 'close', (code) =>
      console.log "Playback of #{sound} finished."
      fetch_next_event()

fetch_next_event()
setInterval fetch_next_event, 5 * 60 * 1000
setInterval wake_next_event, 5 * 1000
