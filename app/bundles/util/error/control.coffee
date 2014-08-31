module.exports = (request, response, next)->

	status =
		if request.errors and request.errors.status
		then request.errors.status
		else 500

	response.status status

	response.render
		errors: request.errors or {}
