Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (data, callback)->

	self       = @
	collection = ﬁ.db.collection 'events'
	result     = events:[], advertisers:[]

	collection
		.find("date.end": $gte: new Date)
		.sort("date.ini": 1).toArray (error, data)->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se encontraron eventos'], status: 403
				return callback.call self, error

			result.events    = data
		# Advertisers
			Advertisers (error, data)->
				callback.call(self,error) if error
				result.advertisers = data


				callback.call self, null, result