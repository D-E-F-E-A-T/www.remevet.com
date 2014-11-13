Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (data, callback)->

	self   = @
	result = advertisers:[], magazines:[], events:[], articles:[]

	magazines   = ﬁ.db.collection 'magazines'
	events      = ﬁ.db.collection 'events'
	articles    = ﬁ.db.collection 'articles'

	# Magazines
	magazines.aggregate
		$group:(_id: "$slug",document: $last: "$$ROOT"), (error, data)->
			callback.call(self, error) if error
			result.magazines = data.map (v)-> v.document

			# Advertisers
			Advertisers (error, data)->
				callback.call(self,error) if error
				result.advertisers = data

				# Events
				events
					.find("date.end": $gte: new Date)
					.sort("date.ini": 1)
					.limit(6).toArray (error, data)->
						callback.call(self,error) if error
						result.events = data

						articles.find().sort(num:-1).limit(1).toArray (error, data)->
							callback.call(self, error) if error
							result.articles = data



							# Ended
							callback.call self, null, result



