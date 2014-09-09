FS = require 'fs'

Model = require './model'

module.exports = (request, response, next)->

	response.locals.TITLE = 'reporte'
	
	Model request, (error, data) ->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()

		x = 'Reporte 3 al 6 de Septiembre 2014'
		for user in data
			ﬁ.log.debug 'la fecha es ' + user._id.getTimestamp()
			x += "\n Usuario: #{user.name_first} #{user.name_last1} Correo: #{user.email} Fecha de Registro: #{user._id.getTimestamp()}"

		ﬁ.log.error '====='
		ﬁ.log.error x
		ﬁ.log.error '====='

		FS.appendFile 'message.txt', x, (err) ->
			throw err if err
			response.render
				data:data