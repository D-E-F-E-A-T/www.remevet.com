module.exports = (request, response, next)->

	response.locals.TITLE = 'Aviso de Privacidad'
	
	response.render()