Model = require '../../dao/model'

module.exports = (request, response, next)->

	if request.method is 'POST'

		query = 
			"action" : "select"
			"from"   : "user"
			"where"	 : request.body

		console.log query
		console.log Model

		Model.execute query, (error, data)->
			if error
				response.flash 'notice-error', [error.status]
				return response.redirect ﬁ.bundles['video/auth/sign_in']
			
			if not data or data.length is 0
				return response.render
					data : data
			else
				ﬁ.locals.USER = {}
				ﬁ.locals.USER.id = data[0]._id
				request.session.user = data[0]

				query =
					"action" : "select"
					"from"   : "subscription"
					"where"  : 
						"user_id" : data[0]._id
						"status"  : 1 #activo       2 #inactivo

				Model.execute query, (error, data) ->
					if error
						response.flash 'notice-error', [error.status]
						return response.redirec fi.bundles['video/auth/sign_in'] # ???
					if data isnt [] && data[0]
						request.session.subscription = true
					else 
						request.session.subscription = false

					return response.redirect ﬁ.bundles['video/home']
	else
		return response.render()