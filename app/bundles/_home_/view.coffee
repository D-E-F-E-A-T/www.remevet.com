$document.readyStack.push ->

	$covr = $ '.cover.cover-fit'
	$elem = $covr.find('article > *').first()
	$covr.height $elem.height()


$window.loadStack.push ->

	$contain  = $('.cover:not(.cover-fit) .cover-contain')
	$cover    = $contain.closest('.cover')
	$articles = $contain.find '> *'

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

	setInterval	cback, timer