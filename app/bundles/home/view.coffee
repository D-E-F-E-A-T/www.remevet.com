$(document).ready ->

	slickUpdate = (e)->
		$slides = $('#clients-slider .slide');
		$slides.height $slides.first().width()

	$('#cover-article').height $('#cover-welcome').outerHeight()

	$(window).resize ->
		$('#cover-article').height $('#cover-welcome').outerHeight()
		slickUpdate()


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
		onInit         : slickUpdate
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