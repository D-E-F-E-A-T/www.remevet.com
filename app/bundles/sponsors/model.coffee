Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'library'
	result     = articles:[], advertisers:[]

	collection.find(slug:'sponsor').sort(issue:-1).toArray (error, data)->
		if error or not data
			error =
				if error
				then message: [String error], status : 500
				else message: ['No se encontraron artículos'], status:403
			return callback.call self, error
		result.articles = data

		# Advertisers
		Advertisers (error, data)->
			callback.call(self,error) if error
			result.advertisers = data


			callback.call self, null, result
