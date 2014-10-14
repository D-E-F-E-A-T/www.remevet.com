window.$window   = $ window
window.$document = $ document

$document.readyStack = []

$document.foundation().ready ->
	window.IS_DESKTOP = $('html').hasClass 'is_desktop'
	window.USER = $('#data user').data()

	$('#header-button').click ->
		$(this).parent().toggleClass 'toggle'

	screenUpdate = (e)->
		$slides = $('#clients-slider .slide');
		$slides.height $slides.first().width()
		timer = null

	$(window).resize ->
		clearTimeout(timer) if timer isnt null
		timer = setTimeout(screenUpdate, 666)

	$('#clients-slider').slick
		dots           : false
		infinite       : true
		speed          : 500
		slidesToShow   : 8
		slidesToScroll : 8
		autoplay       : true
		autoplaySpeed  : 10000
		arrows         : false
		draggable      : true
		onInit         : screenUpdate
		responsive     : [{
			breakpoint         : 1080
			settings           :
				slidesToShow   : 6
				slidesToScroll : 6
			},{
			breakpoint         : 960
			settings           :
				slidesToShow   : 4
				slidesToScroll : 4
			},{
			breakpoint         : 480
			settings           :
				slidesToShow   : 3
				slidesToScroll : 3
		}]

	# Execute all onReady functions
	(fn.call(this) if typeof fn is 'function') for fn in $document.readyStack


