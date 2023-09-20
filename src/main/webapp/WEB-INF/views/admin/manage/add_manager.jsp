<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>

</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_manage.jsp">
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
                    <h3>운영자 관리</h3>
				</div>
				<div class="write">
                    <form id="frm">
                    	<input type="hidden" name="seq" value="${one.seq}">
    					<table>
                            <caption>운영자 관리</caption>
    						<colgroup>
    							<col style="width:15%;">
    							<col style="width:85%;">
    						</colgroup>
    						<tr>
    							<th scope="row">부서명 <span class="ast">&#42;</span></th>
    							<td>
    								<input type="text" title="담당자명" name="adminDept" value="${one.adminDept}" required>
    							</td>
    						</tr>
    						<tr>
    							<th scope="row">담당자명 <span class="ast">&#42;</span></th>
    							<td>
    								<input type="text" title="담당자명" name="adminName" value="${one.adminName}" required>
    							</td>
    						</tr>
    						<tr>
    							<th scope="row">아이디 <span class="ast">&#42;</span></th>
    							<td>
    								<input type="text" title="아이디" name="adminId" value="${one.adminId}" required <c:if test="${not empty one.seq}">readonly</c:if>>
    							</td>
    						</tr>
    						<tr>
    							<th scope="row">비밀번호 <span class="ast">&#42;</span></th>
    							<td>
                                    <input type="password" title="비밀번호" name="pwd" value="${one.pwd}" required  style="padding-left: 10px;">
    							</td>
    						</tr>
                            <tr>
                                <th scope="row">이메일 <span class="ast">&#42;</span></th>
                                <td>
                                    <input type="text" title="이메일" name="adminEmail" value="${one.adminEmail}" required>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">전화번호 <span class="ast">&#42;</span></th>
                                <td>
                                    <input type="text" title="전화번호" name="adminMobile" value="${one.adminMobile}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" required>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">IP <span class="ast">&#42;</span></th>
                                <td>
                                    <input type="text" title="IP" name="ip" value="${one.ip}" required>
                                </td>
                            </tr>
    						<tr>
    							<th scope="row">사용여부 <span class="ast">&#42;</span></th>
    							<td>
    								<c:if test="${empty one.seq }">
    									<input type="radio" name="deleteYn" title="사용" id="use_y" value="N" checked>
	    								<label for="use_y" class="radio_label">사용</label>
	    								<input type="radio" name="deleteYn" title="미사용" id="use_n" value="Y">
	    								<label for="use_n" class="radio_label">미사용</label>
    								</c:if>
    								<c:if test="${not empty one.seq }">
    									<input type="radio" name="deleteYn" title="사용" id="use_y" value="N" ${one.deleteYn == 'N'?'checked':''}>
	    								<label for="use_y" class="radio_label">사용</label>
	    								<input type="radio" name="deleteYn" title="미사용" id="use_n" value="Y" ${one.deleteYn == 'Y'?'checked':''}>
	    								<label for="use_n" class="radio_label">미사용</label>
    								</c:if>
    							</td>
    						</tr>
                            
                             <tr>
                                 <th scope="row">권한 <span class="ast">&#42;</span></th>
                                 <td>
                        <%--             <input type="checkbox" title="대관관리" id="allcheck">
                                     <label for="allcheck" class="radio_label">전체</label>
                                     <input type="checkbox" name="auth" title="예약 신청 관리" id="menu_0" value="1" <c:if test="${fn:substring(one.auth,3,4) == '1'}">checked</c:if>>
                                     <label for="menu_0" class="radio_label">예약 신청 관리</label>
                                     <input type="checkbox" name="auth" title="갤러리 관리" id="menu_1" value="10" <c:if test="${fn:substring(one.auth,2,3) == '1'}">checked</c:if>>
                                     <label for="menu_1" class="radio_label">갤러리 관리</label>
                                     <input type="checkbox" name="auth" title="게시판 관리" id="menu_2" value="100" <c:if test="${fn:substring(one.auth,1,2) == '1'}">checked</c:if>>
                                     <label for="menu_2" class="radio_label">게시판 관리</label>
                                     <input type="checkbox" name="auth" title="설정" id="menu_6" value="1000" <c:if test="${fn:substring(one.auth,0,1) == '1'}">checked</c:if>>
                                     <label for="menu_6" class="radio_label">설정</label>--%>


									<input type="checkbox" title="대관관리" id="allcheck">
									<label for="allcheck" class="radio_label">전체</label>
									<input type="checkbox" name="auth" title="예약·신청 관리" id="menu_0" value="1" <c:if test="${fn:substring(one.auth,5,6) == '1'}">checked</c:if>>
									<label for="menu_0" class="radio_label">예약 신청 관리</label>
									<input type="checkbox" name="auth" title="아카이브 관리" id="menu_1" value="10" <c:if test="${fn:substring(one.auth,4,5) == '1'}">checked</c:if>>
									<label for="menu_1" class="radio_label">갤러리 관리</label>
									<input type="checkbox" name="auth" title="게시판 관리" id="menu_2" value="100" <c:if test="${fn:substring(one.auth,3,4) == '1'}">checked</c:if>>
									<label for="menu_2" class="radio_label">게시판 관리</label>
									<input type="checkbox" name="auth" title="회원 관리" id="menu_3" value="1000" <c:if test="${fn:substring(one.auth,2,3) == '1'}">checked</c:if>>
									<label for="menu_3" class="radio_label">설정</label>
									<input type="checkbox" name="auth" title="통계분석 관리" id="menu_4" value="10000" <c:if test="${fn:substring(one.auth,1,2) == '1'}">checked</c:if>>
									<label for="menu_4" class="radio_label">설정</label>
									<input type="checkbox" name="auth" title="운영 관리" id="menu_5" value="100000" <c:if test="${fn:substring(one.auth,0,1) == '1'}">checked</c:if>>
									<label for="menu_5" class="radio_label">설정</label>
                                 </td>
                             </tr>
                            
    					</table>
    					<div class="write_btn align_r mt35">
                            <a href="javascript:history.back();" class="btn_list">목록</a>
    						<button type="submit" class="btn_modify">저장</button>
    					</div>
                    </form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    $(function () {
    	$('#gnb ul li').eq(5).addClass('on');
    	$('#allcheck').on('change', function () {
    		$('[name="auth"]').prop('checked', $(this).prop('checked'));
    	});
        
        
        $("#frm").submit(function(){
        	
        	if($("input[name='auth']:checked").length == 0){
        		alert("권한을 부여하세요");
        		return false;
        	}
        	
        	var flag = confirm("저장하시겠습니까?");
        	var url = "/admin/manage/insert";
        	
        	if("${one.seq}" != ""){
        		url = "/admin/manage/update";
        	}
        	if(!flag){
        		return false;
        	}
        	
        	$.ajax({
        	    url : url
        	    , data: $("#frm").serialize()
        	    , type: 'post'
        	    , dataType: 'json'
        	    , success : function (data) {
        	    	if(data != 0){
        	    		location.href="/admin/manage/managerList";
        	    	}else{
        	    		alert("중복된 아이디입니다");
        	    		$("input[name='adminId']").focus();
        	    	}
        	    }, error : function () {
        	    	alert('error');
        	    }
        	});
        	return false;
    	});
    });
</script>
</body>
</html>
