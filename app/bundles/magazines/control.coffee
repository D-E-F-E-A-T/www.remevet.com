Model = require './model'

module.exports = (request, response, next) ->

	response.locals.TITLE = 'Revistas'

	Model request, (error, data)->
		if error
			response.status = error.status
			response.flash 'notice-error', error.message
			return response.render()
		response.render
			data: data
			breadcrumbs: [
				name:"Revistas"
				href:ﬁ.bundles['magazines']
			]



	# equinos = [{"linkIframe":"https://www.yumpu.com/es/document/embed/fqKvuzlbz0f3ExsR", linkA:"https://www.yumpu.com/es/document/view/26760644/revision-medica-equina-23"},{"linkIframe":"https://www.yumpu.com/es/document/embed/1mmaIssI0VVST1FD", linkA:"https://www.yumpu.com/es/document/view/26760647/revision-medica-equina-22"},{"linkIframe":"https://www.yumpu.com/es/document/embed/MIfDU0EP8EBo3H5l", linkA:"https://www.yumpu.com/es/document/view/26760642/revision-medica-equina-21"},{"linkIframe":"https://www.yumpu.com/es/document/embed/x1q109nEa70gfePn", linkA:"https://www.yumpu.com/es/document/view/26760640/revision-medica-equina-20"}]
	# response.render
	# 	equinos : equinos
