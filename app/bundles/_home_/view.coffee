#$(document).ready ->
$window.loadStack.push ->

	$video    = $ 'video'
	$contain  = $ '.cover:not(.cover-fit) .cover-contain'
	$cover    = $contain.closest '.cover'
	$articles = $contain.find '> *'

	navegador = navigator.userAgent

	i = 0
	len = $articles.length
	width  = $contain.width()
	height = $contain.height()
	timer  = parseInt($contain.data('timeout'),10) * 1000
	cback = ->
		i++
		$video = $($articles[i]).find('> video')
		propCovr =
			height: (if $video.length then $video.height() else height)	
		propCont =
			left: (if i <= (len-1) then '-=' + width else '+=' + (i=0) + (width*(len-1)))
		$cover.animate propCovr, 333
		$contain.animate propCont, 333
	
			
	if navigator.userAgent.indexOf("Windows ") != -1
			
		
		coverSet   = -> $window.intervalCovr = setInterval cback, timer
		coverClear = -> clearInterval $window.intervalCovr

		coverSet()

		$window.blur coverClear

		$video.on 'play', coverClear
		$("video").on 'ended', coverSet
		$video.on 'pause', coverSet


	else	
			
		coverSet   = -> 
			console.log $("video").get(0).ended
			#clearInterval $window.videoInterval
			$window.intervalCovr = setInterval cback, timer
		coverClear = -> 
			clearInterval $window.intervalCovr
			# $window.videoInterval = setInterval videoPaused, 300

		do coverSet if not $window.intervalCovr

		
		#$window.focus coverSet
		$window.blur coverClear

		$("video").on 'play', coverClear
		$("video").on 'rewind',coverSet
		$("video").on 'pause', coverSet


