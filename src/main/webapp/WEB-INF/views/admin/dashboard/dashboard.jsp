<%@page import="kr.go.yanggu.util.Utils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="main_wrap02">
		<h2>양구자연생태공원에 오신 것을 환영합니다.</h2>
		<div class="num_list02">
			<div class="box">
				<h3>금일 용늪 예약신청현황</h3>
				<ul>
					<li>
						<span class="tit">예약 신청</span>
						<em>${rentalCnt.cnt1 }</em>
					</li>
					<li>
						<span class="tit">예약취소</span>
						<em>${rentalCnt.cnt2 }</em>
					</li>
				</ul>
			</div>
			<div class="box c2">
				<div class="toot_wrap">
				<div class="text_info ">
					<h3>최근 공지사항</h3>
					<c:forEach var="item" items="${noticeList}" varStatus="statu">
						<p>
							<a style="display:inline-block; width:400px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; "href="/admin/site/noticewrite?seq=${item.seq }" class="link">${item.title }</a>
							<span class="deta_r"><fmt:formatDate value="${item.insertDate}" pattern="yyyy-MM-dd"/></span>
						</p>
					</c:forEach>
				</div>
			</div>
			</div>
		</div>
		<div class="main_foot">
			<div class="toot_wrap">
				<div class="text_info num2">
					<div class="right_area">
						<span class="date_tit" id="todayTxt"></span>
						<span>최근접속일시 : ${lastLoginDate}</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
<script>
$(function() {
	$("#todayTxt").text("${lastLoginDate}".substring(0, 10)+"("+getInputDayLabel("${lastLoginDate}".substring(0, 10))+")");
	$('#gnb li:eq(0)').addClass('on');
		     
});
</script>
</body>
</html>