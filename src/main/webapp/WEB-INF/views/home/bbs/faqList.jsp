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
			<p><i class="home_i"></i><span>참여마당</span><span>자주하는 질문 (FAQ)</span></p>
		</div>
		<div class="contents sub_content top">
			<div class="srch_wrap">
				<p>총 <strong class="c_main"><c:out value="${totalCount}"/></strong> 개의 FAQ물이 있습니다. </p>
				<form method="post" action="notice_list">
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
			
			<div class="list_type_03">
				<dl class="result_list" id="tbl">
					<c:forEach items="${list }"  var="item">
						<dt>
							<span class='blind'>질문</span>
							<a href="javascript:;" class="btn"><c:out value="${item.title }"/></a>
							<i class="ico_list">닫힘</i>
						</dt>
						<dd>
							<span class='blind'>답변</span>
							<p class="txt">${item.content }</p> 
						</dd>
					</c:forEach>
				</dl>
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
			
			
			
			$('.date_wrap .box .mask').on('click', function(){
					$('.date_wrap .box').removeClass('on');
					$(this).parents('.box').addClass('on');
			});
			/* 달력 결과 토글 */
			$('.result_list dt a').on('click', function(){
					$(this).parents('dt').next('dd').slideToggle('fast');
					$(this).toggleClass('on');
					$(this).parents('dt').find('.ico_list').toggleClass('list_on');
				if ( $(this).hasClass('on') ){
					$(this).parents('dt').find('.ico_list').html('열림');
				} else {
					$(this).parents('dt').find('.ico_list').html('닫힘');
				}
			});
			
			
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
