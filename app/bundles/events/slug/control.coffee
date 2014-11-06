Model = require './model'

module.exports = (request, response, next)->

	Model request, (error,data)-> response.render data