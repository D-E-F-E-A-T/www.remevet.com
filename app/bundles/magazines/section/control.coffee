Model  = require './model'
Covers = require './covers'

module.exports = (request, response, next) ->
	section = request.param 'section'

	found = false
	for cover in Covers
		continue if cover.slug isnt section
		found = cover
		break

	return next(status:404, errors:['Sección inválida']) if not found


	Model section, (error, data)->
		return next(status:500, errors:[error]) if error

		response.render
			BREADCRUMBS : [name: section, href: ﬁ.bundles['magazines']]
			cover       : found
			magazines   : data

