Users = require '../../../templates/json/users'

module.exports = (request, response, next)->

	if not request.body.mail or not request.body.pass
		response.flash 'notice-error', ['Todos los campos son requeridos']
		return response.redirect ﬁ.bundles['auth']

	for user in Users
		continue if request.body.mail isnt user.Email or request.body.pass isnt user.Password
		# User found successfully
		request.session.user = user

		response.flash 'notice-info', ["¡Bienvenido!"]
		return response.redirect ﬁ.bundles['home']

	response.flash 'notice-error', ['Los datos proporcionados fueron incorrectos']
	return response.redirect ﬁ.bundles['auth']
