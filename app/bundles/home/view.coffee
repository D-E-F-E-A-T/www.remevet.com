$(document).ready ->

	timer = null

	screenUpdate = (e)->
		$slides = $('#clients-slider .slide');
		$slides.height $slides.first().width()
		$('#cover-article').height $('#cover-welcome').outerHeight()
		timer = null

	$(window).resize ->
		clearTimeout(timer) if timer isnt null
		timer = setTimeout(screenUpdate, 500)

	$('#clients-slider').slick
		dots           : false
		infinite       : true
		speed          : 500
		slidesToShow   : 8
		slidesToScroll : 2
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