/**FILEDESC
홈페이지:공지사항 상세 script 파일
*/

//파일다운로드
function fileDownLoad(src,tmp,org){
	$("input[name='src']").val(src);
	$("input[name='org']").val(org);
	$("input[name='tmp']").val(tmp);

	$("#fileform").submit();
}