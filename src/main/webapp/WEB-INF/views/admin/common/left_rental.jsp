<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<aside id="lnb">
	<h2 class="tit"><span>예약 신청 관리</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="rentallist?page=1&startDate=<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />&endDate=<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />&search_type=b&stat=a"<c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>용늪 출입신청</a>
        </li>
        <li class="btn_sub">
            <a href="experiencelist"<c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>체험 프로그램 신청</a>
        </li>
        <li class="btn_sub">
            <a href="smslist"<c:if test="${param.menuOn eq '3'}"> class="skin_bg"</c:if>>SMS 전송 리스트</a>
        </li>
        
	</ul>
</aside>