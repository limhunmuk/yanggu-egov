//당월의 19일
function getNow19() {
	var date = new Date();
	var year = date.getFullYear();
	var month = new String(date.getMonth()+1);

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	
	return year + "-" + month + "-19";
}
//당월 YYYY-MM
function getNowMonth() {
	var date = new Date();
	var year = date.getFullYear();
	var month = new String(date.getMonth()+1);

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	
	return year + "-" + month;
}
//다음달 YYYY-MM
function getNextMonth() {
	var date = new Date();
	var firstDayOfMonth = new Date( date.getFullYear(), date.getMonth() + 1, 1 );
	var nextMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() + 1 ) );
	var year = nextMonth.getFullYear();
	var month = new String(nextMonth.getMonth()+1);
	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	
	return year + "-" + month;	
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
	initSetDayState(_cate2);
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

function initSetDayState(_cate2) {
	var now19 = getNow19();
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();
	
	var dayNum=dateDiff(_firstDate,_lastDate);
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		$("#td-"+mydate).css("cursor","pointer");		
		var myMonth = getTrMonth(mydate);
		var pickMonth = getTrMonth(_pickDate);
		var myDay = getTrDay(mydate);
		var nowTime = getNowHour()+1;
			
		if (mydate <= _today) {
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약종료</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(_pickDate > nextMonth){
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">준비중</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");	
		} else if (_pickDate == nowMonth || _pickDate == nextMonth) {
			if(pickMonth != myMonth){
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else{
				dayReserveState(mydate);
			}
		} else {
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">준비중</span>');		
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}
		
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}
			
	}
	
}

function dayReserveState(mydate) {			
	$.post( "/facility/checkDayClose","date="+mydate , function(result) {
		cnt = result.po_ret;
		if(cnt==0){
			$('#reserve_'+mydate).html('<span class=\"reserve\">예약가능</span>');
		}else if(cnt==1){
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약마감</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(cnt==2){
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">휴관일</span>');
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
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
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

	var now19 = getNow19();
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
			allClear();

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