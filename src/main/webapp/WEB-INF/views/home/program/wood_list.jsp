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
			<h2>목재문화체험</h2>
			<p><i class="home_i"></i><span>목재문화체험</span><span>목공예 체험 프로그램</span></p>
		</div>
		<div class="contents sub_content top">
			<ul class="gallery_list">
				<c:choose>
					<c:when test="${empty list }">
						<!--<li>등록된 목공예 체험 프로그롬이 없습니다</li>-->
						<p style="padding: 150px 0; font-size: 36px;text-align: center;font-weight: 600;">등록된 목공예 체험 프로그램이 없습니다</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${list}" varStatus="status">	
							<li>
								<a href="javascript:void(0);" class="img_box" style="background-image: url(/uploads/woodworking/${item.attachment});"></a>
								<div class="text_box">
									<a href=""class="title"><c:out value="${item.title}"/></a>
									<p class="info_box">
										<span class="tit"><i class="time_i"></i><!--소요시간-->교육시간<em>(가로X세로X높이 또는 폭, mm)</em></span>
										<span class="txt"><c:out value="${item.text_date}"/></span>
									</p>
									<p class="info_box">
										<span class="tit"><i class="w_i"></i>이용료<em>(체험료/재료비)</em></span>
										<span class="txt"><fmt:formatNumber value="${item.price }" pattern="#,###"/>원 <em class="c_main">※<c:out value="${item.remark}"/></em></span>
									</p>
								</div>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
			<div class="pagination" id="pagination">
				<c:if test="${page gt 1  }">
                    <a href="?page=${page - 1}" class="prev">이전 페이지</a>
                </c:if>
				<c:forEach var="pageLink" items="${pageLinks }">
                    <c:choose>
                        <c:when test="${page eq pageLink }">
                            <a href="?page=${pageLink}" class="on" onclick="return false;">${pageLink }</a>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${pageLink}">${pageLink }</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${page lt totalPage}">
                    <a class="next" href="?page=${page + 1}">다음 페이지</a>
                </c:if>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			$.datepicker.setDefaults({
				dateFormat: 'yy-mm-dd',
				prevText: '이전 달',
				nextText: '다음 달',
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				minDate: new Date('2019-08-28'),
				yearSuffix: '년'
			  });

			  $(function() {
				$("#datepicker1, #datepicker2").datepicker();
			  });
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
