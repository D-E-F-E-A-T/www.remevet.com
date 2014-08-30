module.exports = (request, callback)->

	self       = @
	collection = ﬁ.db.collection 'pdf'
	data       = {}

	collection.find(slug:'pequenas-especies').sort(issue:-1).toArray (error, small)->
		if error or not data
			error = 
				if error
				then message: [String error], status: 500
				else message: ['No se han encontrado revistas'], status:403
			return callback.call self, error

		collection.find(slug:'equinos').sort(issue:-1).toArray (error, horses)->
			if error or not data
				error = 
					if error
					then message: [String error], status: 500
					else message: ['No se han encontrado revistas'], status:403
				return callback.call self, error

			collection.find(slug:'fauna-silvestre').sort(issue:-1).toArray (error, wild)->
				if error or not data
					error = 
						if error
						then message: [String error], status: 500
						else message: ['No se han encontrado revistas'], status:403
					return callback.call self, error

				data.horses = horses
				data.small  = small
				data.wild   = wild



				callback.call self, null, data