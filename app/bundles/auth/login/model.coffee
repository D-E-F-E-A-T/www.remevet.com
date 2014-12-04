module.exports = (request, callback)->

	request.assert('mail', 'Dirección de correo inválida.').notEmpty().isEmail()
	request.assert('pass', 'Password inválido.').notEmpty()

	request.sanitize('pass').toString()

	if (errors = request.validationErrors())
		return callback.call @, (message: errors.map((e)-> e.msg), status: 403)

	self = @
	collection = ﬁ.db.collection 'user'

	# TODO : md5 comparisson should be done here
	collection.findOne (password: request.body.pass, email: request.body.mail),

		email      : true
		name_first : true
		name_last  : true
		interest   : true

		(error, data)->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No existe usuario con esa combinación'], status:403
				return callback.call self, error

			data.type = 'user'
			callback.call self, null, data