# Node modules
FS = require 'fs'

# Utilities used by this control
Assets = require './util/assets'
Render = require './util/render'

module.exports = (request, response, next)->

	# if this is an asset request, handle it separatedly
	return Assets.apply(this, arguments) if request.params.file
	param  = request.params[0] or ''
	path   = ﬁ.bundles['magazine'].replace('/:file','')
	bundle = [ﬁ.path.bundles, 'magazine', 'bundles', param].join('/')
	console.info bundle
	FS.exists "#{bundle}.jade", (exists)->

		if not exists
			return response.end 'hola'
			return next(status: 404, message: "Página no encontrada.") 

		response.renderview bundle,
			LINK  : [(rel:"stylesheet", href:"#{path}/master.css")]
			SCRIPT: [(src:"#{path}/master.js")]
