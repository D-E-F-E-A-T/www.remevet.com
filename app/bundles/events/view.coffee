$document.readyStack.push ->

$("#calendar").fullCalendar
	header :
		left   : "title"
		center : ""
		rigth  : "Hoy Ant, Post"

	editable : true
	theme    : true
	events   : "https://www.google.com/calendar/feeds/m3t2rshvq1v31sa9nseqbaou94%40group.calendar.google.com/public/basic"
	height   : 550
