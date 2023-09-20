<%@ page language="java" contentType="application/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
response.setHeader("Content-Disposition","attachment;filename="+new String("운영자관리".getBytes("utf-8"),"8859_1")+".xls");
%>
<!DOCTYPE html>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=utf-8">
<style>
  table, th, td {
    border: 1px solid #bcbcbc;
  }
</style>
</head>
<body>
	<table class="search_list">
		<colgroup>
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
			<col  style="width:auto;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">담당자명</th>
				<th scope="col">이메일</th>
				<th scope="col">전화번호</th>
				<th scope="col">부서명</th>
				<th scope="col">접근권한</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list }">
					<tr><td colspan="7">데이타가 없습니다</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${list}" varStatus="status">		
						<tr>
							<td>${status.index+1}</td>
							<td>${item.adminId}</td>
							<td>${item.adminName}</td>
							<td>${item.adminEmail}</td>
							<td>&nbsp;${item.adminMobile}</td>
							<td>${item.adminDept}</td>
							<c:set value="" var="auth"/>
							<c:if test="${fn:substring(item.auth,3,4) == '1'}"><c:set value="${auth},예약신청관리" var="auth"/></c:if>
							<c:if test="${fn:substring(item.auth,2,3) == '1'}"><c:set value="${auth},갤러리관리" var="auth"/></c:if>
							<c:if test="${fn:substring(item.auth,1,2) == '1'}"><c:set value="${auth},게시판관리" var="auth"/></c:if>
							<c:if test="${fn:substring(item.auth,0,1) == '1'}"><c:set value="${auth},설정관리" var="auth"/></c:if>
                           	<td>${fn:substring(auth,1,fn:length(auth)) }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>
