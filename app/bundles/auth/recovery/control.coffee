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
				name:"Recuperar contraseña"
				href:ﬁ.bundles['auth/login']
			]

	return next() if request.method isnt 'POST'


	Model request, (error, data)->
		if error
			response.status error.status
			response.flash 'notice-error', error.message
			return response.render()

		message =
			from    : "soporte@remevet"
			to      : "#{request.body.mail}"
			subject : "Recuperación de contraseña"
			text    : "Gracias por utilizar REMEVET. Tu contraseña es #{data.password}"


		mailer.sendMail message, (error, message)->
			return next(status:500, errors:[error]) if error
			response.render
				breadcrumbs: [
					name:"Recuperar contraseña"
					href:ﬁ.bundles['recovery']
				]
				isPOST : true


