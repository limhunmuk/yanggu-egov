<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<div class="sub_visual bg02">
			<h2>양구 수목원</h2>
			<p><i class="home_i"></i><span>양구 수목원</span><span class="last">수목원 테마 소개</span></p>
		</div>
		<!--<div class="contents sub_content">
			<p style="padding: 150px 0; font-size: 36px;text-align: center;font-weight: 600;">준비중입니다.</p>
		</div>-->
		<div class="contents sub_content">
			<div class="tab_area top">
				<ul class="tab_btn">
					<li><a href="/plant/botanical_list" class="btn">숲 키움터</a></li>
					<li class="on"><a href="/plant/botanical_list2" class="btn">숲 놀이터</a></li>
					<li><a href="/plant/botanical_list3" class="btn">숲 배움터</a></li>
				</ul>
			</div>
			<p class="sub_text pt60">
				<span class="c_main">피크닉 광장, 우주과학 놀이터, 연못과 노천극장 등</span><br> 식물원을 걷다보면 이색적으로 자리잡은 아이들의 공간이 있다. 아이들이 놀 수 있도록 낮은 계곡과<br> 외계, 우주캐릭터의 놀이터와 더불어 가족들의 소풍을 만끽할 수 있는 느티나무 그늘의 넓은 뜰도 조성되어 있다.
			</p>
			<ul class="month_tab c3">
				<li class="on"><a href="javascript:;" class="btn">우리과학 놀이터</a></li>
				<li><a href="javascript:;" class="btn">피크닉 광장</a></li>
				<li><a href="javascript:;" class="btn">연못과 노천극장</a></li>
			</ul>
			<ul class="tab_view">
				<li class="on">
					<div class="img_box"><img src="/images/sub/plant2_img01.png" alt=""></div>
					<div class="content_box">
						<p class="tit">우리과학 놀이터</p>
						<p class="txt">아이들이 좋아하는 외계캐릭터와 태양계를 모티브로 대형미끄럼틀, 달 크레이터 모양의 트럼블린, 우주선 발사대를 형상화한 포토존, 별자리 보기, 태양계 모형 등은 아이들에게 즐거움과 호기심을 갖게 하고 아름다운 풍경과 맑은 공기가 더해져 무한한 상상력의 세계로 아이들을 인도합니다.</p>
					</div>
				</li>
				<li>
					<div class="img_box"><img src="/images/sub/plant2_img02.png" alt=""></div>
					<div class="content_box">
						<p class="tit">피크닉 광장</p>
						<p class="txt">버섯동산을 형상화 하여 대암산 계곡물을 흐르는 낮은 계곡은 아이들이 안전하게 놀 수 있도록 조성 되어 있습니다. 넓은 잔디뜰의 느티나무 그늘아래에서 간단한 도시락을 가족과 먹으며 소풍을 즐겨보세요.</p>
					</div>
				</li>
				<li>
					<div class="img_box"><img src="/images/sub/plant2_img03.png" alt=""></div>
					<div class="content_box">
						<p class="tit">연못과 노천극장</p>
						<p class="txt">고목과 곤충으로 디자인 된 연못분수와 노천극장은, 보는 것 만으로도 동화 속에 있는 듯한 착각을 들게 합니다. 60여명의 아이들을 수용할 수 있는 노천극장과 동전을 던지며 행운을 기원하는 연못분 수에서 좋은 추억을 만들어 보세요.</p>
					</div>
				</li>
			</ul>
			<div class="btn_area">
				 <a href="#" class="btn w260">양구수목원 테마소개 이동</a> 
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			$(' .month_tab li .btn').on('click', function () {
				var tgIdx = $(this).parent().index();
				$(this).parent().addClass('on').siblings().removeClass('on');
				$('.tab_view').find('li').eq(tgIdx).addClass('on').siblings().removeClass('on');
			});
		</script>
	</div>
	<!-- //wrap -->
</body>
</html>
