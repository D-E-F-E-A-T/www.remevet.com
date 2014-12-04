(function() {
  window.$window = $(window);

  window.$document = $(document);

  $window.loadStack = [];

  $document.readyStack = [];

  $document.screenStack = [];

  $document.foundation().ready(function() {
    var $covr, $elem, fn, screenFn, screenTimer, _i, _j, _len, _len1, _ref, _ref1;
    window.IS_DESKTOP = $('html').hasClass('is_desktop');
    window.USER = $('#data user').data();
    $('#header-button').click(function() {
      return $(this).parent().toggleClass('toggle');
    });
    $covr = $('.cover.cover-fit');
    $elem = $covr.find('article > *').first();
    $covr.height($elem.height());
    (function() {
      var onScreen;
      onScreen = function() {
        var $slides;
        $slides = $('.advertisers-slider .slide');
        $slides.$img = $slides.find('img');
        $slides.$img.css({
          width: '100%'
        });
        return $slides.closest('.advertisers').height($slides.$img.first().width());
      };
      $('.advertisers-slider').slick({
        dots: false,
        infinite: true,
        speed: 500,
        slidesToShow: 8,
        slidesToScroll: 8,
        autoplay: true,
        autoplaySpeed: 10000,
        arrows: false,
        draggable: true,
        onInit: onScreen,
        responsive: [
          {
            breakpoint: 1080,
            settings: {
              slidesToShow: 6,
              slidesToScroll: 6
            }
          }, {
            breakpoint: 960,
            settings: {
              slidesToShow: 4,
              slidesToScroll: 4
            }
          }, {
            breakpoint: 480,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 3
            }
          }
        ]
      });
      return $document.screenStack.push(onScreen);
    })();
    _ref = $document.readyStack;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      fn = _ref[_i];
      if (typeof fn === 'function') {
        fn.call(this);
      }
    }
    _ref1 = $window.loadStack;
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      fn = _ref1[_j];
      if (typeof fn === 'function') {
        fn.call(this);
      }
    }
    screenTimer = null;
    screenFn = function(e) {
      var _k, _len2, _ref2;
      _ref2 = $document.screenStack;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        fn = _ref2[_k];
        if (typeof fn === 'function') {
          fn.call(this);
        }
      }
      return screenTimer = null;
    };
    return $(window).resize(function() {
      if (screenTimer !== null) {
        clearTimeout(screenTimer);
      }
      return screenTimer = setTimeout(screenFn, 666);
    });
  });

  /* Cuando en DOM de la página esta listo
  $document.ready ->
  	# $('.advertisers').fadeIn 'slow'
  	$('.advertisers-slider').fadeIn 'slow'
  	console.log '-->patrocinadores : visibles'
  
  	console.log '-->medida : ', $('.advertisers-slider img').eq(0).attr 'src'
  	console.log '-->medida h: ', $('.advertisers-slider img').eq(0).height()
  	console.log '-->medida w: ', $('.advertisers-slider img').eq(0).width()
  
  	$('.advertisers-slider .slider').height $('.advertisers-slider img').eq(0).width()
  */


}).call(this);
