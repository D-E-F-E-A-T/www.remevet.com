module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'events'
	data       = {}

	collection.find(month:'Octubre').toArray (error, october) ->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron eventos'], status: 403
			return callback.call self, error

		collection.find(month:'Noviembre').toArray (error, november) ->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se encontraron eventos'], status: 403
				return callback.call self, error
			
			data.Noviembre  = november
			data.Octubre    = october

			callback.call self, null, data