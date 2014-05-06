# TODO: This should be handled by an extension of the "assets" core lib.

# Node Modules
FS = require 'fs'

# NPM (ﬁ) modules
Express = ﬁ.module 'express'
Coffee  = ﬁ.module 'coffee-script'
Stylus  = ﬁ.module 'stylus'
Nib     = ﬁ.module 'nib'

route = [ﬁ.path.bundles, 'magazine', 'assets'].join('/')
paths = [route, ﬁ.path.bundles, ﬁ.path.templates]

module.exports 	= (request, response, next)->

	# only serve valid file extensions.
	file    = String(request.params[0]).split('.')
	file[1] =
		if file[1] is 'css' then 'styl'
		else (if file[1] is 'js' then 'coffee' else false)

	filename = route + '/' + file.join('.')
	return next(status:404, message:"Invalid Extension.") if not file[1]

	onFileRead = (error, cont)->
		return next(status:500, message: error) if error

		cont = String cont
		mime = Express.mime.lookup request.url

		response.setHeader 'Vary'        , 'Accept-Encoding'
		response.setHeader 'Content-Type', "#{mime}; charset=utf-8"

		cont =
			if   file[1] is 'coffee'
			then Coffee.compile cont
			else Stylus(cont).set('paths', paths).use(do Nib).render()

		return response.end cont

	onFileCheck = (exists)->
		# Only continue when the file actually exists.
		return next(status:404, message: "File not found.") if not exists

		FS.readFile filename, onFileRead


	FS.exists filename, onFileCheck
