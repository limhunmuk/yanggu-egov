<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="lnb">
	<h2 class="tit"><span>통계/분석</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="/admin/statistics/category1"<c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>메뉴1</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/statistics/category2"<c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>메뉴2</a>
        <li class="btn_sub">
            <a href="/admin/statistics/category3" <c:if test="${param.menuOn eq '3'}">class="skin_bg"</c:if>>메뉴3</a>
        </li>
	</ul>
</aside>