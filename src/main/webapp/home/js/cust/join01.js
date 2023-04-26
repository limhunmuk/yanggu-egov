/**FILEDESC
홈페이지:회원가입 동의 script 파일
*/

    function validForm () {
    	if (!$('#join_chk01').prop('checked')) {
    		alert('이용약관을 동의해주세요');
    		return false;
    	}
        if (!$('#join_chk02').prop('checked')) {
            alert('개인정보수집 및 이용안내를 동의해주세요');
            return false;
        }
        document.frm.submit();
    }
    $(function () {
    	$('#join_chk01, #join_chk02 ,#join_chk03').on('change', function () {
    		$('#join_chk_all').prop('checked', $('#join_chk01').prop('checked') && $('#join_chk02').prop('checked'));
    	});
        $('#join_chk_all').on('change', function () {
            $('#join_chk01, #join_chk02').prop('checked', $(this).prop('checked'));
        });
    });