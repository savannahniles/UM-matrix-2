@buildCanvas = ->
	# contentWidth = 2000
	# contentHeight = 2000
	# cellWidth = 100
	# cellHeight = 100
	# clientWidth = window.innerWidth 
	# clientWidth = clientWidth - 50 #Math.min(clientWidth - 50, 1250)
	# clientHeight = window.innerHeight - 50 #Math.min(window.innerHeight - 200, 800)
	# content = document.getElementById("dataCanvas")
	# context = content.getContext("2d")
	# tiling = new Tiling

	# # Canvas renderer
	# render = (left, top, zoom) ->
	  
	#   # Sync current dimensions with canvas
	#   content.width = clientWidth
	#   content.height = clientHeight
	  
	#   # Full clearing
	#   context.clearRect 0, 0, clientWidth, clientHeight
	  
	#   # Use tiling
	#   tiling.setup clientWidth, clientHeight, contentWidth, contentHeight, cellWidth, cellHeight
	#   tiling.render left, top, zoom, paint
	#   return


	# # Cell Paint Logic
	# paint = (row, col, left, top, width, height, zoom) ->
	#   context.fillStyle = (if row % 2 + col % 2 > 0 then "#ddd" else "#fff")
	#   context.fillRect left, top, width, height
	#   context.fillStyle = "black"
	#   context.font = (14 * zoom).toFixed(2) + "px \"Helvetica Neue\", Helvetica, Arial, sans-serif"
	  
	#   # Pretty primitive text positioning :)
	#   context.fillText row + "," + col, left + (6 * zoom), top + (18 * zoom)
	#   return

	contentWidth = 2000
	contentHeight = 2000
	cellWidth = 100
	cellHeight = 100
	clientWidth = window.innerWidth 
	clientWidth = clientWidth - 50 #Math.min(clientWidth - 50, 1250)
	clientHeight = window.innerHeight - 50 #Math.min(window.innerHeight - 200, 800)

	# Initialize layout
	container = document.getElementById("container")
	content = document.getElementById("dataCanvas")
	content.style.width = contentWidth + "px"
	content.style.height = contentHeight + "px"

	# Generate content
	size = 100
	frag = document.createDocumentFragment()
	row = 0
	rl = contentHeight / size

	while row < rl
	  col = 0
	  cl = contentWidth / size

	  while col < cl
	    elem = document.createElement("div")
	    elem.style.backgroundColor = (if row % 2 + col % 2 > 0 then "#ddd" else "")
	    elem.style.width = cellWidth + "px"
	    elem.style.height = cellHeight + "px"
	    elem.style.display = "inline-block"
	    elem.style.textIndent = "6px"
	    elem.innerHTML = row + "," + col
	    frag.appendChild elem
	    col++
	  row++
	content.appendChild frag

	ui = ->
		# Intialize layout
		container = document.getElementById("container")
		container.setAttribute("style","height:"+ clientHeight+ "px; width:"+ clientWidth+ "px;")
		content = document.getElementById("dataCanvas")
		# clientWidth = 0
		# clientHeight = 0

		# Initialize Scroller
		@scroller = new Scroller(render,
		  zooming: true
		)
		# scrollLeftField = document.getElementById("scrollLeft")
		# scrollTopField = document.getElementById("scrollTop")
		# zoomLevelField = document.getElementById("zoomLevel")
		# setInterval (->
		#   values = scroller.getValues()
		#   scrollLeftField.value = values.left.toFixed(2)
		#   scrollTopField.value = values.top.toFixed(2)
		#   zoomLevelField.value = values.zoom.toFixed(2)
		#   return
		# ), 500
		rect = container.getBoundingClientRect()
		scroller.setPosition rect.left + container.clientLeft, rect.top + container.clientTop

		# Reflow handling
		reflow = ->
		  clientWidth = container.clientWidth
		  clientHeight = container.clientHeight
		  scroller.setDimensions clientWidth, clientHeight, contentWidth, contentHeight
		  return

		window.addEventListener "resize", reflow, false
		reflow()
		# checkboxes = document.querySelectorAll("#settings input[type=checkbox]")
		# i = 0
		# l = checkboxes.length

		# while i < l
		#   checkboxes[i].addEventListener "change", (->
		#     scroller.options[@id] = @checked
		#     return
		#   ), false
		#   i++
		# document.querySelector("#settings #zoom").addEventListener "click", (->
		#   scroller.zoomTo parseFloat(document.getElementById("zoomLevel").value)
		#   return
		# ), false
		# document.querySelector("#settings #zoomIn").addEventListener "click", (->
		#   scroller.zoomBy 1.2, true
		#   return
		# ), false
		# document.querySelector("#settings #zoomOut").addEventListener "click", (->
		#   scroller.zoomBy 0.8, true
		#   return
		# ), false
		# document.querySelector("#settings #scrollTo").addEventListener "click", (->
		#   scroller.scrollTo parseFloat(document.getElementById("scrollLeft").value), parseFloat(document.getElementById("scrollTop").value), true
		#   return
		# ), false
		# document.querySelector("#settings #scrollByUp").addEventListener "click", (->
		#   scroller.scrollBy 0, -150, true
		#   return
		# ), false
		# document.querySelector("#settings #scrollByRight").addEventListener "click", (->
		#   scroller.scrollBy 150, 0, true
		#   return
		# ), false
		# document.querySelector("#settings #scrollByDown").addEventListener "click", (->
		#   scroller.scrollBy 0, 150, true
		#   return
		# ), false
		# document.querySelector("#settings #scrollByLeft").addEventListener "click", (->
		#   scroller.scrollBy -150, 0, true
		#   return
		# ), false
		if "ontouchstart" of window
		  container.addEventListener "touchstart", ((e) ->
		    
		    # Don't react if initial down happens on a form element
		    return  if e.touches[0] and e.touches[0].target and e.touches[0].target.tagName.match(/input|textarea|select/i)
		    scroller.doTouchStart e.touches, e.timeStamp
		    e.preventDefault()
		    return
		  ), false
		  document.addEventListener "touchmove", ((e) ->
		    scroller.doTouchMove e.touches, e.timeStamp, e.scale
		    return
		  ), false
		  document.addEventListener "touchend", ((e) ->
		    scroller.doTouchEnd e.timeStamp
		    return
		  ), false
		  document.addEventListener "touchcancel", ((e) ->
		    scroller.doTouchEnd e.timeStamp
		    return
		  ), false
		else
		  mousedown = false
		  container.addEventListener "mousedown", ((e) ->
		    #return  if e.target.tagName.match(/input|textarea|select/i)
		    scroller.doTouchStart [
		      pageX: e.pageX
		      pageY: e.pageY
		    ], e.timeStamp
		    mousedown = true
		    return
		  ), false
		  document.addEventListener "mousemove", ((e) ->
		    return  unless mousedown
		    scroller.doTouchMove [
		      pageX: e.pageX
		      pageY: e.pageY
		    ], e.timeStamp
		    mousedown = true
		    return
		  ), false
		  document.addEventListener "mouseup", ((e) ->
		    return  unless mousedown
		    scroller.doTouchEnd e.timeStamp
		    mousedown = false
		    return
		  ), false
		  container.addEventListener (if navigator.userAgent.indexOf("Firefox") > -1 then "DOMMouseScroll" else "mousewheel"), ((e) ->
		    scroller.doMouseZoom (if e.detail then (e.detail * -120) else e.wheelDelta), e.timeStamp, e.pageX, e.pageY
		    return
		  ), false

		#
		#// Test for background activity (slow down scrolling)
		#setInterval(function() {
		#	var arr = [];
		#	for (var i=0, l=Math.random()*600; i<l; i++) {
		#		arr.push.call(arr, document.querySelectorAll(".abc" + i));
		#	}
		#}, 50);
		#

	ui()





# # DOM-based rendering (Uses 3D when available, falls back on margin when transform not available) 
# @render = ((global) ->
#   docStyle = document.documentElement.style
#   content = document.getElementById("dataCanvas")

#   engine = undefined
#   if global.opera and Object::toString.call(opera) is "[object Opera]"
#     engine = "presto"
#   else if "MozAppearance" of docStyle
#     engine = "gecko"
#   else if "WebkitAppearance" of docStyle
#     engine = "webkit"
#   else engine = "trident"  if typeof navigator.cpuClass is "string"
#   vendorPrefix =
#     trident: "ms"
#     gecko: "Moz"
#     webkit: "Webkit"
#     presto: "O"
#   [{engine}]
#   helperElem = document.createElement("div")
#   undef = undefined
#   perspectiveProperty = vendorPrefix + "Perspective"
#   transformProperty = vendorPrefix + "Transform"
#   if helperElem.style[perspectiveProperty] isnt undef
#     (left, top, zoom) ->
#       content.style[transformProperty] = "translate3d(" + (-left) + "px," + (-top) + "px,0) scale(" + zoom + ")"
#       return
#   else if helperElem.style[transformProperty] isnt undef
#     (left, top, zoom) ->
#       content.style[transformProperty] = "translate(" + (-left) + "px," + (-top) + "px) scale(" + zoom + ")"
#       return
#   else
#     (left, top, zoom) ->
#       content.style.marginLeft = (if left then (-left / zoom) + "px" else "")
#       content.style.marginTop = (if top then (-top / zoom) + "px" else "")
#       content.style.zoom = zoom or ""
#       return
# )(this)