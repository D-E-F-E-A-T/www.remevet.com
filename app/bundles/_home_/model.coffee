Shuffle = (require 'knuth-shuffle').knuthShuffle

module.exports = (request, callback)->

	self   = @
	result = advertisers:[], magazines:[], events:[], articles:[]

	magazines   = ﬁ.db.collection 'magazines'
	events      = ﬁ.db.collection 'events'
	articles    = ﬁ.db.collection 'articles'
	advertisers = ﬁ.db.collection 'advertisers'

	# Magazines
	magazines.aggregate
		$group:(_id: "$slug",document: $last: "$$ROOT"), (error, data)->
			callback.call(self, error) if error
			result.magazines = data.map (v)-> v.document

			# Advertisers
			advertisers.find().toArray (error, data)->
				callback.call(self,error) if error
				result.advertisers = Shuffle data

				# Events
				events
					.find("date.end": $gte: new Date)
					.sort("date.ini": 1)
					.limit(6).toArray (error, data)->
						callback.call(self,error) if error
						result.events = data

						articles.find().limit(5).toArray (error, data)->
							callback.call(self, error) if error
							result.articles = data

							# Ended
							callback.call self, null, result