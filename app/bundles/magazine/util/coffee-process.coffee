# TODO: Finish this, based upon fi/core/bundles:65

Path = require 'path'

extension = '.coffee'
regexReq  = /^(\s*)require\s*\(?["']([^"']+)["']\)?.*$/
paths     = [ﬁ.path.templates, ﬁ.path.bundles]

module.exports = (content='', opts={}, callback=(->))->

	if arguments.length is 2
		callback = opts
		opts     = {}
	
	lines   = content.split /[\r\n]/
	content = []

	for line,i in lines

		# just add lines that don't contain a "require"
		if not (match = line.match regexReq)
			str.push line
			continue
		
		# this line has a "require" directive
		indent = match[1]
		file   = "#{match[2]}#{extension}"


		

	