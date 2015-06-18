$(function(){

	$(".welcome").fadeIn(1000,"swing").animate({letterSpacing: "+=10px"}, 1000).animate({letterSpacing: "-=10px"}, 1000);
	$(".instructions").delay(3000).fadeIn(1000,"swing");
	$(".dod").delay(6000).fadeIn(1000,"swing");
	$(".links").delay(8000).fadeIn(1000,"swing");
	$(".dod").delay(8000).addClass("animated infinite zoomIn");
});