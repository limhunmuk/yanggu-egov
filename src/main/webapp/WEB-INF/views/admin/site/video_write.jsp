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
											<input type="text" title="제목 입력" placeholder="제목을 입력하세요." style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">유형 <span class="asta">*</span></th>
										<td>
											<input type="radio" id="type_link" name="type" value="">
											<label for="type_link">링크</label>
											<input type="radio" id="type_attach" name="type" value="">
											<label for="type_attach">파일첨부</label>
										</td>
									</tr>
									<tr>
										<th scope="row">파일 <span class="asta">*</span></th>
										<td>
											<div class="file_area">
												<div class="img_type01">
													<p>
														<input type="text" title="첨부파일 원본파일명2" readonly="" name="attachment2_org" value="">
														<input type="hidden" title="첨부파일2" readonly="" name="attachment2" value="">
													</p>
													<input type="file" id="file_type02">
													<label for="file_type02" class="btn_file">파일찾기</label>
												</div>
												<button type="button" class="btn delete_btn" id="del2" onclick="delFile(2);" style="display: none">삭제</button>
												<span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpeg, gif</span>
											</div>
											<ul class="file_list">
												<li>
													<a href="javascript:;" class="file">첨부한 파일명. 확장자</a>
													<button type="button" class="delete_btn">삭제</button>
												</li>
												<li>
													<a href="javascript:;" class="file">첨부한 파일명. 확장자</a>
													<button type="button" class="delete_btn">삭제</button>
												</li>
											</ul>
										</td>
									</tr>
									<tr>
										<th scope="row">링크 <span class="asta">*</span></th>
										<td>
											<input type="text" title="링크 입력" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">노출상태 <span class="asta">*</span></th>
										<td>
											<input type="radio" id="push_advertisement" name="push_setting" value="">
											<label for="push_advertisement">노출</label>
											<input type="radio" id="push_information" name="push_setting" value="">
											<label for="push_information">미노출</label>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="write_btn align_r mt35">
								<a href="./notice_list.html" class="btn_list">목록</a>
								<button type="submit" class="btn_modify">저장</button>
								<button type="submit" class="btn_modify">삭제</button>
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
		});
		function excelDownload(){
			$("#excel").submit();
		}
	</script>
</body>
</html>