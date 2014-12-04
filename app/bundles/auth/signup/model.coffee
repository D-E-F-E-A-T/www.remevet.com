module.exports = (request, callback)->


	request.assert('name_first', 'Nombre(s) inválido').notEmpty()
	request.assert('name_last', 'Apellido(s) inválido').notEmpty()
	request.assert('gender', 'Género inválido.').notEmpty()
	request.assert('mail_1', 'Email inválido').notEmpty().isEmail()

	# TODO Sanitizar variables

	if (errors = request.validationErrors())
		return callback.call @, (message: errors.map((e)-> e.msg), status: 400)

	if request.body.mail_1 isnt request.body.mail_2
		console.log request.body.mail_1, request.body.mail_2
		return callback.call @, (message: ["Los emails no coinciden"], status:400)

	if request.body.pass_1 isnt request.body.pass_2
		console.log request.body.pass_1, request.body.pass_2
		return callback.call @, (message: ["Los password no coinciden"], status:400)

	collection = ﬁ.db.collection 'user'
	self = @

	# make sure no other user like this one exist
	collection.findOne {email:request.body.mail_1},{email:true}, (error, data)->
		if error or data
			console.info arguments
			error =
				if error
				then message: [String error], status: 500
				else message: ['El usuario ya existe'], status:403
			return callback.call self, error

		collection.insert
			signupDate : new Date()
			password   : request.body.pass_1
			name_first : request.body.name_first
			name_last1 : request.body.name_last
			gender     : request.body.gender
			interest   : request.body.interest
			degree     : request.body.degree
			country    : request.body.country
			state      : request.body.state
			town       : request.body.town
			email      : request.body.mail_1
			is_mailable: request.body.is_mailable,

			(error, data)->
				return callback.call(self,(message:[String error], status: 500)) if error
				data[0].type = 'user'
				callback.call self, null, data[0]