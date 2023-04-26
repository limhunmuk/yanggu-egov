$(function(){
	/* 유틸메뉴,헤더 마우스 오버 */
	/*$('.pc .util_menu').on('mouseover focusin',function(){
		$(this).addClass('hover');
		$(this).siblings('header').addClass('hover');
	}).on('mouseout focusout',function(){
		$(this).removeClass('hover');
		$(this).siblings('header').removeClass('hover');
	});*/
	
	$('.pc header').on('mouseover focusin',function(){
		$(this).addClass('hover');
		$(this).siblings('.util_menu').addClass('hover');
	}).on('mouseout focusout',function(){
		$(this).removeClass('hover');
		$(this).siblings('.util_menu').removeClass('hover');
	});
	
	/* gnb메뉴 드롭다운*/
	$('#gnb .gnb > li').on('mouseover keyup',function(){
		$('#gnb .gnb > li > a').removeClass('on');
		$('#gnb .gnb > li .depth2').removeClass('selected');
		$(this).children('a').addClass('on');
		$(this).children('.depth2').addClass('selected');
	}).on('mouseout blur',function(){
		$('#gnb .gnb > li > a').removeClass('on');
		$('#gnb .gnb > li .depth2').removeClass('selected');
	});

	$('.depth2 .depth_list02 li:last').focusout(function(){
		$('#gnb .gnb > li > a').removeClass('on');
		$('#gnb .gnb > li .depth2').removeClass('selected');		
	});

	/* 모바일 gnb토글 */
	$('.gnb_list .list_tit').on('click', function(){
		if ($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).next('ul').slideUp();
		} else {
			$(this).closest('li').siblings('li').find('.list_tit').removeClass('on');
			$(this).closest('li').siblings('li').find('ul').slideUp();
			$(this).addClass('on');
			$(this).next('ul').slideDown();
		}
	});

	/* 빠른예약 탭 */
	$('.rs_tab .btn').on('click',function(){
		var rsIndex = $(this).index();
		$('.rs_tab .btn').removeClass('on');
		$('.rs_content').hide();
		$(this).addClass('on');
		$(this).parents('.rs_tab').siblings('.rs_content#rs_con'+ rsIndex).fadeIn();
	});
	
	/* sub_visual뎁스메뉴 드롭다운 */
	$('.tab_dep ul li').on('mouseover focusin',function(){
		$(this).addClass('hover');
		$(this).find('.depth02').stop().slideDown();
	}).on('mouseout focusout',function(){
		$('.tab_dep ul li').removeClass('hover');
		$('.tab_dep ul li .depth02').stop().slideUp();
	});
});

function btnTop() {
	$('body,html').animate({
	 scrollTop: 0
	}, 500);  
	return false;
}

/* 디바이스 사이즈 */
var windowWidth = $( window ).width();
if(windowWidth > 768) {
	$('html').addClass('pc');
} else if (windowWidth <= 768 && windowWidth > 640) {
	$('html').addClass('tablet');
} else {
	$('html').addClass('mobile');				
}

/* 스크롤 */
var didScroll;
var navScroll;

$(window).scroll(function(event){
	didScroll = true;
	navScroll = true;
}); 

setInterval(function() { 
	if (didScroll) { 
		hasScrolled(); 
		didScroll = false; 
	} 
}, 250);

function hasScrolled() {
	var $st = $(this).scrollTop();
	if ( $st > 351 ){
		$('.tablet header').addClass('hover');
	} else {
		$('.tablet header').removeClass('hover');
	}

	if ( $st > 169 ){
		$('.mobile header').addClass('hover');
	} else {
		$('.mobile header').removeClass('hover');
	}
}

setInterval(function() { 
	if (navScroll) { 
		navScrolled(); 
		navScroll = false; 
	} 
});

function navScrolled() {
	var $st = $(this).scrollTop();
	if ( $st > 492 ){
		$('.pc .sub_nav').addClass('fixed');
	} else {
		$('.pc .sub_nav').removeClass('fixed');
	}
	
	if ( $st > 161 ){
		$('.pc .member .sub_nav').addClass('fixed');
		$('.pc .mypage .sub_nav').addClass('fixed');
	} else {
		$('.pc .member .sub_nav').removeClass('fixed');
		$('.pc .mypage .sub_nav').removeClass('fixed');
	}
}

/* mobile_gnb */
function menuBtn() {
	$('html').css({'overflow': 'hidden', 'height': 'auto'});
	$('#mobile_gnb').fadeIn();
	$('#mobile_gnb .gnb_content').animate({
		left: 0,
		right: "98px",
	}, 500);
}

function menuClose() {
	$('html').css({'overflow': 'auto', 'height': 'auto'});
	$('#mobile_gnb').hide();
	$('#mobile_gnb .gnb_content').animate({
		left: "-500px",
		right: "100%",
	}, 500);
}

/* mobile_search */
function srchBtn() {
	$('html').css({'overflow': 'hidden', 'height': 'auto'});
	$('#mobile_srch').fadeIn();
}

function srchClose() {
	$('html').css({'overflow': 'auto', 'height': 'auto'});
	$('#mobile_srch').hide();
}

function shareClose() {
	$('.share_box').hide();
}