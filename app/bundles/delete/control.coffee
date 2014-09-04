Model = require './model'

module.exports = (request, response, next)->

	if request.method is "GET"
		return response.render()

	else
		return ﬁ.log.debug '--ZZZ--- ' + JSON.stringify request.body

		ﬁ.log.debug 'ya pase post'

		Model request, (error, data)->
			if error
				response.status error.status
				response.flash 'notice-error', error.message
				return response.render()
			ﬁ.log.debug 'sin error en control'

			return response.redirect ﬁ.bundles['_home_']