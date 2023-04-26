/**FILEDESC
홈페이지:회원가입 script 파일
*/

$(function(){
	/* 회원구분 */
	$('.table_wrap .input_chk .chk_area input').on('click',function(){
		if ( $(this).is(':checked') ){
			$('.table_wrap .input_content').hide();
			var $chk = $(this).parents('.chk_area').index();
			$(this).closest('dl').siblings('.input_content#join_' + $chk).fadeIn();
		}
	});
});
	
$( document ).ready(function() {
	initValidate('frm');
	//$("label[for='memberEmail2']").hide();
	$("#memberEmail2").hide();
});

function pickEmail(){
	var frm = document.frm;
	var email3 = frm.memberEmail3.value;
	if(email3==0){
		//$("label[for='memberEmail2']").show();
		$("#memberEmail2").show();
	}else{
		//$("label[for='memberEmail2']").hide();
		$("#memberEmail2").hide();
	}
	console.log("email3 : "+email3 );
}

function idCheck(){
	var id = $("#user_id").val();
	var frm = document.frm;
	if (frm.memberId.value == '') {
		alert('아이디를 입력해주세요.');
		frm.memberId.focus();
		return;
	}
    if (!/^[a-z0-9]{4,12}$/.test(frm.memberId.value)) {
        alert('아이디는 4자 이상, 12자 이하 영문 소문자와 숫자만 사용가능합니다.');
        frm.memberId.focus();
        return;
    }
	$.post( "/member/idCheckAction", {id:id} , function(result) {
		if(result['result']==0) {
			alert("사용가능한 아이디 입니다.");
		}else{
			alert("중복된 아이디 입니다.");
		}
		console.log("갯수 : "+result['result']);
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}

$('#frm').submit (function(e) {
	
	e.preventDefault();
	
	var frm = document.frm;
	if (frm.memberId.value == '') {
		alert('아이디를 입력해주세요.');
		frm.memberId.focus();
		return;
	}
    if (!/^[a-z0-9]{4,12}$/.test(frm.memberId.value)) {
        alert('아이디는 4자 이상, 12자 이하 영문 소문자와 숫자만 사용가능합니다.');
        frm.memberId.focus();
        return;
    }
    if (frm.password.value == '') {
        alert('비밀번호를 입력해주세요.');
        frm.password.focus();
        return;
    }
	var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,12}$/;
	if(!check.test(frm.password.value)){
		alert("비밀번호는 영문, 숫자, 특수문자(!@#$&%)혼용하여 8-12자 사이로 입력해주세요.");
		return;
	}
    if (frm.password.value !== frm.password2.value) {
        alert('비밀번호가 일치하지 않습니다.');
        return;
    }
    if (frm.memberEmail.value == '' || (frm.memberEmail2.value == '' && frm.memberEmail3.value=='')) {
        alert('이메일을 입력해주세요.');
        frm.memberEmail.focus();
        return;
    }
    if (frm.user_address.value == '') {
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
    if (frm.memberMobile.value !== frm.memberMobile.value) {
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
	$("#loading").show();
	$.post( "/member/entryMemberAction", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			$("#loading").hide();
			alert('양구수목원 회원가입을 축하드립니다.\n앞으로 다양한 정보 제공을 위해 최선을 다하겠습니다.\n감사합니다');
			sendMail();
			location.replace("/");
		}else if(result['result']==14){
			$("#loading").hide();
			alert('중복된 아이디가 있습니다.\n아이디를 다시 입력해주세요');
			return;
		}else if(result['result']==15){
			$("#loading").hide();
			alert('이미 가입한 회원입니다.');
			return;
		} else {
			$("#loading").hide();
			alert("회원가입에 실패하였습니다.");
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
	});
});


function sendMail(){
	$.post( "/member/entryMemberMailSend", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			console.log("메일 발송 성공");
		}else{
			console.log("메일 발송 실패");
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
	});
}