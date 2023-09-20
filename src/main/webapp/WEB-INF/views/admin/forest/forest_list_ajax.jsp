<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/general.css?222"/>
<link rel="stylesheet" type="text/css" href="/ad_css/calendar.css?222"/>
</head>
<body id="nav_3">

									<div class="search_wrap">
										<div class="result">
											<p class="txt" id = "reserveDate"></p>
										</div>
										<table class="search_list">
											<caption>검색결과</caption>
											<colgroup>
												<col style="width: 8%;">
												<col style="*">
												<col style="*">
												<col style="width: 15%;">
												<col style="width: 12%;">
												<col style="width: 12%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">신청자</th>
													<th scope="col">시간</th>
													<th scope="col">전화번호</th>
													<th scope="col">참여인원</th>
													<th scope="col">승인현황</th>
												</tr>
											</thead>
											<tbody id="listBodyAjax">
												<c:choose>
													<c:when test="${empty list }">
														<tr><td colspan="6">예약자가 없습니다</td></tr>	
													</c:when>
													<c:otherwise>
													<c:forEach items="${list}" var="list" varStatus="Status">
												<tr>
													<td>${totalCount - ((page -1) * 10 + Status.index)}</td>
													<td><a href="forestRentalWrite?seq=${list.seq}" class="c_blue">${list.name}</a></td>
													<td>
													<c:choose>
														<c:when test="${list.entryTime =='1'}">
															오전 10:00 ~ 11:30
														</c:when>
														<c:when test="${list.entryTime =='2'}">
															<c:choose>
																<c:when test="${list.gubun == 'f'}">
																	오후 13:30 ~ 15:00
																</c:when>
																<c:otherwise>
																 	오후 14:00 ~ 15:30
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															오후 15:30 ~ 17:00
														</c:otherwise>
													</c:choose>
													</td>
													<td>${list.mobile}</td>
													<td>${list.cnt}명</td>
													<td>
														<select style="width: 80px;" name="forestStat" onchange="updateStat('${list.seq}','${list.cnt }','${list.useDate }','${list.entryTime}','${list.mobile }','${list.name}','${list.insertDate}',this);">
															<option value="a"<c:if test="${list.stat == 'a'}">selected</c:if>>신청</option>
															<option value="b"<c:if test="${list.stat == 'b'}">selected</c:if>>승인</option>
															<option value="c"<c:if test="${list.stat == 'c'}">selected</c:if>>취소</option>
														</select>
													</td>
												</tr>
												</c:forEach>
												</c:otherwise>
												</c:choose>												
											</tbody>
										</table>
										<div class="pagination mt0">
											
										</div>
									</div>
<script src="/ad_CLNDR/js/underscore-min.js?v=2020"></script>
<script src="/ad_CLNDR/js/moment.min.js?v=2020"></script>
<script src="/ad_CLNDR/js/clndr.js?v=2020"></script>
<script src="/ad_js/cust/forest_rental.js?v=2021"></script>	
<script src="/js/common.min.js?v=2020"></script>	 

</body>
</html>
