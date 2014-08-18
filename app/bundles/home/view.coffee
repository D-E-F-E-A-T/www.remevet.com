$(document).ready ->

	$('#cover-article').height $('#cover-welcome').outerHeight()

	$(window).resize ->
		$('#cover-article').height $('#cover-welcome').outerHeight()
