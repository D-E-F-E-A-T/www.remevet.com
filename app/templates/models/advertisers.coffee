Shuffle = (require 'knuth-shuffle').knuthShuffle

module.exports = (type, callback)->

	self       = @
	callback   = type if arguments.length is 1
	collection = ﬁ.db.collection 'advertisers'

	collection.find().toArray (error, data)->
		callback.call(self, error, null) if error
		callback.call(self, null , Shuffle data)
