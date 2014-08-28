module.exports = (request, response, next)->

	response.locals.TITLE = 'Nosotros'

	response.render
		SCRIPT: []
		breadcrumbs: [
			name:"Nosotros"
			href:ﬁ.bundles['aboutus']
		]
