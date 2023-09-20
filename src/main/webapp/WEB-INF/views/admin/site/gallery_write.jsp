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
            <c:param name="menuOn" value="3" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>
						<c:choose>
							<c:when test="${kind eq 'A'}">생태 식물원 사계</c:when>
							<c:when test="${kind eq 'B'}">생태관 사진</c:when>
							<c:when test="${kind eq 'C'}">분재 갤러리</c:when>
							<c:when test="${kind eq 'D'}">포토 갤러리</c:when>
						</c:choose>
					</h3>
				</div>
				<div class="write">
				<form id="frm" onsubmit="return frm_submit(this);">
					<table>
						<caption>공지사항</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">등록자</th>
							<td>
								<input type="hidden" style="width:200px;" value="${writer}" name="writer">
								<input type="hidden" style="width:200px;" value="${one.seq }" name="seq">
								<c:if test="${empty one.seq }"><input type="text" style="width:200px;" value="${name }" readonly="readonly"></c:if>
								<c:if test="${not empty one.seq }"><input type="text" style="width:200px;" value="${one.adminName }" readonly="readonly"></c:if>
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
						<tr>
							<th scope="row">첨부파일</th>
							<td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명1" readonly name="attachment_org" value="${one.attachment_org}">
                                            <input type="hidden" title="첨부파일1" readonly name="attachment" value="${one.attachment}">
                                        </p>
                                        <input type="file" id="file_type01">
                                        <label for="file_type01" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del1" onclick="delFile(1);" style="display: ${not empty one.attachment?'':'none'}">삭제</button>
                                    <span class="txt">※ 파일형식 : jpg, jpge, bmp, png, gif</span>
                                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">탭설정</th>
							<td>
								<input type="radio" name="season" id="season_1" value="1" <c:if test="${empty one.season or one.season eq '1'}">checked</c:if>><label for="season_1">봄</label>
								<input type="radio" name="season" id="season_2" value="2" <c:if test="${one.season eq '2'}">checked</c:if>><label for="season_2">여름</label>
								<input type="radio" name="season" id="season_3" value="3" <c:if test="${one.season eq '3'}">checked</c:if>><label for="season_3">가을</label>
								<input type="radio" name="season" id="season_4" value="4" <c:if test="${one.season eq '4'}">checked</c:if>><label for="season_4">겨울</label>
							</td>
						</tr>
						<tr>
							<th scope="row">노출상태</th>
							<td>
								<input type="hidden" id="kind" name="kind" value="${kind}">
								<select name="stat">
									<option value="Y" <c:if test="${one.stat == 'Y'}">selected</c:if>>노출</option>
									<option value="N" <c:if test="${one.stat == 'N'}">selected</c:if>>미노출</option>
								</select>
							</td>
						</tr>
					</table>
					<div class="write_btn align_r mt35">
						<a href="galleryList" class="btn_list">목록</a>
						<button type="submit" class="btn_modify">저장</button>
						<button type="button" class="btn_modify" onclick="del();">삭제</button>
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
	
	function del(){
		var flag = confirm("삭제하시겠습니까?");
		if(!flag){
    		return false;
    	}
		$.ajax({
    	    url : "/admin/site/deleteGallery"
    	    , data: {seq:"${one.seq}"}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		alert("삭제 성공하였습니다.");
    	    		location.href="/admin/site/galleryList";
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
    	var url = "/admin/site/insertGallery";
    	
    	if("${one.seq}" != ""){
    		url = "/admin/site/updateGallery";
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
    	    		alert("저장 성공하였습니다.");
    	    		location.href="/admin/site/galleryList?kind=D";
    	    	}else{
    	    		alert("저장 실패하였습니다.");
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
		
		return false;
	}
    
    $(function () {
        $('#gnb ul li').eq(3).addClass('on');
        
        $("#file_type01").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type01');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "gallery");
    		uploadFile(filedata,1,file.files[0].name);
        });
    });
    
    function delFile(){
    	if(confirm("삭제하시겠습니까?")){
    		$("input[name='attachment']").val("");
			$("input[name='attachment_org']").val("");
			$("#del"+kind+"").css("display","none");
			var agent = navigator.userAgent.toLowerCase();
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
			    // ie 일때 input[type=file] init.
			    $("#file_type0"+kind+"").replaceWith( $("#file_type0"+kind+"").clone(true) );
			} else {
			    //other browser 일때 input[type=file] init.
			    $("#file_type0"+kind+"").val("");
			}
    	}
    }
    
    function uploadFile(filedata,kind,name){
    	$.ajax({
			url: "/file/upload",
			contentType: 'multipart/form-data', 
			type: 'POST',
			data: filedata,   
			dataType: 'json',     
			mimeType: 'multipart/form-data',
			success: function (data) { 
				console.log(data);
				if(data.result == 1){
					$("input[name='attachment']").val(data.fileTemp);
					$("input[name='attachment_org']").val(name);
					$("#del"+kind+"").css("display","");
				}else{
					alert("파일 업로드 실패하였습니다")
				}
			},
			error : function (jqXHR, textStatus, errorThrown) {
				console.log("jqXHR : "+jqXHR);
				console.log("textStatus : "+textStatus);
				console.log("errorThrown : "+errorThrown);
				alert('ERRORS: ' + textStatus);
			},
			cache: false,
			contentType: false,
			processData: false
		}); 
    }
    
</script>
</body>
</html>
