<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<style>
.write table tr td .file_area .img_type01 .btn_del{height:32px;font-size:14px;position:absolute;top:0;right:-45px;background-color:#20494c;}
</style>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_site.jsp">
            <c:param name="menuOn" value="5" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>목공예 체험 프로그램</h3>
				</div>
				<div class="write">
				<form id="frm" onsubmit="return frm_submit();">
					<table>
						<caption>행사사진</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						 <tr>
                            <th scope="row">제목 <span class="ast">&#42;</span></th>
                            <td>
                            	<input type="hidden" style="width:200px;" value="${writer }" name="writer">
								<input type="hidden" style="width:200px;" value="${one.seq }" name="seq">
                                <input type="text" name="title" required value="${one.title }">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">소요시간 <span class="ast">&#42;</span><br>(가로×세로×높이또는폭,mm)</th>
                            <td>
                                <input type="text" name="text_date" required value="${one.text_date }">
                            </td>
                        </tr>
						<tr>
							<th scope="row">이용료 <span class="ast">&#42;</span></th>
							<td>
                                <input type="text" name="price" required value="${one.price }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
							</td>
						</tr>
						<tr>
							<th scope="row">이미지파일</th>
							<td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명" readonly name="attachment_org" value="${one.attachment_org }" required>
                                            <input type="hidden" title="첨부파일" readonly name="attachment" value="${one.attachment }">
                                        </p>
                                        <input type="file" id="file_type01">
                                        <label for="file_type01" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del" style="display: none">삭제</button>
                                    <span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpge, bmp, gif</span>
                                </div>
							</td>
						</tr>
						<tr>
							<th scope="row">비고 </th>
							<td>
                                <input type="text" name="remark" value="${one.remark }">
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
					</table>
					<div class="write_btn align_r mt35">
						<a href="woodWorkingList" class="btn_list">목록</a>
						<button type="submit" class="btn_modify">저장</button>
						<c:if test="${not empty one.seq }">
							<button type="button" class="btn_modify" onclick="delWoodworking();">삭제</button>
						</c:if>
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
        
        $("#file_type01").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type01');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "woodworking");
    		
    		$.ajax({
    			url: "${pageContext.request.contextPath}/file/upload",
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
    });
    
    function frm_submit(){
		
		var flag = confirm("저장하시겠습니까?");
    	var url = "/admin/site/insertWoodWorking";
    	
    	if("${one.seq}" != ""){
    		url = "/admin/site/updateWoodWorking";
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
    	    		location.href="/admin/site/woodWorkingList";
    	    	}else{
    	    		alert("저장 실패하였습니다.");
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
		
		return false;
	}
    
    function delWoodworking(){
		var flag = confirm("삭제하시겠습니까?");
		if(!flag){
    		return false;
    	}
		$.ajax({
    	    url : "/admin/site/deleteWoodWorking"
    	    , data: {seq:"${one.seq}"}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		location.href="/admin/site/woodWorkingList";
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
