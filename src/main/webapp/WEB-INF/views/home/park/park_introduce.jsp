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
			<h2>수목원 소개</h2>
			<p><i class="home_i"></i><span>수목원 소개</span><span class="last">수목원 소개</span></p>
		</div>
		
		<div class="contents sub_content full pt0">
			<div class="full_bg">
				<div class="txt_wrap">
					<div class="txt_box">
						<span class="top">자연생태의 모든 것을 오감으로 느끼고 체험할 수 있는곳 </span>
						<span class="tit">양구수목원</span>
						<p class="txt">양구수목원은 수목원과 DMZ야생동물생태관, DMZ야생화분재원, DMZ무장애나눔숲길, <br>생태탐방로가 어우러진 자연 중심의 생태 타운입니다. <br> 자연생태가 잘 보존된 대암산 해발 450m의 자락에 조성되어 자연생태의 모든 것을 오감으로 느끼고<br> 체험할 수 있는 곳입니다. 살아있는 신비의 자연생태가 여러분을 기다리고 있습니다.</p>
						<div class="circle_list">
							<div class="swiper-container gallery-thumbs ">
								<ul class="swiper-wrapper">
									<li class="swiper-slide" style="background-image:url(/images/sub/park_list01.png)"><span>01</span></li>
									<li class="swiper-slide" style="background-image:url(/images/sub/park_list02.png)"><span>02</span></li>
									<li class="swiper-slide" style="background-image:url(/images/sub/park_list03.png)"><span>03</span></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="swiper-container gallery-top">
					<div class="swiper-wrapper">
						<div class="swiper-slide" style="background-image:url(/images/sub/park01.png)"></div>
						<div class="swiper-slide" style="background-image:url(/images/sub/park02.png)"></div>
						<div class="swiper-slide" style="background-image:url(/images/sub/park03.png)"></div>
					</div>
				</div>
			</div>
			<div class="cnt_wrap">
				<ul class="bevel_list">
					<li>
						<span class="top">개원일</span>
						<p class="txt"><em>양구수목원</em>2004년 04월 19일</p>
					</li>
					<li>
						<span class="top">개원일</span>
						<p class="txt"><em>DMZ야생동물생태관</em>2014년 07월 25일</p>
					</li>
					<li>
						<span class="top">개원일</span>
						<p class="txt"><em>DMZ야생화분재원</em>2017년 05월 30일</p>
					</li>
					<li>
						<span class="top">개원일</span>
						<p class="txt"><em>목재문화체험관</em>2020년 10월 25일</p>
					</li>
				</ul>
			</div>
			<div class="layout_bg type02">
				<div class="layout_map">
					<div class="img_box ibm_01" style="background-image: url(/images/sub/layout_map04_1.png);"></div>
					<div class="txt_box">     
						<span class="tit"><strong>양구수목원 </strong> <br>위치도</span>       
						<div class="list_info">              
							<p><em>A.</em><span>양구수목원 숲 배움터</span></p>
							<p><em>B.</em><span>양구수목원 숲 놀이터</span></p>
							<p><em>C.</em><span>양구수목원 숲 키움터</span></p>
							<p><em>D.</em><span>DMZ 야생동물생태관</span></p>
							<p><em>E.</em><span>DMZ 야생화분재원</span></p>
							<p><em>F.</em><span>목재문화체험관</span></p>
						</div>
					</div>
				</div>
			</div><!-- //layout_bg -->
			<div class="cnt_wrap">
				<ul class="bevel_info">
					<li>
						<div class="img_box" style="background-image: url(/images/sub/bevel_info01_ico.png);"></div>
						<div class="txt_box">
							<span class="tit">면적</span>
							<p>양구수목원 : 189,141㎡ <br> DMZ야생동물생태관 : 5,623㎡<br>DMZ야생화분재원 : 33,000㎡</p>
						</div>
					</li>
					<li>
						<div class="img_box" style="background-image: url(/images/sub/bevel_info02_ico.png);"></div>
						<div class="txt_box">
							<span class="tit">식물보유 현황</span>
							<p>초목류 : 히어리, 미선나무, 미스김라일락 등 90여종 <br>초화류 : 깽깽이풀, 모데미풀, 노루귀 등 170여종 <br>멸종위기식물 : 6종</p>
						</div>
					</li>
					<li>
						<div class="img_box" style="background-image: url(/images/sub/bevel_info03_ico.png);"></div>
						<div class="txt_box">
							<span class="tit">박제보유 현황</span>
							<p>산양, 여우 등 97종 153점</p>
						</div>
					</li>
					<li>
						<div class="img_box" style="background-image: url(/images/sub/bevel_info04_ico.png);"></div>
						<div class="txt_box">
							<span class="tit">분재보유 현황</span>
							<p>소나무, 소사나무, 향나무 등 1,500여점</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			var galleryThumbs = new Swiper('.gallery-thumbs', {
				spaceBetween: 14,
				slidesPerView: 4,
				freeMode: true,
				watchSlidesVisibility: true,
				watchSlidesProgress: true,
				touchRatio: 0,
				breakpoints: {
					1400: {
						slidesPerView: 4,
						spaceBetween: 14,
					},
					1: {
						slidesPerView: 'auto',
						spaceBetween: 16,
					},
				}

				 
			  
			});
			var galleryTop = new Swiper('.gallery-top', {
				effect: 'fade',
				autoplay:{
					delay: 4000,
				},

			  thumbs: {
				swiper: galleryThumbs
			  },
				

			});
		  </script>
	</div>        
	<!-- //wrap -->
</body>
</html>
