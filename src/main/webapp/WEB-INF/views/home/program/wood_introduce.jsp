<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<div class="sub_visual bg05">
			<h2>목재문화체험</h2>
			<p><i class="home_i"></i><span>목재문화체험</span><span class="last">목재 체험관 소개</span></p>
		</div>
		<!--<div class="contents sub_content">
			<p style="width: 102px; height: 122px; font-size: 36px;text-align: center;font-weight: 600; background-image: url(/images/common/ico_preparing.png); margin: 100px auto 0;"></p>
			<p style="padding: 30px 0; font-size: 36px;text-align: center;font-weight: 600;">개원 준비중입니다.</p>
		</div>-->
		<div class="contents sub_content full">
			<div class="theme_area">
				<div class="theme_txt">
					<p class="tit"><span class="c_main">양구 목재문화체험관</span>은 해발 450m의 자락에 조성되어 자연과 하나 됨을<br>느낄 수 있는 공간입니다.</p>
				</div>
				<div class="gallery_slide type2">
					<div class="swiper-container gallery-top">
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/wood_sd1_01.png)">목재문화체험관 외부 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/wood_sd1_02.png)">목재문화체험관 내부 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/wood_sd1_03.png)">목재문화체험관 내부 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/wood_sd1_04.png)">목재문화체험관 내부 사진</div>
							</li>
							<li class="swiper-slide">
								<div class="img_box" style="background-image:url(/images/sub/wood_sd1_05.png)">목재문화체험관 체험 사진</div>
							</li>
						</ul>
						<!-- Add Arrows -->
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>
				</div>
				<div class="theme_txt">
					<p class="txt">
						<span class="c_main">양구 목재문화체험관</span>은 해발 450m의 자락에 조성되어 자연과 하나 됨을 느낄 수 있는 공간이다.<br><br>
						또한 우리생활 속 목재의 쓰임새, 목재의 종류 등을 한 눈에 볼 수 있는 체험장과 전시관 어린이 놀이 시설 등 다양한 공간이 조성되어 있다.<br>
						목재체험을 통하여 나무를 활용, 사용법 및 지식을 습득하고 생활 공예품, 놀이기구, 학습기구 등 다양한 목제품을 직접 만지고 느끼는<br>
						체험의 장이 마련되어 있다.
					</p>
				</div>
				<div class="table_wrap color2">
					<p class="sub_txt_tit">양구 목재문화체험관</p>
					<table>
						<caption>양구 목재문화체험관 목록으로 주소, 전화번호, 입장시간, 체험료, 재료비, 관람료를 목록으로 표시합니다. </caption>
						<colgroup>
							<col class="colsize_wood_introduce" style="width: 260px">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="col">주소</th>
								<td>강원도 양구군 동면 원달길 185-5</td>
							</tr>
							<tr>
								<th scope="col">전화번호</th>
								<td>033-480-2537</td>
							</tr>
							<tr>
								<th scope="col">입장시간</th>
								<td>
									동절기 : 09:00 ~ 18:00 / 하절기 : 09:00 ~ 18:00 / 휴관 : 매주 월요일<br>
									<span class="c_main f14">*체험프로그램 참여시 폐장전 1시간 까지 입장</span>
								</td>
							</tr>
							<tr>
								<th scope="col">체험료</th>
								<td>
									大품 : 3,000원 / 中품 : 2,000원 / 小품 : 1,000원(체험프로그램 별도)<br>
									<span class="c_main f14">*단체 체험객은 사전 예약</span>
								</td>
							</tr>
							<tr>
								<th scope="col">재료비</th>
								<td>품목에 따라 변동</td>
							</tr>
							<tr>
								<th scope="col">관람료</th>
								<td>무료</td>
							</tr>
						</tbody>
					</table>
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
