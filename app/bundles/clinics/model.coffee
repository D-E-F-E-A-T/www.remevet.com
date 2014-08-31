module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'clinics'
	data       = {}

	collection.find(specialty:'small').toArray (error, small) ->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron clínicas'], status: 403
			return callback.call self, error

		collection.find(specialty:'horses').toArray (error, horses) ->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se encontraron clínicas'], status: 403
				return callback.call self, error

			data.horses = horses
			data.small  = small

			callback.call self, null, data