<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<div class="sub_visual bg06">
			<h2>체험프로그램</h2>
			<p><i class="home_i"></i><span>체험프로그램</span><span>용늪 출입 신청</span></p>
		</div>
		<div class="contents sub_content">
			<div class="tit_area">
				<div class="tit_txt">	
					<p>양구수목원</p>
					<p class="tit">용늪 휴장 안내</p>
				</div>
				<div class="tit_sub">
					<span>지금은 대관신청 기간이 아닙니다.</span>
				</div>
			</div>
			<p class="tit_sub_txt">
				<span>양구수목원</span>
				반만년 생태계의 신비 <strong>대암산 용늪</strong>
			</p>
			<div class="sub_con">
				<p class="tit">대암산 용늪</p>
				<p>큰 바위산이라는 뜻은 대암산은 해발 1,304m로 산자락부터 정상까지 바위들로 이루어진 험한 산이다. 대암산 남서쪽 사면에 있는 1,280m의 구릉지대에 형성된 용늪은 북방계 식물이
				남하하다가 남방계 식물과 만나는 곳, 즉 북방계와 남방계 식물을 동시에 만날 수 있는 곳이기도 하다. 고위도 지역에서는 비교적 쉽게 찾아볼 수 있는 이탄습지로 우리나라 중북부지방에
				해당하는 지역에서는 매우 찾아보기 어려운 경우에 해당한다. 남한에서 처음 발견된 고층습원 용늪은 그 곳에 살고 있는 여러 희귀 동식물, 그리고 빼어난 자연 경관 때문에 환경부가
				습지보호지역(1999년)으로 지정하였고, 우리나라가 람사르 협약에 가입하면서 제일 먼저 등록한 습지이다. 역사적, 문학적 가치를 인정하여 문화재청에서는 천연보호구역(1973년)으로,
				산림청에서는 산람유전자원보호구역(2006년)으로 지정하였다.<p>
				<div class="gallery_slide type3">
					<div class="swiper-container gallery-top">
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/reserv_sd1_01.png)">용늪1 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/reserv_sd1_02.png)">용늪2 사진</div>
							</li>
						</ul>
						<!-- Add Arrows -->
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>
				</div>
			</div>
			<div class="sub_con">
				<p class="tit">용늪 서식 식물</p>
				<p>용늪에는 신사초, 복사초, 물이끼, 비로용담 등이 모여 습지식물의 천국을 이룹니다.<p>
				<ul class="img_list">
					<li>
						<img src="/images/sub/flower01.png" alt="기생꽃"/>
						<div class="txt">
							<p>기생꽃</p>
							<p>멸종위기 야생생물 2급</p>
						</div>
					</li>
					<li>
						<img src="/images/sub/flower02.png" alt="날개하늘나리"/>
						<div class="txt">
							<p>날개하늘나리</p>
							<p>멸종위기 야생생물 2급</p>
						</div>
					</li>
					<li>
						<img src="/images/sub/flower03.png" alt="닻꽃"/>
						<div class="txt">
							<p>닻꽃</p>
							<p>멸종위기 야생생물 2급</p>
						</div>
					</li>
					<li>
						<img src="/images/sub/flower04.png" alt="비로용담"/>
						<div class="txt">
							<p>비로용담</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			$('.calendar_box2 table  button.reserve').on('click', function () {
				$('.calendar_box2 table td').removeClass('on');
				$(this).parent().parent().addClass('on');
			});
			 
			//임시 스크립트(나중에 지울것)
			$('.calendar_box2 .clndr table td .reserve').on('click', function () {
				$('.sub_main.r_main .strong_txt').hide();
				$('.date_result').show();
			});

			var galleryTop = new Swiper('.gallery-top', {
			spaceBetween: 10,
			draggable: true,
			
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			  },
			});
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
