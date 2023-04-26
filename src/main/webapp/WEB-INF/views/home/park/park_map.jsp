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
			<p><i class="home_i"></i><span>수목원 소개</span><span class="last">찾아오시는 길</span></p>
		</div>
	
		<div class="contents sub_content">
			<div class="map_area">
				<div id="map"  style="height:580px;"></div> 
				<div class="map_caption">
					양구수목원 <span>(강원도 양구군 동면 숨골로 310번길 131)</span>
				</div>
			</div>
			<div class="map_info">
				<p class="title">
					양구수목원 찾아오시는 길
				</p>
				<dl>
					<dt>
						<em class="c_green">서울</em>
						<span class="tit">서울 방면</span>
					</dt>
					<dd>
						<p class="be"><span class="c_green">서울</span> → 춘천 → 배후령 → 양구송청삼거리 → <span class="last">양구수목원(151km, 2시간 소요)</span></p>
						<p class="be"><span class="c_green">서울</span> → 춘천(서울-춘천고속도로 경유) → 배후령 → <span class="last">양구송청삼거리 → 양구수목원(147km, 1시간 40분 소요)</span></p>
						<p class="be"><span class="c_green">서울</span> → 양평 → 홍천 → 신남 → 양구남면삼거리 → <span class="last">양구수목원(160km, 2시간 10분)</span></p>
					</dd>
					<dt>
						<em class="c_purple">부산</em>
						<span class="tit">부산 방면</span>
					</dt>
					<dd>
						<p class="be"><span class="c_purple">부산</span> → 경부고속도로 → 대구(금호분기점) → 중앙고속도로 → 홍천 → 신남 → 양구남면사거리 → <span class="last">양구수목원(464km, 5시간 소요)</span></p>
					</dd>
					<dt>
						<em class="c_sky">광주</em>
						<span class="tit">광주 방면</span>
					</dt>
					<dd>
						<p class="be"><span class="c_sky">광주</span> → 호남고속도로 → 대전(경부고속도로) → 중부고속도로 → 영동고속도로(호법) → 중앙고속도로(원주) → 홍천 → 신남 → <br>양구남면사거리 → <span class="last">양구수목원(488km, 5시간 30분 소요)</span></p>
					</dd>
				</dl>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=641324b46f57bc77184b8194aeed21b8"></script>
	<script charset="UTF-8" src="https://t1.daumcdn.net/mapjsapi/js/main/4.4.3/kakao.js"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=641324b46f57bc77184b8194aeed21b8"></script> -->
<script>
var mapContainer = document.getElementById('map'),
    mapOption = { 
        center: new kakao.maps.LatLng(38.1920423112882, 128.076277842835),
        level: 3
    };

var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</body>
</html>
