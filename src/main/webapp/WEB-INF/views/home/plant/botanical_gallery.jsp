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
			<p><i class="home_i"></i><span>양구 수목원</span><span class="last">수목원 사계</span></p>
		</div>
		<div class="contents sub_content">
			<div class="gallery_slide">
				<div class="swiper-container gallery-top">
					<div class="swiper-wrapper">
						<c:choose>
							<c:when test="${empty list }">
								<div class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_02.png)">수목원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>01.</em>양구수목원 피크닉 광장1</span>
										<p>양구수목원 피크닉 광장 사진입니다</p>
									</div> 
								</div>
								<div class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_03.png)">수목원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>02.</em>양구수목원 피크닉 광장2</span>
										<p>양구수목원 피크닉 광장 사진입니다</p>
									</div> 
								</div>
								<div class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_04.png)">수목원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>03.</em>양구수목원 피크닉 광장3</span>
										<p>양구수목원 피크닉 광장 사진입니다</p>
									</div> 
								</div>
								<div class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_05.png)">양구수목원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>04.</em>양구수목원 피크닉 광장4</span>
										<p>양구수목원 피크닉 광장 사진입니다</p>
									</div> 
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${list}" varStatus="status">	
									<div class="swiper-slide">
										<div class="img_box" style="background-image:url(/uploads/gallery/<c:out value="${item.attachment}"/>)"><c:out value="${item.attachment_org}"/></div>
										<div class="txt_box">
											<span class="tit"><em><c:out value="${status.index+1}"/>.</em><c:out value="${item.title}"/></span>
											<p><c:out value="${item.content}" escapeXml="false"/></p>
										</div> 
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- Add Arrows -->
					<div class="swiper-pagination"></div>
					<div class="swiper-button-next swiper-button-white"></div>
					<div class="swiper-button-prev swiper-button-white"></div>
				</div>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			var galleryTop = new Swiper('.gallery-top', {
			draggable: true,
			pagination: {
			el: '.swiper-pagination',
					clickable: true,
			  },
			
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
