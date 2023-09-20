<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="lnb">
	<h2 class="tit"><span>게시판관리</span></h2>
	<ul class="menu">
        <li class="btn_sub">
            <a href="/admin/site/noticeList"<c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>공지사항</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/exhibitionList" <c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>행사전시</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/galleryList"<c:if test="${param.menuOn eq '3'}"> class="skin_bg"</c:if>>수목원 사계절</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/qnaList"<c:if test="${param.menuOn eq '4'}"> class="skin_bg"</c:if>>1:1 문의 내역</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/faqList" <c:if test="${param.menuOn eq '5'}">class="skin_bg"</c:if>>FAQ</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/videoList" <c:if test="${param.menuOn eq '6'}">class="skin_bg"</c:if>>홍보통영상(유투브)</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/articleList" <c:if test="${param.menuOn eq '7'}">class="skin_bg"</c:if>>게시판 리스트</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/site/articleWrite" <c:if test="${param.menuOn eq '8'}">class="skin_bg"</c:if>>게시판 등록</a>
        </li>
	</ul>
</aside>