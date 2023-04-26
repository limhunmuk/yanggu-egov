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
					<li class="on"><a href="/plant/botanical_list" class="btn">숲 키움터</a></li>
					<li><a href="/plant/botanical_list2" class="btn">숲 놀이터</a></li>
					<li><a href="/plant/botanical_list3" class="btn">숲 배움터</a></li>
				</ul>
			</div>
			<p class="sub_text pt60">
				<span class="c_main">멸종위기식물보전원, 증식 시설, 유리온실 이야기 꽃 등</span><br> 재미난 이야기를 간직한 꽃들, 멸종위기식물 등  테마별로 꽃을 관람할 수 있는 공간이다.
			</p>
			<ul class="month_tab c4">
				<li class="on"><a href="javascript:;" class="btn">멸종위기식물 보전원</a></li>
				<li><a href="javascript:;" class="btn">온실</a></li>
				<li><a href="javascript:;" class="btn">이야기 꽃</a></li>
				<li><a href="javascript:;" class="btn">증식시설</a></li>
			</ul>
			<ul class="tab_view">
				<li class="on">
					<div class="img_box"><img src="/images/sub/plant1_img01.png" alt="#"></div>
					<div class="content_box">
						<p class="tit">멸종위기식물 보전원</p>
						<p class="txt">우리나라에서 훼손되어 사라져가는 식물을 소개함으로써 우리식물의 소중함을 일깨워 주는 화원입니다. 멸종위기식물의 희귀한 특징과 아름다움도 감상하실 수 있습니다.</p>
					</div>
				</li>
				<li>
					<div class="img_box"><img src="/images/sub/plant1_img02.png" alt="#"></div>
					<div class="content_box">
						<p class="tit">온실</p>
						<p class="txt">국내 다양한 분재와 어울어진 지피식물을 감상하실 수 있도록 전시하였습니다.</p>
					</div>
				</li>
				<li>
					<div class="img_box"><img src="/images/sub/plant1_img03.png" alt="#"></div>
					<div class="content_box">
						<p class="tit">이야기꽃</p>
						<p class="txt">예로부터 내려온 전설이나 이름이 명명된 사연 등 꽃에 얽힌 이야기를 소개하는 화원으로 꽃을 보며 이야기를 감상할 수 있는 화원입니다.</p>
					</div>
				</li>
				<li>
					<div class="img_box"><img src="/images/sub/plant1_img04.png" alt="#"></div>
					<div class="content_box">
						<p class="tit">증식시설</p>
						<p class="txt">양구수목원 식물들을 연구하고, 건강하게 키우는 공간으로 관람은 불가한 공간입니다.</p>
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
