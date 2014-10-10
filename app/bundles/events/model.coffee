Shuffle     = (require 'knuth-shuffle').knuthShuffle
Advertising = require './ads'

module.exports = (request, callback)->
	# Ads

	ADS = Shuffle(Advertising.slice(0))
	ads = s:[], m:[], l:[], x:[]
	while ADS.length
		tmp = ADS.splice(0,12)
		ads.x.push tmp
		ads.l.push(tmp.slice i, i+6) for i in [0..6] by 6
		ads.m.push(tmp.slice i, i+4) for i in [0..8] by 4
		ads.s.push(tmp.slice i, i+3) for i in [0..9] by 3


	self       = @
	collection = ﬁ.db.collection 'events'
	data       = {}

	collection.find(month:'Octubre').toArray (error, october) ->
		if error or not data
			error =
				if error
				then message: [String error], status: 500
				else message: ['No se encontraron eventos'], status: 403
			return callback.call self, error

		collection.find(month:'Noviembre').toArray (error, november) ->
			if error or not data
				error =
					if error
					then message: [String error], status: 500
					else message: ['No se encontraron eventos'], status: 403
				return callback.call self, error
			
			data.Noviembre  = november
			data.Octubre    = october

			callback.call self, null, data