module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'articles'
	data       = {}

	collection.find(slug:'sponsor').sort(issue:-1).toArray (error, articles)->
		if error or not data
			error =
				if error
				then message: [String error], status : 500
				else message: ['No se encontraron artículos'], status:403
			return callback.call self, error
		callback.call self, null, articles
