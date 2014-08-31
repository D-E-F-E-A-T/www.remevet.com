module.exports = (request, response, next)->

	response.locals.TITLE = 'Nosotros'

	response.render
		SCRIPT: []
		BREADCRUMBS: [
			name:"Nosotros"
			href:ﬁ.bundles['aboutus']
		]
