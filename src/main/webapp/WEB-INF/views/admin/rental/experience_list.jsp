<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
		<c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list"> 
					<form action="experienceList" method="post">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="*">
							</colgroup>
							<tr>
								<th scope="row">선택</th>
								<td>
	                               <select style="width:200px;" name="seq">
	                                    <option value="" <c:if test="${seq == ''}">selected</c:if>>전체</option>
	                                    <c:forEach var="item" items="${productList}" varStatus="statu">
											<option value="${item.seq}" <c:if test="${seq == item.seq}">selected</c:if>>${item.title}</option>
										</c:forEach>
	                                </select>
								</td>
							</tr>
							<tr>
								<th scope="row">기간조회</th>
								<td>
									<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" value="${startDate }" autocomplete="off">
									<span class="hypen">~</span>
									<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" value="${endDate }" autocomplete="off">
								</td>
							</tr>
						</table>
						<div class="align_r mt20">
							<button type="button" class="btn_down" onclick="excelDownload();">엑셀다운로드</button>
							<button type="submit" class="btn_search">검색</button>
						</div>
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>${totalCount}</span>건</p>
						</div>
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:5%;">
								<col style="width:10%;">
								<col style="*">
								<col style="*">
								<col style="*">
                                <col style="width:10%;">
                                <col style="*">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">신청일시</th>
									<th scope="col">구분</th>
									<th scope="col">성명</th>
									<th scope="col">연락처</th>
									<th scope="col">신청일</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<tr><td colspan="7">데이타가 없습니다</td></tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="item" items="${list}" varStatus="statu">
											<tr>
												<td>${totalCount - ((page -1) * 10 + statu.index)}</td>
												<td><fmt:formatDate value="${item.insertDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>${item.title }</td>
												<td>${item.name}</td>
												<td>${item.phone}</td>
			                                    <td>${item.useDate}</td>
			                                    <td>${item.remark}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
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
<form action="/admin/rental/experienceList/excel" method="post" id="excel">
	<input type="hidden" name="adminId" value="${adminId}">
	<input type="hidden" name="adminName" value="${adminName}">
</form> 
<script>

$(function(){
	$('#gnb ul li').eq(1).addClass('on');
	$('#lnb ul.menu > li').eq(0).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(3).addClass('on');
});
function excelDownload(){
	$("#excel").submit();
}
</script>
</body>
</html>
