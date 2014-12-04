Model = require '../../dao/model'

module.exports = (request, response, next)->

	if request.method is 'POST'
		
		data = {
			"_id"	: request.body._id
			"name"	: request.body.name
			"lastname" : request.body.lastname
			"date"	: request.body.birth_date
			"gender" : request.body.gender
			"sign_up" : request.body.sign_up
			"email"  : request.body.email
			"_password" : request.body._password
		}

		console.log data	

		query = 
			"action" 	  : "insert"
			"from"   	  : "user"
			"values"  	  : data
			"primary_key" : "auto"

		Model.execute query, (error, data)->
			if error
				response.flash 'notice-error', [error.message]
				return response.redirect ﬁ.bundles['auth/sign_up']

			if data 
				response.flash 'notice-success', ['¡Gracias por registrarte!']
				return response.redirect ﬁ.bundles['auth/sign_in']

	else
		return response.render()