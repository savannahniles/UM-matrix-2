
Template.main.created = ->

  $ -> #initialize multitouch.
    window.client = new Caress.Client(
      host: "localhost"
      port: 5000
    )
    console.log "Caress:"
    console.log window.client
    client.connect()
    return

Template.dataCanvas.rendered = ->
  buildCanvas()

Template.main.events =
  "click .touch": (d) ->
    console.log "Clicked!"

  "touchstart .touch": (d) ->
    console.log "That tickles!"

  "click #dataCanvas": (d) ->
    console.log "Clicked dataCanvas"
    scroller.zoomBy 1.2, true

