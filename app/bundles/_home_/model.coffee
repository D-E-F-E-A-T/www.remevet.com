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
								ads: ads
###
module.exports = (request, callback)->

	collection = ﬁ.db.collection 'pdf'

	pdfs = []
	self = @

	aggregator = []

    # Agrupa por "slug" y determina el máximo de "issue",
    # pasa los fields "tal cual" usando $first
	aggregator.push	$group:
		_id   : "$slug"
		issue : $max   : "$issue"
		name  : $first : "$name"
		file  : $first : "$file"
		image : $first : "$image"


    # Renombra el resultado anterior,
    # impide que _id se publique y mapea su resultado a "slug",
    # los demas pasan "tal cual"
	aggregator.push $project:
		slug:"$_id",_id:0,issue:1,name:1,file:1,image:1

	collection.aggregate aggregator, (error, data)->
		return callback.call(self, (message:[String error], status:500)) if error
		callback.call self, null,data
###