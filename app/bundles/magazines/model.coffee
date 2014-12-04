Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (data, callback)->

	self      = @
	magazines = ﬁ.db.collection 'magazines'
	result    = advertisers:[], magazines:[]

	# Magazines
	magazines.aggregate
		$group:(_id: "$slug",document: $last: "$$ROOT"), (error, data)->
			callback.call(self, error) if error
			result.magazines = data.map (v)-> v.document

			Advertisers (error, data)->
				callback.call(self,error) if error
				result.advertisers = data

				# Ended
				callback.call self, null, result