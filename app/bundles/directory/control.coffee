Model = require './model'

module.exports = (request, response, next) ->

	response.locals.TITLE = 'Directorio'

	response.locals.SCRIPT = [
		(src:'https://maps.googleapis.com/maps/api/js?v=3.exp'),
	]

	Model request, (error, data) ->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()

		response.render
			BREADCRUMBS: [
				name:"Directorio"
				href:ﬁ.bundles['calendar']
			]
			clinics : data
			feature : data.small[0]

