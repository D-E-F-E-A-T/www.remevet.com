module.exports = (request, response, next)->

	response.render request.errors or {}