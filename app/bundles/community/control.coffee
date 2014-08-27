module.exports = (request, response, next) ->
	response.locals.TITLE = 'Comunidad'
	response.render()
