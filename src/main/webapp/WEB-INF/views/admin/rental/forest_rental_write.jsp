<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/admin/common/head.jsp"/>

</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
		</c:import>
		<!--
        <c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
            <c:param name="menuOn" value="2" />
        </c:import>
		-->
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>신청관리</h3>
				</div>
				<div class="list">
					<div class="search_wrap">
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">예약번호</th>
									<th scope="col">예약 일시</th>
									<th scope="col">시간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${result.seq}</td>
									<td>${result.useDate}</td>
									<td>
										<c:choose>
											<c:when test="${result.entryTime == '1'}">
												오전 10:00 ~ 11:30
											</c:when>
											<c:when test="${result.entryTime == '2' }">
												오후 13:30 ~ 15:00
											</c:when>
											<c:otherwise>
												<c:if test="${result.gubun == 'f' }">
												오후 15:30 ~ 17:00
												</c:if>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="write">
					<table>
						<caption>신청관리</caption>
							<colgroup>
								<col style="width:15%;">
								<col style="*">
							</colgroup>
							<tr>
								<th scope="row">신청자명</th>
								<td>${result.name }</td>
							</tr>
							<tr>
								<th scope="row">전화 정보</th>
								<td>${result.mobile }</td>
							</tr>
							<tr>
								<th scope="row">참가인원</th>
								<td>${result.cnt }명</td>
							</tr>
							<tr>
								<th scope="row">상태</th>
								<td>
									<c:choose>
										<c:when test="${result.stat == 'a'}">
											신청
										</c:when>
										<c:when test="${result.stat == 'b'}">
											승인
										</c:when>
										<c:otherwise>
											취소
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td>${result.remark }</td>
							</tr>
						</table>
						<div class="write_btn align_r mt35">
							<a href="javascript:window.history.back();" class="btn_list">목록</a>
						</div>
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

		$('#gnb ul li').eq(1).addClass('on');
		$('#lnb ul.menu > li').eq(0).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(0).addClass('on');


		/* $(".layerpopup .btn_close").on("click", function () {
			$(".layerpop-box").removeClass("open");
			$('html').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제
		}); */
        
        /*$("#file_type01").change(function(){
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
        });*/
       
    });
    
   /* function delFile(kind){
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
    }*/
    
</script>
</body>
</html>
