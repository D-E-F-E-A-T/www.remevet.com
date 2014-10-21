Model  = require './model'
Covers = require './covers'

module.exports = (request, response, next) ->
	section = request.param 'section'

	bread = [
		{slug: 'fauna-silvestre', name: 'Fauna Silvestre', href:ﬁ.bundles['magazines/section'].replace(':section','fauna-silvestre')},
		{slug: 'equinos', name: 'Equinos', href:ﬁ.bundles['magazines/section'].replace(':section','equinos')},
		{slug: 'pequenas-especies', name: 'Pequeñas Especies', href:ﬁ.bundles['magazines/section'].replace(':section','pequenas-especies')}
	]

	crumbs = []
	for bc in bread
		continue if bc.slug is section
		crumbs.push bc

	found = false
	for cover in Covers
		continue if cover.slug isnt section
		found = cover
		break

	return next(status:404, errors:['Sección inválida']) if not found


	Model section, (error, data)->
		return next(status:500, errors:[error]) if error

		data.cover = found
		data.BREADCRUMBS = crumbs.concat [
			(name: section, href:ﬁ.bundles['magazines/section'].replace(':section',section) )
		]
		
		response.render data
