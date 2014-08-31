module.exports = (request, response, next)->
	response.locals.TITLE = 'Eventos'
	response.render
		BREADCRUMBS: [
			name:"Eventos"
			href:ﬁ.bundles['calendar']
		]