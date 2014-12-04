module.exports = (request, response, next)->
	if ﬁ.locals.USER.id
		ﬁ.locals.USER = undefined
		request.session.destroy()
		return response.redirect ﬁ.bundles['auth/sign_in']
	else 
		return response.redirect ﬁ.bundles['auth/sign_in']