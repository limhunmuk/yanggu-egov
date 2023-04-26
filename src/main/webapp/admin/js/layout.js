function PopupCenter(url, title, w, h) {
    // Fixes dual-screen position                         Most browsers      Firefox
    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : window.screenX;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : window.screenY;

    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
    var top = ((height / 2) - (h / 2)) + dualScreenTop;
    var newWindow = window.open(url, title, 'scrollbars=no, location=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

    // Puts focus on the newWindow
    if (window.focus) {
        newWindow.focus();
    }
}
function popup_layer(a_tag) {
	var $iframe = $("<iframe><\/iframe>");
	$iframe.attr("id", "popup_iframe");
	$iframe.attr("src", typeof a_tag == "string" ? a_tag : a_tag.href);
	$iframe.attr("allowtransparency", "true");
	$iframe.attr("scrolling", "yes");
	$("body").append($iframe);
	$("#popup_iframe").css({
		"width": "100%",
		"height": "100%"
	}).wrap("<div id='popup_iframe_wrap' style='background-color:transparent; overflow:scroll; -webkit-overflow-scrolling:touch; position:fixed; left:0; top:0; right:0; bottom:0; z-index:150'><\/div>");

	$("body").css({overflow:'hidden','height':'100%'});

	$("#popup_iframe_wrap").on("DOMNodeRemoved", function() {
		console.log("DOMNodeRemoved");
		$("body", parent.document).css({'overflow': 'auto', 'height': 'auto'});
	});

	return false;
}

function popup_layer_close() {
	if (parent) {
		console.log("popup_layer_close-parent");
		$("#popup_iframe_wrap", parent.document).remove();
		this.close();
	} else {
		console.log("popup_layer_close");
		$("#popup_iframe_wrap").remove();
	}

	return false;
}

$(document).ready(
	function() {
	$("li.btn_sub > a").click(
		function() {
			var submenu = $(this).next(".sub_menu");
			if (submenu.is(":visible")) {
				submenu.slideUp();
			} else {
				submenu.slideDown();
			}
		});
	$( "li.btn_sub > a" ).click(function() {
		$( this ).toggleClass( "skin_bg");
	});

	/* tab 적용  */
	/*function tabSplit () {
		$('.list_tab li a').on('click', function () {
			//1) 클릭한 버튼 부모li의 인덱스번호 변수 저장
			var tgIdx = $(this).parent().index();
			console.log(tgIdx);
			
			//2) .cnt > div 중에서 저장한 변수에 해당하는 인덱스번호만 보여지게 처리, 나머지 형제들은 숨기기
			$(this).closest('.content').find('.view > div').eq(tgIdx).addClass('on').siblings().removeClass('on');
			
			//3) 활성화된 li에 .on 추가하기
			$(this).parent().addClass('on').siblings().removeClass('on');
		});
	}
	tabSplit ();*/
	
	/*  버튼 신청완료 */
	function btn_op () {
	$('.btn_op0').hide();
	$('.btn_op1').on('click', function () {
		$(this).hide().next('.btn_op0').show();
	});
		
	/*  gnb 활성화 */
	}
	btn_op ();


	

 /* 모바일 gnb 오른쪽 메뉴 열림 */
	$('.m_header .btn_menu').on('click', function () {
		var sidemenu = $(".m_gnb_wrap");
		if( sidemenu.is(":visible") ){
			sidemenu.hide();
	        sidemenu.children(".m_gnb").animate({
	        right: '-88%'
	        }, 500);
		$('html').css({'overflow': 'auto', 'height': 'auto'}); //scroll hidden 해제
			}else{
			sidemenu.fadeIn();
	        sidemenu.children(".m_gnb").animate({
	        right: '0'
	        }, 500);
		$('html').css({'overflow': 'hidden', 'height': '100%'});
			}
		});
 /* 모바일 gnb 오른쪽 메뉴 닫힘 */
	$(".m_gnb_wrap .menu_close").click(function(){
        $(".m_gnb_wrap").children(".m_gnb").animate({
        right: '-88%'
        }, 500).parent(".m_gnb_wrap").fadeOut();
		$('html').css({'overflow': 'auto', 'height': 'auto'}); //scroll hidden 해제


    });
	$('.m_gnb .gnb_menu li button').on('click', function () {

	
	if($(this).parent().hasClass('on')) {

       $(this).parent().removeClass('on')

		 } else{

			$(this).parent().addClass('on').siblings().removeClass();
		}
		
	});
	
});

/*
$(document).ready(function () {
	function gnbOn () {
		var $gnb = $('#gnb > ul');
		var active = $('body').attr('id').split('_');
		var dep1 = active[1] - 1;
		console.log(active, dep1);
		

		
		$gnb.find('>li>a').on('mouseenter focus', function () {
			$gnb.find('>li.on').removeClass('on');
			$(this).next().show().parent().addClass('on');
		});
		
		$gnb.on('mouseleave', function () {
			$gnb.find('>li.on').removeClass('on');
			//인덱스 페이지가 아닌 경우만 제어
			if (dep1 >= 0) $gnb.children().eq(dep1).addClass('on');
		});
		
		$gnb.find('a:first, a:last').on('blur', function () {
			setTimeout(function () {
				if ( !$gnb.find('a').is(':focus') ) $gnb.trigger('mouseleave');
			}, 10);
		});
		
		//인덱스를 제외한 서브페이지일 경우 문서 로딩이 끝난후 초기화면 설정하기
		if (dep1 >= 0) $gnb.trigger('mouseleave');
		
	};
	gnbOn ()
});
*/