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
		<div class="sub_visual bg07">
			<h2>참여마당</h2>
			<p><i class="home_i"></i><span>참여마당</span><span>공지사항</span></p>
		</div>
		<div class="contents sub_content top">
			<div class="srch_wrap">
				<p>총 <strong class="c_main"><c:out value="${totalCount}"/></strong> 개의 게시물이 있습니다. </p>
				<form method="post" action="animal_record_list">
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
			<ul class="notice_list">
				<c:choose>
					<c:when test="${empty list }"> 
						<li>공지사항이 없습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${list}" varStatus="status">	
							<li>
								<div class="title">
									<a href="animal_record_view?seq=<c:out value="${item.seq }"/>" class=""><c:if test="${item.kind == 'Y' }"><em class="bg_green">공지</em></c:if><c:out value="${item.title }"/></a>
									<i class="new_i"></i>
								</div>
								<p class="txt"><c:out value="${item.content }" escapeXml="false"/></p>
								<p class="tit_caption">
									<span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.insertDate }"/></span>
									<span>조회수 : <fmt:formatNumber value="${item.read_cnt }" pattern="#,###"/></span>
								</p>
								<c:if test="${not empty item.attachment1 or not empty item.attachment2 or not empty item.attachment3}">
									<div class="down_box">
										<c:if test="${not empty item.attachment1 }"><a href="javascript:fileDownLoad('ecology','${item.attachment1}','${item.attachment1_org}');" class="down_btn"><i></i><span>${item.attachment1_org}</span></a></c:if>
										<c:if test="${not empty item.attachment2 }"><a href="javascript:fileDownLoad('ecology','${item.attachment2}','${item.attachment2_org}');" class="down_btn"><i></i><span>${item.attachment2_org}</span></a></c:if>
										<c:if test="${not empty item.attachment3 }"><a href="javascript:fileDownLoad('ecology','${item.attachment3}','${item.attachment3_org}');" class="down_btn"><i></i><span>${item.attachment3_org}</span></a></c:if>
									</div>
								</c:if>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
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
			
			function fileDownLoad(src,tmp,org){
		    	$("input[name='src']").val(src);
		    	$("input[name='org']").val(org);
		    	$("input[name='tmp']").val(tmp);
		    	$("#fileform").submit();
		    }
		</script>
	</div>

	<!-- //wrap -->
<iframe name="frmHidden" id="frmHidden" style="visibility: hidden; display: none"></iframe>
<form action="/file/download" method="post" id="fileform" name="fileform" >
	<input type="hidden" name="src" value="">
	<input type="hidden" name="org" value="">
	<input type="hidden" name="tmp" value="">
</form>
</body>
</html>