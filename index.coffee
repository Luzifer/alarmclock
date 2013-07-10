googleapis = require('googleapis')
settings = require('./settings')

next_event = null

fetch_next_event = () ->
  googleapis.discover('calendar', 'v3').execute (err, client) ->
    params =
      'calendarId': settings.calendar_id
      'orderBy': 'startTime'
      'timeMin': '2013-07-10T20:29:00Z'
      'singleEvents': true
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
        next_event = n
      else
        console.log 'No events could be found. Cache remains empty.'
        next_event = null

wake_next_event = () ->
  console.log next_event

fetch_next_event()
setInterval fetch_next_event, 5 * 60 * 1000
setInterval wake_next_event, 5 * 1000
