<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_setting.jsp">
            <c:param name="menuOn" value="2" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>팝업 관리</h3>
				</div>
				<div class="write">
				<form id="frm">
					<table>
						<caption>팝업 관리</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">제목 <span class="ast">&#42;</span></th>
							<td>
								<input type="hidden" name="writer" value="${writer}">
								<input type="hidden" name="seq" value="${one.seq}">
								<input type="text" name="title" value="${one.title}" required>
							</td>
						</tr>
                        <tr>
                            <th scope="row">노출상태 <span class="ast">&#42;</span></th>
                            <td>
                            	<c:if test="${empty one.seq }">
                            		 <input type="radio" name="stat" id="display_y" value="N" checked>
	                                <label for="display_y" class="radio_label">노출</label>
	                                <input type="radio" name="stat" id="display_n" value="Y">
	                                <label for="display_n" class="radio_label">미노출</label>
                            	</c:if>
                               <c:if test="${not empty one.seq }">
                            		 <input type="radio" name="stat" id="display_y" value="N" <c:if test="${one.stat == 'N' }"> checked</c:if>>
	                                <label for="display_y" class="radio_label">노출</label>
	                                <input type="radio" name="stat" id="display_n" value="Y" <c:if test="${one.stat == 'Y' }"> checked</c:if>>
	                                <label for="display_n" class="radio_label">미노출</label>
                            	</c:if>
                            </td>
                        </tr>
                     	<tr>
							<th scope="row">이미지 <span class="ast">&#42;</span></th>
							<td>
								<div class="file_area">
									<div class="img_type01">
										<p>
											<input type="text" title="첨부파일 원본파일명" readonly name="attachment_org" value="${one.attachment_org }">
											<input type="hidden" title="첨부파일" readonly name="attachment" value="${one.attachment }">
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
                        <tr>
                            <th scope="row">링크URL <span class="ast"></span></th>
                            <td>
                                <input type="text" name="link" id="link" value="${one.link}" style="width:80%">
                                <select name="kind" id="kind">
                                	<option value="a" <c:if test="${one.kind == 'a' }"> selected</c:if>>새창</option>
                                	<option value="b" <c:if test="${one.kind == 'b' }"> selected</c:if>>현재창</option>
                                </select>
                            </td>
                        </tr>
					</table>
					<div class="write_btn align_r mt35">
						<a href="popuplist" class="btn_list">목록</a>
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
    					$("input[name='attachment']").val(data.fileTemp);
    					$("input[name='attachment_org']").val(file.files[0].name);
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
        
		$("#frm").submit(function(){
			var flag = confirm("저장하시겠습니까?");
        	var url = "/admin/setting/member/popupinsert";
        	
        	if("${one.seq}" != ""){
        		url = "/admin/setting/member/popupupdate";
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
        	    		location.href="/admin/setting/member/popuplist";
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
</script>
</body>
</html>
