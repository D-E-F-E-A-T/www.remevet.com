Model = require '../../../dao/model'
Crypto = require 'crypto'

module.exports = (request, response, next)->
	if request.method is 'POST'
		if request.passwordTmp == request.passwordTmpEncryp

			query = 
				"action" : "find_and_modify"
				"from"   : "user"
				"where"  : 
					"email" : request.body.email
				"modify" :
					$set :
						"_password" : request.body._password

			Model.execute query, (error, data)->
				return next(status:500, errors:[error]) if error

				if data 
					response.flash 'notice-success', ["Se ha restablecido tu contraseña."]
					return response.redirect ﬁ.bundles['auth/sign_in']

		else
			return response.render
				error_tmp : true

	if request.method is 'GET'
		mail = request.param 'mail'.replace('%2B','+').replace('%2F','/')
		pass = request.param 'password'.replace('%2F','/')

		decipherMail = Crypto.createDecipher('aes-256-cbc', ﬁ.settings.app.secret)
		decipherMail.update(mail, 'base64', 'utf8')
		decryptedMail = decipherMail.final('utf8')

		decipherPass = Crypto.createDecipher('aes-256-cbc', ﬁ.settings.app.secret)
		decipherPass.update(pass, 'base64', 'utf8')
		decryptedPass = decipherPass.final('utf8')

		return response.render
			mail : decryptedMail
			pass  : decryptedPass
