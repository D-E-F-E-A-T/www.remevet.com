$(document).ready ->

	timer = null

	screenUpdate = (e)->
		$slides = $('#clients-slider .slide');
		$slides.height $slides.first().width()
		$('#cover-article').height $('#cover-welcome').outerHeight()
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

	$('.event').click ->
		p   = $(this).data('p')
		img = $(this).data('img')

		$('#event p').text(p)
		$('#event img').attr("src", img)
		


