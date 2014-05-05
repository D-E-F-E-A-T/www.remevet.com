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

	FS.exists "#{bundle}.jade", (exists)->

		return next(status:404, message:"Not found.") if not exists

		response.renderview bundle,
			LINK  : [(rel:"stylesheet", href:"#{path}/master.css")]
			SCRIPT: [(src:"#{path}/master.js")]
