/**FILEDESC
홈페이지:회원정보 재동의 동의페이지 script 파일
*/

$('#agree').click(function(){
	
	if (!$('#notice_confirm').prop('checked')) {
		alert('이용약관을 동의해주세요');
		return;
	}
    if (!$('#notice_confirm2').prop('checked')) {
        alert('개인정보수집 및 이용안내를 동의해주세요');
        return;
    }
	
	$.post( "/mypage/member_agreeAction", $("#frm").serialize() , function(result) {
		if(result['result']==0) {
			alert('재동의가 완료되었습니다.');
			location.replace("/");
		}else if(result['result']==-1){
			alert('재동의에 실패했습니다. 다시 시도해 주세요.');
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
	});
});