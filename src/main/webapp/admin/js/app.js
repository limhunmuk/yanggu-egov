/**
 * 교육프로그램 신청관리 JS
**/

// 신청일 지정 modal popup
function selAppDate() {
	$('#appDateModal').bPopup();
}
// 신청일 선택
function selAppDateTime( appCase ) {
	if( $('#popAppDate').val() == '' ) {
		return false;
	}
	
	var dateHtml = '<tr><td class="center">1</td>';
	
	if( appCase == '3' ) { // 유아숲체험 - 또래숲이면
		$op = $('#popFac option:selected');
		dateHtml += '<td class="center"><input type="hidden" name="f_idx" value="' + $op.val() + '">' + $op.text().trim() + '</td>';
	}
	
	$op = $('#popAppTime option:selected');
	dateHtml += '<td id="reser_date" class="center">' + $('#popAppDate').val() + '</td>' 
			+ '<td class="center"><input type="hidden" name="reser_time" value="' + $op.val() + '">' + $op.text().trim() + '</td>'
			+ '<td class="center"><button class="btn" onclick="delAppDate(' + appCase + ')" type="button">X</button></td>';
	
	$('#dateTable tbody').html(dateHtml);
	$('#appDateModal').bPopup().close();
}
// 신청일 삭제
function delAppDate( appCase ) {
	if( confirm('삭제하시겠습니까?') ) {
		$('#dateTable tbody').html('<tr><td class="center" colspan="' + (appCase == 3 ? '5' : '4') + '">데이타가 없습니다.</td></tr>');
	}
}

// 승인상태 변경
function changeApproval( select, p_idx ) {
	
	var modeStr;
	switch($(select).val()) {
		case '1': modeStr = '신청상태로 변경 하시겠습니까?'; break;
		case '2': modeStr = '승인 하시겠습니까?'; break;
		case '3': modeStr = '취소 하시겠습니까?'; break;
		default: {alert('잘못된 선택입니다'); location.reload();}
	}
	
	if( confirm(modeStr) ) {
		$.ajax({
			url: './updateApproval',
			data: {idx: $(select).attr('data-idx'), approval: $(select).val(), p_idx: p_idx},
			type: 'post',
			dataType: 'json',
			success: function(data) {
				if( data.rst ) {
					alert('수정되었습니다');
					
					if($(select).val()==2){
						goKakaoProgramReserved($(select).attr('data-idx'));
					}
				} else {
					alert('오류가 발생했습니다');
				}
			},
			error: function(e) {
				console.log(e);
				alert('오류가 발생했습니다');
			}
		});
	} else {
		location.reload();
	}
}

function goKakaoProgramReserved(idx){
	$.ajax({
		url: '/programReservedKakaoApi',
		data: {idx: idx},
		type: 'post',
		dataType: 'json',
		success: function(data) {
			if( data.result == 0 ) {
				console.log("카카오 성공");
			} else {
				console.log("카카오 실패");
			}
		},
		error: function(e) {
			console.log("카카오 오류가 발생했습니다");
		}
	});
}


var searchName = ''; // 신청자 검색어
// 신청자 찾기 modal popup
function searchAppMember() {
	$('#appMemberModal').bPopup();
}

// 신청자 검색
$(document).ready(function() {
	$('input[name=searchName]').on('keyup', function(e) {
		if( e.keyCode == 13 ) {
			searchName = $(this).val();
			setAppMember(1);
		}
	});
	
	$('#appMemberSearchBtn').on('click', function() {
		searchName = $(this).val();
		setAppMember(1);
	});
	
	checkSubDisalbed()
	calPrice();
});
function setAppMember( page ) {
	$.ajax({
		url: './setAppMember',
		data: {searchName:searchName, page:page},
		type: 'post',
		dataType: 'text',
		success: function(html) {
			$('#appMemResultDiv').html(html);
		}, error: function(e) {
			alert('오류가 발생했습니다');
			console.log(e);
		}
	});
}

// 신청자 선택
function selectAppMember( tr ) {
	$('#memberSeq').val($(tr).find('input[name=seq]').val());
	$('#memberId').text($(tr).find('input[name=memberId]').val());
	$('#memberName').text($(tr).find('input[name=memberName]').val());
	$('#memberMobile').text($(tr).find('input[name=memberMobile]').val());
	$('#memberEmail').text($(tr).find('input[name=memberEmail]').val());
	
	$('#detailNoDataTable').hide();
	$('#detailTable').show();
	$('#appMemberModal').bPopup().close();
}

// 품목 추가
function addSub() {
	var sCnt = $('#programSubTd').find('p').length + 1;
	
	// 총 품목 종류보다 select가 많아질 수 없음
	if( sCnt > cost_list.length ) {
		alert('더 이상 품목을 추가 할 수 없습니다');
		return false;
	}
	
	var sel_list = []; // 선택된 cost_idx list
	$('#programSubTd').find('select[name=sub_list] option:selected').each(function() {
		sel_list.push($(this).val()*1);
	});
	
	var subHtml = '<p style="margin-top:5px;"><strong>품목 ' + sCnt + '</strong>'
		+ ' <select name="sub_list" onchange="changeSub()" style="width:50%;">';
	
	// 품목 select박스( selected: default:첫번째, 첫번째가 이미 선택되어있을 때 미선택된 option select )
	var ck_flag = true;
	for( idx in cost_list ) {
		subHtml += '<option value="' + cost_list[idx].idx + '"';
		if( ck_flag && !sel_list.includes(cost_list[idx].idx) ) {
			subHtml += ' selected';
			ck_flag = false;
			sel_list.push(cost_list[idx].idx);
		}
		subHtml += '>' + cost_list[idx].title + ' (' 
			+ numberWithCommas(cost_list[idx].total_fee) + '원)</option>';
	}
	subHtml += '</select> <select name="cnt_list" style="width:120px;" onchange="calPrice()">';
	
	for( var i=1 ; i<=50 ; i++ ) {
		subHtml += '<option value="' + i + '">' + i + ' 개</option>';
	}
	subHtml += '</select> <button type="button" onclick="delSub(this)" class="btn">삭제</button></p>';
	
	$('#programSubTd').append(subHtml);
	
	// 선택된 option들 disalbed 처리
	$('#programSubTd').find('select[name=sub_list] option').each(function() {
		if( !$(this).prop('selected') && sel_list.includes($(this).val()*1) ) $(this).prop('disabled',true);
	});
	
	calPrice();
}

// 품목, 수량 변경
function changeSub() {
	checkSubDisalbed();
	calPrice();
}

// 품목 삭제
function delSub( btn ) {
	$(btn).closest('p').remove();
	$('#programSubTd').find('p strong').each(function(e) {
		$(this).text('품목 ' + (e+1));
	});
	checkSubDisalbed();
	calPrice();
}

// 품목 가격 get
function getSubTotalFee( idx ) {
	var total_fee;
	for( i in cost_list ) {
		if( cost_list[i].idx == idx ) {
			total_fee = cost_list[i].total_fee; 
		}
	}
	return total_fee;
}


// 선택된 품목 disabled
function checkSubDisalbed() {
	// 선택된 option들 disalbed 처리
	var sel_list = []; // 선택된 cost_idx list
	$('#programSubTd').find('select[name=sub_list] option:selected').each(function() {
		sel_list.push($(this).val()*1);
	});
	$('#programSubTd').find('select[name=sub_list] option').each(function() {
		if( !$(this).prop('selected') && sel_list.includes($(this).val()*1) ) $(this).prop('disabled',true);
		else $(this).prop('disabled',false);
	});
}

// 품목 전체가격 계산
function calPrice() {
	var total_price = 0;
	
	var total_fee, cnt;
	$('#programSubTd').find('p').each(function() {
		total_fee = getSubTotalFee($(this).find('select[name=sub_list]').val());
		cnt = $(this).find('select[name=cnt_list]').val();
		
		total_price += total_fee * cnt;
	});
	
	$('#price').val(numberWithCommas(total_price));
}


// 저장
function submitApp() {
	
	if( !confirm('저장 하시겠습니까?') ) return false;
	
	var data = {
		idx: $('#idx').val(),
		p_idx: $('#p_idx').val(),
		reser_time: $('input[name=reser_time]').val(),
		m_seq: $('#memberSeq').val(),
		f_idx: $('input[name=f_idx]').val(),
		group_name: $('input[name=group_name]').val(),
		parti_cnt: $('input[name=parti_cnt]').val(),
		remark: $('input[name=remark]').val()
	};
	
	console.log(data.reser_time);
	
	if( appCase != '2' && (data.reser_time == '' || data.reser_time == null) ) {
		alert('신청일을 지정 해 주세요');
		return false;
	} else if( appCase != '2' ) {
		data.reser_date_str = $('#reser_date').text().trim();
	}
	if( data.m_seq == '' ) {
		alert('신청자를 지정 해 주세요');
		return false;
	}
	
	if( data.parti_cnt == '' ) {
		alert('참여인원을 입력 해 주세요');
		return false;
	}
	if( isNaN(data.parti_cnt) ) {
		alert('참여인원엔 숫자만 입력 해 주세요');
		return false;
	}
	
	// 목재문화체험일 경우
	if( appCase == '1' ) {
		data.price = removeCommas($('#price').val());
		
		var sub_list = [];
		$('#programSubTd').find('p').each(function(e) {
			var sub_data = {
				s_idx: $(this).find('select[name=sub_list]').val(),
				cnt: $(this).find('select[name=cnt_list]').val(),
				i_order: e+1
			};
			sub_list.push(sub_data);
		});
		data.sub_list_str = JSON.stringify(sub_list);
	}
	
	$.ajax({
		url: './insertApp',
		data: data,
		type: 'post',
		dataType: 'json',
		success: function(rData) {
			if( rData.rst ) {
				alert('저장 되었습니다');
				
				moveUrl = './appManage?idx=' + data.p_idx;
				if( appCase != '2' ) {
					moveUrl += '&searchDate=' + data.reser_date_str;
				}
				
				location.replace(moveUrl);
			} else {
				alert('오류가 발생했습니다');
			}
		}, error: function(e) {
			alert('오류가 발생했습니다.');
			console.log(e);
		}
	});
	
}

//프로그램 리스트 구분 변경
function changeGubun() {
	if( $('#gubun').val() == '' ) {
		$('#type').remove();
		return;
	}
	
	$.ajax({
		url: './selectProgramType',
		data: {gubun: $('#gubun').val()},
		type: 'post',
		dataType: 'json',
		success: function(data) {
			var typeList = data.typeList;
			
			$('#type').remove();
			if( typeList.length > 0 ) {
				var typeHtml = '<select id="type" name="type" style="margin-left:2%;width:20%;"> <option value="">전체</option>';
				for( idx in typeList ) {
					typeHtml += '<option value="' + typeList[idx].seq + '">' + typeList[idx].codeName + '</option>';
				}
				typeHtml += '</select>'
				$('#gubun').after(typeHtml);
			}
			
		}, error: function(e) {
			alert('오류가 발생했습니다');
			console.log(e);
		}
	});
}

function excelDownload(fn){
	$("#fn").val(fn);
	$("#excelAreaTemp").html($("#excelArea").html());
	//console.log($("#excelAreaTemp").html());
	$("#excelAreaTemp .noExcel").remove();
	$("#excelAreaTemp .radioExcel").each(function(index) {
		if ($(this).children("input[type=radio]").is(":checked")) {
			$(this).html($("label[for='"+$(this).children("input[type=radio]").attr("id")+"']").html());
		} else {
			$(this).html("");
		}
	});
	$("#excelAreaTemp > table > tbody > tr > td > input[type=text]").each(function(index) {
		$(this).parents("td").html($(this).val());
	});
	$("#excelAreaTemp > table > thead > tr > th > input[type=checkbox]").closest("th").remove();
	$("#excelAreaTemp > table > tbody > tr > td > input[type=checkbox]").closest("td").remove();
	$("#excelAreaTemp > table").attr("border","1");
	$("#excelAreaTemp > table > thead > tr").attr("bgcolor","#cccccc");
	$("#excelAreaTemp > table > thead > tr").attr("align","center");
	$("#excelAreaTemp > table > tbody > tr").attr("bgcolor","#ffffff");
	$("#excelAreaTemp > table > tbody > tr").attr("align","center");
	$("#excelAreaTemp > table > tbody > tr").attr("height","22");
	$("#excelAreaTemp > table > tbody > tr > td > a").contents().unwrap().wrap("<span></span>");
	$("#excel").val($("#excelAreaTemp").html());
	$("#exfrm").attr("target","frmHidden");
	$("#exfrm").attr("action","../excel");
	$("#exfrm").submit();
}

/** 숫자변환 **/
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCommas(x) {
	if( x == '' ) return 0;
	return x.toString().replace(/,/gi,'');
}

