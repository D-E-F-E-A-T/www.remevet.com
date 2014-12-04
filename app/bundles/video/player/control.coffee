Model = require '../dao/model'

module.exports = (request, response, next)->
	if not request.session.user
		return response.redirect ﬁ.bundles['auth/login']

	resource_id = parseInt(request.param 'resource_id')

	query =
		"action" : "select"
		"fields" :
			"_id"         : false
			"upload_date" : false
			"status"      : false
		"from"   : "resource"
		"where"  :
			"_id": resource_id
			"status" : 1

	request.session.user.video = if not request.session.user.video then false else request.session.user.video

	Model.execute query, (error, data)->
		return next(status:500, errors:[error]) if error
		if data and data.length > 0
			resource = data[0]
			resource.rtmp = ﬁ.settings.domain.rtmp
			resource.web = ﬁ.settings.domain.web

			query_counter =
				"action" : "find_and_modify"
				"from"   : "counter"
				"where"  :
					"user_id" : request.session.user._id
					"resource_id" : resource_id
					"category_id" : resource.category_id
				"modify" :
					$inc :
						"views" : 1
					$set :
						"last_seen" : new Date()
				"options" :
					new : true
					upsert : true

			Model.execute query_counter, (err,success)->

			query_related =
				"action" : "select"
				"fields" :
					"_id"   : true
					"image" : true
					"path"  : true
					"title" : true
				"from"   : "resource"
				"where"  :
					"category_id" : data[0].category_id
				"limit"  : 3

			Model.execute query_related, (error, item_related)->
				return next(status:500, errors:[error]) if error
				item_related_list = []
				if item_related and item_related.length > 0
					item_related_list = item_related
					return response.render
						data : resource
						related : item_related_list
						vsubs : request.session.user.video
						BREADCRUMBS : [
							name : "Videos"
							href : ﬁ.bundles['video/home'].replace(":interest", resource.category_id)
						]