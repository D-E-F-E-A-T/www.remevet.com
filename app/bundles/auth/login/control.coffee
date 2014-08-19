users = []

users.push
	id   : 1
	type : 'admin'
	mail : 'admin@remevet.com'
	pass : 'admin'
	name :
		first : 'Héctor'
		last  : 'Menéndez'

users.push
	id   : 2
	type : 'user'
	mail : 'user@gmail.com'
	pass : 'user'
	name :
		first : 'Alejandra'
		last  : 'Piña'

Users = require '../../../templates/json/users'
console.log JSON.stringify Users

module.exports = (request, response, next)->

	ﬁ.log.debug 'request.body', JSON.stringify request.body

	if not request.body.mail or not request.body.pass
		response.flash 'notice-error', ['Todos los campos son requeridos']
		return response.redirect ﬁ.bundles['auth']

	for user in Users
		ﬁ.log.trace 'user', JSON.stringify user
		continue if request.body.mail isnt user.mail or request.body.pass isnt user.pass
		# User found successfully
		request.session.user = user
		response.flash 'notice-info', ["¡Bienvenido #{user.name.first}!"]
		return response.redirect ﬁ.bundles['home']

	response.flash 'notice-error', ['Los datos proporcionados fueron incorrectos']
	return response.redirect ﬁ.bundles['auth']
