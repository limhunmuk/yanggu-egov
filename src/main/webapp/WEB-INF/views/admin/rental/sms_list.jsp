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
            <c:param name="menuOn" value="3" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list"> 
					<form action="smslist" method="post">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="*">
							</colgroup>
							<tr>
								<th scope="row">상태</th>
								<td>
	                                <input type="checkbox" name="stat" id="status_00" >
	                                <label for="status_00">전체</label>
	                                <input type="checkbox" name="stat" value="S" id="status_01" <c:if test="${fn:indexOf(statString,'S') != -1}">checked</c:if>>
	                                <label for="status_01">SMS</label>
	                                <input type="checkbox" name="stat" value="L" id="status_03" <c:if test="${fn:indexOf(statString,'L') != -1}">checked</c:if>>
	                                <label for="status_03">LMS</label>
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
							<button type="submit" class="btn_search">검색</button>
						</div>
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">총 건수(성공/실패): <span>${totalCount}(${sCount}/${fCount})</span>건</p>
						</div>
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:10%;">
								<col style="*">
								<col style="width:5%;">
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:5%;">
								<col style="width:5%;">
								<col style="*">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">전송일</th>
									<th scope="col">전송내용</th>
									<th scope="col">예약번호</th>
									<th scope="col">예약자명</th>
									<th scope="col">수신번호</th>
									<th scope="col">발신번호</th>
									<th scope="col">체험명</th>
									<th scope="col">전송구분</th>
									<th scope="col">구분</th>
									<th scope="col">제목</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<tr><td colspan="10">데이타가 없습니다</td></tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="item" items="${list}" varStatus="statu">
											<tr>
												<td><fmt:formatDate value="${item.sandDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td title="${item.msg}" style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" >${item.msg}</td>
												<td>${item.dseq}</td>
												<td>${item.name}</td>
												<td>${item.phoneNum}</td>
												<td>${item.sandPhoneNum}</td>
												<td>${item.experienceName}</td>
												<td>
													<c:choose>
														<c:when test="${item.sandSYn eq 'S'}">성공</c:when>
														<c:when test="${item.sandSYn eq 'F'}">실패</c:when>
													</c:choose>
												</td>
												<td>
													<c:choose>
														<c:when test="${item.smsType eq 'S'}">SMS</c:when>
														<c:when test="${item.smsType eq 'L'}">LMS</c:when>
													</c:choose>
												</td>
			                                    <td>${item.title}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div class="pagination mt0">
							<c:if test="${page gt 1  }">
			                    <a href="?page=${page - 1}&startDate=${startDate}&endDate=${endDate}${statQuery}" class="prev">이전 페이지</a>
			                </c:if>
							<c:forEach var="pageLink" items="${pageLinks }">
			                    <c:choose>
			                        <c:when test="${page eq pageLink }">
			                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}${statQuery}" class="on" onclick="return false;">${pageLink }</a>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}${statQuery}">${pageLink }</a>
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			                <c:if test="${page lt totalPage}">
			                    <a class="next" href="?page=${page + 1}&startDate=${startDate}&endDate=${endDate}${statQuery}">다음 페이지</a>
			                </c:if>
						</div>
					</div>	
								
				</div>
			</div>
		</div>
	</div>
</div>
<form action="/admin/rental/rentalList/excel" method="post" id="excel">
	<input type="hidden" name="adminId" value="${adminId}">
	<input type="hidden" name="adminName" value="${adminName}">
</form> 
<script>

$(function(){
	$('#gnb ul li').eq(1).addClass('on');
	$('#lnb ul.menu > li').eq(2).find(' > a ').addClass('skin_bg').next().show().find('>li')
	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
});
</script>
</body>
</html>
