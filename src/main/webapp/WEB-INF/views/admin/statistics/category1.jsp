<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<style>
    .search_wrap table.search_list td{padding:0 10px;}
    .search_wrap table.search_list td.t_left{text-align:left;}
    .search_wrap table.search_list td.t_center{text-align:center;}
    .search_wrap table.search_list td a{display:inline-block;width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;vertical-align:middle;}
</style>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_statistics.jsp">
            <c:param name="menuOn" value="1" />
        </c:import>
        <div class="container clearfix">
            <div class="content">
                아카이브 1
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $('#gnb ul li').eq(5).addClass('on');
    });
</script>
</body>
</html>
