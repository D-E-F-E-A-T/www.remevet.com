###
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

	# PDFs
	collection = ﬁ.db.collection 'pdf'

	pdfs = []
	self = @

	collection.find(slug:'pequenas-especies')
		.sort(issue:-1)
		.limit(2).toArray (error, data)->

			pdfs.push d for d in data

			collection.find(slug:'fauna-silvestre')
				.sort(issue:-1)
				.limit(2).toArray (error, data)->

					pdfs.push d for d in data

					collection.find(slug:'equinos')
						.sort(issue:-1)
						.limit(2).toArray (error, data)->

							pdfs.push d for d in data

							callback.call self, null,
								pdfs: pdfs




###
module.exports = (request, callback)->

	self       = 
	collection = ﬁ.db.collection 'pdf'
	data       = {}

	collection.find(slug:'pequenas-especies').sort(issue:-1).toArray (error, small)->
		if error or not data
			error = 
				if error
				then message: [String error], status: 500
				else message: ['No se han encontrado revistas'], status:403
			return callback.call self, error

		collection.find(slug:'equinos').sort(issue:-1).toArray (error, horses)->
			if error or not data
				error = 
					if error
					then message: [String error], status: 500
					else message: ['No se han encontrado revistas'], status:403
				return callback.call self, error

			collection.find(slug:'fauna-silvestre').sort(issue:-1).toArray (error, wild)->
				if error or not data
					error = 
						if error
						then message: [String error], status: 500
						else message: ['No se han encontrado revistas'], status:403
					return callback.call self, error

				data.horses = horses
				data.small  = small
				data.wild   = wild



				callback.call self, null, data