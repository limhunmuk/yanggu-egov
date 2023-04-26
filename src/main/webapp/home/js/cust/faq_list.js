/**FILEDESC
홈페이지:공지사항 리스트 script 파일
*/

var _pg=1; //현재 페이지
var _rn=10;  //페이지당 행수
var _totalcnt=0; //총 행수
var _pageCnt=0; //총 페이지 수
var _pageSize=10; //표시할 페이지 단위
var _kind="";

$( document ).ready(function() {
	$.ajaxSettings.async = false;
	console.log("_faqKind : "+_faqKind);
	console.log("_search : "+_search);
	if(_faqKind!=""){
		_kind=_faqKind;
		$("#srch_input").val(_search);
		srch(_faqKind);
	}else{
		list('a');
	}
	$.ajaxSettings.async = true;
});

function srch(_kind) {
	_pg=1;
	$.ajaxSettings.async = false;
	list(_kind);
	$.ajaxSettings.async = true;
}

function goCate(kind){
	_pg=1;
	list(kind);
}

//(a:회원,b:결제,c:숙박/시설 대관,d:교육프로그램,e:기타)
function list(kind){
	_kind=kind;
	_faqKind = kind;
	$("#li_a,#li_b,#li_c,#li_d,#li_e").removeClass("on");
	$("#li_"+kind).addClass("on");
	console.log(" kind : " +kind);
	$.post('/bbs/faq_listApi', {cp:_pg,rn:_rn,op:$("#srch_sel option:selected").val(),opv:$("#srch_input").val(),kind:kind} , function(result) {
		
		for (var i = 0; i < result['list'].length; i++) {
			insertDate = String(nullCheck(result['list'][i].insertDate, ''));
			title = String(nullCheck(result['list'][i].title, ''));
			content = String(nullCheck(result['list'][i].content, ''));
			totalcnt = String(nullCheck(result['list'][i].totalcnt, ''));
			
			var sTmp="";
			sTmp+= "<dt><span class='blind'>질문</span>";
			sTmp+= "<a href=\"javascript:;\" class=\"btn\">"+title+"</a>";
			sTmp+= "<i class=\"ico_list\">닫힘</i>";
			sTmp+= "</dt>";
			sTmp+= "<dd><span class='blind'>답변</span>";
			sTmp+= "<p class=\"txt\">"+content+"</p>";
			sTmp+= "</dd>";
			
			if (i==0) {
				$("#tbl").html(sTmp);
				_totalcnt=totalcnt;
			} else {
				$("#tbl").append(sTmp);
				_totalcnt=totalcnt;
			}
		}
		if (i==0) {
			$("#tbl").html("<dt><span class='dot'>자료가 없습니다.</span></dt>");
			_totalcnt=0;
		}
		toggle();
		$("#searchResult").html(_totalcnt);
		$("#paginationDiv").html(PageSet(_totalcnt,_rn,_pageSize,_pg));

	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	})
}
// 페이지 이동
function go_paging(pg) {
	_pg = pg;
	$.ajaxSettings.async = false;
	list(_kind);
	$.ajaxSettings.async = true;
}

function toggle() {
	$('.date_wrap .box .mask').on('click', function(){
				$('.date_wrap .box').removeClass('on');
				$(this).parents('.box').addClass('on');
		});
		/* 달력 결과 토글 */
		$('.result_list dt a').on('click', function(){
				$(this).parents('dt').next('dd').slideToggle('fast');
				$(this).toggleClass('on');
				$(this).parents('dt').find('.ico_list').toggleClass('list_on');
			if ( $(this).hasClass('on') ){
				$(this).parents('dt').find('.ico_list').html('열림');
			} else {
				$(this).parents('dt').find('.ico_list').html('닫힘');
			}
		});
}
