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
			<h2>DMZ야생화분재원</h2>
			<p><i class="home_i"></i><span>DMZ야생화분재원</span><span class="last">분재원 소개</span></p>
		</div>
		<!--<div class="contents sub_content">
			<p style="padding: 150px 0; font-size: 36px;text-align: center;font-weight: 600;">준비중입니다.</p>
		</div>-->
		<div class="contents sub_content full">
			<div class="theme_area">
				<div class="theme_txt">
					<p class="tit">DMZ야생화분재원은 DMZ 인근 남한 최북단에 서식하는 북방계식물 및 희귀자생식물의 <br> 보존 및 증식을 위해 <span class="c_main">자연 그대로의 모습을 분재 형태로 재현한 분재원입니다.</span></p>
					<p class="txt">양구는 DMZ와 접경지역이며 민간인통제구역으로 오랫동안 <span class="c_main">생태 그대로의 숲</span>이 잘 보존되어 오고 있습니다.</p>
				</div>
				<div class="gallery_slide type2">
					<div class="swiper-container gallery-top">
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/bonsai_sd1_01.png)">분재원1 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/bonsai_sd1_02.png)">분재원2 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/bonsai_sd1_03.png)">분재원3 사진</div>
							</li>
						</ul>
						<!-- Add Arrows -->
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>
				</div>
			</div>
			<div class="layout_bg">
				<div class="layout_map">
					<div class="img_box ibm_04" style="background-image: url(/images/sub/layout_map03.png);"></div>
					<div class="txt_box">      
						<span class="tit"><strong>DMZ야생화분재원</strong> <br>배치도</span>       
						<div class="list_info row100">          
							<p><em>01.</em><span>유락저 (流樂貯) - 흐르는 즐거움을 쌓자 <br><em class="gray">계곡 주변에 물가식물과 괴석식물, 분재가 전시되는 곳</em></span></p>
							<p><em>02.</em><span>유람정 (流覽停) - 유람하다 머물다 가는 곳<br><em class="gray">저수지와 분재원을 한 눈에 관람하시며 휴식을 <br> 즐기실 수 있는 곳</em></span></p>
							<p><em>03.</em><span>해암정 (解巖庭) - 돌로인해 깨닫는 뜰<br><em class="gray">전국 다양한 분재의 모습을 관람하실 수 있는 곳</em></span></p>
							<p><em>04.</em><span>선비천 (仙飛泉) - 선인이 나는 샘<br><em class="gray">계곡과 어우러진 암석원과 음지식물을 관람하시는 곳</em></span></p>
							<p><em>05.</em><span>소분지 (消憤知) - 분노를 해소할 방법을 알다<br><em class="gray">식재된 희귀자생식물과 분재가 전시되는 곳</em></span></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
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
