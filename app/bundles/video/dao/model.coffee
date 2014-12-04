bcrypt = require 'bcrypt-nodejs'
Model = {}
properties = {

}

Model.next = (name, callback)->
	
	throw new ﬁ.error 'Expecting valid sequence name.' if not name
	self       = @
	collection = ﬁ.db.collection "sequence"
	name       += "_id" 
	collection.findAndModify({ _id: name }, [], { $inc: { seq: 1 } }, {}, (err, data)->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se pudo actualizar el índice.'], status: 403
			return callback.call self, error
		callback.call self, null, data.seq
	)

Model.execute = (query, callback)->

	throw new ﬁ.error 'Expecting a callback.' if not ﬁ.util.isFunction callback
	throw new ﬁ.error 'Expecting a query.' if not ﬁ.util.isDictionary query
	throw new ﬁ.error 'Expecting DML (data manipulation language).' if not query.action
	throw new ﬁ.error 'Expecting a collection mongo.' if not query.from

	self          = @
	collection    = ﬁ.db.collection query.from
	query.fields  = {} if not query.fields
	query.where   = {} if not query.where
	query.orderBy = {} if not query.orderBy
	query.options = {} if not query.options
	query.limit   = 0 if not query.limit
	query.skip    = 0 if not query.skip

	switch query.action
		when "select", "select_all"
			query.where = {} if query.action is 'select_all'
			for k, v of query.where
				if (k.indexOf "_", 0) is 0 and k isnt '_id'
					query.where[k] = bcrypt.hashSync v, ﬁ.settings.app.hashKey
			console.log query
			collection.find(query.where, query.fields).sort(query.orderBy).limit(query.limit).skip(query.skip).toArray (error, data)->
				if error or not data
					error =
						if error
						then message: [String error], status: 500
						else message: ['No se encontraron registros con tu búsqueda'], status: 403
					return callback.call self, error
				console.log data
				callback.call self, null, data
		when "insert"
			throw new ﬁ.error 'Expecting valid record.' if not query.values and not ﬁ.util.isDictionary query.values
			for k, v of query.values
				if (k.indexOf "_", 0) is 0 and k isnt "_id"
					query.values[k] = bcrypt.hashSync v, ﬁ.settings.app.hashKey

			operation = (query)->
				collection.insert query, (error, data)->
					if error or not data
						error =
							if error
							then message: [String error], status: 500
							else message: ['No se pudo guardar el registro.'], status: 403
						return callback.call self, error
					callback.call self, null, data

			if query.primary_key and query.primary_key is "auto"
				self.next query.from, (error, index)->
					if error or not index
						error =
							if error
							then message: [String error], status: 500
							else message: ['No se encontraron registros con tu búsqueda'], status: 403
						throw new ﬁ.error error
					query.values._id = index
					operation.call self, query.values
			else
				operation.call self, query.values

		when "delete", "delete_all"
			query.where = {} if query.action is 'delete_all'
			for k, v of query.where
				if (k.indexOf "_", 0) is 0 and k isnt '_id'
					query.where[k] = bcrypt.hashSync v, ﬁ.settings.app.hashKey
			collection.remove query.where, (error, data)->
				if error or not data
					error =
						if error
						then message: [String error], status: 500
						else message: ['No se pudo eliminar el registro.'], status: 403
					return callback.call self, error
				callback.call self, null, data
		when "update"
			throw new ﬁ.error 'Expecting valid record.' if not query.record and not ﬁ.util.isDictionary query.record
			for k, v of query.where
				if (k.indexOf "_", 0) is 0 and k isnt '_id'
					query.where[k] = bcrypt.hashSync v, ﬁ.settings.app.hashKey
			collection.update query.where, { $set: query.record }, (error, data)->
				if error or not data
					error =
						if error
						then message: [String error], status: 500
						else message: ['No se pudo actualizar el registro.'], status: 403
					return callback.call self, error
				callback.call self, null, data
		when "find_and_modify"
			throw new ﬁ.error 'Expecting valid record to modify.' if not query.modify and not ﬁ.util.isDictionary query.modify
			if query.modify.$set
				for k, v of query.modify.$set
					if (k.indexOf "_", 0) is 0 and k isnt '_id'
						query.modify.$set[k] = bcrypt.hashSync v, ﬁ.settings.app.hashKey
			
			collection.findAndModify(query.where, [], query.modify, query.options, (error, data)->
				if error or not data
					error =
						if error
						then message: [String error], status: 500
						else message: ['No se pudo actualizar el registro.'], status: 403
					return callback.call self, error
				callback.call self, null, data
			)
		else
			throw new ﬁ.error 'Expecting valid DML (data manipulation language).'

module.exports = Model