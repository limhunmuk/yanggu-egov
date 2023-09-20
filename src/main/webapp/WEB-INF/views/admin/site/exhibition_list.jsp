<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<style>
	.search_wrap table.search_list td{padding:0 10px;}
	.search_wrap table.search_list td.t_left{text-align:left;}
	.search_wrap table.search_list td.t_center{text-align:center;}
	.search_wrap table.search_list td a{display:inline-block;width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;vertical-align:middle;}
</style>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
		<c:import url="/WEB-INF/views/admin/common/left_site.jsp">
			<c:param name="menuOn" value="2" />
		</c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list">
					<form action="/admin/site/exhibitionList" method="post">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="width:auto;">
								<col style="width:14%;">
								<col style="width:auto;">
							</colgroup>
							<tr>
								<th scope="row">키워드</th>
								<td>
									<select style="width:160px;vertical-align:middle;" name="keyword">
										<option value="1" <c:if test="${keyword == '1'}">selected</c:if>>제목</option>
										<option value="2" <c:if test="${keyword == '2'}">selected</c:if>>내용</option>
										<option value="3" <c:if test="${keyword == '3'}">selected</c:if>>등록자</option>
									</select>
									<input type="text" name="searchName" value="${searchName }">
								</td>
								<th scope="row">등록일자</th>
								<td>
									<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" value="${startDate }" autocomplete="off">
									<span class="hypen">~</span>
									<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" value="${endDate }" autocomplete="off">
								</td>
							</tr>
							<tr>
								<th scope="row">노출</th>
								<td colspan="3">
									<select style="width:200px;" name="stat">
										<option value="" <c:if test="${stat == ''}">selected</c:if>>전체</option>
										<option value="Y" <c:if test="${stat == 'Y'}">selected</c:if>>노출</option>
										<option value="N" <c:if test="${stat == 'N'}">selected</c:if>>미노출</option>
									</select>
								</td>
							</tr>
						</table>
						<div class="align_r mt20">
							<button type="button" class="btn_down" onclick="location.href = 'exhibitionWrite';">등록</button>
							<button type="submit" class="btn_search">검색</button>
						</div>
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>${totalCount}</span>건</p>
						</div>
						<ul class="gallery_list">
							<c:if test="${list != null}">
								<c:forEach var="item" varStatus="stat" items="${list}">
									<li>
										<a href="exhibitionWrite?seq=${item.seq }">
											<div class="attach_img">
												<img src="${pageContext.request.contextPath}/uploads/exhibition/${item.attachment }"/>
											</div>
										</a>
										<div class="txt_area">
											<div>
												<a href="exhibitionWrite?seq=${item.seq }"><strong class="text_ellipsis">${item.title}</strong></a>
												<p>작성일: <span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.insertDate }"/></span></p>
											</div>
										</div>
									</li>
								</c:forEach>
							</c:if>
						</ul>
						<div class="pagination mt0">
							<c:if test="${page gt 1  }">
								<a href="?page=${page - 1}&startDate=${startDate}&endDate=${endDate}&seq=${seq}" class="prev">이전 페이지</a>
							</c:if>
							<c:forEach var="pageLink" items="${pageLinks }">
								<c:choose>
									<c:when test="${page eq pageLink }">
										<a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&seq=${seq}" class="on" onclick="return false;">${pageLink }</a>
									</c:when>
									<c:otherwise>
										<a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&seq=${seq}">${pageLink }</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${page lt totalPage}">
								<a class="next" href="?page=${page + 1}&startDate=${startDate}&endDate=${endDate}&seq=${seq}">다음 페이지</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(function(){
		$('#gnb ul li').eq(3).addClass('on');
	});
	function excelDownload(){
		$("#excel").submit();
	}
</script>
</body>
</html>