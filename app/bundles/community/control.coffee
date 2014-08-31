module.exports = (request, response, next) ->
	response.locals.TITLE = 'Comunidad'
	response.render
		BREADCRUMBS: [
			name:"Comunidad"
			href:ﬁ.bundles['community']
		]
