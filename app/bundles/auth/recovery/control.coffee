NodeMailer = require 'nodemailer'

mailer = NodeMailer.createTransport(
	service: 'Gmail'
	auth   :
		user: 'soporte@remevet.com'
		pass: 'R3m3\\/37.'
)
Model = require './model'

module.exports = (request, response, next)->
	response.locals.TITLE = 'Recupera tu contraseña'
	if request.method is 'GET'
		return response.render
			breadcrumbs: [
				name:"Entrar"
				href:ﬁ.bundles['auth/login']
			,
				name:"Recuperar contraseña"
				href:ﬁ.bundles['auth/recovery']
			]

	return next() if request.method isnt 'POST'
	return next(status:403, errors:['Los correos no coinciden'], message:['Los correos no coinciden']) if request.body.mail isnt request.body.mail2


	Model request, (error, data)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render()

		message =
			from    : "soporte@remevet"
			to      : "#{request.body.mail}"
			subject : "Recuperación de contraseña"
			text    : "Hola #{data.name_first}.\n Tu contraseña es #{data.password}. \nREMEVET"


		mailer.sendMail message, (error, message)->
			return next(status:500, errors:[error]) if error
			ﬁ.log.debug "Enviando contraseña al correo #{data.email}"
			response.render
				breadcrumbs: [
					name:"Recuperar contraseña"
					href:ﬁ.bundles['auth/recovery']
				,
					name:"Entrar"
					href:ﬁ.bundles['auth/login']
				]
				isPOST : true


