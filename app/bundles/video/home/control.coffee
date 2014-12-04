Model = require "../dao/model"

module.exports = (request, response, next)->

	resources = {}
	console.log request.session.user
	random = Math.floor(Math.random() * 3) + 1
	interest = if request.param 'interest' then parseInt(request.param 'interest') else null
	interest = if not interest then request.session.user.interest else interest
	interest = if not interest then random else interest

	bread = [
		{slug: 3, name: 'Fauna Silvestre', href:ﬁ.bundles['video/home'].replace(':interest','3')},
		{slug: 2, name: 'Equinos', href:ﬁ.bundles['video/home'].replace(':interest','2')},
		{slug: 1, name: 'Pequeñas Especies', href:ﬁ.bundles['video/home'].replace(':interest','1')}
	]

	crumbs = []
	crumbName = ""
	for bc in bread
		if bc.slug is interest
			crumbName = bc.name
			continue
		crumbs.push bc

	console.log JSON.stringify crumbs

	query_all =
		"action" : "select"
		"fields" :
			"_id"   : true
			"image" : true
			"path"  : true
			"title" : true
		"from"  : "resource"
		"where" :
			"status" : 1
			"category_id" : interest
		"orderBy" :
			"upload_date" : -1

	Model.execute query_all, (error, resource_all)->
		resources.all = []
		if resource_all and resource_all.length > 0
			for all in resource_all
				resources.all.push
					id : all._id
					url: ﬁ.settings.domain.web + all.path + all.image
					title : all.title

		end = new Date()
		start = new Date()
		start.setMonth start.getMonth() - 1

		query_last =
			"action" : "select"
			"fields" :
				"_id"   : true
				"image" : true
				"path"  : true
				"title" : true
			"from"   : "resource"
			"where"  :
				"category_id" : interest
				"status" : 1
				"upload_date":
					$gte: start
					$lt : end
			"orderBy" :
				"upload_date" : -1

		Model.execute query_last, (error, resource_last)->
			resources.last_upload = []
			if resource_last and resource_last.length > 0
				for rl in resource_last
					resources.last_upload.push
						id : rl._id
						url: ﬁ.settings.domain.web + rl.path + rl.image
						title : rl.title

			query_counter =
				"action" : "select"
				"fields" :
					"_id" : false
					"resource_id" : true
				"from"   : "counter"
				"where"  :
					"category_id" : interest
					"user_id" : request.session.user._id
				"orderBy" :
					"last_seen" : -1

			Model.execute query_counter, (error, resource)->
				most_viewed = []
				if resource and resource.length > 0
					for r in resource
						most_viewed.push r.resource_id

					query_counter_in =
						"action" : "select"
						"fields" :
							"_id"   : true
							"image" : true
							"path"  : true
							"title" : true
						"from"   : "resource"
						"where"  :
							"category_id" : interest
							"status" : 1
							"_id":
								$in : most_viewed

					resources.orden_videos = most_viewed

					Model.execute query_counter_in, (error, resource_in)->
						resources.most_viewed = []
						if resource_in and resource_in.length > 0
							for rin in resource_in
								resources.most_viewed.push
									id : rin._id
									url: ﬁ.settings.domain.web + rin.path + rin.image
									title : rin.title

						# console.log "ultimos vistos : ", JSON.stringify resources.most_viewed
						last_seen_unsort = resources.most_viewed.slice()
						
						i = 0
						for so in resources.orden_videos
							resources.orden_videos[i] = { "id" : so, "ind" : i }
							i++

						# console.log "indices",JSON.stringify resources.orden_videos

						compara_id = (a, b) ->
							return 1 if a.id > b.id
							return -1 if a.id < b.id
							0

						resources.orden_videos.sort compara_id
						# console.log "indices*",JSON.stringify resources.orden_videos
						


						i = 0
						delete resources.most_viewed
						resources.most_viewed = []
						# console.log "Ordenando #", last_seen_unsort.length
						for so in last_seen_unsort
							# console.log "---->[",i,"]: id:",so.id,",#",resources.orden_videos[i].ind
							resources.most_viewed[ resources.orden_videos[i].ind ] = so
							i++ 
						# console.log "---------------------------1"
						# i = 0
						# for so in resources.most_viewed
						# 	console.log "*[",i,"] : ", JSON.stringify so
						# 	i++
						# console.log "---------------------------2"
						delete resources.orden_videos
						# console.log "orden final : ", JSON.stringify resources.most_viewed
						return response.render
							data : resources
							BREADCRUMBS : [
								name : "Videos"
								href : ﬁ.bundles['video/welcome']
							].concat crumbs.concat [(name:crumbName, href:ﬁ.bundles['video/home'].replace(':interest', interest))]
				else
					return response.render 
						data: resources
						BREADCRUMBS : [
							name : "Videos"
							href : ﬁ.bundles['video/welcome']
						].concat crumbs.concat [(name:crumbName, href:ﬁ.bundles['video/home'].replace(':interest', interest))]
