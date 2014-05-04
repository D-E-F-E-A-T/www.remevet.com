module.exports = (request, response, next)->
	return response.render() if request.method is 'GET'

	ﬁ.log.debug '---------> ' + JSON.stringify request.body.answer
	return response.end JSON.stringify '{status:ok, answer:correct}'
