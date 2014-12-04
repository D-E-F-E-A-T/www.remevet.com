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

	$covr = $ '.cover.cover-fit'
	$elem = $covr.find('article > *').first()
	$covr.height $elem.height()

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

### Cuando en DOM de la página esta listo
$document.ready ->
	# $('.advertisers').fadeIn 'slow'
	$('.advertisers-slider').fadeIn 'slow'
	console.log '-->patrocinadores : visibles'

	console.log '-->medida : ', $('.advertisers-slider img').eq(0).attr 'src'
	console.log '-->medida h: ', $('.advertisers-slider img').eq(0).height()
	console.log '-->medida w: ', $('.advertisers-slider img').eq(0).width()

	$('.advertisers-slider .slider').height $('.advertisers-slider img').eq(0).width()###


# Cuando las imagenes de los patrocinadores se terminaron de cargar
# advertisers = $('.advertisers img')
# window.number_advertisers = advertisers.length
# window.counter_advertisers = 0
# console.log "-----#",window.number_advertisers
# console.log '-->patrocinadores : ocultos'
# $('.advertisers img').each ->
# 	$(this).load ->
# 		window.counter_advertisers++
# 		if window.counter_advertisers == window.number_advertisers
# 			$('.advertisers').css 'visibility', 'visible'
# 			$('.advertisers-slider').fadeIn 'slow'
# 			console.log '-->patrocinadores : visibles'