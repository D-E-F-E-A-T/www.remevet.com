Model = require './model'

module.exports = (request, response, next) ->

	slug = request.param 'slug'

	Model request, (error, data)->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()
		ﬁ.log.debug 'la info de las revistas es: ' + JSON.stringify data
		response.render
			data: data
			BREADCRUMBS: [
				name:slug
				href:ﬁ.bundles['magazines']
			]
