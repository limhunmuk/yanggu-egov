<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<header id="header">
	<div class="header_top">
		<div class="inner relative">
			<h1>ADMINISTRATOR</h1>
			<div class="user_name">
				<span class="ico"></span>
				<p class="txt">${loginName}님</p>
				<span class="info">최종관리자</span>
			</div>
			<ul class="btn_wrap clearfix">
				<li class="homepage"><a href="/">HOMEPAGE</a></li>
                <li class="logout"><a href="/admin/logout">LOGOUT</a></li>
			</ul>
		</div>
	</div>
	<nav id="gnb">
		<ul class="clearfix">
			<li><a href="/admin/dashboard">HOME</a></li>
			<c:if test="${fn:substring(sessionScope.loginAuth,3,4) == '1'}">
				<li><a href="/admin/rental/rentallist?page=1&startDate=<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />&endDate=<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />&search_type=b&stat=a"> 예약 신청 관리</a></li>
			</c:if>
			<li><a href="/admin/forest/forest_rental?gubun=e">유아숲 신청관리</a></li>
			<c:if test="${fn:substring(sessionScope.loginAuth,2,3) == '1'}"> 
				<li><a href="/admin/gallery/gallerylist?kind=A">갤러리관리</a></li>
			</c:if>
			<c:if test="${fn:substring(sessionScope.loginAuth,1,2) == '1'}">
				<li><a href="/admin/site/noticelist">게시판관리</a></li>
			</c:if>
			<c:if test="${fn:substring(sessionScope.loginAuth,0,1) == '1'}">
				<li><a href="/admin/setting/member/accountlist">설정</a></li>
			</c:if>
		</ul>
	</nav>
	<div class="m_header">
		<h1>LOGO</h1>
		<button type="button" class="btn_menu"><img src="/ad_images/common/m_gnb_menu.png" alt="모바일 메뉴바"></button>
	</div>
</header>