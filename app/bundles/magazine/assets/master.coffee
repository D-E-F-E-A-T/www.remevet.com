$(document).ready ->

	Reveal.initialize
		controls   : true
		progress   : false
		history    : true
		center     : true
		theme      : Reveal.getQueryHash().theme
		transition : "page"

	Reveal.addEventListener "slidechanged", (e) ->

		if e.indexh == 2
			v = document.getElementsByTagName("video")[0]
			v.play()