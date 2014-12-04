Model = require './model'

module.exports = (request, response, next)->
	response.locals.TITLE = 'Ingresar'

	if request.method is 'GET'
		return response.render
			BREADCRUMBS: [
				name:"Entrar"
				href:ﬁ.bundles['auth/login']
			]


	return response.render() if request.method is 'GET'

	Model request, (error, data)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render
				errorMessage : error.message

		redirect = request.flash 'auth_redirect'
		request.session.user = data

		response.flash 'notice-info', ["¡ Bienvenido #{data.name_first} !"]

		return response.redirect redirect if redirect
		return response.redirect ﬁ.bundles['_home_']

