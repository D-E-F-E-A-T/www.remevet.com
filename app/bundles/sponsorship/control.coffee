module.exports = (request, response, next) ->
	response.locals.TITLE = 'Artículos de nuestros patrocinadores'
	response.render
		breadcrumbs: [
			name:"Artículos de Patrocinadores"
			href:ﬁ.bundles['sponsorship']
		]