/**FILEDESC
홈페이지:회원정보 수정 script 파일
*/
	
	
$( document ).ready(function() {
	initValidate('frm');
});

$('#frm').submit (function(e) {
	e.preventDefault();
	
	var frm = document.frm;
	
    if (frm.memberEmail.value == '') {
        alert('이메일을 입력해주세요.');
        frm.memberEmail.focus();
        return;
    }
    if (frm.address.value == '') {
        alert('주소를 입력해주세요.');
        frm.user_address.focus();
        return;
    }
    if (frm.memberPhone.value == '') {
        alert('연락처를 입력해주세요.');
        frm.memberPhone.focus();
        return;
    }
    var phonePattern = /^[0-9]{9,11}$/; 
    if (!phonePattern.test(frm.memberPhone.value)) {
        alert('잘못된 전화번호입니다.');
        frm.memberPhone.focus();
        return;
    }
    if (frm.memberMobile.value == '') {
        alert('휴대폰번호를 입력해주세요.');
        frm.memberMobile.focus();
        return;
    }
    var mobilePattern = /^[0-9]{10,11}$/; 
    if (!mobilePattern.test(frm.memberMobile.value)) {
        alert('잘못된 휴대폰번호입니다.');
        frm.memberMobile.focus();
        return;
    }
	
    if(confirm("회원정보를 수정하시겠습니까?")){
		$.post( "/mypage/updateMemberAction", $("#frm").serialize() , function(result) {
			if(result['result']==0) {
				alert('회원정보가 수정되었습니다.');
				location.href="/mypage/apply_list";
			} else {
				alert("회원정보 변경에 실패하였습니다.");
				return;
			}
		}, "json").fail(function(response) {
			console.log('Error: ' + response.responseText);
		}).always(function() {
		});
    }
});