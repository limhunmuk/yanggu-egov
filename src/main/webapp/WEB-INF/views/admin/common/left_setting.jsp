<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="lnb">
	<h2 class="tit"><span>설정</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="/admin/setting/member/accountlist"<c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>운영자관리</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/setting/rentalSetting"<c:if test="${param.menuOn eq '4'}"> class="skin_bg"</c:if>>용늪신청 관리</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/setting/member/popuplist"<c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>팝업관리</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/setting/member/productlist"<c:if test="${param.menuOn eq '3'}"> class="skin_bg"</c:if>>체험프로그램  항목 관리</a>
        </li>
        <li class="btn_sub">
            <a href="#" target="_blank">구글 애널리틱스</a>
        </li>
	</ul>
</aside>