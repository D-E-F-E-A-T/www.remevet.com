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
		#autoplay       : true
		#autoplaySpeed  : 10000
		arrows         : false
		draggable      : true
		lazyLoad       : 'progressive'
		onInit         : slickUpdate
###
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
        dots: true
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
  ]
###