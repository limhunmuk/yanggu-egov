//당월의 19일
function getNow9() {
	var date = new Date();
	var year = date.getFullYear();
	var month = new String(date.getMonth()+1);

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	
	return year + "-" + month + "-09";
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
	var now9 = getNow9();
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();
//	console.log(nextMonth);
//	console.log(_pickDate);
//	console.log(nextMonth);
	
	var dayNum=dateDiff(_firstDate,_lastDate);
//	_today="2019-10-20";
	
	console.log(getNowHour());
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		$("#td-"+mydate).css("cursor","pointer");		
		var myMonth = getTrMonth(mydate);
		var myDay = getTrDay(mydate);
		var nowTime = getNowHour()+1;
		console.log(nowTime);
		
		
		if (mydate < _today) {
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(myMonth == nextMonth){
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if((_today < now9 && _pickDate == nextMonth) || ( _today == now9 && _pickDate == nextMonth && nowTime < 11)){
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		} else if (_pickDate == nowMonth || (_pickDate == nextMonth && _today >= now9)) {
			if(mydate==_today && getNowHour()>=20){
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else{
				dayReserveState('2',mydate);
				//$("#td-"+mydate).css("background-color","#eaeaea");
				$('#reserveDay_'+mydate).css("background-color","#eaeaea");
			}
		} else {	
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}
		
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}
			
	}
	
}

function dayReserveState(cseq,mydate) {			
	$.post( "/leisure/day_reserve_state", "cseq="+cseq+"&date="+mydate , function(result) {
		cnt = result.po_ret;
		if(cnt==1){
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		}else if(cnt==2){
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
			console.log("휴관일 :"+mydate);
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
			//console.log('Cal-1 clicked: ', target);
			//console.log(target.date._i);
			dayStateToggle(target.date._i);
		},
		today: function () {
			//console.log('Cal-1 today');
		},
		nextMonth: function () {
			initSetDay();
			initSetState();
			_pick_dt="";
			radioReset();
			//console.log('Cal-1 next month');
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
			_pick_dt="";
			radioReset();
			//console.log('Cal-1 previous month');
		},
		onMonthChange: function () {
			//console.log('Cal-1 month changed');
		},
		nextYear: function () {
			//console.log('Cal-1 next year');
		},
		previousYear: function () {
			//console.log('Cal-1 previous year');
		},
		onYearChange: function () {
			//console.log('Cal-1 year changed');
		},
		nextInterval: function () {
			//console.log('Cal-1 next interval');
		},
		previousInterval: function () {
			//console.log('Cal-1 previous interval');
		},
		onIntervalChange: function () {
			//console.log('Cal-1 interval changed');
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
		
		$(document).keydown( function(e) {
			if (e.keyCode == 37) {
			calendars.clndr1.back();
			}
		
			if (e.keyCode == 39) {
				calendars.clndr1.forward();
			}
		});
}

function dayStateToggle(mydate) {

	var now19 = getNow9();
	var nowMonth = getNowMonth();
	
	if($("#td-"+mydate).attr("data-old")==0) {	
		
		var todayD = new Date();
		var todayTime=todayD.getTime();
		
		var local = new Date(getNow9()+" 10:00");
		var localTime=local.getTime();
		
		if(getTrMonth(mydate)==getNextMonth()){
			if(localTime>todayTime){
				alert("9일 오전 10:00부터 신청하실 수 있습니다.");
				return;
			}
		}
		var nextDay = dayAdd(mydate, 1);
		
		var kind="";
			kind="I";
			//$("#td-"+_save).css("background-color","#eaeaea");
			$('#reserveDay_'+_save).css("background-color","#eaeaea");
			
			if(_daySelect==1){
				//$("#td-"+mydate).css("background-color","#cd3d3d");
				$('#reserveDay_'+mydate).css("background-color","#cd3d3d");
			}
			_save2=nextDay;
			_save=mydate;
			_pick_dt=mydate;
			radioReset();

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