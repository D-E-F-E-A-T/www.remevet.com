Path = require 'path'

module.exports = (request, response, next)->

	return next() if ﬁ.util.isDictionary request.session.user
	
	response.flash 'auth_redirect', request.url

	response.redirect ﬁ.bundles['auth/login']