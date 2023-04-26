/**FILEDESC
홈페이지:로그인 script 파일
*/

$( document ).ready(function() {
	init();
	initValidate('frm');	
});

function init() {
	var ids = getCookie("ids");
	$("#memberId").val(ids);
	if (ids != "") {
		$("#save_id").prop("checked","true")
	}
}

function procIDSave() {
	var id=$("#memberId").val();
	if ($("#save_id").is(":checked")) {
		setCookie("ids",$("#memberId").val(),365);
	} else {
		setCookie("ids","",1);
	}
}

$('#frm').submit (function(e) {
		
	e.preventDefault();
	
	var frm = document.frm;
	if (frm.memberId.value == '') {
		alert('아이디를 입력해주세요.');
		frm.memberId.focus();
		return;
	}
	if (frm.memberPassword.value == '') {
		alert('비밀번호를 입력해주세요.');
		frm.memberPassword.focus();
		return;
	}
	
	$.post( "/member/loginAction", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			procIDSave();
			location.replace(_retUrl);
		}else if(result['result']==11){
			procIDSave();
			location.replace('/mypage/pw_change');
			return;
		}else if(result['result']==12){
			alert('일치하는 정보가 없습니다.\n확인후 다시 입력해주세요');
			return;
		}else if(result['result']==13){
			procIDSave();
			if(confirm('회원님의 계정이\n휴면계정 해제처리가 되었습니다.\n\n개인정보보호를 위해 비밀번호를 확인하여\n 수정해주시기 바랍니다.\n\n회원정보 수정 페이지로\n이동하시겠습니까?')){
				location.replace("/member/diapause");
			}else{
			return;
			}
		} else {
			alert("로그인 실패");
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
	});
});