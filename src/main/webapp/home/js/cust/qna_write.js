/**FILEDESC
홈페이지:Q&A script 파일
*/

$( document ).ready(function() {
	allValidate();
});

function file_upload(){
	
	$('#loading').show();
	
	var filedata = new FormData(); // FormData 인스턴스 생성
		var file = document.getElementById('attachment_file');
		filedata.append('uploadfile', file.files[0]);
		filedata.append('file_src', "qna");	//들어갈 파일 지정 ( '파일명/' 형식), ""는 default
		
	    // 파일 업로드 확장자 체크
	    if( $("#attachment_file").val() != "" ){
			$("#attachment_file_name").text(file.files[0].name);
	         var ext = $("#attachment_file_name").text().split('.').pop().toLowerCase();
	         console.log("extext1----"+ext);
	 	  if($.inArray(ext, ['jsp', 'php', 'asp', 'html', 'perl']) != -1) {
	 	     alert('등록 할수 없는 파일명입니다.');
	 		$("#attachment_file_name").text("");
			$('#loading').hide();
	 	     return;
		  }
			$("#attachment_org").val(file.files[0].name);
			$("#del_attachment").show();
	     }
	    
	$.ajax({
		url: "/fileUpload",
		contentType: 'multipart/form-data', 
		type: 'POST',
		data: filedata,   
		dataType: 'json',     
		mimeType: 'multipart/form-data',
		success: function (data) { 
			if(data.result == 1){
				 console.log(data.fileTemp);
				 console.log("uploadDir---"+data.uploadDir);
					 $("#attachment").val(data.fileTemp);
				 $('#loading').hide();
			}else if(data.result == -2){
				alert("등록 할수 없는 파일명입니다.");
				return;
			}
		},
		error : function (jqXHR, textStatus, errorThrown) {
			alert('ERRORS: ' + textStatus);
		},
	    complete: function(){
			$('#loading').hide();
	    },
		cache: false,
		contentType: false,
		processData: false
	});      
}

$('#frm').submit (function(e) {
	
	e.preventDefault();
	
	var frm = document.frm;
	
	$.post( "/bbs/qna_writeAction", $("#frm").serialize() , function(result) {
		if(result['result']==1) {
			alert('등록하였습니다.');
			location.replace("/");
		}else if(result['result']==-1 || result['result']==0){
			alert('등록에 실패 했습니다. 다시 시도해 주세요');
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	})
	return false;
});

function delFile(){
	
		$("#attachment_file_name").text("");
		$("#attachment_org").val("");
		$("#attachment").val("");
		$("#del_attachment").hide();
	
}



