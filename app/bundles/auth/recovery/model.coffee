module.exports = (request, callback)->

	request.assert('mail', 'Dirección de correo inválida').notEmpty().isEmail()

	if (errors = request.validationErrors())
		return callback.call @, (message: errors.map((e)-> e.msg), status: 403)

	self = @
	collection = ﬁ.db.collection 'user'

	collection.findOne (email: request.body.mail),
		email    : true
		name     : true
		password : true

		(error, data)->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No existe el correo electónico'], status:403
				return callback.call self, error

			callback.call self, null, data

