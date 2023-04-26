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
			<h2>DMZ야생동물생태관</h2>
			<p><i class="home_i"></i><span>DMZ야생동물생태관</span><span class="last">생태관  소개</span></p>
		</div>
		<!--<div class="contents sub_content">
			<p style="padding: 150px 0; font-size: 36px;text-align: center;font-weight: 600;">준비중입니다.</p>
		</div>-->
		<div class="contents sub_content full">
			<div class="theme_area">
				<div class="theme_txt">
					<p class="tit">DMZ야생동물생태관은 우리 아이들과 관람객들에게 동물들의 살아가는모습을 통해 <br><span class="c_main">자연의 중요성을 알리는 환경 교육의 계기가 되고자 합니다.</span></p>
				</div>
				<div class="gallery_slide type2">
					<div class="swiper-container gallery-top">
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/animal_sd1_01.png)">삵 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/animal_sd1_02.png)">여유 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/animal_sd1_03.png)">수리부엉이 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/animal_sd1_03.png)">하늘다람쥐 사진</div>
							</li>
						</ul>
						<!-- Add Arrows -->
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>
				</div>
				<div class="theme_txt">
					<p class="txt">
						양구는 DMZ와 접경지역이며 민간인통제구역으로 오랫동안 생태 그대로의 숲이 잘 보존되어 오고 있습니다. <br><br>
						오래전부터 양구군은 환경이 좋지 않거나 로드킬로 죽은 소중한 동물들의 서식을 기록하기 위하여 박제를 만들고 샘플을 저장하기 시작하여 지금의 생태관을 설립하게 되었습니다. DMZ의 축소판인 방산면, 해안면의 동물들의 서식형태를 조사, 기록하고 국내 희귀동물들의 유전자원 저장과 기록에 대한 주요기관으로 발전시켜나갈 예정입니다.<br><br>
						더 나아가 DMZ야생동물생태관이 단순한 전시 시설이 아니라 자연과 인간이 공존할 수 있는 중간지대로서, 인간이 자연속에서 어떻게 살아가고, 왜 자연을 지키고 보존해야 하는지를 보여주는 매개자로서 역할이 되고자 합니다.
					</p>
				</div>
			</div>
			<div class="layout_bg">
				<div class="layout_map">
					<div class="img_box ibm_03" style="background-image: url(/images/sub/layout_map02.png);"></div>
					<div class="txt_box">     
						<span class="tit"><strong>DMZ야생동물생태관 </strong> <br>배치도</span>       
						<div class="list_info">              
							<p><em>01.</em><span>기획전시실</span></p>
							<p><em>02.</em><span>DMZ영상실</span></p>
							<p><em>03.</em><span>생태갤러리</span></p>
							<p><em>04.</em><span>생태연구소</span></p>
							<p><em>05.</em><span>생태탐험존</span></p>
						</div>
						<div class="list_info">   
							<p><em>06.</em><span>미래존</span></p>
							<p><em>07.</em><span>체험존</span></p>
							<p><em>08.</em><span>포토존</span></p>
							<p><em>09.</em><span>수장고</span></p>
						</div>
					</div>
				</div>
			</div><!-- //layout_bg -->
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
