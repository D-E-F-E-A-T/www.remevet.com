module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'user'
	data       = {}

	collection.find().toArray (error, users) ->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron eventos'], status: 403
			return callback.call self, error

		callback.call self, null, users
