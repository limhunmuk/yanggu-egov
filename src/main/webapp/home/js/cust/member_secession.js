/**FILEDESC
홈페이지:회원탈퇴 script 파일
*/
	$( document ).ready(function() {

		initValidate('frm');
	});

	$('#frm').submit (function(e) {
		
		e.preventDefault();
		
		var frm = document.frm;
		if (frm.qna_content.value == '') {
			alert('탈퇴사유를 입력해주세요.');
			frm.qna_content.focus();
			return;
		}
		if (frm.password.value == '') {
			alert('현재 비밀번호를 입력해주세요.');
			frm.password.focus();
			return;
		}
		checkPassword();
	});
	
function checkPassword(){
	$.post( "/mypage/checkPassword", $("#frm").serialize() , function(result) {
		if(result['result']==1) {
			$("#loading").hide();
			console.log("P0");
			if(confirm("탈퇴 전 유의사항을 확인하여 주시기 바랍니다.\n정말로 회원탈퇴 하시겠습니까?")){
				
				$("#loading").show();
				
				$.post( "/mypage/member_secessionAction", $("#frm").serialize() , function(result) {
					if(result['result']==1) {
						$("#loading").hide();
						location.replace("/");
					}else{
						$("#loading").hide();
						alert('탈퇴에 실패했습니다. 다시 시도해주세요.');
						return;
					}
				}, "json").fail(function(response) {
					console.log('Error: ' + response.responseText);
				});
			}
		}else{
			$("#loading").hide();
			console.log("P1");
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});	
}



