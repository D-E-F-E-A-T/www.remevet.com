Assets = require './util/assets'

module.exports = (request, response, next)->

	# if this is an asset request, handle it separatedly
	return Assets.apply(this, arguments) if request.params.file

	response.renderview 'view',
		LINK: [
			(rel:"stylesheet", href:"/static/revealjs/css/reveal.min.css")
			(rel:"stylesheet", href:"/static/revealjs/css/theme/default.css", id:"theme")
			(rel:"stylesheet", href:"/static/revealjs/lib/css/zenburn.css"),
			(rel:"stylesheet", href:ﬁ.bundles['magazine'].replace(':file', 'master.css'))
		],
		SCRIPT: [
			(src:"/static/revealjs/lib/js/head.min.js")
			(src:"/static/revealjs/js/reveal.min.js")
			(src:ﬁ.bundles['magazine'].replace(':file', 'master.js'))
		]
