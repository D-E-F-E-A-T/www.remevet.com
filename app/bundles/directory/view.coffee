$(document).ready ->

	initialize = ->
		infoWindow = new google.maps.InfoWindow(
			content : feature.description
		)

		lat = feature.lat
		long = feature.long
		myLatlng = new google.maps.LatLng(lat, long)
		mapOptions =
			zoom: 14
			center: myLatlng

		map = new google.maps.Map(document.getElementById("map"), mapOptions)
		marker = new google.maps.Marker(
			position: myLatlng
			map: map
			title: "#{feature.name}"
		)

		google.maps.event.addListener marker, "click", ->
			infoWindow.open map, marker

	google.maps.event.addDomListener window, "load", initialize

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

	$('.clinic').click ->
		lati = $(this).data('lat')
		longi = $(this).data('long')

		infoWindow = new google.maps.InfoWindow(
			content : $(this).data('serv')
		)

		myLatlng = new google.maps.LatLng(lati, longi)
		mapOptions =
			zoom: 14
			center: myLatlng

		map = new google.maps.Map(document.getElementById("map"), mapOptions)
		marker = new google.maps.Marker(
			position: myLatlng
			map: map
			title: "demo"
		)
		google.maps.event.addListener marker, "click", ->
			infoWindow.open map, marker
