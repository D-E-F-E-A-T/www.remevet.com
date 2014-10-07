Model = require './model'

module.exports = (request, response, next)->

	Model request, (error,data)->

		response.render
			pdfs : data.pdfs
			ads  : data.ads
			eventos : data.eventos