/**FILEDESC
홈페이지:팀 등록 script 파일
*/

$( document ).ready(function() {
	allValidate();
});

function file_upload(file_no){
	
	$('#loading').show();
	
	var filedata = new FormData(); // FormData 인스턴스 생성
	if(file_no==1){
		var file = document.getElementById('rule_file');
		filedata.append('uploadfile', file.files[0]);
		filedata.append('file_src', "rule_file");	//들어갈 파일 지정 ( '파일명/' 형식), ""는 default
		
	    // 파일 업로드 확장자 체크
	    if( $("#file_text").val() != "" ){
			$("#rule_file_name").text(file.files[0].name);
	         var ext = $("#rule_file_name").text().split('.').pop().toLowerCase();
	         console.log("extext1----"+ext);
	 	  if($.inArray(ext, ['jsp', 'php', 'asp', 'html', 'perl']) != -1) {
	 	     alert('등록 할수 없는 파일명입니다.');
	 		$("#rule_file_name").text("");
			$('#loading').hide();
	 	     return;
		  }
			$("#rulesFile").val(file.files[0].name);
			$("#ruleArea").show();
	     }
	    
	}else{
		var file = document.getElementById('pledge_file');
		filedata.append('uploadfile', file.files[0]);
		filedata.append('file_src', "pledge_file");	//들어갈 파일 지정 ( '파일명/' 형식), ""는 default
		
	    // 파일 업로드 확장자 체크
	    if( $("#file_text").val() != "" ){
			$("#pledge_file_name").text(file.files[0].name);
	         var ext = $("#pledge_file_name").text().split('.').pop().toLowerCase();
	         console.log("extext2----"+ext);
	 	  if($.inArray(ext, ['jsp', 'php', 'asp', 'html', 'perl']) != -1) {
	 	     alert('등록 할수 없는 파일명입니다.');
		 	 $("#pledge_file_name").text("");
			 $('#loading').hide();
	 	     return;
		  }
			$("#vowsFile").val(file.files[0].name);
			$("#del_pledge").show();
	     }
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
				 if(file_no==1){
					 $("#rulesTemp").val(data.fileTemp);
				 }else{
					 $("#vowsTemp").val(data.fileTemp);
				 }
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

function selectCate(){
	var cseq =$("#cseq option:selected").text();
	$("#place").html(cseq);
}

function add_member(){
	if ($("#member_name").val() == "") {
		alert("성명을 입력해 주세요.");
		$("member_name").focus();
		return;
	}
	if ($("#member_address1").val() == "") {
		alert("주소를 입력해 주세요.");
		$("#member_address1").focus();
		return;
	}
	if ($("#member_address2").val() == "") {
		alert("상세주소를 입력해 주세요.");
		$("#member_address2").focus();
		return;
	}
	if ($("#year").val() == "") {
		alert("년도를 입력해 주세요.");
		$("#year").focus();
		return;
	}
	if ($("#month").val() == "") {
		alert("월를 입력해 주세요.");
		$("#month").focus();
		return;
	}
	if ($("#day").val() == "") {
		alert("일를 입력해 주세요.");
		$("#day").focus();
		return;
	}
		
	$.post( "/sports/insertTempTeamMember", $("#frm").serialize()+"&zipcode="+_zipcode , function(result) {
		if(result['result']==0) {
			
			var addMemberText =   "<div class=\"info_area\" id=\"addTameMember"+result['po_seq']+"\"> "+
			    "<div class=\"mi_inner\">"+
			    "<span>"+result['name']+"</span>"+
			    "<span>"+result['birthday']+"</span>"+
			    "<span>"+result['addr']+"</span>"+
			    "</div>"+
			    "<button type=\"button\" class=\"btn\" onclick=\"delTeamMember('"+result['po_seq']+"')\">삭제</button>"+
			    "</div> ";
				var trHtml = $( "div[id=addTameMember]:last" );
				 
				trHtml.after(addMemberText);
				
				$("#member_name").val("");
				$("#year").val("");
				$("#month").val("");
				$("#day").val("");
				$("#member_address1").val("");
				$("#address_detail1").val("");
				
		}else if(result['result']==-1){
			alert('이미 등록된 팀원입니다.');
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}
$('#frm').submit (function(e) {
	
	e.preventDefault();
	var memberCnt = $('.mi_inner').length;
	var kindCnt = $('#cseq').val();
	var frm = document.frm;
	
 	var teamType = $("input[name='teamType']:checked").val();
	
	if($("#team_name").val == "" || $("#team_name").val == null){
		alert("팀이름을 입력해 주세요.");
	}
	if($("#estimate").val == "" || $("#estimate").val == null){
		alert("창단일을 입력해 주세요.");
	}
	if(memberCnt<=0){
		alert("팀 멤버를 추가해 주세요");
		return;
	}    
	var soccerCnt           = 25;
	var baseballCnt         = 15;
	var futsalCnt           = 12;
	var footVolleyBallCnt	= 10;
	
	if(kindCnt == 8){	   //야구장
		if(memberCnt<baseballCnt){
			alert("야구는 팀 멤버 "+baseballCnt+"명이상 신청 가능합니다.");
			return;
		}  
	}else if(kindCnt == 9){	   //족구장
		if(memberCnt<footVolleyBallCnt){
			alert("족구는 팀 멤버 "+footVolleyBallCnt+"명이상 신청 가능합니다.");
			return;
		}    
	}else if(kindCnt == 7){	   //축구장
		if(memberCnt<soccerCnt){
			alert("축구는 팀 멤버 "+soccerCnt+"명이상 신청 가능합니다.");
			return;
		}          
	}else if(kindCnt == 10){   //풋살장
		if(memberCnt<futsalCnt){
			alert("풋살은 팀 멤버 "+futsalCnt+"명이상 신청 가능합니다.");
			return;
		}  
	}else if(kindCnt == ""){
		alert("종목을 선택해 주세요.");
		return;
	}

	
	$.post( "/sports/insertTeam", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			alert('신청이 완료 되었습니다.');
			location.replace("/");
		}else if(result['result']==-1){
			alert('이미 등록된 팀이 존재합니다.');
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	})
	return false;
});

function delTeamMember(seq){
$.post( "/sports/deleteTempTeamMember", "del_seq="+seq , function(result) {
	if(result['result']==1) {
		alert("삭제되었습니다.");
		$("#addTameMember"+seq).hide();
	}else if(result['result']==0){
		alert('삭제 실패했습니다. 다시 시도해 주세요.');
		return;
	}
}, "json").fail(function(response) {
	console.log('Error: ' + response.responseText);
});
}

function delFile(kind){
	
	if(kind==1){
		$("#rule_file_name").text("");
		$("#rulesFile").val("");
		$("#rulesTemp").val("");
		$("#ruleArea").hide();
 		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
 		    $("#rulesFile").replaceWith( $("#rulesFile").clone(true) );
 		} else {
 		    $("#rulesFile").val("");
 		}
	}else{
		$("#pledge_file_name").text("");
		$("#vowsFile").val("");
		$("#vowsTemp").val("");
		$("#del_pledge").hide();
 		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
 		    $("#vowsFile").replaceWith( $("#vowsFile").clone(true) );
 		} else {
 		    $("#vowsFile").val("");
 		}
	}
	
}



