<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside id="lnb">
    <h2 class="tit"><span>운영관리[${param.menuOn}]</span></h2>
    <ul class="menu">
        <li class="btn_sub">
            <a href="/admin/manage/managerList" <c:if test="${param.menuOn eq '1'}"> class="skin_bg"</c:if>>운영자관리</a>
        </li>
        <li class="btn_sub">
            <a href="javascript:;" <c:if test="${param.menuOn eq '2'}"> class="skin_bg"</c:if>>접속 통계</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/manage/menuList"  <c:if test="${param.menuOn eq '3'}"> class="skin_bg"</c:if>>메뉴 관리</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/manage/mainList" <c:if test="${param.menuOn eq '4'}">class="skin_bg"</c:if>>메인관리</a>
            <ul class="sub_menu">
                <li><a href="/admin/manage/mainList">메인 배너</a></li>
                <li><a href="javascript:;">기타영역 배너</a></li>
            </ul>
        </li>
        <li class="btn_sub">
            <a href="/admin/manage/popupList" <c:if test="${param.menuOn eq '5'}"> class="skin_bg"</c:if>>팝업 관리</a>
        </li>
        <li class="btn_sub">
            <a href="/admin/manage/bannerList" <c:if test="${param.menuOn eq '6'}"> class="skin_bg"</c:if>>상단 띠 배너</a>
        </li>
    </ul>
</aside>