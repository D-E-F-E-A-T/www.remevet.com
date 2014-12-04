Model = require '../../dao/model'
NodeMailer = require 'nodemailer'
Crypto = require 'crypto'

mailer = NodeMailer.createTransport
	service: 'Gmail'
	auth   :
		user: ﬁ.settings.email.user 
		pass: ﬁ.settings.email.password 

module.exports = (request, response, next)->

	return response.render() if request.method is 'GET'

	request.assert('email'  , 'El correo electrónico que ingresaste no es válido.').notEmpty().isEmail()

	content = ﬁ.util.makeid()

	if content
		query = 
			"action" : "find_and_modify"
			"from"   : "user"
			"where"  : 
				"email" : request.body.email
			"modify" :
				$set :
					"_password" : content

		Model.execute query, (error, data)->
			if error
				response.flash 'notice-error', ['El correo electrónico no está registrado.']
				return response.redirect ﬁ.bundles['auth/recovery']

			cipherEmail = Crypto.createCipher('aes-256-cbc', ﬁ.settings.app.secret)
			cipherEmail.update(request.body.email, 'utf8', 'base64')
			encryptedEmail = cipherEmail.final('base64')

			cipherPass = Crypto.createCipher('aes-256-cbc', ﬁ.settings.app.secret)
			cipherPass.update(content, 'utf8', 'base64')
			encryptedPass = cipherPass.final('base64')

			link = ﬁ.settings.domain.video+"password/change/recovery/"+encryptedEmail.replace('+','%2B').replace('/','%2F')+"/"+encryptedPass.replace('/','%2F')

			message =
				from    : ﬁ.settings.email.user
				to      : request.body.email
				subject : "Recuperación de contraseña exitosa."
				html    : "<p> Tu contraseña temporal es:<b> #{content}</b>"+
						  "<p> Da clic al siguiente enlace: #{link}"


			mailer.sendMail message, (error, message)->
				if error
					return response.render()
				else  
					ﬁ.log.debug "Mailed:", JSON.stringify message
					response.flash 'notice-error', ['Tu contraseña ha sido enviada a tu correo electrónico.']
					return response.redirect ﬁ.bundles['auth/recovery']
