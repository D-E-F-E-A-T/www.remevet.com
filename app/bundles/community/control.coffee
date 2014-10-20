Model = require './model'

module.exports = (request, response, next)->

	response.locals.TITLE = 'Comunidad'
	
	Model request, (error, data) ->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()

		data.BREADCRUMBS= [
			name:"Comunidad"
			href:ﬁ.bundles['community']
		]
		response.render data