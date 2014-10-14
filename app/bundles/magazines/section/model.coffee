module.exports = (data, callback)->

	self       = @
	collection = ﬁ.db.collection 'magazines'

	collection.find(slug:data).sort(issue:-1).toArray (error, data)->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron revistas con tu búsqueda'], status: 403
			return callback.call self, error
		callback.call self, null, data