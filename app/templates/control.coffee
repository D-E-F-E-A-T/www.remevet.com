Model  = ﬁ.require 'templates', 'model'
Notice = ﬁ.require 'templates', 'controls/notice'

module.exports = (request, response, next)->

	# when a static call is not found, it reaches here.
	if request.path.indexOf('/static ') isnt -1
		return next (status:404, errors:["No encontrado"])

	# Initialize the user global
	response.locals.USER =
		_id  : 0
		type : 'anon'

	# The current URL will be a global
	response.locals.URL = request.url

	# A session must always have an identifier
	request.session.uuid = ﬁ.util.uuid().replace(/\-/g, '') if not request.session.uuid

	# if no user is logged, assign a temporary id.
	if not request.session.user
		response.locals.USER._id = request.session.uuid
	# a user is logged, populate global variable.
	else
		response.locals.USER[k] = v for k,v of request.session.user
		response.locals.USER.type = 'user'

	# there's no need of doing anything else, if the requested bundle is logout.
	return next() if request.url is ﬁ.bundles['auth/logout']

	# Centralized notifications by using this control along with its template view
	response.locals.NOTICE = Notice request

	next()
