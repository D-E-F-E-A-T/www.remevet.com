Model = require './model'

module.exports = (request, response, next) ->

	response.locals.TITLE = 'Directorio'

	response.locals.SCRIPT = [
		(src:'https://maps.googleapis.com/maps/api/js?v=3.exp'),
	]

	Model request, (error, data) ->
		# ﬁ.log.debug '====== ' + JSON.stringify data.users
		for i in data.users
			console.log "#{i.name_first},#{i.name_last1},#{i.email},#{i._id.getTimestamp()}"

