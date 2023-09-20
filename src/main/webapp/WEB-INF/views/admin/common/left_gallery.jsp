<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="lnb">
	<h2 class="tit"><span>아카이브</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="galleryList?kind=A"<c:if test="${param.menuOn eq 'A'}"> class="skin_bg"</c:if>>생태 식물원 사계</a>
        </li>
        <li class="btn_sub">
            <a href="galleryList?kind=B"<c:if test="${param.menuOn eq 'B'}"> class="skin_bg"</c:if>>생태관 사진</a>
        <li class="btn_sub">
            <a href="galleryList?kind=C" <c:if test="${param.menuOn eq 'C'}">class="skin_bg"</c:if>>분재 갤러리</a>
        </li>
     <%--   <li class="btn_sub">
            <a href="gallerylist?kind=D" <c:if test="${param.menuOn eq 'D'}">class="skin_bg"</c:if>>포토 갤러리</a>
        </li>--%>
	</ul>
</aside>