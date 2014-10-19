window.$window   = $ window
window.$document = $ document

$window.loadStack     = []
$document.readyStack  = []
$document.screenStack = []

$document.foundation().ready ->
	window.IS_DESKTOP = $('html').hasClass 'is_desktop'
	window.USER = $('#data user').data()

	$('#header-button').click ->
		$(this).parent().toggleClass 'toggle'

	require 'scripts/advertisers'

	# Execute all onReady functions
	(fn.call(this) if typeof fn is 'function') for fn in $document.readyStack

	# Execute all onLoad functions
	(fn.call(this) if typeof fn is 'function') for fn in $window.loadStack

	# Execute screen resize functions
	screenTimer = null
	screenFn = (e)->
		(fn.call(this) if typeof fn is 'function') for fn in $document.screenStack
		screenTimer = null

	$(window).resize ->
		clearTimeout(screenTimer) if screenTimer isnt null
		screenTimer = setTimeout(screenFn, 666)