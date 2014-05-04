module.exports = (request, response, next)->

	#Loading extra scripts and style files dynamically
	response.locals.LINK = [

		(rel:"stylesheet", href:"/static/revealjs/css/reveal.min.css")
		(rel:"stylesheet", href:"/static/revealjs/css/theme/default.css", id:"theme")
		(rel:"stylesheet", href:"/static/revealjs/lib/css/zenburn.css")
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/core/deck.core.css')
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/extensions/navigation/deck.navigation.css')
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/extensions/status/deck.status.css')
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/extensions/scale/deck.scale.css')
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/themes/style/web-2.0.css')
		# (rel:'stylesheet', media:"screen" , href:'/static/deckjs/themes/transition/horizontal-slide.css')
	]

	response.locals.SCRIPT = [
		(src:"/static/revealjs/lib/js/head.min.js")
		(src:"/static/revealjs/js/reveal.min.js")
		# (src:'/static/deckjs/core/deck.core.js')
		# (src:'/static/deckjs/extensions/status/deck.status.js')
		# (src:'/static/deckjs/extensions/navigation/deck.navigation.js')
		# (src:'/static/deckjs/extensions/scale/deck.scale.js')
	]



	response.render()