<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list"> 
					<form id="frm" name="frm" method="post">
						<input type="hidden" name="adminId" value="${adminId}">
						<input type="hidden" name="adminName" value="${adminName}">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="*">
							</colgroup>
							<tr>
								<th scope="row">상태</th>
								<td>
	                                <input type="checkbox" name="stat" id="status_00" >
	                                <label for="status_00">전체</label>
	                                <input type="checkbox" name="stat" value="a" id="status_01" <c:if test="${fn:indexOf(statString,'a') != -1}">checked</c:if>>
	                                <label for="status_01">신청</label>
	                                <%-- <input type="checkbox" name="stat" value="b" id="status_02" <c:if test="${fn:indexOf(statString,'b') != -1}">checked</c:if>>
	                                <label for="status_02">승인</label> --%>
	                                <input type="checkbox" name="stat" value="c" id="status_03" <c:if test="${fn:indexOf(statString,'c') != -1}">checked</c:if>>
	                                <label for="status_03">취소</label>
								</td>
							</tr>
							<tr>
								<th scope="row">기간조회</th>
								<td>
                               		<select id="search_type" name="search_type" class="sms">
                                       <option value="a" <c:if test="${search_type == 'a'}">selected</c:if>>예약일</option>
                                       <option value="b" <c:if test="${search_type == 'b'}">selected</c:if>>체험일</option>
                                       <option value="c" <c:if test="${search_type == 'c'}">selected</c:if>>취소일</option>
                                   </select>
									<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" value="${startDate }">
									<span class="hypen">~</span>
									<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" value="${endDate }">
								</td>
							</tr>
						</table>
						<div class="align_r mt20">
							<button type="button" class="btn_down" onclick="goSms();">SMS전송</button>
							<button type="button" class="btn_down" onclick="moveWrite();">신청등록</button>
							<button type="button" class="btn_down" onclick="excelDownload();">엑셀다운로드</button>
							<button type="button" class="btn_search" onclick="search();">검색</button>
						</div>
					</form>
					<form id="smsFrm" name="smsFrm" action="/admin/rental/goSms" method="post">
						<div class="search_wrap">
							<div class="result">
								<p class="txt">검색결과 총 <span>${totalCount}</span>건 / 총 인원 <span>${sumCount}</span>명</p>
							</div>
							<table class="search_list">
								<caption>검색결과</caption>
								<colgroup>
									<col style="width:3%;">
									<col style="width:5%;">
									<col style="width:5%;">
									<col style="width:10%;">
									<col style="width:5%;">
									<col style="width:10%;">
									<col style="width:10%;">
									<col style="width:10%;">
									<col style="*">
									<col style="width:5%;">
									<col style="*">
	                                <col style="width:5%;">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">번호</th>
										<th scope="col">예약번호</th>
										<th scope="col">신청 일시</th>
										<th scope="col">성명</th>
										<th scope="col">연락처</th>
										<th scope="col">체험일</th>
										<th scope="col">취소일</th>
										<th scope="col">단체명</th>
										<th scope="col">참여인원</th>
										<th scope="col">비고</th>
										<th scope="col">신청현황</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty list }">
											<tr><td colspan="12">데이타가 없습니다</td></tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="item" items="${list}" varStatus="statu">
												<tr>
													<td><input type="checkbox" id="mobile${item.seq}" name="rphoneArr" value="${item.phone}@${item.seq}"></td>
													<td>${totalCount - ((page -1) * 10 + statu.index)}</td>
													<td>${item.seq}</td>
													<td><fmt:formatDate value="${item.insertDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
													<td>${item.name }</td>
													<td>${item.phone}</td>
													<td>${item.useDate}</td>
													<td>${item.cancelDate}</td>
													<td>${item.teamName}</td>
				                                    <td><fmt:formatNumber value="${item.cnt}" pattern="#,###"/></td>
				                                    <td>${item.remark}</td>
	                                    			<td>
	                                    				<select name="stat" onchange="updateStat('${item.seq}','${item.cnt }','${item.useDate }',this);">
					                                        <option value="a" <c:if test="${item.stat == 'a'}">selected</c:if>>신청</option>
					                                        <%-- <option value="b" <c:if test="${item.stat == 'b'}">selected</c:if>>승인</option> --%>
					                                        <option value="c" <c:if test="${item.stat == 'c'}">selected</c:if>>취소</option>
					                                    </select>
	                                    			</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="pagination mt0">
								<c:if test="${page gt 1  }">
				                    <a href="?page=${page - 1}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}" class="prev">이전 페이지</a>
				                </c:if>
								<c:forEach var="pageLink" items="${pageLinks }">
				                    <c:choose>
				                        <c:when test="${page eq pageLink }">
				                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}" class="on" onclick="return false;">${pageLink }</a>
				                        </c:when>
				                        <c:otherwise>
				                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}">${pageLink }</a>
				                        </c:otherwise>
				                    </c:choose>
				                </c:forEach>
				                <c:if test="${page lt totalPage}">
				                    <a class="next" href="?page=${page + 1}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}">다음 페이지</a>
				                </c:if>
							</div>
						</div>
					</form>
						
				</div>
			</div>
		</div>
	</div>
</div>
<script>

$(function(){
	$('#gnb ul li').eq(1).addClass('on');
	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
});
function excelDownload(){
	$("#frm").attr("action","/admin/rental/rentallist/excel");
	$("#frm").submit();
}
function search(){
	$("#frm").attr("action","rentallist");
	$("#frm").submit();
}

function updateStat(seq,cnt,useDate,obj){
	var stat = $(obj).val()=="a"?"신청":$(obj).val()=="b"?"승인":"취소";
	var flag = confirm("상태값을 "+stat+"로 변경하시겠습니까?");
	if(flag){
		$.ajax({
    	    url : "/admin/rental/admin_rental_update"
    	    , data: {seq:seq,stat:$(obj).val(),useDate:useDate,cnt:cnt}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		alert("변경 완료 되었습니다.");
    	    		location.reload();
    	    	}else{
    	    		alert("변경 실패하였습니다.");
    	    		location.reload();
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
	}else{
		location.reload();
	}
}

function moveWrite(){
	location.href="/admin/rental/rentalWrite";
}

function goSms(){
	$("#smsFrm").submit();
}
</script>
</body>
</html>
