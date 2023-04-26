/**FILEDESC
홈페이지:공지사항 리스트 script 파일
*/

var _pg=1; //현재 페이지
var _rn=8;  //페이지당 행수
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
	$.post('/bbs/gallery_listApi', {cp:_pg,rn:_rn,op:$("#srch_sel option:selected").val(),opv:$("#srch_input").val()} , function(result) {
		path = String(nullCheck(result['path'], ''));
		for (var i = 0; i < result['list'].length; i++) {
			seq = String(nullCheck(result['list'][i].seq, ''));
			insertDate = String(nullCheck(result['list'][i].insertDate, ''));
			writer = String(nullCheck(result['list'][i].writer, ''));
			title = String(nullCheck(result['list'][i].title, ''));
			content = String(nullCheck(result['list'][i].content, ''));
			attachment = String(nullCheck(result['list'][i].attachment, ''));
			attachment_org = String(nullCheck(result['list'][i].attachment_org, ''));
			read_cnt = String(nullCheck(result['list'][i].read_cnt, ''));
			totalcnt = String(nullCheck(result['list'][i].totalcnt, ''));
			newDate = String(nullCheck(result['list'][i].newDate, 0));
			
			var sTmp="";
			sTmp+= "<li class=\"notice_pic\">";
			sTmp+= "<div class=\"img_box\">";
			sTmp+= "<a href=\"/bbs/gallery_view?seq="+seq+"\">";
			sTmp+= "<img src=\""+path+"photo/"+attachment+"\" alt=\""+title+"\">";
			sTmp+= "</a>";
			sTmp+= "</div>";
			sTmp+= "<a href=\"/gallery/view?seq="+seq+"\"><p>"+title;
			if(newDate<15){
				sTmp+= "<i class=\"new_i\">N</i>"
			}
			sTmp+= "</p></a>";
			sTmp+= "</li>";
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
			$("#tbl").html("<tr><td colspan='6' class=\"name\">자료가 없습니다.</td></tr>");
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
