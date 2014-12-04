Path = require 'path'

module.exports = (request, response, next)->

	return next() if ﬁ.util.isDictionary request.session.user
	
	response.flash 'auth_redirect', request.url

	response.redirect ﬁ.bundles['auth/login']

module.exports = (request, response, next)->
	return next() if ﬁ.util.isDictionary request.session.user
	
	response.flash 'auth_redirect', request.url
	response.flash 'notice-error', ["Para continuar inicia sesion"]
	response.redirect ﬁ.bundles['auth/sign_in']