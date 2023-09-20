//현재일의 3일 후부터 예약가능
function getNow() {	
	if(_deadline==''){
		_deadline=0
	}
	return dayAdd(_today, (_deadline*1));
}
//당월 YYYY-MM
function getNowMonth() {
	var year = _cy;
	var month = _cm;

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	
	return year + "-" + month;
}
//다음달 YYYY-MM
function getNextMonth() {	
	if(_cnm.length == 1){
		_cnm = "0" + _cnm;
	}
	return _cny + "-" + _cnm;	
}

//YYYY-MM로 변환
function getTrMonth(day) {
	return day.substr(0,7);
}
//DD로 변환
function getTrDay(day) {
	return day.substr(8,2);
}

function initSetDay() {
	var i=0;
	_firstDate=$(".day:first").attr("data-day");
	_lastDate=$(".day:last").attr("data-day");
	_pickMonth=$(".month").attr("data-nowMonth");
	_pickYear=$(".month").attr("data-nowYear");
	if(_pickMonth<10){
		_pickMonth="0"+_pickMonth;
	}
	_pickDate=_pickYear+"-"+_pickMonth;
	initSetDayState();
}

function initSetState() {
	$(".next-month").each(function(index) { 
		$(this).css("cursor","");
		$(this).attr("data-old","1");
	});	
	$(".last-month").each(function(index) { 
		$(this).css("cursor","");
		$(this).attr("data-old","1");
	});	
}

function initSetDayState() {
	var now = getNow();
	
	//yyyy-mm 현재 월 
	var nowMonth = getNowMonth();
	
	//yyyy-mm 다음 월
	var nextMonth = getNextMonth();
	
	//날짜사이 계산
	var dayNum=dateDiff(_firstDate,_lastDate);
	
	//dayNum 만큼 for문 
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		//css 손가락 포인터
		$("#td-"+mydate).css("cursor","pointer");
		var nowWeek = $("#td-"+mydate).attr('data-week');
		//getTrMonth=yyyy-mm 형식으로 변환
		var myMonth = getTrMonth(mydate);
		var pickMonth = getTrMonth(_pickDate);
		//getTrDay = DD로 형변환
		var myDay = getTrDay(mydate);
		//월  추출 *1 ? ex)01 = 1로 만듬
		var myMonthM = (myMonth.substring(5, 7))*1;
		var reserveId = '#reserve_'+mydate;
		var dayClose = "N";
		var gubun = $('#gubun').val();
		
	//	if (_startDate != "" && _endDate != ""){
	//		if(mydate < _startDate || mydate > _endDate){
	//		 dayClose = 'Y'
	//		}else if(mydate == _startDate){
	//			console.log("오픈시작날짜랑 같으면 시간비교");
	//		}else if(mydate == _endDate){
	//			console.log("오픈마감날짜랑 같으면 시간비교");
	//		}
	//	}
		
		if (dayClose == "Y") {
			if (pickMonth != myMonth) {
				$('#td-' + mydate).css("cursor", "");
				$('#td-' + mydate).attr("data-old", "1");
			} else {
				$(reserveId).html('<span class="reserve finish">휴장 기간</span>');
				$('#td-' + mydate).css("cursor", "");
				$('#td-' + mydate).attr("data-old", "1");
			}
		} else if (mydate <= _today || mydate <= now) {
			//				console.log(now+" : mydate : "+mydate);
			if (nowWeek == 1) {
				$(reserveId).html('<span class="reserve finish">휴원일</span>');
				$('#td-' + mydate).css("cursor", "");
				$('#td-' + mydate).attr("data-old", "1");
			} else {
				$(reserveId).html('<span class="reserve finish">예약 마감</span>');
				$('#td-' + mydate).css("cursor", "");
				$('#td-' + mydate).attr("data-old", "1");
			}
		} else if (_pickDate > nextMonth) {
			$(reserveId).html('<span class="reserve finish">준비중</span>');
			$('#td-' + mydate).css("cursor", "");
			$('#td-' + mydate).attr("data-old", "1");
		} else if (nowWeek == 1) {
			$(reserveId).html('<span class="reserve finish">휴장일</span>');
			$('#td-' + mydate).css("cursor", "");
			$('#td-' + mydate).attr("data-old", "1");
		} else if (_startDate > mydate || _endDate < mydate) { //접수기간 이외의 기간은 준비중
			$(reserveId).html('<span class="reserve finish">준비중</span>');
			$('#td-' + mydate).css("cursor", "");
			$('#td-' + mydate).attr("data-old", "1");
		} else if (_pickDate == nowMonth || _pickDate == nextMonth) {
			if (pickMonth != myMonth) {
				$('#td-' + mydate).css("cursor", "");
				$('#td-' + mydate).attr("data-old", "1");
			} else {
				dayReserveState(mydate, gubun);
			}
		} else {
			$(reserveId).html('<span class="reserve finish">준비중</span>');
			$('#td-' + mydate).css("cursor", "");
			$('#td-' + mydate).attr("data-old", "1");
		}
		
		if (myMonth != _pickDate) {
			$(reserveId).html('');
		}
	}
}

function dayReserveState(mydate,gubun) {			
	$.post( "/program/checkDayCloseForest",{"useDate":mydate,"gubun":gubun}, function(result) {
		var ret = result.po_ret;
		var aCnt = result.po_aCnt;
		var bCnt = result.po_bCnt;
		var cCnt = 0;
		if(gubun == 'f'){
			cCnt = result.po_cCnt;
		}
		var closeYn = result.po_closeYn;
		
		if(closeYn == "Y"){
			$('#reserve_'+mydate).html('<span class="reserve finish">예약 불가</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(ret==210 || ret==441){
			if(aCnt>0 || bCnt>0 || cCnt>0){
				$('#reserve_'+mydate).html('<span class=\"reserve\">예약가능</span>');	
			}else{
				$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약마감</span>');
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}
		}else{
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약마감</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}		
	}, "json").fail(function(response) {
		alert('Error: ' + response.responseText);
	});
}

function initCLNDR() {
	var thisMonth = moment().format('YYYY-MM');
	var eventArray = [];
	var gubun = $('#gubun').val();
	calendars.clndr1 = $('.calendar_box2').clndr({
		events: eventArray,
		clickEvents: {
		click: function (target) {
			dayStateToggle(target.date._i,gubun);
		},
		today: function () {
			//console.log('Cal-1 today');
		},
		nextMonth: function () {
			initSetDay();
			initSetState();
			$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
			$("#inputArea").hide();
			$("#checkArea").hide();
			$("#prevPickP").show();
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
			$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
			$("#inputArea").hide();
			$("#checkArea").hide();
			$("#prevPickP").show();
		},
		onMonthChange: function () {
		},
		nextYear: function () {
		},
		previousYear: function () {
		},
		onYearChange: function () {
		},
		nextInterval: function () {
		},
		previousInterval: function () {
		},
		onIntervalChange: function () {
		}
		},
		multiDayEvents: {
			singleDay: 'date',
			endDate: 'endDate',
			startDate: 'startDate'
		},
		showAdjacentMonths: true,
			adjacentDaysChangeMonth: false
		});
}

function dayStateToggle(mydate,gubun) {
	console.log("dayStateToggle");
	$.post( "/program/checkDayCloseForest",{"useDate":mydate,"gubun":gubun} , function(result) {
		var ret = result.po_ret;
		var aCnt = result.po_aCnt;
		var bCnt = result.po_bCnt;
		var cCnt = 0;
		if(gubun =='f'){
			cCnt = result.po_cCnt;
		}	
		var closeYn = result.po_closeYn;
		
		console.log("mydate:"+mydate);
		var now = getNow();
		var nowMonth = getNowMonth();
		var html;
		if($("#td-"+mydate).attr("data-old")==0) {	
		
			var kind="";
				kind="I";
				$("#"+mydate).attr("data-close","1");
				$("#td-"+mydate).css("background-color","#e1eaee");
				
				if(mydate != _save){
				$("#td-"+_save).css("background-color","#fff");
				$(".next-month.calendar-day-"+_save).css("background-color","#eee");
				$(".last-month.calendar-day-"+_save).css("background-color","#eee");
				}
				
				_save=mydate;
				_pick_dt=mydate;
				if(aCnt == 0){
					$('.cnt_wrap2 .table_wrap.color3 table tr.firstTime .fr_chk input[type=radio]').attr('disabled', true);
					$("#firstTime").text("오전 10:00 ~ 11:30 예약가능 인원 " + 0 +"명");
					$('#firstTime').attr('style','text-decoration:line-through');
					
				}else{
					 //html = "<td>오전 10:00 ~ 12:00 예약가능 인원<strong class='c_red'>+'aCnt'+명</strong></td>";
					$("#firstTime").text("오전 10:00 ~ 11:30 (예약가능 인원 " + aCnt +"명)");
					$('.cnt_wrap2 .table_wrap.color3 table tr.firstTime .fr_chk input[type=radio]').attr('disabled', false);
					$('.cnt_wrap2 .table_wrap.color3 table tr.firstTime .fr_chk input[type=radio]').prop('checked', false);
					$("#firstTime").attr('style','');				
					$("#firstTime").css('color','red');				
				}
				if(bCnt == 0){
					$('.cnt_wrap2 .table_wrap.color3 table tr.secondTime .fr_chk input[type=radio]').attr('disabled', true);
					if(gubun == 'f'){
					$("#secondTime").text("오전 13:30 ~ 15:00 예약가능 인원 " + 0 +"명");
					}else{
					$("#secondTime").text("오전 14:00 ~ 15:30 예약가능 인원 " + 0 +"명");
					}
					$('#secondTime').attr('style','text-decoration:line-through');
				}else{
					if(gubun == 'f'){
					$("#secondTime").text("오전 13:30 ~ 15:00 (예약가능 인원 " + bCnt +"명)");
					}else{
					$("#secondTime").text("오전 14:00 ~ 15:30 (예약가능 인원 " + bCnt +"명)");
					}
					$('.cnt_wrap2 .table_wrap.color3 table tr.secondTime .fr_chk input[type=radio]').attr('disabled', false);
					$('.cnt_wrap2 .table_wrap.color3 table tr.secondTime .fr_chk input[type=radio]').prop('checked', false);
					$('#secondTime').attr('style','');
					$("#secondTime").css('color','red');
				}
				if(cCnt == 0){
					$('.cnt_wrap2 .table_wrap.color3 table tr.thirdTime .fr_chk input[type=radio]').attr('disabled', true);
					$("#thirdTime").text("오전 15:30 ~ 17:00 예약가능 인원 " + 0 +"명");
					$('#thirdTime').attr('style','text-decoration:line-through');
				}else{
					$("#thirdTime").text("오전 15:30 ~ 17:00 (예약가능 인원 " + cCnt +"명)");
					$('.cnt_wrap2 .table_wrap.color3 table tr.thirdTime .fr_chk input[type=radio]').attr('disabled', false);
					$('.cnt_wrap2 .table_wrap.color3 table tr.thirdTime .fr_chk input[type=radio]').prop('checked', false);
					$('#thirdTime').attr('style','');
					$("#thirdTime").css('color','red');
				}
				$("#datePick").html(formatDay(mydate,9)+"("+getInputDayLabel(mydate)+")");
				choice02(mydate);
				$("#noPcik").hide();
				$("#useDate").val(mydate);

		}
	}, "json").fail(function(response) {
		alert('Error: ' + response.responseText);
	});
}
function allToggleGood(obj) {
	$("input:checkbox[name='good[]']").prop("checked", obj.checked);
}
$("input[name='good[]']").change(function() {
	allToggleGoodCheck();
});
function allToggleGoodCheck() {
	var totalCnt=0, trueCnt=0;
	$("input[name='good[]']").each(function(index) { 
		totalCnt++;
		if ($(this).is(":checked")) {
			trueCnt++;
		}
	});
	if (totalCnt==trueCnt){
		$("#type_60").prop("checked", true);
	} else {
		$("#type_60").prop("checked", false);
	}
}