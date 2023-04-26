<%@ page language="java" contentType="application/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
response.setHeader("Content-Disposition","attachment;filename="+new String("유아숲".getBytes("utf-8"),"8859_1")+".xls");
%>
<!DOCTYPE html>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=utf-8">
<style>
  table, th, td {
    border: 1px solid #bcbcbc;
    text-align: center;
  }
</style>
</head>
<body>
	<table class="search_list">
		<colgroup>
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
			<col style="width:auto;">
	        <col style="width:auto;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">신청 일시</th>
				<th scope="col">성명</th>
				<th scope="col">연락처</th>
				<th scope="col">신청일</th>
				<th scope="col">신청시간</th>
				<th scope="col">참여인원</th>
				<th scope="col">비고</th>
				<th scope="col">승인현황</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list }">
					<tr><td colspan="8">데이타가 없습니다</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td>${status.index+1}</td>
							<td>&nbsp;${item.insertDate}</td>
							<td>${item.name }</td>
							<td>&nbsp;${item.mobile }</td>
							<td>${item.useDate}</td>
							<td>
							<c:choose>
								<c:when test="${item.entryTime == '1'}">
									오전 10:00 ~ 11:30
								</c:when>
								<c:otherwise>
									오전 13:30 ~ 15:00
								</c:otherwise>
							</c:choose>
							
							</td>
                            <td><fmt:formatNumber value="${item.cnt}" pattern="#,###"/></td>
                            <td>${item.remark}</td>
                  			<td>${item.stat == 'a'?'신청':item.sta == 'b'?'승인':'취소'}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>
