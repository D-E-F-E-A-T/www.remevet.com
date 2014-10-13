Shuffle     = (require 'knuth-shuffle').knuthShuffle
Advertisers = require './ads'

module.exports = (request, callback)->

	self   = @
	result = advertisers:[], magazines:[], events:[], articles:[]

	magazines   = ﬁ.db.collection 'magazines'
	events      = ﬁ.db.collection 'events'
	articles    = ﬁ.db.collection 'temp'
	advertisers = Shuffle(Advertisers.slice(0))

	# Ads
	# data = s:[], m:[], l:[], x:[]
	# while advertisers.length
	# 	tmp = advertisers.splice(0,12)
	# 	data.x.push tmp
	# 	data.l.push(tmp.slice i, i+6) for i in [0..6] by 6
	# 	data.m.push(tmp.slice i, i+4) for i in [0..8] by 4
	# 	data.s.push(tmp.slice i, i+3) for i in [0..9] by 3
	# result.advertisers = data
	result.advertisers = advertisers.splice(0,12)


	# Magazines
	magazines.aggregate
		$group:(_id: "$slug",document: $last: "$$ROOT"), (error, data)->
			callback.call(self, error) if error
			result.magazines = data.map (v)-> v.document

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