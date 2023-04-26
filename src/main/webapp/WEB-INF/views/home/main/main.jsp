<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</head>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">
		<%@ include file="../inc/gnb.jsp"%>
		
		<!-- PC popup -->
		<c:forEach items="${popupList}" var="pop" varStatus="index">		
			<div class="main_popup sec${index.count}" id="pop_main_${index.count}" style="display:none;">
				<div class="img_box">
					<a href="${pop.link}" <c:if test="${pop.kind eq 'a'}">target="_blank"</c:if>>
						<img alt="${pop.title}" src="/uploads/popup/${pop.attachment}">
					</a>
				</div>
				<div class="pop_bot">
					<div class="chk_area">
						<input id="pop0${index.count}" onclick="notice_closeWin('${index.count}');" type="checkbox" checked>
						<label class="chk" for="pop0${index.count}">
							<i class="ico_chk type02"></i>
							오늘하루 이 창을 열지 않음
						</label>
					</div>
					<button type="button" class="btn" onclick="LeyerPopupClose('${index.count}')">닫기</button>
				</div>
			</div>
		</c:forEach>
		<!-- PC popup -->

		<!-- mobile popup -->
		<div class="pop_bg_m dn"></div>
		<div class="popup_m dn">
			<div class="popup_m_top swiper">
				<div class="pop_slide_wrap swiper-wrapper">
					<c:forEach items="${popupList}" var="pop" varStatus="index">		
						<!-- 퍼블리싱 작업 위해 일부 클래스명 아이디명 변경 20220406 -->
						<div class="popup_slide_li swiper-slide" id="disable_pop_main_${index.count}">
							<div class="pop_m_image">
								<a href="${pop.link}" <c:if test="${pop.kind eq 'a'}">target="_blank"</c:if>>
									<img alt="${pop.title}" src="/uploads/popup/${pop.attachment}">
								</a>
							</div>
						</div>
						<!-- popup -->
					</c:forEach>
				</div>
				<button class="main_pop_btn main_pop_next"></button>
				<button class="main_pop_btn main_pop_prev"></button>
			</div>
			<div class="pop_m_bot">
				<label class="chk_area" for="pop_m_chk">
					<input id="pop_m_chk" type="checkbox">
					<div class="chk_in">
						<i class="ico_chk type02"></i>
						오늘 하루 보지 않기
					</div>
				</label>
				<div class="pop_m_close" onclick="LeyerPopupClose2()">닫기</div>
			</div>
		</div>
		
		<div class="main_visual">
			 <div class="swiper-container">
				<div class="sw_btn_wrap">
					<div class="box">
						<div class="swiper-pagination"></div><!--main_page m_on-->
						<button type="button" class="swiper-button-prev">이전</button>
						<button type="button" class="swiper-button-next">다음</button>
						<div class="control_box">
							<button type="button" class="span_btn swiper_stop" >정지</button>
							<button type="button" class="span_btn swiper_play" style="display: none;" >시작</button>
						</div>
					</div>
				</div>
				<ul class="swiper-wrapper">
					<li class="swiper-slide" style=" background-image: url(/img/visual_1.png);">
						<div class="info_wrap" data-aos="fade-right" data-aos-duration="1200" data-aos-delay="200">
							<span class="title"> 자연생태의 모든 것을 <br>  <em>오감으로 느끼고 체험할 수 있는 곳</em></span>
							<p>자연의 향기와 멋을 마음껏 즐길 수 있는 양구수목원</p>
							<a href="/plant/bonsai_introduce" class="btn">DMZ야생화분재원</a>
						</div>
					</li>
					<li class="swiper-slide" style=" background-image: url(/img/visual_2.png);">
						<div class="info_wrap">
							<span class="title"> 자연 그대로의 모습을   <br>  <em>분재형태로 체험 할 수 있는 곳</em></span>
							<p>자연의 향기와 멋을 마음껏 즐길 수 있는 양구수목원</p>
							<a href="/plant/bonsai_introduce" class="btn">DMZ야생화분재원</a>
						</div>
					</li>
					<li class="swiper-slide" style="background-image: url(/img/visual_3.png);">
						<div class="info_wrap" >
							<span class="title"> 자연의 신비, DMZ 야생동물 <br>  <em> 생태의 열쇠가 있는 곳</em></span>
							<p>자연의 향기와 멋을 마음껏 즐길 수 있는 양구수목원</p>
							<a href="/plant/bonsai_introduce" class="btn">DMZ야생화분재원</a>
						</div>
					</li>
				</ul>
			</div>
			<div class="visual_wrap">
				<div class="visual_list "  data-aos="fade-up" data-aos-duration="1500" data-aos-delay="700">
					<ul>						
						<li>
							<!-- 예약막기 <a href="/program/rsvList?gubun=3" class="link"> -->
							<a href="/program/reservation1">
							<!-- <a href="/program/" class="link"> -->
								<span>대암산 용늪<br>출입신청</span>
								<p>go</p>
							</a>
						</li>
						<li >
							<!-- 예약막기 <a href="/facility/reservation1" class="link"> -->
							<a href="http://www.ygtour.kr/user_sub.php?pagecode=01_02_02_04_00" target="_blank" title="새창 이동">
							<!-- <a href="/facility/" class="link"> -->
								<span>생태탐방로<br>둘러보기</span>
								<p>go</p>
							</a>
						</li><br class="br_768">
						<li>
							<a href="/program/wood_introduce">
								<span>목재문화<br>체험</span>
								<p>go</p>
							</a>
						</li>
						<li>
							<a href="/program/program_write">
								<span>체험프로그램<br>신청</span>
								<p>go</p>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<span class="scroll" style=""></span>
		</div>
		<div class="contents main_content">
			<div class="main_notice">
				<div class="list_wrap">
					<h2 class="title bd_on">공지사항 </h2>
					<div class="slide_for_pc">
						<ul>
							<c:forEach items="${noticeList}" var="Map1" varStatus="index1">
								<li>
									<div class="box">
										<a href="/bbs/notice_view?seq=${Map1.seq}" class="title"><span>${Map1.title}</span><i class="ico_new"></i></a>
										<span class="date">${Map1.insertDate}</span>
										<p class="txt">
											<a href="/bbs/notice_view?seq=${Map1.seq}">${Map1.content}</a>
										</p>
									</div>
								</li>
							</c:forEach>
							<!-- <li>
								<div class="box">
									<a href="#" class="title"><span>코로나 바이러스 감염증 안내해 드립니다.</span><i class="ico_new"></i></a>
									<span class="date">2020-04-24</span>
									<p class="txt">
										<a href="#">코로나바이러스감염증-19 예방 및 확산 방지를 위해 양구군에서 운영 관리하는 산림휴양시설을 아래와 같이 임시 휴관하고자 하오니, 이용에 참고하시기 바랍니다.</a>
									</p>
								</div>
							</li>
							<li>
								<div class="box">
									<a href="#" class="title"><span>코로나 바이러스 감염증 안내해 드립니다.</span><i class="ico_new"></i></a>
									<span class="date">2020-04-24</span>
									<p class="txt">
										<a href="#">코로나바이러스감염증-19 예방 및 확산 방지를 위해 양구군에서 운영 관리하는 산림휴양시설을 아래와 같이 임시 휴관하고자 하오니, 이용에 참고하시기 바랍니다.</a>
									</p>
								</div>
							</li>
							<li>
								<div class="box">
									<a href="#" class="title"><span>코로나 바이러스 감염증 안내해 드립니다.</span><i class="ico_new"></i></a>
									<span class="date">2020-04-24</span>
									<p class="txt">
										<a href="#">코로나바이러스감염증-19 예방 및 확산 방지를 위해 양구군에서 운영 관리하는 산림휴양시설을 아래와 같이 임시 휴관하고자 하오니, 이용에 참고하시기 바랍니다.</a>
									</p>
								</div>
							</li> -->
						</ul>
					</div>
					<div class="ovf_hidden swiper slide_for_m">
						<ul class="swiper-wrapper">
							<c:forEach items="${noticeList}" var="Map1" varStatus="index1">
								<li class="swiper-slide">
									<div class="box">
										<a href="/bbs/notice_view?seq=${Map1.seq}" class="title"><span>${Map1.title}</span><i class="ico_new"></i></a>
										<span class="date">${Map1.insertDate}</span>
										<p class="txt">
											<a href="/bbs/notice_view?seq=${Map1.seq}">${Map1.content}</a>
										</p>
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="main_board_prev"></div>
  						<div class="main_board_next"></div>
					</div>
					<a href="/bbs/notice_list" class="more_btn">더보기 </a>
				</div>
				<ul class="r_area">
					<li class="weather weather-api fr" tabindex="0">
						<iframe title="미세먼지 알림 영역" style="width: 310px; height: 95px; border: none" src="https://www.yanggu.go.kr/fnc_inc/weather_api_view.php"></iframe>
					</li>
					<li class="info_box">
						<span class="tit">체험 상담문의</span>
						<p>033) 480-7391</p>
						<em>상담시간: 09:00~18:00</em>
					</li>
					<li class="info_box">
						<span class="tit">용늪출입신청 상담문의</span>
						<p>033) 480-7393</p>
						<em>상담시간: 09:00~18:00</em>
					</li>
				</ul>
			</div><!-- //main_notice -->
			<div class="cnt_wrap">
				<h2 class="title ">갤러리 <span>양구수목원의 신비의 자연생태를 만나보세요 </span></h2>
				<div class="slide_for_pc">
					<ul class="main_gallery">
						<c:forEach items="${galleryList}" var="Map2" varStatus="index2">
							<li style="background-image: url('/uploads/gallery/${Map2.attachment}');">
								<a href="/bbs/gallery_view?seq=${Map2.seq}">
									<i></i>
									<p>${Map2.title}</p>
								</a>
							</li>
						</c:forEach>
						<!-- <li style="background-image: url(/images/main/gallery_bg01.png);">
							<a href="#">
								<i></i>
								<p>양구자연생태공원 가을전경 양구자연생태공원 가을전경 </p>
							</a>
						</li>
						<li style="background-image: url(/images/main/gallery_bg02.png);">
							<a href="#">
								<i></i>
								<p>양구자연생태공원 가을전경 양구자연생태공원 가을전경 </p>
							</a>
						</li>
						<li style="background-image: url(/images/main/gallery_bg03.png);">
							<a href="#">
								<i></i>
								<p>양구자연생태공원 가을전경 양구자연생태공원 가을전경 </p>
							</a>
						</li>
						<li style="background-image: url(/images/main/gallery_bg04.png);">
							<a href="#">
								<i></i>
								<p>양구자연생태공원 가을전경 양구자연생태공원 가을전경 </p>
							</a>
						</li> -->
					</ul>
				</div>
				<div class="ovf_hidden main_gallery_slide swiper slide_for_m">
					<ul class="main_gallery swiper-wrapper">
						<c:forEach items="${galleryList}" var="Map2" varStatus="index2">
							<li class="swiper-slide" style="background-image: url('/uploads/gallery/${Map2.attachment}');">
								<a href="/bbs/gallery_view?seq=${Map2.seq}">
									<i></i>
									<p>${Map2.title}</p>
								</a>
							</li>
						</c:forEach>
					</ul>
					<div class="main_board_prev"></div>
  					<div class="main_board_next"></div>
				</div>
				<a href="/bbs/gallery_list" class="more_btn">더보기 </a>
			</div>
			<div class="main_btm">
				<ul class="btm_list">
					<li>
						<span class="tit">확인하고 방문하세요!</span>
						<p>평일: 09~18시 / 토요일: 09~18시 <br> 매주 월요일 휴관 </p>
						<div class="btn_box">
							<a href="/park/park_guidance" class="btn">휴관일 안내<i></i></a>
						</div>
					</li>
					<li>
						<span class="tit">이렇게 찾아오세요!</span>
						<p>강원도 양구군 동면 숨골로 310번길</p>
						<div class="btn_box">
							<a href="/park/park_map" class="btn">길찾기<i></i></a>
						</div>
					</li>
					<li>
						<span class="tit">함께 이야기해요!</span>
						<p>양구수목원의 다양한 소식을<br>SNS를 통해 만나보세요!</p>
						<div class="sns_box">
							<a href="#" class="btn sns1">페이스북</a>
							<a href="#" class="btn sns2">유튜브</a>
							<a href="#" class="btn sns3">스토어</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
    /* 비쥬얼 슬라이드 */

    var swiperVisual = new Swiper('.main_visual .swiper-container', {
        slidesPerView: 1,
        slidesPerGroup:1,
		touchRatio: 1,
       // watchActiveIndex: false,

		effect : 'fade',

		speed: 1100,
        loop: true,
        
		autoplay:{
			delay: 3000,
			},
			
		navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
		pagination: {
        el: '.swiper-pagination',
			clickable: true,
      },
			breakpoints: {
			768: {
					touchRatio: 0,
			},
		}
    });

	/* popup swiper */
	var swiperPop = new Swiper ('.popup_m_top' , {
		loop: true,
		autoHeight: true,
		navigation: true,
		navigation: {
			nextEl: '.main_pop_next',
        	prevEl: '.main_pop_next',
		},
	});

	/* 공지사항 swiper */
	var swiperNotice = new Swiper('.main_notice .swiper', {
		slidesPerView: 2,
        slidesPerGroup:1,
		loop: true,
		navigation: true,
		navigation: {
			nextEl: '.main_board_next',
        	prevEl: '.main_board_prev',
		},
		breakpoints: {
			768: {
				slidesPerView: 3,
				slidesPerGroup:1,
			},
			1: {
				slidesPerView: 2,
				slidesPerGroup:1,
			},
		}
	});

	/* 갤러리 swiper */
	var swiperNotice = new Swiper('.main_gallery_slide.swiper', {
		slidesPerView: 2,
        slidesPerGroup:1,
		spaceBetween: 15,
		loop: true,
		navigation: true,
		navigation: {
			nextEl: '.main_board_next',
        	prevEl: '.main_board_prev',
		},
		breakpoints: {
			768: {
				slidesPerView: 3,
				slidesPerGroup:1,
			},
			1: {
				slidesPerView: 2,
				slidesPerGroup:1,
			},
		}
	});

	function updateSlides () {
		slides.find('.access').attr('tabindex','-1');
	}
	
    $(".main_page").find("span").attr('tabindex','0');
    $(".main_page span").keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
            $(this).trigger("click");
        }
    });
	$(".sw_btn_wrap .box button").on('click',function(e){	
       $(".swiper_play").show();
	    $(".swiper_stop").hide();
        swiperVisual.autoplay.stop();
    });

    $(".swiper_stop").on('click',function(e){
       $(this).hide();
       $(".swiper_play").show();
        swiperVisual.autoplay.stop();
    });
    $(".swiper_play").on('click',function(e){
        $(this).hide();
        $(".swiper_stop").show();
        swiperVisual.autoplay.start();

    });
	
	function notice_getCookie(name){ // 오늘 하루 안열기 확인
		    var nameOfCookie = name + "=";
			var x = 0;
			 while ( x <= document.cookie.length ){
                var y = (x+nameOfCookie.length);
                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                endOfCookie = document.cookie.length;
                        return unescape( document.cookie.substring( y, endOfCookie ) );
                }
                x = document.cookie.indexOf( " ", x ) + 1;
                if ( x == 0 )
                        break;
			}
			return "";
	}

	function LeyerPopupClose(idx){ // 레이어 그냥 닫기
		var oPopup = document.getElementById("pop_main_"+idx+"");
		oPopup.style.display = "none";
	}
	
	function LeyerPopupClose2() {
		if($("#pop_m_chk").is(":checked")){
			notice_closeWin('m');
		}
		
		document.querySelector('.pop_bg_m').classList.add('dn');
		document.querySelector('.popup_m').classList.add('dn');
	}

	function notice_setCookie( name, value, expiredays ){ // 오늘 하루 안열기
        var todayDate = new Date();
        todayDate.setDate( todayDate.getDate() + expiredays );
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
    }

	function notice_closeWin(idx){ // 오늘하루 안열기 설정하고 닫기
		//alert(sDivName);
        	notice_setCookie("pop_main_"+idx+"", "done" , 1); // 1=하룻동안 공지창 열지 않음
		var oPopup = document.getElementById("pop_main_"+idx+"");
        	
        if(idx != "m"){ //모바일 팝업에서 클릭한 게 아닐 경우
			oPopup.style.display = "none";
        } else {
//         	$(".pop_bg_m").addClass("dn");
// 			$(".popup_m").addClass("dn");
        }
	}

	function main_notice_ok(idx){
		//alert(sDivName);
		//alert(document.getElementById("pop_main_"+idx+""));
		if (notice_getCookie("pop_main_"+idx+"") == "done"){
			var oPopup = document.getElementById("pop_main_"+idx+"");
			oPopup.style.display = "none";
		}
		else
		{
			//var oPopup = document.getElementById("pop_main_"+idx+"");
			//oPopup.style.display = "block";
			$("#pop_main_"+idx+"").css("display","block");
		}
	}
	//alert(notice_getCookie("Notice_<?=$row[idx]?>"));
	
	//2022-04-06
	//모바일 or PC 팝업 구분
	window.onload = function(){
		if(window.innerWidth < 1400){ //모바일 팝업
			//PC용 팝업 보이지 않게
			$(".main_popup").css("display", "none");
		
			<%-- 오늘하루 열지 않기 팝업 닫기 --%>
			if (notice_getCookie("pop_main_m") == "done"){
				$(".pop_bg_m").addClass("dn");
				$(".popup_m").addClass("dn");
			} else {
				$(".pop_bg_m").removeClass("dn");
				$(".popup_m").removeClass("dn");
			}
		} else { //PC용 팝업
			//모바일용 팝업 보이지 않게
			$(".pop_bg_m").addClass("dn");
			$(".popup_m").addClass("dn");
			
			<%-- 오늘하루 열지 않기 팝업 닫기 --%>
			$.each($(".main_popup"), function(i) {
				main_notice_ok(i + 1);
			});
		}
	}
</script>
<script>
  AOS.init();
</script>
	</div>
	<!-- //wrap -->
</body>
</html>
