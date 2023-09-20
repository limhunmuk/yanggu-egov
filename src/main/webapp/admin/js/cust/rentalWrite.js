//현재일의 20일 후부터 예약가능
function getNow() {	
	if(_deadline==''){
		_deadline=20
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
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();
	
	var dayNum=dateDiff(_firstDate,_lastDate);
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		$("#td-"+mydate).css("cursor","pointer");
		var nowWeek = $("#td-"+mydate).attr('data-week');
		var myMonth = getTrMonth(mydate);
		var pickMonth = getTrMonth(_pickDate);
		var myDay = getTrDay(mydate);
		
		var myMonthM = (myMonth.substring(5, 7))*1;
		var reserveId = '#reserve_'+mydate;
		var monthClose = "N";

		if(myMonthM==1&&_month01=="Y"){
			monthClose="Y";
		}else if(myMonthM==2&&_month02=="Y"){
			monthClose="Y";
		}else if(myMonthM==3&&_month03=="Y"){
			monthClose="Y";
		}else if(myMonthM==4&&_month04=="Y"){
			monthClose="Y";
		}else if(myMonthM==5&&_month05=="Y"){
			monthClose="Y";
		}else if(myMonthM==6&&_month06=="Y"){
			monthClose="Y";
		}else if(myMonthM==7&&_month07=="Y"){
			monthClose="Y";
		}else if(myMonthM==8&&_month08=="Y"){
			monthClose="Y";
		}else if(myMonthM==9&&_month09=="Y"){
			monthClose="Y";
		}else if(myMonthM==10&&_month10=="Y"){
			monthClose="Y";
		}else if(myMonthM==11&&_month11=="Y"){
			monthClose="Y";
		}else if(myMonthM==12&&_month12=="Y"){
			monthClose="Y";
		}else{
			monthClose="N";
		}

		if(monthClose=="Y"){
			if(pickMonth != myMonth){
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else{
				$(reserveId).html('<span class="reserve finish">휴장 기간</span>');
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}
		}else {
			if(pickMonth != myMonth){
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else{
				dayReserveState(mydate);
			}
		}
		
		if (myMonth != _pickDate) {
			$(reserveId).html('');
		}
	}
}

function dayReserveState(mydate) {		
	$.post( "/program/checkDayClose","useDate="+mydate , function(result) {
		var ret = result.result.po_ret;
		var cnt = result.result.po_aCnt;
		var closeYn = result.result.po_closeYn;
		console.log(mydate + " : dayReserveState : "+cnt)	
		
		if(closeYn == "Y"){
			$('#reserve_'+mydate).html('<span class="reserve finish">예약 불가</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(ret==210 || ret==441){
			if(cnt>0){
				$('#reserve_'+mydate).html('<p class="txt"><strong>'+cnt+'</strong>명 예약가능</p><span class=\"reserve\">예약가능</span>');	
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

	calendars.clndr1 = $('.calendar_box2').clndr({
		events: eventArray,
		clickEvents: {
		click: function (target) {
			dayStateToggle(target.date._i);
		},
		today: function () {
			//console.log('Cal-1 today');
		},
		nextMonth: function () {
			initSetDay();
			initSetState();
			$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
			$("#inputArea").hide();
			$("#prevPickP").show();
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
			$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
			$("#inputArea").hide();
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

function dayStateToggle(mydate) {

	var now = getNow();
	var nowMonth = getNowMonth();
	
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
			$("#datePick").html(formatDay(mydate,9)+"("+getInputDayLabel(mydate)+")");
			choice02(mydate);
			$("#noPcik").hide();
			$("#useDate").val(mydate);

	}
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