Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (data, callback)->

	self       = @
	collection = ﬁ.db.collection 'clinics'
	result     = small:[], horses:[], advertisers:[]

	collection
		.find(specialty:'small').toArray (error, small) ->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se encontraron clínicas'], status: 403
				return callback.call self, error
			result.small = data

		collection
			.find(specialty:'horses').toArray (error, horses) ->
				if error or not data
					error =
						if error
						then message: [String error], status: 500
						else message: ['No se encontraron clínicas'], status: 403
					return callback.call self, error
				result.horses = data
				Advertisers (error, data)->
					callback.call(self,error) if error
					result.advertisers = data
					callback.call self, null, data