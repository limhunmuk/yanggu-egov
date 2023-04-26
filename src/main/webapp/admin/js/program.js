/**
 * 교육프로그램 > 프로그램 관리 JS
**/

String.prototype.startsWith = function(str) {
	if (this.length < str.length) { return false; }
	return this.indexOf(str) == 0;
}

String.prototype.endsWith = function(str) {
	if (this.length < str.length) { return false; }
	return this.lastIndexOf(str) + str.length == this.length;
}

// 구분 변경
function changeGubun( sel ) {
	var newGubun = $(sel).val();
	
	// 프로그램 유형
	if( newGubun == gubunList[0] || newGubun == gubunList[3] || newGubun == gubunList[4] ) {
		$('#type').addClass('ignore');
		$('#type').html('');
	} else {
		// 유형 리스트
		$('#type').removeClass('ignore');
		$.ajax({
			url: './selectProgramType',
			data: {gubun: newGubun},
			type: 'post',
			dataType: 'json',
			success: function(data) {
				var typeList = data.typeList;
				var typeHtml = '';
				for( idx in typeList ) {
					typeHtml += '<option value="' + typeList[idx].seq + '">' + typeList[idx].codeName + '</option>';
				}
				$('#type').html(typeHtml);
			}, error: function(e) {
				alert('오류가 발생했습니다');
				console.log(e);
			}
		});
		
	}
	
	// 타입에 따른 폼 set
	switch(newGubun) {
		case gubunList[0]:
			setProgramFormCase_1(); break; // 목재문화체험
		case gubunList[1]:
			setProgramFormCase_2(); break; // 유아숲체험
		case gubunList[2]:
		case gubunList[3]:
		case gubunList[4]:
			setProgramFormCase_5(); break; // 숲해설, 숲길체험, 산림치유
	}
}

// 유형 변경
function changeType( sel ) {
	var newType = $(sel).val();
	
	switch(newType) {
		case typeList[0]:
		case typeList[1]:
		case typeList[2]:
			setProgramFormCase_2(); break; // 정기형, 체험형, 찾아가는 유아숲
		case typeList[3]:
			setProgramFormCase_3(); break; // 또래형
		case typeList[4]:
			setProgramFormCase_4(); break; // 행복나눔숲
		case typeList[5]:
		case typeList[6]:
			setProgramFormCase_5(); break; // 숲해설, 찾아가는 숲해설
	}
}

// 목재문화체험으로 폼 변경
function setProgramFormCase_1() {
	$('#facManageDiv').addClass('ignore'); // 시설관리 -
	$('#costManageDiv').removeClass('ignore'); // 프로그램 비용 관리 +
	$('#eduTimeTr').removeClass('ignore'); // 교육시간 +
	$('#objTr').removeClass('ignore'); // 대상 +
	$('#placeTr').removeClass('ignore'); // 교육장소 +
	$('#introTr').removeClass('ignore'); // 교육소개 +
	$('.maxNum').addClass('ignore');
	$('#maxNumCase1').removeClass('ignore'); // 정원 ->온라인정원/전체정원
}
// 유아숲체험(정기형, 체험형, 찾아가는 유아숲)으로 폼 변경
function setProgramFormCase_2() {
	$('#facManageDiv').addClass('ignore'); // 시설관리 -
	$('#costManageDiv').addClass('ignore'); // 프로그램 비용 관리 -
	$('#eduTimeTr').removeClass('ignore'); // 교육시간 +
	$('#objTr').removeClass('ignore'); // 대상 +
	$('#placeTr').removeClass('ignore'); // 교육장소 +
	$('#introTr').removeClass('ignore'); // 교육소개 +
	$('.maxNum').addClass('ignore');
	$('#maxNumCase2').removeClass('ignore'); // 정원 ->접수/정원
}
// 유아숲체험(또래형)으로 폼 변경
function setProgramFormCase_3() {
	$('#facManageDiv').removeClass('ignore'); // 시설 관리 +
	$('#costManageDiv').addClass('ignore'); // 프로그램 비용 관리 -
	$('#eduTimeTr').removeClass('ignore'); // 교육시간 +
	$('#objTr').removeClass('ignore'); // 대상 +
	$('#placeTr').removeClass('ignore'); // 교육장소 +
	$('#introTr').removeClass('ignore'); // 교육소개 +
	$('.maxNum').addClass('ignore');
	$('#maxNumCase3').removeClass('ignore'); // 정원 ->정원
}
// 유아숲체험(행복나눔숲)으로 폼 변경
function setProgramFormCase_4() {
	$('#facManageDiv').addClass('ignore'); // 시설관리 -
	$('#costManageDiv').addClass('ignore'); // 프로그램 비용 관리 -
	$('#eduTimeTr').addClass('ignore'); // 교육시간 -
	$('#objTr').addClass('ignore'); // 대상 -
	$('#placeTr').addClass('ignore'); // 교육장소 -
	$('#introTr').addClass('ignore'); // 교육소개 -
	$('.maxNum').addClass('ignore');
	$('#maxNumCase3').removeClass('ignore'); // 정원 ->정원
}
// 숲해설, 숲길체험, 산림치유으로 폼 변경
function setProgramFormCase_5() {
	$('#facManageDiv').addClass('ignore'); // 시설관리 -
	$('#costManageDiv').addClass('ignore'); // 프로그램 비용 관리 -
	$('#eduTimeTr').removeClass('ignore'); // 교육시간 +
	$('#objTr').removeClass('ignore'); // 대상 +
	$('#placeTr').removeClass('ignore'); // 교육장소 +
	$('#introTr').removeClass('ignore'); // 교육소개 +
	$('.maxNum').addClass('ignore');
	$('#maxNumCase3').removeClass('ignore'); // 정원 ->정원
}

// 휴관일 추가
function addHoliday() {
	var hDay = $('#hDay').val();
	if( hDay != '' ) {
		var hdHtml = '<span><span class="hDayList">' + hDay + '</span><button type="button" onclick="delHoliday(this)">x</button></span>';
		$('#holidaySpan').append(hdHtml);
		$('#hDay').val('');
	}
}

// 휴관일 삭제
function delHoliday( btn ) {
	$(btn).parent('span').remove();
}

// 프로그램 비용 Line 추가
function addCostLine() {
	var costLineHtml = ''
		+ '<tr>'
		+	'<td><input type="text" name="title" placeholder="품목입력" class="Required"></td>'
		+	'<td><input type="text" name="entry_fee" class="exInput Required Number" onkeyup="inputProgramCost(this)"></td>'
		+	'<td><input type="text" name="book_fee" class="tmInput Required Number" onkeyup="inputProgramCost(this)"></td>'
		+	'<td><input type="text" name="total_fee" class="sumInput Number" readonly></td>'
		+	'<td><button type="button" class="btn" onclick="delCostLine(this)">X</button></td>'
		+ '</tr>';
	$('#costManageDiv').find('tbody').append(costLineHtml);
}
//프로그램 비용 Line 삭제
function delCostLine( btn ) {
	$(btn).closest('tr').remove();
}

// 프로그램 체험비,교재비 입력 ','추가, 합계 계산
function inputProgramCost( input ) {
	if( isNaN(removeCommas($(input).val())) ) $(input).val('0');
	
	var $tr = $(input).closest('tr');
	var exCost = removeCommas($tr.find('.exInput').val())*1; // 체험비
	var tmCost = removeCommas($tr.find('.tmInput').val())*1; // 교재비
	
	$tr.find('.exInput').val(numberWithCommas(exCost));
	$tr.find('.tmInput').val(numberWithCommas(tmCost));
	$tr.find('.sumInput').val(numberWithCommas(exCost + tmCost));
}

// 시설 관리 Line 추가
var facIdx = 2; // 시설관리 checkbox id를 위한 idx
function addFacLine() {
	var facLineHtml = ''
		+ '<tr>'
		+	'<td>'
		+		'<select class="facListSelect" style="width:100%;">'
		+			'<option value="">시설 선택</option>'
	;
	for( idx in facList ) {
		facLineHtml += '<option value="' + facList[idx].seq + '">' + facList[idx].codeName + '</option>';
	}
	facLineHtml += ''
		+		'</select>'
		+	'</td>'
		+	'<td>'
		+		'<input type="text" name="st_ymd" title="시작일" placeholder="시작일" class="ico_date" style="width:40%;">'
		+		' <span class="hypen">~</span> '
		+		'<input type="text" name="ed_ymd" title="종료일" placeholder="종료일" class="ico_date" style="width:40%;">'
		+	'</td>'
		+	'<td>'
		+		'<input type="checkbox" name="fri_yn" id="week_f_' + facIdx + '"><label for="week_f_' + facIdx + '">금요일</label> '
		+		'<input type="checkbox" name="sat_yn" id="week_s_' + facIdx + '"><label for="week_s_' + facIdx + '">토요일</label>'
		+	'</td>'
		+	'<td>'
		+		'<input type="checkbox" name="am_yn" id="time_m_' + facIdx + '"><label for="time_m_' + facIdx + '">오전</label> '
		+		'<input type="checkbox" name="pm_yn" id="time_a_' + facIdx + '"><label for="time_a_' + facIdx + '">오후</label>'
		+	'</td>'
		+	'<td><button type="button" class="btn" onclick="delFacLine(this)">X</button></td>'
		+ '</tr>'
	;
	$('#facManageDiv').find('tbody').append(facLineHtml);
	
	facIdx++;
	
	$('.ico_date').datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'yy-mm-dd'
    });
}
// 시설 관리 Line 삭제
function delFacLine( btn ) {
	$(btn).closest('tr').remove();
}

// 등록
function submitProgram() {
	var data = new Object();
	var ckFlag = false;
	
	// 기본 테이블 값 add
	$('#mainProgramTable').find('tr').each(function() {
		if( !$(this).hasClass('ignore') ) {
			if( !getValues($(this), data) ) {
				ckFlag = true;
				return false;
			}
		}
	});
	if( ckFlag ) return false;
	
	// 휴관일 add
	if( $('#holidaySpan').children('span').length > 0 ) {
		var holiday = '';
		$('#holidaySpan').children('span').each(function() {
			holiday += ',' + $(this).children('.hDayList').text().trim();
		});
		data.closed_ymd = holiday.substr(1);
	}
	
	// 교육소개 add
	if( data.type != typeList[4] ) {
		if(CKEDITOR.instances.editor.getData() == ''){
			alert('내용입력하세요');
			return false;
		}
		data.content = CKEDITOR.instances.editor.getData();
	}
	
	// 접수방법 add
	var receipt = '1'; // 정기접수
	if( data.gubun == gubunList[1] ) {
		if( data.type == typeList[4] ) receipt = '3'; // 유아숲체험 - 행복 숲체험일경우 전화접수
		if( data.type == typeList[0] || data.type == typeList[1]
			|| data.type == typeList[2] ) receipt = '2'; // 유아숲체험 - 정기형,체험형, 찾아가는 유아숲일경우 선착순접수
	}
	data.receipt = receipt;
	
	// 목재문화체험일 경우 프로그램 비용관리 추가
	if( $('#gubun').val() == gubunList[0] ) {
		var cost_data;
		var cost_data_list = new Array();
		
		$('#costManageDiv tbody').find('tr').each(function(i) {
			cost_data = new Object();
			cost_data.idx = $(this).find('input[name=idx]').val();
			cost_data.title = $(this).find('input[name=title]').val();
			cost_data.entry_fee = removeCommas($(this).find('input[name=entry_fee]').val());
			cost_data.book_fee = removeCommas($(this).find('input[name=book_fee]').val());
			cost_data.total_fee = removeCommas($(this).find('input[name=total_fee]').val());
			
			console.log(cost_data);
			
			if( cost_data.title == '' ) {
				alert('품목 명을 입력 해 주세요');
				$(this).find('input[name=title]').focus();
				ckFlag = true;
				return false;
			}
			if( cost_data.entry_fee == '' ) {
				alert('체험비를 입력 해 주세요');
				$(this).find('input[name=entry_fee]').focus();
				ckFlag = true;
				return false;
			}
			if( cost_data.book_fee == '' ) {
				alert('교재비를 입력 해 주세요');
				$(this).find('input[name=book_fee]').focus();
				ckFlag = true;
				return false;
			}
			
			cost_data_list.push(cost_data);
		});
		if( ckFlag ) return false;
		else data.cost_data_list_str = JSON.stringify(cost_data_list);
	}
	
	// 유아숲체험 - 또래숲일 경우 시설 관리 추가
	if( $('#gubun').val() == gubunList[1] && $('#type').val() == typeList[3] ) {
		var fac_data;
		var fac_data_list = new Array();
		
		$('#facManageDiv tbody').find('tr').each(function(i) {
			fac_data = new Object();
			fac_data.idx = $(this).find('input[name=idx]').val();
			fac_data.cSeq = $(this).find('select').val(); // 시설 code_seq
			fac_data.st_ymd = $(this).find('input[name=st_ymd]').val();
			fac_data.ed_ymd = $(this).find('input[name=ed_ymd]').val();
			fac_data.fri_yn = $(this).find('input[name=fri_yn]').prop('checked') ? 'Y' : 'N';
			fac_data.sat_yn = $(this).find('input[name=sat_yn]').prop('checked') ? 'Y' : 'N';
			fac_data.am_yn = $(this).find('input[name=am_yn]').prop('checked') ? 'Y' : 'N';
			fac_data.pm_yn = $(this).find('input[name=pm_yn]').prop('checked') ? 'Y' : 'N';
			
			console.log(fac_data);
			
			if( fac_data.cSeq == '' ) {
				alert('시설을 선택 해 주세요');
				$(this).find('select').focus();
				ckFlag = true;
				return false;
			}
			if( fac_data.st_ymd == '' ) {
				alert('접수 시작일을 입력 해 주세요');
				$(this).find('input[name=st_ymd]').focus();
				ckFlag = true;
				return false;
			}
			if( fac_data.ed_ymd == '' ) {
				alert('접수 시작일을 입력 해 주세요');
				$(this).find('input[name=ed_ymd]').focus();
				ckFlag = true;
				return false;
			}
			if( fac_data.fri_yn == 'N' && fac_data.sat_yn == 'N' ) {
				alert('요일 중 적어도 하나를 선택해야 합니다.');
				ckFlag = true;
				return false;
			}
			if( fac_data.am_yn == 'N' && fac_data.pm_yn == 'N' ) {
				alert('시간 중 적어도 하나를 선택해야 합니다.');
				ckFlag = true;
				return false;
			}
			
			fac_data_list.push(fac_data);
		});
		if( ckFlag ) {
			return false;
		} else {
			data.fac_data_list_str = JSON.stringify(fac_data_list);
		}
	}
	
	if( $('#idx').val() != '' ) data.idx = $('#idx').val();
	
	console.log(data);
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		url: './insertProgram',
		data: data,
		type: 'post',
		dataType: 'json',
		success: function(rData) {
			if( rData.rst ) {
				alert('저장 되었습니다');
				location.replace('./pList');
			} else {
				alert('오류가 발생했습니다');
				console.log(rData);
			}
		}, error: function(e) {
			console.log(e);
		}
	});
}


/** 숫자변환 **/
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCommas(x) {
	if( x == '' ) return 0;
	return x.toString().replace(/,/gi,'');
}

/** 하위 입력 값 가져오기 **/
function getValues( obj, data ) {
	var ckFlag = false;
	
	// INPUT
	$(obj).find('input[type=text]').each(function() {
		if( $(this).attr('name') == null ) return true;
		
		if( $(this).hasClass('Required') && $(this).val() == '' ) {
			alert($(this).attr('data-name') + '값은 필수값입니다.');
			$(this).focus();
			ckFlag = true;
			return false;
		} else {
			addToObject($(this), data);
		}
	});
	if( ckFlag ) return false;
	
	// SELECT
	$(obj).find('select').each(function() {
		if( !$(this).hasClass('ignore') ) {
			if( $(this).attr('name') == null ) return true;
			
			if( $(this).hasClass('Required') && $(this).val() == '' ) {
				alert($(this).attr('data-name') + '값은 필수값입니다.');
				$(this).focus();
				ckFlag = true;
				return false;
			} else {
				addToObject($(this), data);
			}
		}
	});
	if( ckFlag ) return false;
	
	// RADIO
	if( $(obj).find('input[type=radio]').length > 0 ) {
		var $ck_radio = $(obj).find('input[type=radio]:checked');
		data[$ck_radio.attr('name')] = $ck_radio.val();
	}
	
	// CHECKBOX
	if( $(obj).find('input[type=checkbox]:checked').length > 0 ) {
		$(obj).find('input[type=checkbox]:checked').each(function() {
			data[$(this).attr('name')] = $(this).val();
		});
	}
	
	return true;
}

function addToObject(obj, data) {
	var name = $(obj).attr('name');
	var value = $(obj).val();
	
	if( $(obj).hasClass('Number') ) value = removeCommas(value);
	
	if( name.endsWith('_list') ) {
		if( data[name] == null ) data[name] = new Array();
		data[name].push(value);
	} else {
		data[name] = value;
	}
}






