window.$window   = $ window
window.$document = $ document

$document.readyStack = []

$document.foundation().ready ->
	window.IS_DESKTOP = $('html').hasClass 'is_desktop'
	window.USER = $('#data user').data()

	# Execute all onReady functions
	(fn.call(this) if typeof fn is 'function') for fn in $document.readyStack