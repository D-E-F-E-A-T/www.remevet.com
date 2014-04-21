module.exports = (request, response, next)->

	###
		link(rel='stylesheet',    href='/static/bower_components/fullcalendar/fullcalendar.css')
		link(rel='stylesheet',    href='/static/bower_components/fullcalendar/fullcalendar.print.css')
		link(rel='stylesheet',    href='/static/bower_components/jquery-ui/jquery-ui-1.10.4.custom.css')

		script(src='/static/bower_components/jquery-ui/jquery-ui-1.10.4.custom.js')
		script(src='/static/bower_components/momentjs/moment.js')
		script(src='/static/bower_components/fullcalendar/fullcalendar.js')
		script(src='/static/bower_components/fullcalendar/gcal.js')
	###

	response.render()
