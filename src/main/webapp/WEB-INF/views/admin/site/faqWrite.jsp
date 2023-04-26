<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>

<%@ include file="../inc/smartEditor.jsp"%>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_site.jsp">
            <c:param name="menuOn" value="4" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>자주하는 질문 (FAQ)</h3>
				</div>
				<div class="write">
				<form id="frm" onsubmit="return frm_submit(this);">
					<table>
						<caption>자주하는 질문 (FAQ)</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">등록자</th>
							<td>
								<input type="hidden" style="width:200px;" value="${writer }" name="writer">
								<input type="hidden" style="width:200px;" value="${one.seq }" name="seq">
								<c:if test="${empty one.seq }"><input type="text" style="width:200px;" value="${name }" readonly="readonly"></c:if>
								<c:if test="${not empty one.seq }"><input type="text" style="width:200px;" value="${one.adminName }" readonly="readonly"></c:if>
							</td>
						</tr>
                        <tr>
                            <th scope="row">노출상태</th>
                            <td>
                                <select name="stat">
                                    <option value="Y" <c:if test="${one.stat == 'Y'}">selected</c:if>>노출</option>
                                    <option value="N" <c:if test="${one.stat == 'N'}">selected</c:if>>미노출</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">제목 <span class="ast">&#42;</span></th>
                            <td>
                                <input type="text" name="title" value="${one.title }" required>
                            </td>
                        </tr>
						<tr>
							<th scope="row">내용 <span class="ast">&#42;</span></th>
							<td>
                                <textarea id="editor_html" name="content">${one.content }</textarea>
							</td>
						</tr>
					</table>
					<div class="write_btn align_r mt35">
						<a href="faqlist" class="btn_list">목록</a>
						<button type="submit" class="btn_modify">저장</button>
						<c:if test="${not empty one.seq }">
							<button type="button" class="btn_modify" onclick="del();">삭제</button>
						</c:if>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function validForm(frm) {
		oEditors.getById["editor_html"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터에 등록한 텍스트 입력
	
		if (frm.content.value == '<p>&nbsp;</p>' || frm.content.value == '') {
			alert('내용입력하세요');
			return false;
		}
	}
    $(function () {
        $('#gnb ul li').eq(4).addClass('on'); 
    });
    
    function del(){
		var flag = confirm("삭제하시겠습니까?");
		if(!flag){
    		return false;
    	}
		$.ajax({
    	    url : "/admin/site/faqdelete"
    	    , data: {seq:"${one.seq}"}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		location.href="/admin/site/faqlist";
    	    	}else{
    	    		alert("삭제 실패하였습니다.");
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
	}
	
	function frm_submit(frm){
		validForm(frm);
		
		var flag = confirm("저장하시겠습니까?");
    	var url = "/admin/site/faqinsert";
    	
    	if("${one.seq}" != ""){
    		url = "/admin/site/faqupdate";
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
    	    		location.href="/admin/site/faqlist";
    	    	}else{
    	    		alert("저장 실패하였습니다.");
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
		
		return false;
	}
</script>
</body>
</html>
