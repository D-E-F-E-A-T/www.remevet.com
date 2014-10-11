Model = require './model'

module.exports = (request, response, next) ->
	response.locals.TITLE = 'Artículos de nuestros patrocinadores'
	Model request, (error, data)->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()

		ﬁ.log.debug '-------------------->', JSON.stringify data

		response.render
			data:data
			BREADCRUMBS: [
				name:"Biblioteca"
				href:ﬁ.bundles['sponsors']
			]