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
			<c:param name="menuOn" value="2" />
		</c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>행사전시</h3>
				</div>
				<div class="write">
					<form id="frm" method="post">
						<table>
							<caption>작성</caption>
							<colgroup>
								<col style="width:15%;">
								<col style="width:85%;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제목 <span class="asta">*</span></th>
									<td>
										<input type="text" name="title" value="${one.title }" required>
									</td>
								</tr>
								<tr>
									<th scope="row">내용 <span class="asta">*</span></th>
									<td>
										<textarea id="editor_html" name="contents">${one.contents }</textarea>
									</td>
								</tr>
								<tr>
									<th scope="row">첨부 파일</th>
									<td>
										<div class="file_area">
											<div class="img_type01">
												<p>
													<input type="text" title="첨부파일 원본파일명" readonly name="attachment_org_list" value="">
													<input type="hidden" title="첨부파일" readonly name="attachment_list" value="">
												</p>
												<input type="file" id="file_type">
												<label for="file_type" class="btn_file">파일찾기</label>
											</div>
											<button type="button" class="btn delete_btn" id="" onclick="" style="display: none">삭제</button>
											<span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpeg, gif</span>
										</div>
										<ul class="file_list" id="add_file">
											<c:forEach var="item" varStatus="status" items="${fileList}">
												<li id="li_${item.seq}">
													<a href="javascript:;" class="file">${item.attachment_org}</a>
													<button type="button" class="delete_btn" onclick="deleteFile(${item.seq})">삭제</button>
												</li>
											</c:forEach>
										</ul>
										<input type="hidden" id="addFileCnt" name="addFileCnt" value="${fileList.size()}">
									</td>
								</tr>
								<tr>
									<th scope="row">PC 이미지(1개) <span class="asta">*</span></th>
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
											<span class="txt">※ 파일형식 : jpg, jpeg, gif</span>
										</div>
										<ul class="file_list" id="add_file_pc">
											<li>
												<img src="${pageContext.request.contextPath}/uploads/exhibition/${one.attachment }"/>
												<button type="button" class="delete_btn" onclick="delFile(1);">삭제</button>
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th scope="row">모바일 이미지(1개) <span class="asta">*</span></th>
									<td>
										<div class="file_area">
											<div class="img_type01">
												<p>
													<input type="text" title="첨부파일 원본파일명2" readonly name="attachment_org2" value="${one.attachment_org2}">
													<input type="hidden" title="첨부파일2" readonly name="attachment2" value="${one.attachment2}">
												</p>
												<input type="file" id="file_type02">
												<label for="file_type02" class="btn_file">파일찾기</label>
											</div>
											<button type="button" class="btn delete_btn" id="del2" onclick="delFile(2);" style="display: ${not empty one.attachment2?'':'none'}">삭제</button>
											<span class="txt">※ 파일형식 : jpg, jpeg, gif</span>
										</div>
										<ul class="file_list" id="add_file_mb">
											<li>
												<img src="${pageContext.request.contextPath}/uploads/exhibition/${one.attachment2 }"/>
												<button type="button" class="delete_btn" onclick="delFile(2);">삭제</button>
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th scope="row">노출상태</th>
									<td>
										<select name="state">
											<option value="Y" <c:if test="${one.stat == 'Y'}">selected</c:if>>노출</option>
											<option value="N" <c:if test="${one.stat == 'N'}">selected</c:if>>미노출</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" style="width:200px;" value="${writer}" name="writer">
						<input type="hidden" style="width:200px;" value="${one.seq }" name="seq">
						<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" >
						<div class="write_btn align_r mt35">
							<a href="javascript:void(0);" class="btn_list">목록</a>
							<button type="button" class="btn_modify" onclick="frm_submit();">저장</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		</div>
	</div>
<script>


	$(function () {
		$('#gnb ul li').eq(3).addClass('on');

		$("#file_type").change(function(){
			var filedata = new FormData();
			var file = document.getElementById('file_type');
			filedata.append('uploadfile', file.files[0]);
			filedata.append('file_src', "exhibition_list");
			uploadFile(filedata,0,file.files[0].name);
		});

		$("#file_type01").change(function(){
			var filedata1 = new FormData();
			var file1 = document.getElementById('file_type01');
			filedata1.append('uploadfile', file1.files[0]);
			filedata1.append('file_src', "exhibition");
			uploadFile(filedata1,1,file1.files[0].name);
		});

		$("#file_type02").change(function(){
			var filedata2 = new FormData();
			var file2 = document.getElementById('file_type02');
			filedata2.append('uploadfile', file2.files[0]);
			filedata2.append('file_src', "exhibition");
			uploadFile(filedata2,2,file2.files[0].name);
		});
	});

	function validForm() {
		var frm = document.forms.frm;
		oEditors.getById["editor_html"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터에 등록한 텍스트 입력

		if (frm.contents.value == '<p>&nbsp;</p>' || frm.contents.value == '') {
			alert('내용입력하세요');
			return false;
		}
	}

	function frm_submit(){

		var frm = document.forms.frm;
		validForm(frm);

		var flag = confirm("저장하시겠습니까?");
		var url = "/admin/site/insertExhibition";

		if("${one.seq}" != ""){
			url = "/admin/site/updateExhibition";
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
				if(data.result != 0){
					alert("저장 성공하였습니다.");
					location.href="/admin/site/exhibitionList";
				}else{
					alert("저장 실패하였습니다.");
				}
			}, error : function () {
				alert('error');
			}
		});

		return false;
	}

	function delFile(kind){
		if(confirm("삭제하시겠습니까?")){
			$("input[name='attachment']").val("");
			$("input[name='attachment_org']").val("");
			$("#del"+kind+"").css("display","none");

			if(kind == "1")	$("#add_file_pc").html("");		// pc 이미지 삭제
			if(kind == "2")	$("#add_file_mb").html("");	// 모바일 이미지 삭제


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
				if(data.result == 1){
					if(kind == 0) {

						let addFileCnt = parseInt($("#addFileCnt").val()) + 1;
						$("#addFileCnt").val(addFileCnt);

						$("#add_file").append(`<li id="li_`+addFileCnt+`">
												<a href="javascript:;" class="file">`+name+`</a>
												<button type="button" class="delete_btn" onclick="deleteFile(`+addFileCnt+`);">삭제</button>
												<input type="hidden" id="hiAddFile_`+addFileCnt+`" name="attachment_list" value="`+data.fileTemp+`"/>
												<input type="hidden" id="hiAddFileOrg_`+addFileCnt+`" name="attachment_org_list" value="`+name+`"/>
											 </li>`);
						addFileList(data.fileTemp, name);
					}else if(kind == 1){

						$("input[name='attachment']").val(data.fileTemp);
						$("input[name='attachment_org']").val(name);
						$("#del"+kind+"").css("display","");

						$("#add_file_pc").html(`<li>
													<img src="${pageContext.request.contextPath}/uploads/exhibition/`+data.fileTemp+`"/>
													<button type="button" class="delete_btn" onclick="delFile(1)">삭제</button>
											 	</li>`);

					}else{
						$("input[name='attachment2']").val(data.fileTemp);
						$("input[name='attachment_org2']").val(name);
						$("#del"+kind+"").css("display","");

						$("#add_file_mb").html(`<li>
													<img src="${pageContext.request.contextPath}/uploads/exhibition/`+data.fileTemp+`"/>
													<button type="button" class="delete_btn" onclick="delFile(2)">삭제</button>
											 	</li>`);
					}

				}else{
					alert("파일 업로드 실패하였습니다");
				}
			},
			error : function (jqXHR, textStatus, errorThrown) {
				console.log("jqXHR : "+jqXHR);
				console.log("textStatus : "+textStatus);
				console.log("errorThrown : "+errorThrown);
				alert('ERRORS: ' + textStatus);
			},
			complete : function(xhr, status) {
				// success와 error 콜백이 호출된 후에 반드시 호출, try - catch - finally의 finally 구문과 동일
			},
			cache: false,
			contentType: false,
			processData: false
		});
	}

	function addFileList(file_name, file_org_name) {

		let exhibitionSeq = $("input[name='seq']").val();
		$.ajax({
			url: '/admin/site/exhibitionWrite/addFile'
			, data: {
				'exhibitionSeq': exhibitionSeq,
				'attachment': file_name,
				'attachment_org': file_org_name
				}
			, type: 'post'
		}).done(function (data) {
			let result = JSON.parse(data);
			if (result.result != 1) {
				alert(result.msg);
			}
		}).fail(function (data) {
			console.log(data);
			alert('error > ' + data.status);
		});
	}

	function deleteFileList(){
		var flag = confirm("삭제하시겠습니까?");
		if(!flag){
			return false;
		}
	}

	function deleteFile(fileseq) {

		let flag = confirm("삭제하시겠습니까?");
		if(!flag){
			return false;
		}

		$.ajax({
			url : "/admin/site/exhibitionWrite/deleteFile"
			, data: {"seq" : fileseq, "exhibitionSeq" :"${one.seq}"}
			, type: 'post'
			, dataType: 'json'
			, success : function (data) {
				if(data != 0){
					$("#li_"+fileseq).remove();
					$("#addFileCnt").val(parseInt($("#addFileCnt").val())-1);
				}else{
					alert("삭제에 실패하였습니다.");
				}
			}, error : function () {
				alert('error');
			}
		});
	}


</script>
</body>
</html>