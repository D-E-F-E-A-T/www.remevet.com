Model = require './model'

module.exports = (request, response, next)->
	

	return response.render() if request.method is 'GET'

	Model request, (error, data)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render()

		redirect = request.flash 'auth_redirect'
		request.session.user = data

		response.flash 'notice-info', ["¡ Muchas gracias por registrarte #{data.name_first} !"]

		return response.redirect redirect if redirect
		return response.redirect ﬁ.bundles['home']