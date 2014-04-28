module.exports = (request, response, next)->

	request.session.destroy() if response.locals.USER.type isnt 'anon'
	response.redirect ﬁ.bundles['home']
