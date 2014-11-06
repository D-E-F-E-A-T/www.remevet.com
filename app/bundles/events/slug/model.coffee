Advertisers = ﬁ.require 'templates', 'models/advertisers'

module.exports = (data, callback)->

	self   = @
	result = advertisers:[]

	# Advertisers
	Advertisers (error, data)->
		callback.call(self,error) if error
		result.advertisers = data

		# Ended
		callback.call self,result