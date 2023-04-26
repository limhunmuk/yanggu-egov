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
			<div id="container" class="sub_content top">
				<div class="board_wrap">
                    <div class="srch_wrap">
                        <p>총 : <strong id="searchResult" class="c_main"><c:out value="${totalCount}"/></strong> 건</p>
                        <form method="post" action="gallery_list">
                        <fieldset>
                            <legend>목록 검색</legend>
                            <div class="srch_sub_box">
                                <label for="srch_sel" class="blind">검색조건 선택</label>
                                <select id="srch_sel" name="keyword" class="option_box">
									<option value="1" <c:if test="${keyword == '1'}">selected</c:if>>제목</option>
									<option value="2" <c:if test="${keyword == '2'}">selected</c:if>>내용</option>
								</select>
								<div class="srch_sub_box2">
									<label for="srch_input" class="blind">검색어 입력</label>
									<input type="text" id="srch_input" name="searchName" placeholder="검색어 입력" value="<c:out value="${searchName }"/>">
									<button type="submit" class="btn">검색</button>
								</div>
                            </div>
                        </fieldset>
                        </form>
                    </div>
                    <div class="list_type_02">
						<ul class="notice_pic_wrap" id="tbl">
							<c:choose>
								<c:when test="${empty list }">
									<li>포토 갤러리가 없습니다.</li>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${list}" varStatus="status">	
										<li class="notice_pic">
											<div class="img_box">
												<a href="gallery_view?seq=${item.seq }"><img src="/uploads/gallery/<c:out value="${item.attachment}"/>" alt="<c:out value="${item.attachment_org}"/>"></a>
											</div>
											<a class ="tit" href="gallery_view?seq=${item.seq }"><c:out value="${item.title}"/></a>
											<div class="txt"><c:out value="${item.content}" escapeXml="false"/></div>
											<span class="date"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.insertDate }"/></span>
										</li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ul>
                    </div>
                    
					<div class="pagination" id="pagination">
						<c:if test="${page gt 1  }">
		                    <a href="?page=${page - 1}&searchName=${searchName}&keyword=${keyword}" class="prev">이전 페이지</a>
		                </c:if>
						<c:forEach var="pageLink" items="${pageLinks }">
		                    <c:choose>
		                        <c:when test="${page eq pageLink }">
		                            <a href="?page=${pageLink}&searchName=${searchName}&keyword=${keyword}" class="on" onclick="return false;">${pageLink }</a>
		                        </c:when>
		                        <c:otherwise>
		                            <a href="?page=${pageLink}&searchName=${searchName}&keyword=${keyword}">${pageLink }</a>
		                        </c:otherwise>
		                    </c:choose>
		                </c:forEach>
		                <c:if test="${page lt totalPage}">
		                    <a class="next" href="?page=${page + 1}&searchName=${searchName}&keyword=${keyword}">다음 페이지</a>
		                </c:if>
					</div>
                </div>
            </div>
		</div>
		<!-- //container -->
		<hr>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
</body>
</html>
