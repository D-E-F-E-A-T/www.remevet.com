NodeMailer = require 'nodemailer'

mailer = NodeMailer.createTransport 'SMTP',
	service: 'Gmail'
	auth   :
		user: ''
		pass: ''

module.exports = (request, response, next)->

	response.locals.TITLE = 'Soporte'
	return response.render() if request.method is 'GET'

	request.assert('name'   , 'El nombre es inválido.').notEmpty()
	request.assert('email'  , 'El correo es inválido.').notEmpty().isEmail()
	request.assert('subject', 'El asunto es inválido.').notEmpty()
	request.assert('body', 'El contenido es inválido.').notEmpty()

	if (errors = request.validationErrors())
		return response.render(errors: errors.map (e)-> e.msg)

	message =
		from    : "#{request.param('name')} <#{request.param('email')}>"
		replyTo : "#{request.param('name')} <#{request.param('email')}>"
		to      : "beto@gik.mx,etor@gik.mx"
		subject : "[SUPPORT] #{request.param('subject')}"
		text    : request.param('body')

	mailer.sendMail message, (error, message)->
		return next(status:500, errors:[error]) if error
		ﬁ.log.debug "Mailed:", JSON.stringify message
		response.render
			BREADCRUMBS: [
				name:"Comunidad"
				href:ﬁ.bundles['community']
			]
			infos: ['Envío exitoso; nos pondremos en contacto a la brevedad.']
