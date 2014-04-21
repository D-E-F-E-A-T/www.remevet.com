$document.readyStack.push ->
    $('section[data-type="background"').each ->
        $bgobj = $(this)
        $(window).scroll ->
            yPos = -($window.scrollTop() / $bgobj.data("speed"))
            coords = "50% " + yPos + "px"
            $bgobj.css backgroundPosition: coords
