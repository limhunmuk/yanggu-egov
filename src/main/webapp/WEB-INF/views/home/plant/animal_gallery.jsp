<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<p><i class="home_i"></i><span>DMZ야생동물생태관</span><span class="last">생태관 사진</span></p>
		</div>
		<div class="contents sub_content">
			<div class="gallery_slide">
				<div class="swiper-container gallery-top">
					<ul class="swiper-wrapper">
						<c:choose>
							<c:when test="${empty list }">
								<li class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/animal_sd1_01.png)">동물 사진</div>
									<div class="txt_box">
										<span class="tit"><em>01.</em>삵</span>
										<p>양구자연생태공원 생태식물원 피크닉 광장 사진입니다</p>
									</div> 
								</li>
								<li class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/animal_sd1_02.png)">식물원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>02.</em>여우</span>
										<p>양구자연생태공원 생태식물원 피크닉 광장 사진입니다</p>
									</div>
								</li>
								<li class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/animal_sd1_03.png)">식물원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>03.</em>수리부엉이</span>
										<p>양구자연생태공원 생태식물원 피크닉 광장 사진입니다</p>
									</div>
								</li>
								<li class="swiper-slide">
									<div class="img_box" style="background-image:url(/images/sub/animal_sd1_04.png)">식물원 사진</div>
									<div class="txt_box">
										<span class="tit"><em>04.</em>하늘다람쥐</span>
										<p>양구자연생태공원 생태식물원 피크닉 광장 사진입니다</p>
									</div>
								</li>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${list}" varStatus="status">	
									<li class="swiper-slide">
										<div class="img_box" style="background-image:url(/uploads/gallery/<c:out value="${item.attachment}"/>)"><c:out value="${item.attachment_org}"/></div>
										<div class="txt_box">
											<span class="tit"><em><c:out value="${status.index+1}"/>.</em><c:out value="${item.title}"/></span>
											<p><c:out value="${item.content}" escapeXml="false"/></p>
										</div>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
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
			spaceBetween: 10,
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
