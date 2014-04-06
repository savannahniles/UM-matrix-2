Template.main.created = ->

  # $ -> #initialize multitouch.
  #   window.client = new Caress.Client(
  #     host: "localhost"
  #     port: 5000
  #   )
  #   console.log "Caress:"
  #   console.log window.client
  #   client.connect()
  #   return

Template.main.events =
  "click .touch": (d) ->
    console.log "Clicked!"

  "touchstart .touch": (d) ->
    console.log "That tickles!"

