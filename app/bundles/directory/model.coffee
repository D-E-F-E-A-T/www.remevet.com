Advertisers = ﬁ.require 'templates', 'models/advertisers'
module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'clinics'
	result     = clinics:[], advertisers:[]

	collection.find().toArray (error, data) ->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron clínicas'], status: 403
			return callback.call self, error

			callback.call self, null, data
		result.clinics = data
		Advertisers (error, data)->
			callback.call(self,error) if error
			result.advertisers = data


			callback.call self, null, result