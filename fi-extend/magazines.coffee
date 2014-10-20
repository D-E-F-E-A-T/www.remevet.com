Path    = require 'path'
ShellJS = require 'shelljs/global'
path     = {}
path.abs = Path.resolve Path.join(ﬁ.path.static, ﬁ.settings.app.pdf.base)
path.rel = path.abs.replace ﬁ.path.static, ''
cmd      = "find #{path.abs} -type f -name '*.pdf'"

PDF = []

for file in exec(cmd, silent:true).output.split('\n')
	name = file.replace(path.abs,'').replace(/\.pdf$/,'').replace(/\/[^\/]+\//,'').split('-')

	continue if not name

	issue = parseInt(name.pop(),10) or 0
	slug  = name.join '-'
	name  = name.map((e)-> "#{e.charAt(0).toUpperCase()}#{e.substring(1)}").join ' '
	# la chaca
	name  = name.replace 'Pequenas', "Pequeñas"
	continue if not slug or not slug.length

	file = file.replace(ﬁ.path.static,'/static')

	PDF.push
		slug  : slug
		issue : issue
		name  : name
		file  : file
		image : file.replace('.pdf','.png')


collection = ﬁ.db.collection 'magazines'

collection.remove {}, (error, howmany)->
	throw new ﬁ.error error if error

	collection.insert PDF, (error, data)->
		throw new ﬁ.error error if error
		ﬁ.log.debug "Added PDFs to mongo.", JSON.stringify PDF
