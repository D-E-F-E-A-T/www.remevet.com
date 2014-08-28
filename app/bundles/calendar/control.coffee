module.exports = (request, response, next)->
	response.locals.TITLE = 'Eventos'
	response.render
		breadcrumbs: [
			name:"Eventos"
			href:ﬁ.bundles['calendar']
		]