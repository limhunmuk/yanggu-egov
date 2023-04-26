/**FILEDESC
홈페이지:비밀번호 변경 script 파일
*/

$( document ).ready(function() {
	initValidate('frm');
});

$('#frm').submit (function(e) {
	
	e.preventDefault();
	
	var frm = document.frm;
	
    if (frm.password_new.value == '') {
        alert('새 비밀번호를 입력해주세요.');
        frm.password_new.focus();
        return;
    }
    if (frm.password_new2.value == '') {
        alert('새 비밀번호 확인을 입력해주세요.');
        frm.password_new2.focus();
        return;
    }
    /*if (!/[a-z]/ig.test(frm.password_new.value) || !/[0-9]/.test(frm.password_new.value) || frm.password_new.value.length < 8 || frm.password_new.value.length > 20) {
        alert('비밀번호는 8자 이상 20자 이하 영문,숫자를 포함해주세요.');
        frm.password_new.focus();
        return;
    }*/
	var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,12}$/;
	if(!check.test(frm.password_new.value)){
		alert("※ 비밀번호는 영문, 숫자, 특수문자를 혼용하여 8~12자 이내로 입력해주세요.");
		return;
	}
    if (frm.password_new.value !== frm.password_new2.value) {
        alert('새 비밀번호와 새 비밀번호 확인이 다릅니다.');
        return;
    }
	
	$.post( "/mypage/pw_changeAction2", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			alert('비밀번호가 정상적으로\n변경되었습니다.');
			location.replace("/mypage/member");
		}else if(result['result']=-1){
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}else {
			alert("비밀번호 변경에 실패하였습니다.");
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
	});
});