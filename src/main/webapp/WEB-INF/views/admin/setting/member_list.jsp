<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_setting.jsp">
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
                   <h3>운영자 관리</h3>
				</div>
				<div class="list">
                    <form action="/admin/setting/member/accountlist">
    					<table class="search">
    						<caption>검색</caption>
    						<colgroup>
    							<col style="width:20%;">
    							<col style="width:30%;">
    							<col style="width:20%;">
    							<col style="width:30%;">
    						</colgroup>
                            <tr>
                                <th scope="row">담당자명</th>
                                <td>
                                    <input type="text" title="담당자명" name="adminName" value="${adminName}">
                                </td>
                                <th scope="row">아이디</th>
                                <td>
                                    <input type="text" title="아이디" name="adminId" value="${adminId}">
                                </td>
                            </tr>
    					</table>
    					<div class="btn_area align_r mt20">
    						<button type="button" class="btn_down" onclick="excelDownload();">엑셀다운로드</button>
    						<button type="submit" class="btn_search">검색</button>
    					</div>
                    </form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>${totalCount }</span>건</p>
						</div>
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:100px;">
                                <col style="width:10%;">
								<col style="width:10%;">
								<col style="*">
								<col style="width:10%;">
								<col style="width:10%;">
                                <col style="width:30%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">아이디</th>
									<th scope="col">담당자명</th>
									<th scope="col">이메일</th>
									<th scope="col">전화번호</th>
									<th scope="col">부서명</th>
                                    <th scope="col">접근권한</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${empty list }">
									<tr><td colspan="7">데이타가 없습니다</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${list}" varStatus="status">
										<tr>
											<td>${totalCount - ((page -1) * 10 + status.index)}</td>
											<td><a href="addAccount?seq=${item.seq}">${item.adminId}</a></td>
											<td><a href="addAccount?seq=${item.seq}">${item.adminName}</a></td>
											<td><a href="addAccount?seq=${item.seq}">${item.adminEmail}</a></td>
											<td><a href="addAccount?seq=${item.seq}">${item.adminMobile}</a></td> 
											<td><a href="addAccount?seq=${item.seq}">${item.adminDept}</a></td>
											<c:set value="" var="auth"/>
											<c:if test="${fn:substring(item.auth,3,4) == '1'}"><c:set value="${auth},예약신청관리" var="auth"/></c:if>
											<c:if test="${fn:substring(item.auth,2,3) == '1'}"><c:set value="${auth},갤러리관리" var="auth"/></c:if>
											<c:if test="${fn:substring(item.auth,1,2) == '1'}"><c:set value="${auth},게시판관리" var="auth"/></c:if>
											<c:if test="${fn:substring(item.auth,0,1) == '1'}"><c:set value="${auth},설정관리" var="auth"/></c:if>
		                                   	<td><a href="addAccount?seq=${item.seq}">${fn:substring(auth,1,fn:length(auth)) }</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
                        <div class="align_r mt20">
                            <button type="button" class="btn_search" onclick="location.href = '/admin/setting/member/addAccount'">등록</button>
                        </div>
						<!-- 페이징 -->
						<div class="pagination mt0">
							<c:if test="${page gt 1  }">
			                    <a href="?page=${page - 1}&adminName=${adminName}&adminId=${adminId}" class="prev">이전 페이지</a>
			                </c:if>
							<c:forEach var="pageLink" items="${pageLinks }">
			                    <c:choose>
			                        <c:when test="${page eq pageLink }">
			                            <a href="?page=${pageLink}&adminName=${adminName}&adminId=${adminId}" class="on" onclick="return false;">${pageLink }</a>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="?page=${pageLink}&adminName=${adminName}&adminId=${adminId}">${pageLink }</a>
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			                <c:if test="${page lt totalPage}">
			                    <a class="next" href="?page=${page + 1}&adminName=${adminName}&adminId=${adminId}">다음 페이지</a>
			                </c:if>
						</div>
						<!-- 페이징 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="/admin/setting/member/excel" method="post" id="excel">
	<input type="hidden" name="adminId" value="${adminId}">
	<input type="hidden" name="adminName" value="${adminName}">
</form> 
<script>
    $(function () {
    	$('#gnb ul li').eq(4).addClass('on');
    });
    
    function excelDownload(){
    	$("#excel").submit();
    }
</script>
</body>
</html>
