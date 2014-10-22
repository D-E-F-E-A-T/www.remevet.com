NodeMailer = require 'nodemailer'

mailer = NodeMailer.createTransport(
	service: 'Gmail'
	auth   :
		user: 'soporte@remevet.com'
		pass: 'R3m3\\/37.'
)

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
		to      : "beto@gik.mx"
		subject : "[CONTACTO REMEVET] #{request.param('subject')}"
		text    : """Usuario: #{request.param('name')}
			Correo: #{request.param('email')}
			Telefono: #{request.param('phone')}
			Ciudad: #{request.param('city')}
			se ha puesto en contacto atraveés de remevet.com su mensaje es: \n #{request.param('body')}"""

	mailer.sendMail message, (error, message)->
		return next(status:500, errors:[error]) if error
		ﬁ.log.debug "Mailed:", JSON.stringify message
		response.redirect ﬁ.bundles['_home_']
