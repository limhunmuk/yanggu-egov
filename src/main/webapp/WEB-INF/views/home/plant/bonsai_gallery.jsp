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
			<h2>DMZ야생화분재원</h2>
			<p><i class="home_i"></i><span>DMZ야생화분재원</span><span class="last">분재 갤러리</span></p>
		</div>
		<div class="contents sub_content">
			<div class="gallery_slide">
				<div class="swiper-container gallery-top">
					<div class="swiper-wrapper">
						<c:choose>
							<c:when test="${empty list }">
								<div class="swiper-slide">
									<h3 class="sub_title2">분재1</h3>
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_01.png)">식물원 사진</div>
									<div class="txt_box">
										<p>분재 사진</p>
									</div> 
								</div>
								<div class="swiper-slide">
									<h3 class="sub_title2">분재2</h3>
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_01.png)">식물원 사진</div>
									<div class="txt_box">
										<p>분재 사진</p>
									</div> 
								</div>
								<div class="swiper-slide">
									<h3 class="sub_title2">분재3</h3>
									<div class="img_box" style="background-image:url(/images/sub/botanical_sd1_01.png)">식물원 사진</div>
									<div class="txt_box">
										<p>분재 사진</p>
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
