module.exports = (request, response, next) ->
	response.locals.TITLE = 'Comunidad'
	response.render
		breadcrumbs: [
			name:"Comunidad"
			href:ﬁ.bundles['community']
		]
