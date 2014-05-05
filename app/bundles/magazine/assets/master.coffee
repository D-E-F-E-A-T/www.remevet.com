$(document).ready ->

	Reveal.initialize
		controls   : true
		progress   : false
		history    : true
		center     : true
		theme      : Reveal.getQueryHash().theme
		transition : "background"

	Reveal.addEventListener "slidechanged", (e) ->
		console.dir e.previousSlide
		console.dir e.currentSlide
		console.log '======== indexh    =  ' + e.indexh
		console.log '======== indexv    =  ' + e.indexv

		if e.indexh == 2
			v = document.getElementsByTagName("video")[0]
			v.play()