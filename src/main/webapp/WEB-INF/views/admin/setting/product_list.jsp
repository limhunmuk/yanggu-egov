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
        <c:import url="/WEB-INF/views/admin/common/left_setting.jsp">
            <c:param name="menuOn" value="3" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>체험프로그램 신청 관리</h3>
				</div>
				<div class="list">
				<form action="/admin/setting/member/productlist" action="post">
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>${totalCount}</span>건</p>
						</div>
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:10%;">
								<col style="*">
								<col style="width:20%;">
								<col style="width:20%;">
<%-- 								<col style="width:10%;"> --%>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">프로그램 명</th>
									<th scope="col">기간</th>
									<th scope="col">대상</th>
<!-- 									<th scope="col">인원</th> -->
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<tr><td colspan="5">데이타가 없습니다</td></tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="item" items="${list}" varStatus="status">		
											<tr>
												<td>${totalCount - ((page -1) * 10 + status.index)}</td>
												<td class="t_left"><a href="productwrite?seq=${item.seq }">${item.title }</a></td>
												<td>${item.text_date }</td>
												<td>${item.mubiao }</td>
<%-- 												<td>${item.number }</td> --%>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
                        <div class="table_btn align_r mt20 pl20">
                            <button type="button" onclick="location.href = 'productwrite';">등록</button>
                        </div>
                        
						<div class="pagination mt0">
							<c:if test="${page gt 1  }">
			                    <a href="?page=${page - 1}" class="prev">이전 페이지</a>
			                </c:if>
							<c:forEach var="pageLink" items="${pageLinks }">
			                    <c:choose>
			                        <c:when test="${page eq pageLink }">
			                            <a href="?page=${pageLink}" class="on" onclick="return false;">${pageLink }</a>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="?page=${pageLink}">${pageLink }</a>
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			                <c:if test="${page lt totalPage}">
			                    <a class="next" href="?page=${page + 1}">다음 페이지</a>
			                </c:if>
						</div>
					</div>
				</div>
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
