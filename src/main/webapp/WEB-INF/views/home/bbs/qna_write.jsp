<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<hr>
	<!-- container -->
		<div class="sub_container">
			<div class="sub_visual bg07">
				<h2 class="title">열린 공간</h2>
				<p><i class="home_i"></i><span>열린 공간</span><span>1:1문의</span></p>
			</div>
			<div id="container" class="sub_content">
				<div class="board_wrap">
					<!-- qna_info -->
					<div class="qna_info">
						<i class="ico_info"></i>
						<p class="info_txt"> 
							<strong>양구자연생태공원에 대해 궁금하신 점이나 의견을 남겨주세요.</strong> <br>
							문의하신 내용은 최대한 빠르게 확인하여 친절하게 답변 드리겠습니다.
						</p>
					</div>
					<!-- //qna_info -->
					<form onsubmit="return frm_submit();" id="frm">
						<fieldset>
							<legend>QnA 등록</legend>
							<div class="table_wrap qna_table">
								<dl>
									<dt>
										 이름 <strong class="required">*</strong>
									</dt>
									<dd>
										<div class="input_area">
											<input type="text" placeholder="제목을 입력해주세요." id="memberName" name="memberName" required>
											<label for="memberName" class="blind">이름</label>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>
										 핸드폰 번호 <strong class="required">*</strong>
									</dt>
									<dd>
										<div class="input_area">
											<input type="text" placeholder="제목을 입력해주세요." id="memberPhone" name="memberPhone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
											<label for="memberPhone" class="blind">핸드폰 번호</label>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>
										 이메일 <strong class="required">*</strong>
									</dt>
									<dd>
										<div class="input_area">
											<input type="text" placeholder="제목을 입력해주세요." id="memberEmail" name="memberEmail" required>
											<label for="memberEmail" class="blind">이메일</label>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>
										 제목 <strong class="required">*</strong>
									</dt>
									<dd>
										<div class="input_area">
											<input type="text" name="title" id="title" placeholder="제목을 입력해주세요." required>
											<label for="title" class="blind">제목</label>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>
										 내용 <strong class="required">*</strong>
									</dt>
									<dd>
										<textarea name="content" id="content" placeholder="문의내용을 입력해주세요." title="문의내용을 입력해주세요." required></textarea>
										<label for="content" class="blind">내용</label>
									</dd>
								</dl>
								<dl>
									<dt>
										첨부파일
									</dt>
									<dd>
										<div class="attach_area">
											<div class="file_area">
												<input type="text" name="attachment_org" id="attachment_org" readonly>
												<label for="attachment_org" class="blind">첨부파일</label>
												<input type="hidden" name="attachment" id="attachment">
												<input type="file" id="file_type01">
												<label for="file_type01" class="file_btn">찾아보기</label>
											</div>
											<div class="txt_area">
												<p >파일형식(ppt, pptx, xls, xlsx, doc, docx, pdf, jpg, jpeg, gif, zip) / 파일용량(5mb 이하)</p>
											</div>
										</div>
										<div class="refer_area">
											<span>
												<span id="attachment_file_name"></span>
												<button type="button" id="del" class="btn" style="display: none">삭제</button>
											</span>
										</div>
									</dd>
								</dl>
								<dl>
									<dt>
										 인증번호 <strong class="required">*</strong>
									</dt>
									<dd>
										<div class="input_area">
											<input type="text" id="number" placeholder="인증번호를 입력해주세요." required>
											<label for="title" class="blind">인증번호를 입력해주세요.</label>
										</div>
										<div class="txt_area">
											<p><c:out value="${number }"/></p>
										</div>
									</dd>
								</dl>
							</div>
							<div class="btn_area qna_btn">
								<button type="submit" class="btn">등록</button>
								<button type="button" class="btn form02" onclick="location.replace('/')">취소</button>
							</div>
						</fieldset>
					</form>
                </div>
            </div>
			
		</div>
		<!-- //container -->
		<hr>
        <%@ include file="../inc/footer.jsp"%>
	</div>
<script>
	
    $(function () {
        $('#gnb ul li').eq(3).addClass('on');
        
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
    	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    	if(!regExp.test($("#memberEmail").val())) {      
    		alert("올바른 이메일 형식이 아닙니다.");
            return false;
		}
    	
    	if($("#number").val() != "${number}"){
    		alert("인증번호를 다시 입력해주세요.");
            return false;
    	}
		
		var flag = confirm("등록하시겠습니까?");
    	if(!flag){
    		return false;
    	}else{
    /* 		
    $.ajax({
        	    url : "qna_insert.do"
        	    , data: $("#frm").serialize()
        	    , type: 'post'
        	    , dataType: 'json'
        	    , success : function (data) {
        	    	if(data != 0){
        	    		location.href="/";
        	    	}else{
        	    		alert("저장 실패하였습니다.");
        	    	}
        	    }, error : function () {
        	    	alert('error');
        	    }
        	}); */
    		
    		 	var objErr;
    		    var objData;
    		
    	    	alert("START CALL!");
    	    	alert($("#frm").serialize());
    	    	console.log($("#frm").serialize());
    			$.ajax({
    			    url:'qna_insert.do', //request 보낼 서버의 경로
    			    type:'get', // 메소드(get, post, put 등)
    			    data:$("#frm").serialize(), //보낼 데이터
    			    success: function(data) {
    			        //서버로부터 정상적으로 응답이 왔을 때 실행
    			        //objData = data;
    			        alert("정상수신 , data = "+data);
    			    },
    			    error: function(err) {
    			        //서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
    			        objErr = err;
    			    	alert("오류발생 , error="+err.state());
    			    	
    			    	console.log(err.state());
    			    	console.log(err);
    			    	
    			    }
    			});
    			return false;
    	}
    	return false;
	}
    
    function test(){
    	$.ajax({
		    url:'/bbs/test.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		  data:{'id':'admin'}, //보낼 데이터 //보낼 데이터
		    success: function(data) {
		        //서버로부터 정상적으로 응답이 왔을 때 실행
		        //objData = data;
		        alert("정상수신 , data = "+data);
		    },
		    error: function(err) {
		        //서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
		        objErr = err;
		    	alert("오류발생 , error="+err.state());
		    	
		    	console.log(err.state());
		    	console.log(err);
		    	
		    }
		});
    }
</script>
</body>
</html>

