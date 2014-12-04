Model = require '../dao/model'

module.exports = (request, response, next)->

	random = Math.floor(Math.random() * 3) + 1
	interest = if not interest then request.session.user.interest else null
	interest = if not interest then random else interest

	query = 
		"action" : "select"
		"from"   : "general_property"
		"where"  : 
			"_id" : "resource.welcome"

	Model.execute query, (error, data)->
		return next(status:500, errors:[error]) if error
		# console.dir data[0]
		data[0].rtmp = ﬁ.settings.domain.rtmp
		data[0].web = ﬁ.settings.domain.web

		query_subscription =
			"action" : "select"
			"from"   : "subscription"
			"where"  :
				"user_id" : request.session.user._id

		Model.execute query_subscription, (error, data_subscription)->

			return next(status:500, errors:[error]) if error

			console.log "data_subscription == ", data_subscription

			if data_subscription isnt [] and data_subscription[0]
				status = data_subscription[0].status
			else
				status = 0

			console.log "status == " , status

			if data
				return response.render
					data : data[0]
					status : status
					interest : interest
					BREADCRUMBS : [
						name : "Videos"
					]
			else 
				return response.render()