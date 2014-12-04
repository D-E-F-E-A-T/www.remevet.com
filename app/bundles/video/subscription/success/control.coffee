Model = require "../../dao/model"

module.exports = (request, response, next)->

	if not request.session.user and not request.query.tx and not request.query.cm
		return response.redirect ﬁ.bundles['video/home']
	else
		user_id = request.query.cm
		user_id = request.session.user._id if ﬁ.util.isUndefined user_id

		query =
			"action" : "select"
			"from"   : "subscription"
			"where"  :
				"user_id" : user_id

		Model.execute query, (error, data)->

			current_date = new Date()
			new_expiry_date = new Date()
			new_expiry_date.setMonth new_expiry_date.getMonth() + 1

			if data isnt [] and data[0]
				# diff = Math.abs(current_date.getTime() - data[0].expiry_date.getTime())
				# diff_days = Math.ceil(diff / (1000 * 3600 * 24))
				# new_expiry_date.setDate new_expiry_date.getDate() + diff_days

				query =
					"action" : "find_and_modify"
					"from"   : "subscription"
					"where"  :
						"user_id" : user_id
					"modify" :
						$set :
							"subscription_date" : current_date
							"expiry_date"       : new_expiry_date
							"last_pay"          : request.query.tx
							"status" : 1 #activo
			else 
				query =
					"action" : "insert"
					"from"   : "subscription"
					"values" :
						"user_id"           : user_id
						"subscription_date" : current_date
						"expiry_date"       : new_expiry_date
						"last_pay"          : request.query.tx
						"status"            : 1
					"primary_key" : "auto"


			Model.execute query, (error, data_success)->
				if error
					return next(status:500, errors:[error]) 
				else
					request.session.user.video = Boolean(data_success.status)

					return response.render()
		# return response.render()