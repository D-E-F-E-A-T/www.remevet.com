Model = require '../../bundles/video/dao/model'

module.exports = (request, response, next)->

	query_subscription =
		"action" : "select"
		"from"   : "subscription"
		"where"  :
			"user_id" : request.session.user._id
			"status" : 1

	Model.execute query_subscription, (error, data_subscription)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render
				errorMessage : error.message

		if data_subscription isnt [] and data_subscription[0]
			today = new Date()
			expiry_date = data_subscription[0].expiry_date
			if expiry_date < today
				request.session.user.video = false
				query =
					"action" : "find_and_modify"
					"from"   : "subscription"
					"where"  :
						"user_id" : request.session.user._id
					"modify" :
						$set :
							"status" : 2 #inactivo
				Model.execute query, (error, data)->
					if error
						response.status error.status
						response.flash 'notice-error', error.message
						return response.render
							errorMessage : error.message
			else
				request.session.user.video = true
		else
			request.session.user.video = false

		return next()

	#console.dir request.session.subscription
	#return next() if request.session.subscription
