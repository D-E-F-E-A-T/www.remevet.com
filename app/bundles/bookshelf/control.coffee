Model = require './model'
Cover = require './cover'

module.exports = (request, response, next) ->
	ﬁ.log.debug 'debug' + JSON.stringify Cover

	slug = request.param 'slug'
	coverData = {}
	for i in Cover
		continue if i.slug isnt slug
		ﬁ.log.debug 'i es: ' + JSON.stringify i
		coverData = i



	Model request, (error, data)->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()
		ﬁ.log.debug 'la info de las revistas es: ' + JSON.stringify data
		response.render
			coverData : coverData
			data: data
			BREADCRUMBS: [
				name:slug
				href:ﬁ.bundles['magazines']
			]
