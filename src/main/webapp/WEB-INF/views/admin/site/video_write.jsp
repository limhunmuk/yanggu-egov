<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
		<c:import url="/WEB-INF/views/admin/common/left_site.jsp">
			<c:param name="menuOn" value="6" />
		</c:import>
		<div class="container clearfix">
				<div class="content">
					<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
					<div class="list_tit">
						<h3>홍보 동영상</h3>
					</div>
					<div class="write">
						<form id="frm" onsubmit="return frm_submit(this);">
							<table>
								<caption>작성</caption>
								<colgroup>
									<col style="width:10%;">
									<col style="width:90%;">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">영상제목 <span class="asta">*</span></th>
										<td>
											<input type="hidden" style="width:200px;" value="${writer}" name="writer">
											<input type="hidden" style="width:200px;" value="${one.seq }" name="seq">
											<input type="text" title="제목 입력" name="title" value="${one.title }" placeholder="제목을 입력하세요." style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">유형 <span class="asta">*</span></th>
										<td>
											<input type="radio" id="type_link" name="type" value="link" <c:if test="${one.type == 'link'}">checked</c:if>>
											<label for="type_link">링크</label>
											<input type="radio" id="type_attach" name="type" value="attach" <c:if test="${one.type == 'attach'}">checked</c:if>>
											<label for="type_attach">파일첨부</label>
										</td>
									</tr>
									<tr id="tr_attach">
										<th scope="row">파일 <span class="asta">*</span></th>
										<td>
											<div class="file_area">
												<div class="img_type01">
													<p>
														<input type="text" title="첨부파일 원본파일명" readonly="" name="attachment_org" value="${one.attachment_org}">
														<input type="hidden" title="첨부파일" readonly="" name="attachment" value="${oone.attachment}">
													</p>
													<input type="file" id="file_type">
													<label for="file_type" class="btn_file">파일찾기</label>
												</div>
												<button type="button" class="btn delete_btn" id="del" onclick="delFile();" style="display: none">삭제</button>
												<span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpeg, gif</span>
											</div>
										</td>
									</tr>
									<tr id="tr_link">
										<th scope="row">링크 <span class="asta">*</span></th>
										<td>
											<input type="text" name="url" value="${one.url}" title="링크 입력" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">노출상태 <span class="asta">*</span></th>
										<td>
											<input type="radio" id="state_y" name="stat" value="Y" <c:if test="${one.stat == 'Y'}">checked</c:if>>
											<label for="state_y">노출</label>
											<input type="radio" id="state_n" name="stat" value="N" <c:if test="${one.stat == 'N'}">checked</c:if>>
											<label for="state_n">미노출</label>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="write_btn align_r mt35">
								<a href="javascript:void(0);" class="btn_list">목록</a>
								<button type="submit" class="btn_modify">저장</button>
								<button type="button" class="btn_modify" id="btn_delete">삭제</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('#gnb ul li').eq(3).addClass('on');

			$("#file_type").change(function(){
				var filedata = new FormData();
				var file = document.getElementById('file_type');
				filedata.append('uploadfile', file.files[0]);
				filedata.append('file_src', "video");
				uploadFile(filedata,null,file.files[0].name);
			});

			if($("input[name=type]:checked").val() == "attach") {
				$("#tr_attach").show();
				$("#tr_link").hide();
			} else {
				$("#tr_attach").hide();
				$("#tr_link").show();
			}

			$("input[name=type]").change(function(){
				if($(this).attr("id") == "type_link"){
					$("#tr_attach").hide();
					$("#tr_link").show();
				}else {
					$("#tr_attach").show();
					$("#tr_link").hide();
				}
			});

			$("#btn_delete").click(function () {
				del();
			})
		});

		function delFile(){
			if(confirm("삭제하시겠습니까?")){
				$("input[name='attachment']").val("");
				$("input[name='attachment_org']").val("");
				$("#del").css("display","none");
				var agent = navigator.userAgent.toLowerCase();
				if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
					// ie 일때 input[type=file] init.
					$("#file_type").replaceWith( $("#file_type").clone(true) );
				} else {
					//other browser 일때 input[type=file] init.
					$("#file_type").val("");
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
						$("input[name='attachment']").val(data.fileTemp);
						$("input[name='attachment_org']").val(name);
						$("#del").css("display","");
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

		function frm_submit(frm){

			var flag = confirm("저장하시겠습니까?");
			var url = "/admin/site/videoInsert";

			if("${one.seq}" != ""){
				url = "/admin/site/videoUpdate";
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
						location.href="/admin/site/videoList";
					}else{
						alert("저장 실패하였습니다.");
					}
				}, error : function () {
					alert('error');
				}
			});

			return false;
		}

		function del(){
			var flag = confirm("삭제하시겠습니까?");
			if(!flag){
				return false;
			}
			$.ajax({
				url : "/admin/site/videoDelete"
				, data: {seq:"${one.seq}"}
				, type: 'post'
				, dataType: 'json'
				, success : function (data) {
					if(data.result != 0){
						location.href="/admin/site/videoList";
					}else{
						alert("삭제 실패하였습니다.");
					}
				}, error : function () {
					alert('error');
				}
			});
		}
	</script>
</body>
</html>