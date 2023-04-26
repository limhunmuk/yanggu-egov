/**FILEDESC
홈페이지:공지사항 리스트 script 파일
*/

var _pg=1; //현재 페이지
var _rn=5;  //페이지당 행수
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
	$.post('/mypage/CancelListApi', {cp:_pg,rn:_rn,startDate:$("#datepicker1").val(),endDate:$("#datepicker2").val()} , function(result) {
		for (var i = 0; i < result['list'].length; i++) {
			var seq = String(nullCheck(result['list'][i].seq, ''));
			var cancelDate = String(nullCheck(result['list'][i].cancelDate, ''));
			var cName = String(nullCheck(result['list'][i].cName, ''));
			var pricePayTotal = String(nullCheck(result['list'][i].pricePayTotal, ''));
			var stat = String(nullCheck(result['list'][i].stat, ''));
			var payMethod = String(nullCheck(result['list'][i].method, ''));
			var rstat = String(nullCheck(result['list'][i].rstat, ''));
			var totalcnt = String(nullCheck(result['list'][i].totalcnt, ''));
			var no =  totalcnt - ((_pg-1)*_rn) - i;
			var p = String(nullCheck(result['list'][i].p, ''));
			var pStat = result['list'][i].pStat;
			var priceRefundTotalPricePay = String(nullCheck(result['list'][i].priceRefundTotalPricePay, ''));
			var totalPriceSale = String(nullCheck(result['list'][i].totalPriceSale, ''));
			console.log(pStat);
			var sTmp='';
			sTmp+='<tr>';
			sTmp+='<td>'+no+'</td>';
			if(stat=="환불신청"){
				sTmp+="<button type=\"button\" onclick=\"location.replace('apply_payment?p="+p+"&method="+payMethod+'&cName='+encodeURI(cName)+'&type=C'+'&type2=CH'+"')\" class=\"small_btn mt2\">신청하기</button>";
				//sTmp+="<button type=\"button\" onclick=\"location.replace('cancel_payment?p="+p+"&method="+payMethod+'&cName='+encodeURI(cName)+"')\" class=\"small_btn mt2\">신청하기</button>";
			}else if(pStat == "P" && rstat == "A"){
				sTmp+="<button type=\"button\" onclick=\"location.replace('apply_payment?p="+p+"&method="+payMethod+'&cName='+encodeURI(cName)+'&type=C'+'&type2=CC'+"')\" class=\"small_btn mt2\">신청하기</button>";
			}
			sTmp+='</td>';
			sTmp+='<td class=\"align_l\"><a href="cancel_view?p='+p+"&method="+payMethod+"&rstat="+rstat+'" class="link">';
			sTmp+=result['list'][i]['detailList'][0].useDayBegin+'('+days(result['list'][i]['detailList'][0].useDayBeginDay)+') ';
			sTmp+='('+(result['list'][i]['detailList'][0].diffDate)+'박'+(result['list'][i]['detailList'][0].diffDate+1)+'일)';
			sTmp+=result['list'][i]['detailList'][0].productName+' 외</a></td>';
			sTmp+='<td>'+comma(priceRefundTotalPricePay-totalPriceSale)+'원</td>';
			sTmp+='<td>'+cancelDate+'</td>';
			sTmp+='</tr>';
			
/*			
			sTmp+='<tr>';
			sTmp+='<td>'+no+'</td>';
			sTmp+='<td>'+insertDate+'</td>';
			if (payMethod == '') {
				sTmp+='<td><a href="apply_view2?p='+p+'" class="link">';
			} else {
				sTmp+='<td><a href="apply_view?p='+p+'" class="link">';
			}
			for (var j = 0; j < result['list'][i]['detailList'].length; j++) {
				if (nullCheck(result['list'][i]['detailList'][j].useTimeBegin, '') == '' && nullCheck(result['list'][i]['detailList'][j].useTimeEnd, '') == '') {
					if (nullCheck(result['list'][i]['detailList'][j].useDayBegin, '') == nullCheck(result['list'][i]['detailList'][j].useDayEnd, '')) {
						sTmp+=result['list'][i]['detailList'][j].useDayBegin+'('+days(result['list'][i]['detailList'][j].useDayBeginDay)+')';
					} else {
						sTmp+=result['list'][i]['detailList'][j].useDayBegin+'('+days(result['list'][i]['detailList'][j].useDayBeginDay)+')~'+result['list'][i]['detailList'][j].useDayEnd+'('+days(result['list'][i]['detailList'][j].useDayEndDay)+')';
					}
				} else {
					sTmp+=result['list'][i]['detailList'][j].useDayBegin+'('+days(result['list'][i]['detailList'][j].useDayBeginDay)+') '+result['list'][i]['detailList'][j].useTimeBegin+'~'+result['list'][i]['detailList'][j].useTimeEnd+' <br>';
				}
			}
			sTmp+=cName+'</a></td>';
			sTmp+='<td> '+comma(pricePayTotal)+'원</td>';
			if (payMethod == '') {
				sTmp+='<td><span class="c_gray">'+pstat+'</span><button type="button" class="small_btn bg_orange" onclick="location.href=\'apply_view2?p='+p+'\';">결제하기</button></td>';
			} else {
				sTmp+='<td><span class="c_gray">'+pstat+'</span><span>'+payMethod+'</span></td>';
			}
			if (rstat == 'H') {
				sTmp+='<td><button type="button" class="small_btn">신청취소</button></td>';
			} else {
				sTmp+='<td>-</td>';
			}
			sTmp+='</tr>';
*/
			if (i==0) {
				$("#tbl").html(sTmp);
				_totalcnt=0;
			} else {
				$("#tbl").append(sTmp);
			}
			_totalcnt=totalcnt;
		}
		if (i==0) {
			$("#tbl").html("<tr><td colspan='4' class=\"name\">자료가 없습니다.</td></tr>");
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
