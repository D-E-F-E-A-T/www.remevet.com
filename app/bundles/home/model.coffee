module.exports = (request, callback)->

	collection = ﬁ.db.collection 'pdf'

	pdfs = []
	self = @

	collection.find(slug:'pequenas-especies')
		.sort(issue:-1)
		.limit(1).toArray (error, data)->
			
			pdfs.push data[0]
			
			collection.find(slug:'fauna-silvestre')
				.sort(issue:-1)
				.limit(1).toArray (error, data)->

					pdfs.push data[0]

					collection.find(slug:'equinos')
						.sort(issue:-1)
						.limit(1).toArray (error, data)->

							pdfs.push data[0]

							callback.call self, null, pdfs
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