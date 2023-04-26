<%
/**FILEDESC
홈페이지: 개인정보 처리방침, 회원 이용약관 페이지
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
</head>
<body class="sub">
	<div id="skipNav"><a href="#container">본문 바로가기</a></div>
	<!-- wrap -->
	<div class="wrap">
		<header id="header">
			<%@ include file="../inc/gnb.jsp"%>
		</header>
		<hr>
		<!-- container -->
		<div id="container" class="sub_container">
			<div class="sub_visual" style="background-image: url(/images/sub/sub_visual01.jpg);">
				<h2 class="title" id="title"></h2>
			</div>
			<div class="sub_content w1100">
				<h3 class="sub_title" id="sub_title"></h3>
				${map.content}
            </div>
		</div>
		<!-- //container -->
		<hr>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
</body>
<script>
var path=window.location.pathname;
$(function(){
	if(path=="/main/terms"){
		$("#title").html("이용 약관");
		$("#sub_title").html("이용 약관");
		depth(8,0);
	}else{
		$("#title").html("개인정보 처리방침");
		$("#sub_title").html("개인정보 처리방침");
		depth(7,0);
	}
})
</script>
</html>
