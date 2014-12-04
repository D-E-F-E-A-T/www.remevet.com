Model = require '../dao/model'

module.exports = (request, response, next)->

	if not request.session.user
		return response.redirect ﬁ.bundles['video/auth/sign_in']
	else
		###
		query_subscription =
			"action" : "select"
			"from"   : "subscription"
			"where"  :
				"user_id" : request.session.user._id

		Model.execute query_subscription, (error, data_subscription)->
			return next(status:500, errors:[error]) if error

			is_free = if ﬁ.util.isEmptyDictionary data_subscription then true else false
		###
		query = 
			"action" : "select"
			"fields" : 
				"hosted_button_id" : true
			"from"   : "paypal"
			"where"  : 
				"_id" : "gik"

		Model.execute query, (error, data)->
			return next(status:500, errors:[error]) if error
			if data isnt [] && data[0]
				return response.render
					data : request.session.user
					paypal : data[0].hosted_button_id