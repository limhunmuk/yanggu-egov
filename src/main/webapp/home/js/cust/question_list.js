/**FILEDESC
홈페이지:공지사항 리스트 script 파일
*/

var _pg=1; //현재 페이지
var _rn=10;  //페이지당 행수
var _totalcnt=0; //총 행수
var _pageCnt=0; //총 페이지 수
var _pageSize=10; //표시할 페이지 단위

$( document ).ready(function() {
	list();
});

function srch() {
	_pg=1;
	list();
}
function list(){
//	$('#loading').show();
	$.post('/mypage/question_listAPI', {cp:_pg,rn:_rn,stat:$("#stat option:selected").val(),op:$("#srch_sel option:selected").val(),opv:$("#srch_input").val()} , function(result) {
		for (var i = 0; i < result['list'].length; i++) {
			seq = String(nullCheck(result['list'][i].seq, ''));
			insertDate = String(nullCheck(result['list'][i].insertDate, ''));
			writer = String(nullCheck(result['list'][i].writer, ''));
			title = String(nullCheck(result['list'][i].title, ''));
			content = String(nullCheck(result['list'][i].content, ''));
			attachment = String(nullCheck(result['list'][i].attachment, ''));
			attachment_org = String(nullCheck(result['list'][i].attachment_org, ''));
			memberSeq = String(nullCheck(result['list'][i].memberSeq, ''));
			state = String(nullCheck(result['list'][i].stat, ''));
			re_content = String(nullCheck(result['list'][i].re_content, ''));
			re_attachment = String(nullCheck(result['list'][i].re_attachment, ''));
			re_attachment_org = String(nullCheck(result['list'][i].re_attachment_org, ''));
			newDate = String(nullCheck(result['list'][i].newDate, 0));
			read_cnt = String(nullCheck(result['list'][i].read_cnt, ''));
			totalcnt = String(nullCheck(result['list'][i].totalcnt, ''));
			no =  totalcnt - ((_pg-1)*_rn) - i;
			
			var sTmp="";
			sTmp+= "<tr>";
			sTmp+= "<td>" + no + "</td>";
			sTmp+= "<td class=\"align_l\">";
			sTmp+= "<a href=\"/mypage/question_view?seq="+seq+"\" class=\"link_btn\">"+title+"</a>";
			if(newDate<15){
			sTmp+= "<i class=\"new_i\">N</i>";
			}
			sTmp+= "</td>";
			sTmp+= "<td>"+insertDate+"</td>";
			if(state != 'Y'){
				sTmp+= "<td>답변 대기</td>";
			}else{
				sTmp+= "<td>답변 완료</td>";
			}
			sTmp+= "</tr>";
			sTmp+= "";			
			
			
			if (i==0) {
				$("#tbl").html(sTmp);
				_totalcnt=totalcnt;
			} else {
				$("#tbl").append(sTmp);
				_totalcnt=totalcnt;
			}
		}
		if (i==0) {
			$("#tbl").html("<tr><td colspan=4' class=\"name\">자료가 없습니다.</td></tr>");
			_totalcnt=0;
		}
		$("#searchResult").html(_totalcnt);
		$("#paginationDiv").html(PageSet(_totalcnt,_rn,_pageSize,_pg));

	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	}).always(function() {
//		$('#loading').hide();
	});
}
// 페이지 이동
function go_paging(pg) {
	_pg = pg;
	list();
}
