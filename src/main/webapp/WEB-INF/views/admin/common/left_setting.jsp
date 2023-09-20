<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="lnb">
	<h2 class="tit"><span>설정</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="/admin/setting/memberList" <c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>회원관리</a>
        </li>
        <li class="btn_sub">
            <a href="#" <c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>푸시관리</a>
        </li>
	</ul>
</aside>