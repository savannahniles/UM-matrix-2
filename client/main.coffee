
Template.main.created = ->
  # hammer = $('#container').hammer()
  # console.log hammer

  # hammer.on "click", (e) ->
  #   e.stopPropagation()
  #   console.log "clicked///"
  #   return

  # hammer.on "tap", (e) ->
  #   e.stopPropagation()
  #   console.log "Tap!"
  #   return

  # hammer.on "doubletap", (e) ->
  #   e.stopPropagation()
  #   console.log "doubletap!"
  #   return

  # hammer.on "pinch", (e) ->
  #   e.stopPropagation()
  #   console.log "pinch."
  #   return

  # hammer.on "pinchin", (e) ->
  #   e.stopPropagation()
  #   console.log "pinchin."
  #   return

  # hammer.on "touch", (e) ->
  #   e.stopPropagation()
  #   console.log "touched!"
  #   return

  Meteor.defer ->
    console.log "here"
    $swipe = $("#container").hammer()
    console.log $swipe
    $swipe.on "hold tap swipe doubletap transformstart transform transformend dragstart drag dragend swipe release", (event) ->
      event.preventDefault()
      console.log "event"
      #console.log "Type: " + event.type + ", Fingers: " + event.touches.length + ", Direction: " + event.direction + "<br/>"
      return
    return

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

  # "click #dataCanvas": (d) ->
  #   console.log "Clicked dataCanvas"
  #   scroller.zoomBy 1.2, true

  "click #container": (d) ->
    console.log "Clicked container"

  "touchstart #container": (d) ->
    console.log "That tickles!"

Template.dataCanvas.swipeme = ->
  Meteor.defer ->
    console.log "here"
    $swipe = $("#container").hammer()
    console.log $swipe
    $swipe.on "hold tap swipe doubletap transformstart transform transformend dragstart drag dragend swipe release", (event) ->
      event.preventDefault()
      console.log "Type: " + event.type + ", Fingers: " + event.touches.length + ", Direction: " + event.direction + "<br/>"
      return
    return
  return



