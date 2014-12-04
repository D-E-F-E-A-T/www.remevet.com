module.exports = (request)->
	return (
		error   : request.flash('notice-error')   or false
		info    : request.flash('notice-info')    or false
		success : request.flash('notice-success') or false
	)
