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
        <c:import url="/WEB-INF/views/admin/common/left_site.jsp">
            <c:param name="menuOn" value="2" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="loaction.reload();">새로고침</a>
				<div class="list_tit">
					<h3>1:1 문의 내역</h3>
				</div>
				<div class="list">
				<form action="qnalist" method="post">
					<table class="search">
						<caption>검색</caption>
						<colgroup>
							<col style="width:14%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">답변여부</th>
							<td>
                                <select style="width:200px;" name="stat">
                                    <option value="" <c:if test="${stat == ''}">selected</c:if>>전체</option>
                                    <option value="Y" <c:if test="${stat == 'Y'}">selected</c:if>>답변</option>
                                    <option value="N" <c:if test="${stat == 'N'}">selected</c:if>>미답변</option>
                                </select>
							</td>
						</tr>
						<tr>
							<th scope="row">등록일자</th>
                            <td>
                                <input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" value="${startDate }" autocomplete="off">
                                <span class="hypen">~</span>
                                <input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" value="${endDate }" autocomplete="off">
                            </td>
						</tr>
						<tr>
							<th scope="row">키워드</th>
							<td>
								<select style="width:160px;vertical-align:middle;" name="keyword">
									<option value="1" <c:if test="${keyword == '1'}">selected</c:if>>제목</option>
									<option value="2" <c:if test="${keyword == '2'}">selected</c:if>>내용</option>
									<option value="3" <c:if test="${keyword == '3'}">selected</c:if>>등록자</option>
								</select>
                                <input type="text" name="searchName" value="${searchName }">
							</td>
						</tr>
					</table>
					<div class="btn_area align_r mt20">
						<input type="hidden" name="order" value="2">
						<button class="btn_search" type="submit">검색</button>
					</div>
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>${totalCount}</span>건</p>
						</div>
						<div id="excelArea">
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:10%;">
								<col style="*">
                                <col style="width:10%;">
 								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:10%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
									<th scope="col">첨부파일</th>
									<th scope="col">답변여부</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<tr><td colspan="6">데이타가 없습니다</td></tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="item" items="${list}" varStatus="status">		
											<tr>
												<td>${totalCount - ((page -1) * 10 + status.index)}</td>
												<td class="t_left"><a href="qnaview?seq=${item.seq }">${item.title }</a></td>
												<td>${item.memberName }</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.insertDate }"/></td>
												<td><c:if test="${not empty item.attachment }"><button type="button" class="btn" onclick="fileDownLoad('qna','${item.attachment}','${item.attachment_org}');">Download</button></c:if></td>
												<td>${item.stat == "Y"?"답변":"미답변" }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						</div>
						<div class="pagination mt0">
							<c:if test="${page gt 1  }">
			                    <a href="?page=${page - 1}&searchName=${searchName}&keyword=${keyword}&stat=${stat}&startDate=${searchStartDate}&endDate=${searchEndDate}" class="prev">이전 페이지</a>
			                </c:if>
							<c:forEach var="pageLink" items="${pageLinks }">
			                    <c:choose>
			                        <c:when test="${page eq pageLink }">
			                            <a href="?page=${pageLink}&searchName=${searchName}&keyword=${keyword}&stat=${stat}&startDate=${searchStartDate}&endDate=${searchEndDate}" class="on" onclick="return false;">${pageLink }</a>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="?page=${pageLink}&searchName=${searchName}&keyword=${keyword}&stat=${stat}&startDate=${searchStartDate}&endDate=${searchEndDate}">${pageLink }</a>
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			                <c:if test="${page lt totalPage}">
			                    <a class="next" href="?page=${page + 1}&searchName=${searchName}&keyword=${keyword}&stat=${stat}&startDate=${searchStartDate}&endDate=${searchEndDate}">다음 페이지</a>
			                </c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="/file/download" method="post" id="fileform" name="fileform" >
	<input type="hidden" name="src" value="">
	<input type="hidden" name="org" value="">
	<input type="hidden" name="tmp" value="">
</form>
<script>
    $(function () {
    	$('#gnb ul li').eq(4).addClass('on');
    });
    function fileDownLoad(src,tmp,org){
    	$("input[name='src']").val(src);
    	$("input[name='org']").val(org);
    	$("input[name='tmp']").val(tmp);
    
    	$("#fileform").submit();
    }
</script>
</body>
</html>
