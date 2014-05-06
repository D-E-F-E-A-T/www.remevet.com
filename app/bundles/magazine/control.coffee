# Node modules
FS = require 'fs'

# Utilities used by this control
Assets = require './util/assets'
Render = require './util/render'

module.exports = (request, response, next)->


	isAsset = request.url.indexOf('/revista/assets') isnt -1

	# if this is an asset request, handle it separatedly
	return Assets.apply(this, arguments) if isAsset

	param  = request.params[0] or 'view'
	path   = ﬁ.bundles['magazine'].replace('/:file','')
	bundle = [ﬁ.path.bundles, 'magazine', 'bundles', param].join('/')

	FS.exists "#{bundle}.jade", (exists)->
		return next(status:404, message:"Not found.") if not exists

		response.renderview bundle, (LINK  : [], SCRIPT: [])


# (rel:"stylesheet", href:"#{path}/master.css")
# (src:"#{path}/master.js")
