$document.readyStack.push ->

	$content = $('#content')
	$section = $content.find('section')

	$content.offsetTop = $content.offset().top

	update = ($e)->
		$ = $e[0].$
		# determine the real height of background, based upon current width.
		$.width     = $e.width()
		$.bg.width  = Math.ceil $.width
		$.bg.height = Math.ceil $.bg.width * ($.bg.orig.height / $.bg.orig.width)

		return true if $.bg.height >= $.visibleArea

		# adapt visible area to fit smaller bg height
		$.visibleArea = $.bg.height
		$e.css
			paddingBottom      : "#{$.bg.height}px"
			backgroundPosition : "center bottom"
		return false

	onChange = -> $section.each ->
		$this     = $(@)
		@$.scroll = (@$.offsetTop - $content.offsetTop) - $window.scrollTop()

		# continue only if the element is visible and the space is > bg.height
		#return true if (@$.scroll > 0 or @$.scroll <= (@$.outerHeight * -1))
		return true if not update($this)

		# How many pixels shoud be advanced in scale?
		@$.scale = Math.abs(@$.scroll) * ( @$.visibleArea / @$.outerHeight)
		@$.pos   = Math.floor (@$.outerHeight - @$.bg.height) + @$.scale

		$this.css backgroundPosition: "center #{@$.pos}px"

	# POsition all section backgrounds
	$section.each ->
		$this = $(@)
		@$    = {}

		@$.height      = $this.height()
		@$.outerHeight = $this.outerHeight()
		@$.offsetTop   = $this.offset().top
		@$.outerWidth  = $this.outerWidth()
		@$.visibleArea = @$.outerHeight - @$.height

		@$.bg      = {}
		@$.bg.orig = $this.data 'bg'

		# continue only if the element is visible and the space is > bg.height
		return true if not update($this)

		@$.pos = @$.outerHeight - @$.bg.height
		$this.css backgroundPosition: "center #{@$.pos}px"

	return false if not IS_DESKTOP

	# everytime the window scrolls, move the background
	$window.scroll onChange
	$window.resize onChange
