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
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>공지사항</h3>
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
						<tr>
							<th scope="row">첨부파일1</th>
							<td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명1" readonly name="attachment1_org" value="${one.attachment1_org}">
                                            <input type="hidden" title="첨부파일1" readonly name="attachment1" value="${one.attachment1}">
                                        </p>
                                        <input type="file" id="file_type01">
                                        <label for="file_type01" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del1" onclick="delFile(1);" style="display: ${not empty one.attachment1?'':'none'}">삭제</button>
                                    <span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpge, bmp, gif</span>
                                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일2</th>
							<td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명2" readonly name="attachment2_org" value="${one.attachment2_org}">
                                            <input type="hidden" title="첨부파일2" readonly name="attachment2" value="${one.attachment2}">
                                        </p>
                                        <input type="file" id="file_type02">
                                        <label for="file_type02" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del2" onclick="delFile(2);" style="display: ${not empty one.attachment2?'':'none'}">삭제</button>
                                    <span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpge, bmp, gif</span>
                                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일3</th>
							<td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명3" readonly name="attachment3_org" value="${one.attachment3_org}">
                                            <input type="hidden" title="첨부파일3" readonly name="attachment3" value="${one.attachment3}">
                                        </p>
                                        <input type="file" id="file_type03">
                                        <label for="file_type03" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del3" onclick="delFile(3);" style="display: ${not empty one.attachment3?'':'none'}">삭제</button>
                                    <span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpge, bmp, gif</span>
                                </div>
							</td>
						</tr>
						<tr>
                            <th scope="row">공지글 설정<span class="ast">&#42;</span></th>
                            <td>
                                <input type="checkbox" name="kind" value="Y" id="kind" <c:if test="${one.kind == 'Y' }">checked</c:if>>
                                <label for="kind" >설정</label>
                            </td>
                        </tr>
					</table>
					<div class="write_btn align_r mt35">
						<a href="noticelist" class="btn_list">목록</a>
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
	
	function del(){
		var flag = confirm("삭제하시겠습니까?");
		if(!flag){
    		return false;
    	}
		$.ajax({
    	    url : "/admin/site/delete"
    	    , data: {seq:"${one.seq}"}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		location.href="/admin/site/noticelist";
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
    	var url = "/admin/site/insert";
    	
    	if("${one.seq}" != ""){
    		url = "/admin/site/update";
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
    	    		location.href="/admin/site/noticelist";
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
        $('#gnb ul li').eq(4).addClass('on');
        
        $("#file_type01").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type01');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "notice");
    		uploadFile(filedata,1,file.files[0].name);
        });
        $("#file_type02").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type02');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "notice");
    		uploadFile(filedata,2,file.files[0].name);
        });
        $("#file_type03").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type03');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "notice");
    		uploadFile(filedata,3,file.files[0].name);
        });
       
    });
    
    function delFile(kind){
    	if(confirm("삭제하시겠습니까?")){
    		$("input[name='attachment"+kind+"']").val("");
			$("input[name='attachment"+kind+"_org']").val("");
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
					$("input[name='attachment"+kind+"']").val(data.fileTemp);
					$("input[name='attachment"+kind+"_org']").val(name);
					$("#del"+kind+"").css("display","");
				}else{
					alert("파일 업로드 실패하였습니다")
				}
			},
			error : function (jqXHR, textStatus, errorThrown) {
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
