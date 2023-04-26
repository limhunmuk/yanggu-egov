$(document).ready(function () {

		var $win = $(window);
        var $header = $('#header');
		var scrollT = $win.scrollTop();

		if (scrollT >= 1) {
           $header.addClass('on on2')
         }
         else if (scrollT < 1) {
           $header.removeClass('on on2');
		}

		$win.on('scroll', function () {
			 var scrollT = $win.scrollTop();

			 if (scrollT >= 1) {
				$header.addClass('on on2');
			 }
			 else if (scrollT < 1) {
				$header.removeClass('on on2');
			 }
       });

	var $gnb = $('#gnb > ul');
	
	//1) depth2 ul 숨기기
	$('#header, depth2').on('mouseenter', function () {
		$(this).addClass('on');
	});

	$('#header').on('mouseleave', function () {
		$(this).removeClass('on');
	});

	$gnb.find('> li > a').on('mouseenter focus', function () {
		$(this).parent().addClass('on').siblings().removeClass('on').children('.depth2').hide();
		$(this).next().show().parent().addClass('on');
		$('#header').addClass('on');
	});
	
	$gnb.on('mouseleave ', function () {
		$gnb.find('> li.on').removeClass('on').children('.depth2').hide();
	});

	$gnb.find('a:first, a:last').on('blur', function () {
		setTimeout(function () {
			if ( !$gnb.find('a').is(':focus') ) $gnb.trigger('mouseleave');
		});
	});
	

	$('.site_box .site_chk .select').on('click', function(){
		$(this).toggleClass('on');
		$('.site_box .site_chk .link_box').slideToggle('fast');
	});
	$('.site_box .site_chk .link_box li:last-child').on('focusout', function(){
		$(this).parent().slideUp('fast');
	});
	
	$('.site_md li .link_box .link_btn').on('click', function () {
		$(this).toggleClass('on')
		$(this).next().slideToggle('fast');
		
	});

	 var footVisual = new Swiper('.foor_slide .swiper-container', {
      slidesPerView: 2,
      spaceBetween: 10,
        slidesPerGroup:1,
        keyboardControl: true,
        watchActiveIndex: true,
        //speed:600,
        loop:false, // http://cfl.niied.go.kr/agency/achieve_view?idx=15
		navigation: {
        nextEl: '.swiper-button-next.foot',
        prevEl: '.swiper-button-prev.foot',
      },
			autoplay:{
			delay: 3000,
			},
			keyboard: {
        enabled: true,
      },
			 breakpoints: {
			787: {
					touchRatio: 0,
				slidesPerView: 5,
				spaceBetween: 10
			},
		},

    });

	var top_banner = new Swiper('.top_banner .swiper-container', {
		effect: 'fade',
      pagination: {
        el: '.swiper-pagination.top',
        clickable: true,
        renderBullet: function (index, className) {
          return '<span class="' + className + '">0' + (index + 1) + '</span>';
        },
      },
    });
		$('.top_banner .close_btn_top ').on('click', function () {
			$('.top_banner').slideUp('fast');
		});
	
	 $(".foor_slide .box button").on('click',function(e){
       $(".span_btn.play").show();
	   $(".span_btn.stop").hide();
        footVisual.autoplay.stop();
    });

	 $(".span_btn.stop").on('click',function(e){
       $(this).hide();
       $(".span_btn.play").show();
        footVisual.autoplay.stop();
    });
    $(".span_btn.play").on('click',function(e){
        $(this).hide();
        $(".span_btn.stop").show();
        footVisual.autoplay.start();
    });

	$('.visual_list, .main_visual').addClass('on');

	$('.tab_dep ul li').on('mouseover focusin',function(){
		$(this).addClass('hover');
		$(this).find('.depth02').stop().slideDown('fast');
	}).on('mouseout focusout',function(){
		$('.tab_dep ul li').removeClass('hover');
		$('.tab_dep ul li .depth02').stop().slideUp('fast');
	});

	$('.foot_top .top_btn').click(function () {
         $('body,html').animate({
             scrollTop: 0  //탑 설정 클수록 덜올라간다
         }, 600);  // 탑 이동 스크롤 속도를 조절할 수 있다.
     });



/*------------------------------------ 모달팝업 ------------------------------------*/

	function modal () {
				//모달 열기 클릭 이벤트
				$('.open_btn').on('click', function (e) {
					e.preventDefault();

					//모달 닫기를 클릭한 경우 보내질 포커스를 변수에 저장
					var $tg = $(this);
					var $modalCnt = $( $(this).attr('href') );		//#modal1 => $('#modal1')
					var $closeBtn = $modalCnt.find('.close_btn');

					var $first = $modalCnt.find('[data-link="first"]');
					var $last = $modalCnt.find('[data-link="last"]');
					//1) 마스크만 동적생성
					$('#container, #contents').after('<div id="mask"></div>');
					
					//2) 열려진 브라우저 가운데 모달이 위치하도록 좌표지정
					$(window).on('resize', function () {
						var topPos = ($(this).height() - $modalCnt.outerHeight())/2;
						var leftPos = ($(this).width() - $modalCnt.outerWidth())/2;
						
						$modalCnt.css({top: topPos, left:leftPos});
					});
					$(window).trigger('resize');
					
					var $mask = $('#mask');
					
					//3) #mask, .modal_cnt를 눈에 보여지게 처리
					$mask.add($modalCnt).stop().fadeIn('fast');
					//4) 상세모달로 포커스 강제 이동 => 제거 : div 태그에 포커스를 가게 할 경우 스크린리더에서 div 내용 전부를 한번에 읽는다
					//$modalCnt.attr('tabIndex', 0).focus();
					$first.focus();
					/* 모달 닫기 이벤트 : 마스크와 모달은 서서히 사라지기 
					완료함수 => #mask remove, 모달 tabIndex제거, 열기 버튼으로 포커스 되돌려주기
					display:none prev(), next()로 선택이 X
					*/
					$closeBtn.on('click', function () {
						$mask.add($modalCnt).stop().fadeOut('fast', function () {
							$mask.remove();
							$tg.focus();
						});
					});
					
					$mask.on('click', function () {
						$closeBtn.click();
					});
					/* 포커스가 모달 밖으로 위치하면 사용자의 편의성을 위해 모달 닫기 => 처리 안함 
					대신 첫번째 영역에서 shift+tab을 누르면 모달의 마지막으로 포커스를 보내고
					마지막 영역에서 tab을 누르면 모달의 처음으로 포커스를 되돌려 순환하게 한다 = > 닫기를 누르기 전에는 포커스를 밖으로 나가게 하지 않는다
					*/
					$first.on("keydown", function (e) {
						if (e.keyCode==9 && e.shiftKey) {
							e.preventDefault();		//포커스 이동을 우선 막고 원하는 엘리먼트를 찾아 하단에서 포커스 이동시키기
							$last.focus();
						}
					});
					$last.on("keydown", function (e) {
						if (e.keyCode==9 && !e.shiftKey) {
							e.preventDefault();
							$first.focus();
						}
					});
					//esc 키를 누르면 모달 닫기
					$(window).on('keydown', function (e) {
						if (e.keyCode==27) $closeBtn.click();
					});
				});
			}
			modal ();


});
