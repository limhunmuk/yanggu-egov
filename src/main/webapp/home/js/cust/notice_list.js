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
	$.post('/bbs/notice_ListApi', {cp:_pg,rn:_rn,op:$("#srch_sel option:selected").val(),opv:$("#srch_input").val()} , function(result) {
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
			no =  totalcnt - ((_pg-1)*_rn) - i;

			var difDate = dateDiff(insertDate,getToday());
			
			var sTmp="";
			sTmp+= "<tr>";
			sTmp+= "<td>" + no + "</td>";
			sTmp+= "<td data-cell-header=\"제목：\" class=\"subject tl\">";
			sTmp+= "<a href=\"/bbs/notice_view?seq="+seq+"\"><span>" + title;
			if(difDate<15){
				sTmp+= "<i class=\"new_i\">N</i>";
			}
			sTmp+= "</span></a>";
			sTmp+= "</td>";
			sTmp+= "<td data-cell-header=\"작성일：\" class=\"date\">" + insertDate + "</td>";
			sTmp+= "<td data-cell-header=\"조회수：\" class=\"last\">" + comma(read_cnt) + "</td>";
			sTmp+= "<td data-cell-header=\"첨부파일：\">";
			if(attachment != ''){
			sTmp+= "<a href=\"javascript:fileDownLoad('notice','"+attachment+"','"+attachment_org+"')\" class=\"file\" >파일다운로드</a>";
			}
			sTmp+= "</td></tr>";
			sTmp+= "";			

			if (i==0) {
				$("#tbl").html(sTmp);
			} else {
				$("#tbl").append(sTmp);
				_totalcnt=totalcnt;
			}
		}
		if (result['list'].length==0) {
			$("#tbl").html("<tr><td colspan='6' class=\"name\">자료가 없습니다.</td></tr>");
			_totalcnt=0;
		}
		$("#searchResult").html(_totalcnt);
		$("#paginationDiv").html(PageSet(_totalcnt,_rn,_pageSize,_pg));
		aList();
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}

function aList(){
	$.post('/bbs/notice_A_ListApi', {} , function(result) {
		for (var i = 0; i < result['list'].length; i++) {
			seq = String(nullCheck(result['list'][i].seq, ''));
			insertDate = String(nullCheck(result['list'][i].insertDate, ''));
			writer = String(nullCheck(result['list'][i].writer, ''));
			title = String(nullCheck(result['list'][i].title, ''));
			content = String(nullCheck(result['list'][i].content, ''));
			attachment = String(nullCheck(result['list'][i].attachment, ''));
			attachment_org = String(nullCheck(result['list'][i].attachment_org, ''));
			read_cnt = String(nullCheck(result['list'][i].read_cnt, ''));

			var difDate = dateDiff(insertDate,getToday());
			
			var sTmp="";
			sTmp+= "<tr>";
			sTmp+= "<td>공지글</td>";
			sTmp+= "<td data-cell-header=\"제목：\" class=\"subject tl\">";
			sTmp+= "<a href=\"/bbs/notice_view?seq="+seq+"\"><span>" + title;
			if(difDate<15){
				sTmp+= "<i class=\"new_i\">N</i>";
			}
			sTmp+= "</span></a>";
			sTmp+= "</td>";
			sTmp+= "<td data-cell-header=\"작성일：\" class=\"date\">" + insertDate + "</td>";
			sTmp+= "<td data-cell-header=\"조회수：\" class=\"last\">" + comma(read_cnt) + "</td>";
			sTmp+= "<td data-cell-header=\"첨부파일：\">";
			if(attachment != ''){
			sTmp+= "<a href=\"javascript:fileDownLoad('notice','"+attachment+"','"+attachment_org+"')\" class=\"file\" >파일다운로드</a>";
			}
			sTmp+= "</td></tr>";
			sTmp+= "";			

			$("#tbl").prepend(sTmp);
		}

	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}


// 페이지 이동
function go_paging(pg) {
	_pg = pg;
	list();
}

//파일다운로드
function fileDownLoad(src,tmp,org){
	$("input[name='src']").val(src);
	$("input[name='org']").val(org);
	$("input[name='tmp']").val(tmp);

	$("#fileform").submit();
}
