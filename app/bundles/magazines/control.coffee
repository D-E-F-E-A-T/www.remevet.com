Model = require './model'

module.exports = (request, response, next)->

	Model request, (error,data)->
		data.BREADCRUMBS = [
			name : "Revistas"
			href : ﬁ.bundles['calendar']
		]

		response.render data
