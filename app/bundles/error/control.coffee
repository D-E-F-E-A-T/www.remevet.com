module.exports = (request, response, next)->

	return response.end JSON.stringify request.errors or {}

	#response.render request.errors or {}
