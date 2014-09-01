Model = require './model'

module.exports = (request, response, next)->

	response.locals.TITLE = 'Eventos'
	
	Model request, (error, data) ->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()

		response.render
			BREADCRUMBS: [
				name:"Eventos"
				href:ﬁ.bundles['calendar']
			]
			data:data