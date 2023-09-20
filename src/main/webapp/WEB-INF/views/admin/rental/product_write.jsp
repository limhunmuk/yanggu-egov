<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
            <c:param name="menuOn" value="4" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>체험프로그램 신청 관리</h3>
				</div>
				<div class="write">
				<form id="frm">
					<table>
						<caption>체험프로그램 신청 관리</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">제목 <span class="ast">&#42;</span></th>
							<td>
								<input type="hidden" name="seq" value="${one.seq}">
								<input type="text" name="title" value="${one.title}" required>
							</td>
						</tr>
						<tr>
							<th scope="row">기간 <span class="ast">&#42;</span></th>
							<td>
								<input type="text" name="text_date" value="${one.text_date}" required placeholder="YYYY-MM-DD~YYYY-MM-DD">
							</td>
						</tr>
						<tr>
							<th scope="row">대상 <span class="ast">&#42;</span></th>
							<td>
								<input type="text" name="mubiao" value="${one.mubiao}" required>
							</td>
						</tr>
						<tr>
							<th scope="row">인원 <span class="ast">&#42;</span></th>
							<td>
								<input type="hidden" name="number"/>
								<div class="btnArea mb20">
									<button type="button" class="btn add_btn" onclick="addNumberRow(this);">추가</button>
								</div>
								<c:if test="${empty one.seq}">
									<div class="addNumber">
										<input type="text" class="ico_date" value="" placeholder="날짜" readonly="readonly" required/>
										<input type="text" value="" style="width: 20%;" placeholder="인원" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required/>
										<select>
											<option value="명">명</option>
											<option value="팀">팀</option>
										</select>
									</div>
								</c:if>
								
								<c:if test="${!empty one.numberList}">
									<c:forEach items="${one.numberList}" var="nData" varStatus="status">
										<div class="addNumber">
											<input type="text" class="ico_date" value="${nData.date}" placeholder="날짜" readonly="readonly" required/>
											<input type="text" value="${nData.number}" style="width: 20%;" placeholder="인원" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required/>
											<select style="margin-right: 5px;">
												<option value="명" ${nData.type eq '명' ? 'selected':''}>명</option>
												<option value="팀" ${nData.type eq '팀' ? 'selected':''}>팀</option>
											</select>
											<c:if test="${!status.first}">
												<button type="button" class="btn" style="margin-left:5px;" onclick="removeNumberRow(this);">삭제</button>
											</c:if>
										</div>
									</c:forEach>
								</c:if>
								
<%-- 								<input type="text" name="number" value="${one.number}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required> --%>
							</td>
						</tr>
						<tr>
							<th scope="row">시간 <span class="ast">&#42;</span></th>
							<td>
								<input type="text" name="text_time" value="${one.text_time}">
							</td>
						</tr>
						<tr>
							<th scope="row">체험료 <span class="ast">&#42;</span></th>
							<td>
								<input type="text" name="price" value="${one.price}">
							</td>
						</tr>
						<tr>
							<th scope="row">유의사항 <span class="ast">&#42;</span></th>
							<td>
								<textarea name="content">${one.content}</textarea>
<%-- 								<input type="text" name="content" value="${one.content}" required> --%>
							</td>
						</tr>
                        <tr>
                            <th scope="row">노출상태 <span class="ast">&#42;</span></th>
                            <td>
                            	<c:if test="${empty one.seq }">
                            		 <input type="radio" name="stat" id="display_y" value="N" checked>
	                                <label for="display_y" class="radio_label">사용</label>
	                                <input type="radio" name="stat" id="display_n" value="Y">
	                                <label for="display_n" class="radio_label">미사용</label>
                            	</c:if>
                               <c:if test="${not empty one.seq }">
                            		<input type="radio" name="stat" id="display_y" value="N" <c:if test="${one.stat == 'N' }"> checked</c:if>>
	                                <label for="display_y" class="radio_label">사용</label>
	                                <input type="radio" name="stat" id="display_n" value="Y" <c:if test="${one.stat == 'Y' }"> checked</c:if>>
	                                <label for="display_n" class="radio_label">미사용</label>
                            	</c:if>
                            </td>
                        </tr>
                        <tr>
                        	<th scope="row">배너 등록 <span class="ast">&#42;</span></th>
                        	<td>
                        		<div class="file_area">
									<div class="img_type01">
										<p>
											<input type="text" title="첨부파일 원본파일명" readonly name="banner_org" value="${one.banner_org}">
											<input type="hidden" title="첨부파일" readonly name="banner" value="${one.banner}">
											<input type="hidden" name="writer" value="${writer}">
										</p>
										<input type="file" id="file_banner" accept="image/*">
										<label for="file_banner" class="btn_file">파일찾기</label>
									</div>
									<span class="txt">※ 파일형식 : jpg, jpge, bmp, gif, png</span>
								</div>
                        	</td>
                        </tr>
                        <c:if test="${empty one.seq }">
                        	<tr>
	                        	<th scope="row">팝업 등록</th>
	                        	<td>
	                        		<span class="txt">※ 첨부한 이미지가 팝업관리에 자동으로 등록됩니다.</span>
	                        		<div class="file_area">
										<div class="img_type01">
											<p>
												<input type="text" title="첨부파일 원본파일명" readonly name="attachment_org">
												<input type="hidden" title="첨부파일" readonly name="attachment">
												<input type="hidden" name="writer" value="${writer}">
											</p>
											<input type="file" id="file_type01" accept="image/*">
											<label for="file_type01" class="btn_file">파일찾기</label>
										</div>
										<c:if test="${empty one.seq }">
											<button type="button" class="btn delete_btn" id="del" style="display: none">삭제</button>
										</c:if>
										<c:if test="${not empty one.seq }">
											<button type="button" class="btn delete_btn" id="del" style="display: ${not empty one.attachment?'':'none'}">삭제</button>
										</c:if>
										<span class="txt">※ 파일형식 : jpg, jpge, bmp, gif, png</span>
									</div>
	                        	</td>
	                        </tr>
                        </c:if>
					</table>
					<div class="write_btn align_r mt35">
						<a href="productlist" class="btn_list">목록</a>
						<button type="button" class="btn_modify" onclick="validCheck();">저장</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function validCheck(){
		if($(":text[name=title]").val() == ""){
			alert("제목을 입력해주세요.");
			$(":text[name=title]").focus();
			return;
		}
		
		var regexp = /[0-9]{4}-[0-9]{2}-[0-9]{2}~[0-9]{4}-[0-9]{2}-[0-9]{2}/;
		var trem = $(":text[name=text_date]").val();
		
		if ( !regexp.test(trem) ) {
	        alert("기간을 YYYY-MM-DD~YYYY-MM-DD 형식으로 입력해주세요.");
	        $(":text[name=text_date]").focus();
	        return;
		}
		
		if($(":text[name=mubiao]").val() == ""){
			alert("대상을 입력해주세요.");
			$(":text[name=mubiao]").focus();
			return;
		}
		
		var numberArr = [];
		
		//인원 json 형태로 저장
		let numberRow = $(".addNumber").length;
		for(let i = 0; i < numberRow; i++) {
			let num_date = $(".addNumber:eq(" + i + ")").find(":text").eq(0).val();
			let num_number = $(".addNumber:eq(" + i + ")").find(":text").eq(1).val();
			let num_type = $(".addNumber:eq(" + i + ")").find("select").val();
			
			if((num_date != undefined && num_date != "") && (num_number != undefined && num_number != "")){
				numberArr.push({date:num_date, number:num_number, type:num_type});
			}
		}
		
		if(numberArr.length > 0){
			$(":hidden[name=number]").val(JSON.stringify(numberArr));
		} else {
			alert("인원을 입력해주세요.");
			$(".addNumber:eq(0)").find(":text").eq(0).focus();
			return;
		}
		
		if($(":text[name=text_time]").val() == ""){
			alert("시간을 입력해주세요.");
			$(":text[name=text_time]").focus();
			return;
		}
		
		if($(":text[name=price]").val() == ""){
			alert("체험료를 입력해주세요.");
			$(":text[name=price]").focus();
			return;
		}
		
		if($(":text[name=content]").val() == ""){
			alert("유의사항을 입력해주세요.");
			$("textarea[name=content]").focus();
			return;
		}
		
		if($(":hidden[name=banner]").val() == ""){
			alert("배너를 등록해주세요.");
			$("label[for=file_banner]").focus();
			return;
		}
		
		$("#frm").submit();
	}

	$(function () {
		$('#gnb ul li').eq(1).addClass('on');
		$('#lnb ul.menu > li').eq(3).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(3).addClass('on');
        
		$("#frm").submit(function(){
			var flag = confirm("저장하시겠습니까?");
			var url = "/admin/setting/member/productinsert";
        	
			if("${one.seq}" != ""){
        		url = "/admin/setting/member/productupdate";
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
						location.href="/admin/setting/member/productlist";
					}else{
						alert("저장 실패하였습니다.");
					}
				}, error : function () {
					alert('error');
				}
			});
		return false;
		});
	});
	
	<%-- 팝업 자동등록 --%>
	$("#file_type01").change(function(){
    	var filedata = new FormData();
    	var file = document.getElementById('file_type01');
		filedata.append('uploadfile', file.files[0]);
		filedata.append('file_src', "popup");
		
		$.ajax({
			url: "/file/upload",
			contentType: 'multipart/form-data', 
			type: 'POST',
			data: filedata,   
			dataType: 'json',     
			mimeType: 'multipart/form-data',
			success: function (data) { 
				//console.log(data);
				if(data.result == 1){
					$("#file_type01").parents(".img_type01").find("input[name='attachment']").val(data.fileTemp);
					$("#file_type01").parents(".img_type01").find("input[name='attachment_org']").val(file.files[0].name);
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
    });
	
	//배너 등록
	$("#file_banner").change(function(){
		var filedata = new FormData();
		var file = document.getElementById('file_banner');
		
		filedata.append('uploadfile', file.files[0]);
		filedata.append('file_src', "product");
		
		$.ajax({
			url: "/file/upload",
			contentType: 'multipart/form-data', 
			type: 'POST',
			cache: false,
			contentType: false,
			processData: false,
			data: filedata,   
			dataType: 'json',     
			mimeType: 'multipart/form-data',
			success: function (data) { 
				if(data.result == 1){
					$("#file_banner").parents(".img_type01").find("input[name='banner']").val(data.fileTemp);
					$("#file_banner").parents(".img_type01").find("input[name='banner_org']").val(file.files[0].name);
				}else{
					alert("파일 업로드 실패하였습니다")
				}
			},
			error : function (jqXHR, textStatus, errorThrown) {
				alert('ERRORS: ' + textStatus);
			}
		});
	});
	
	
	
	
	$("#del").click(function(){
    	if(confirm("삭제하시겠습니까?")){
    		$("input[name='attachment']").val("");
			$("input[name='attachment_org']").val("");
			$("#del").css("display","none");
			var agent = navigator.userAgent.toLowerCase();
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
			    // ie 일때 input[type=file] init.
			    $("#file_type01").replaceWith( $("#file_type01").clone(true) );
			} else {
			    //other browser 일때 input[type=file] init.
			    $("#file_type01").val("");
			}
    	}
    });
	
	//인원 설정 추가
	function addNumberRow(btn){
		var html = '<div class="addNumber">'
				+ '<input type="text" class="ico_date" value="" placeholder="날짜" readonly="readonly"/>'
				+ '<input type="text" value="" style="width: 20%; margin-left:5px;" placeholder="인원"/>'
				+ '<select style="margin-left:5px;"><option value="명">명</option><option value="팀">팀</option></select>'
				+ '<button type="button" class="btn" style="margin-left:5px;" onclick="removeNumberRow(this);">삭제</button>'
			+ '</div>';
		
		$(btn).parents("td").append(html);
		
		$(".ico_date").datepicker();
	}
	
	//인원 설정 삭제
	function removeNumberRow(btn) {
		$(btn).parents(".addNumber").remove();
	}
</script>
</body>
</html>
