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