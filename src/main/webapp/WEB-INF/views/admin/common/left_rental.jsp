<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<aside id="lnb">
	<h2 class="tit"><span>신청 관리</span></h2>
	<ul class="menu">
        <li class="btn_sub" <c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>
            <a href="/admin/rental/forestRentalList?gubun=e">신청 관리</a>
            <ul class="sub_menu">
                <li><a href="/admin/rental/forestRentalList?gubun=e&subMenuNo=0">유아숲체험</a></li>
                <li><a href="/admin/rental/forestRentalList?gubun=f&subMenuNo=1">숲 해설</a></li>
                <li>
                    <a href="/admin/rental/rentalList?subMenuNo=2&page=1&startDate=<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />&endDate=<fmt:formatDate value='${(now)}' pattern='yyyy-MM-dd' />&search_type=b&stat=a"<c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>
                        용늪 출입신청
                    </a>
                </li>
                <li><a href="/admin/rental/experienceList?subMenuNo=3">체험프로그램</a></li>
            </ul>
        </li>
	</ul>
    <ul class="menu">
        <li class="btn_sub" <c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>
            <a href="">소개관리</a>
            <ul class="sub_menu">
                <li><a href="">유아숲체험(신규)</a></li>
                <li><a href="">숲 (신규)</a></li>
                <li><a href="">용늪 탐방(신규)</a></li>
            </ul>
        </li>
	</ul>
    <ul class="menu">
        <li class="btn_sub">
            <a href="/admin/rental/smsList" <c:if test="${param.menuOn eq '3'}"> class="skin_bg"</c:if>>SMS 전송 리스트</a>
        </li>
	</ul>
    <ul class="menu">
        <li class="btn_sub">
            <a href="/admin/rental/forestProgram?gubun=e&subMenuNo=0" <c:if test="${param.menuOn eq '4'}"> class="skin_bg"</c:if>>설정</a>
            <ul class="sub_menu">
                <li><a href="/admin/rental/forestProgram?gubun=e&subMenuNo=0">유아숲체험</a></li>
                <li><a href="/admin/rental/forestProgram?gubun=f&subMenuNo=1">숲 해설</a></li>
                <li><a href="/admin/rental/rentalSetting?subMenuNo=2">용늪 탐방</a></li>
                <li><a href="/admin/rental/productList?subMenuNo=3">체험프로그램(신규)</a></li>
            </ul>
        </li>
	</ul>
</aside>