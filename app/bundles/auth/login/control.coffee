Model = require './model'

module.exports = (request, response, next)->
	response.locals.TITLE = 'Ingresar'

	return response.render() if request.method is 'GET'

	Model request, (error, data)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render()

		redirect = request.flash 'auth_redirect'
		request.session.user = data

		response.flash 'notice-info', ["¡ Bienvenido #{data.name_first} !"]

		return response.redirect redirect if redirect
		return response.redirect ﬁ.bundles['home']

