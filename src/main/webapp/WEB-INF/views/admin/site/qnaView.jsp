<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
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
					<h3>1:1 문의 내역</h3>
				</div>
				<div class="write">
					<form action="/admin/site/qnamodify" method="post" id="frm">
						<input type="hidden" name="writer" value="${writer }">
						<input type="hidden" name="seq" value="${one.seq }">
						<input type="hidden" name="email" value="${one.memberEmail }">
						<input type="hidden" name="title" value="${one.title }">
						<input type="hidden" name="content" value="${one.content }">
					<table>
						<caption>Q&amp;A</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="*">
						</colgroup>
						<tr>
							<th scope="row">등록자</th>
							<td>${one.memberName }</td>
						</tr>
                        <tr>
                            <th scope="row">이메일</th>
                            <td>${one.memberEmail }</td>
                        </tr>
                        <tr>
                            <th scope="row">등록일</th>
                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${one.insertDate }"/></td>
                        </tr>
                        <tr>
                            <th scope="row">답변여부</th>
                            <td>${one.stat=="Y"?"답변":"미답변" }</td>
                        </tr>
                        <tr>
                            <th scope="row">제목</th>
                            <td>${one.title }</td>
                        </tr>
						<tr>
							<th scope="row">내용</th>
							<td>
                                ${one.content }
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
                                <c:if test="${not empty one.attachment_org }">
                                	<button type="button" class="btn" onclick="fileDownLoad('qna','${one.attachment}','${one.attachment_org}');">Download</button>
                                	<span>${one.attachment_org }</span>
                                </c:if>
                            </td>
						</tr>
					</table>
                    <div class="write_btn align_r mt35">
                        <a href="qnaList" class="btn_list">목록</a>
                        <button type="button" class="btn_modify" onclick="delQna();">삭제</button>
                    </div>
                    <table>
                        <caption>답변하기</caption>
                        <colgroup>
                            <col style="width:15%;">
                            <col style="*">
                        </colgroup>
                        <tr>
                            <th scope="row">답변일시</th>
                            <td>
                                ${one.reInsertDate }
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">답변내용</th>
                            <td>
                                <textarea name="re_content" id="re_content">${one.re_content }</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">첨부파일</th>
                            <td>
                                <div class="file_area">
                                    <div class="img_type01">
                                        <p>
                                            <input type="text" title="첨부파일 원본파일명" readonly name="re_attachment_org" value="${one.re_attachment_org }">
                                            <input type="hidden" title="첨부파일" readonly name="re_attachment" value="${one.re_attachment}">
                                        </p>
                                        <input type="file" id="file_type01">
                                        <label for="file_type01" class="btn_file">파일찾기</label>
                                    </div>
                                    <button type="button" class="btn delete_btn" id="del" style="display: ${not empty one.re_attachment?'':'none'}">삭제</button>
                                    <span class="txt">※ 파일형식 : ppt, pptx, xls, xlsx, doc, docx, jpg, jpge, bmp, gif</span>
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                    <p class="txt" style="color:#ff0000;font-weight:bold;">
                        ※ 답변된 내용은 수정/삭제가 불가능 합니다. 신중히 답변해주시기 바랍니다.
                    </p>
                    <c:if test="${empty one.re_content}">
	                    <div class="write_btn align_r">
	                        <button type="submit" class="btn_modify">답변하기</button>
	                    </div>
                    </c:if>
                    </form>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="/file/download" method="post" id="fileform" name="fileform" >
	<input type="hidden" name="src" value="">
	<input type="hidden" name="org" value="">
	<input type="hidden" name="tmp" value="">
</form>
<script>
    function validForm() {
    	oEditors.getById["content_html"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터에 등록한 텍스트 입력
    }
    $(function () {
        $('#gnb ul li').eq(4).addClass('on');
        
        $("#file_type01").change(function(){
        	var filedata = new FormData();
        	var file = document.getElementById('file_type01');
    		filedata.append('uploadfile', file.files[0]);
    		filedata.append('file_src', "qna");
    		
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
    					$("input[name='re_attachment']").val(data.fileTemp);
    					$("input[name='re_attachment_org']").val(file.files[0].name);
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
        		$("input[name='re_attachment']").val("");
    			$("input[name='re_attachment_org']").val("");
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
        	if($("#re_content").val() == ""){
        		alert("답변 내용을 입력하세요");
        		return false;
        	}
        	var flag = confirm("답변하시겠습니까?");
        	if(!flag){
        		return false;
        	}
        	
        });
    });
    
    function fileDownLoad(src,tmp,org){
    	$("input[name='src']").val(src);
    	$("input[name='org']").val(org);
    	$("input[name='tmp']").val(tmp);
    
    	$("#fileform").submit();
    }
    
    function delQna(){
    	var result = confirm('삭제하시겠습니까?');
    	if(result){
    		location.href = '/admin/site/qnadelete?seq='+"${one.seq}";
    	}
    }
</script>
</body>
</html>
