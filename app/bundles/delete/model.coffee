module.exports = (request, callback)->

	collection = ﬁ.db.collection 'events'
	self = @
	ﬁ.log.debug 'holllaaa'
	collection.insert
		name    : request.body.name
		slug    : ﬁ.util.toSlug request.body.name
		start   : request.body.start
		end     : request.body.end
		logo    : request.body.logo
		desc    : request.body.desc
		venue   : request.body.venue
		phone   : request.body.phone
		website : request.body.website
		month   : request.body.month,

		(error, data)->
			return callback.call(self,(message:[String error], status: 500)) if error
			ﬁ.log.debug 'sin error'
			callback.call self, null, data