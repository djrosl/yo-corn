$(function(){
	
	$('.slider').mobilyslider({
		transition: 'fade',
		animationSpeed: 800,
		bullets: true,
		arrowsHide: false,
		arrows:true,
	});
	
	$('.lang_selected').click(function(){
		$(this).parents('.lang').find('.hidden_lang').slideToggle(400);  
		$(this).parents('.lang').find('.lang_selected').toggleClass('is_open');
	   });
	   // footer
	   $('.bottom').click(function(){
		$(this).parents('.footer').find('.footer_hidden').slideToggle(400);  
		$(this).parents('.footer').find('.bottom').toggleClass('bottomis_open');
	   });
	   // menumobile
	   $('.menu_category').click(function(){
		$(this).parents('.menu_mobile').find('.sub_menu_mobile').slideToggle(400);  
	   });

	     $(document).ready(function() {
    $('.select').fancySelect();

    // Boilerplate
    var repoName = 'fancyselect'

    $.get('https://api.github.com/repos/octopuscreative/' + repoName, function(repo) {
     var el = $('#top').find('.repo');

     el.find('.stars').text(repo.watchers_count);
     el.find('.forks').text(repo.forks_count);
    });

    var menu = $('#top').find('menu');

    function positionMenuArrow() {
     var current = menu.find('.current');
     var offsetLeft = typeof current.offset() != 'undefined' ? current.offset().left : 0;

     menu.find('.arrow').css('left', offsetLeft + (current.outerWidth() / 2));
    }

    $(window).on('resize', positionMenuArrow);

    menu.on('click', 'a', function(e) {
     var el = $(this),
      href = el.attr('href'),
      currentSection = $('#main').find('.current');

     e.preventDefault();

     menu.find('.current').removeClass('current');

     el.addClass('current');

     positionMenuArrow();

     if (currentSection.length) {
      currentSection.fadeOut(300).promise().done(function() {
       $(href).addClass('current').fadeIn(300);
      });
     } else {
      $(href).addClass('current').fadeIn(300);
     }
    });

    menu.find('a:first').trigger('click')
   });
  $(function() {
   var pull  = $('#pull');
    search_mobile   = $('.wrap_search > div');
    search_mobileHeight = search_mobile.height();
	var pull2  = $('#pull2');
    menu_mobile   = $('.menu_mobile');
    menu_mobileHeight = menu_mobile.height();
	
   $(pull).on('click', function(e) {
    e.preventDefault();
    search_mobile.slideToggle();
   });
   $(pull2).on('click', function(e) {
    e.preventDefault();
	search_mobile.slideUp();
    menu_mobile.slideToggle();
	
	 });
  });

$('.close').click(function (){
	$('.popup4, .overlay4').css({'opacity': 0, 'visibility': 'hidden'});
	$(".wraper").removeClass("blurred");
});
$('.popup5 .close_window5, .overlay5').click(function (){
	$('.popup5, .overlay5').css({'opacity': 0, 'visibility': 'hidden'});
});
$('a.open_window5').click(function (e){
	$('.popup5, .overlay5').css({'opacity': 1, 'visibility': 'visible'});
	e.preventDefault();
});
	 $('.popup6 .close_window6, .overlay6').click(function (){
		$('.popup6, .overlay6').css({'opacity': 0, 'visibility': 'hidden'});
		
});
$('a.open_window6').click(function (e){
$('.popup6, .overlay6').css({'opacity': 1, 'visibility': 'visible'});
e.preventDefault();
});
	 $('.popup7 .close_window7, .overlay7').click(function (){
		$('.popup7, .overlay7').css({'opacity': 0, 'visibility': 'hidden'});
		
});
$('a.open_window7').click(function (e){
$('.popup7, .overlay7').css({'opacity': 1, 'visibility': 'visible'});
e.preventDefault();
});

});
