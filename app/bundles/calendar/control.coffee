module.exports = (request, response, next)->
	response.locals.TITLE = 'Eventos'
	response.render()