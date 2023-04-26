/**FILEDESC
홈페이지:공지사항 리스트 script 파일
*/

var _pg=1; //현재 페이지
var _rn=5;  //페이지당 행수
var _totalcnt=0; //총 행수
var _pageCnt=0; //총 페이지 수
var _pageSize=10; //표시할 페이지 단위
var okayYn="Y"; //결제하기 표시

$( document ).ready(function() {
	list();
});

function srch() {
	_pg=1;
	list();
}
function list(){
//	$('#loading').show();
	$.post('/mypage/ApplyListApi', {cp:_pg,rn:_rn,startDate:$("#datepicker1").val(),endDate:$("#datepicker2").val()} , function(result) {
		for (var i = 0; i < result['list'].length; i++) {
			var seq = String(nullCheck(result['list'][i].seq, ''));
			var insertDate = String(nullCheck(result['list'][i].insertDate, ''));
			var cName = String(nullCheck(result['list'][i].cName, ''));
			var pricePayTotal = String(nullCheck(result['list'][i].pricePayTotal, ''));
			var totalPay = String(nullCheck(result['list'][i].totalPay, ''));
			var pstat = String(nullCheck(result['list'][i].pstat, ''));
			var payMethod = String(nullCheck(result['list'][i].payMethod, ''));
			var rstat = String(nullCheck(result['list'][i].rstat, ''));
			var totalcnt = String(nullCheck(result['list'][i].totalcnt, ''));
			var no =  totalcnt - ((_pg-1)*_rn) - i;
			var p = String(nullCheck(result['list'][i].p, ''));
			var cancel = "N";
			var priceRefundTotalPricePay = String(nullCheck(result['list'][i].priceRefundTotalPricePay, ''));
			var totalPriceSale = String(nullCheck(result['list'][i].totalPriceSale, ''));
			
			var sTmp='';
			sTmp+='<tr>';
			sTmp+='<td>'+no+'</td>';
			sTmp+='<td>'+insertDate+'</td>';
			if (payMethod == '') {
				sTmp+='<td><a href="apply_view2?p='+p+'&cName='+encodeURI(cName)+'" class="link">';
			} else {
				sTmp+='<td><a href="apply_view?p='+p+'" class="link">';
			}
			sTmp+=result['list'][i]['detailList'][0].useDayBegin+'('+days(result['list'][i]['detailList'][0].useDayBeginDay)+') ';
			sTmp+='('+(result['list'][i]['detailList'][0].diffDate)+'박'+(result['list'][i]['detailList'][0].diffDate+1)+'일)<br>';
			sTmp+=result['list'][i]['detailList'][0].productName+'호...';
			if(nullCheck(result['list'][i]['detailList'][0].useDayBegin, '') < getToday()){
				console.log("캔슬확인");
				cancel = "Y";
			sTmp+='<br>';
			}
			sTmp+='</a></td>';
			sTmp+='<td> '+comma(priceRefundTotalPricePay-totalPriceSale)+'원</td>';
			if (priceRefundTotalPricePay==0 && payMethod == '') {
				sTmp+='<td><span class="c_gray">결제완료</span><span>일반결제</span></td>';
			} else if(payMethod == '') {
				sTmp+='<td><span class="c_gray">'+pstat+(okayYn=="Y"?'</span><button type="button" class="small_btn bg_orange" onclick="location.replace(\'apply_view2?p='+p+'&cName='+encodeURI(cName)+'\');">결제하기</button></td>':'');
			} else {
				sTmp+='<td><span class="c_gray">'+pstat+'</span><span>'+payMethod+'</span></td>';
			}
			if (cancel == "N") {
				sTmp+='<td><button type="button" onclick="cancelLocation(\''+p+'\',\''+encodeURI(cName)+'\')" class="small_btn">신청취소</button></td>';
			} else {
				sTmp+='<td>-</td>';
			}
			sTmp+='</tr>';
			if (i==0) {
				$("#tbl").html(sTmp);
				_totalcnt=0;
			} else {
				$("#tbl").append(sTmp);
			}
			_totalcnt=totalcnt;
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
//신청취소 페이지 이동
function cancelLocation(p,cName){
	if(confirm("신청을 취소하시겠습니까?")){
		location.replace('/mypage/apply_payment?p='+p+'&cName='+cName);
	}
}
// 1~7 요일반환
function days(dayofweek) {
	var days = '';
	switch (dayofweek) {
		case 1:
			days = '일';
			break;
		case 2:
			days = '월';
			break;
		case 3:
			days = '화';
			break;
		case 4:
			days = '수';
			break;
		case 5:
			days = '목';
			break;
		case 6:
			days = '금';
			break;
		case 7:
			days = '토';
			break;
	}
	return days;
}
