Model = require './model'

module.exports = (request, response, next) ->

	response.locals.TITLE = 'Revistas'

	Model request, (error, data)->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()
		response.render
			data: data
			BREADCRUMBS: [
				name:"Revistas"
				href:ﬁ.bundles['magazines']
			]
