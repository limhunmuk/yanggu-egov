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
		<hr>
	<!-- container -->
		<div class="sub_container">
			<div class="sub_visual bg07">
				<h2 class="title">열린 공간</h2>
				<p><i class="home_i"></i><span>열린 공간</span><span>포토 갤러리</span></p>
			</div>
			<div id="container" class="sub_content">
				<div class="view_container">
					<div class="view_title">
						<p ><c:out value="${one.title }"/></p>
						<div class="view_writer">
							<p>
								<span><fmt:formatDate pattern="yyyy-MM-dd" value="${one.insertDate }"/></span>
								<span>조회 :<strong><fmt:formatNumber value="${one.read_cnt+1 }" pattern="#,###"/></strong></span>
							</p>
						</div>
					</div>
					<div class="pic_img_box">
						<div class="pic_img">
							<img src="/uploads/gallery/<c:out value="${one.attachment}"/>" alt="<c:out value="${one.attachment_org}"/>">
						</div>
					</div>
					<div class="pic_txt_box">
						<c:out value="${one.content }" escapeXml="false"/> 
					</div>
				</div>
				<div class="btn_area gallery">
					<a href="/bbs/gallery_list" class="btn">목록</a>
				</div>
			</div><!-- board_wrap end -->
		</div>
		<!-- //container -->
		<hr>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
</body>
</html>

