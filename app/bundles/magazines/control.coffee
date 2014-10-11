Model = require './model'

module.exports = (request, response, next)->

	Model request, (error,data)->

	
		response.render
			BREADCRUMBS: [
				name:"Revistas"
				href:ﬁ.bundles['calendar']
			]
			data:data
			ads  : data.ads
			pdfs : data.pdfs
			ads  : data.ads
