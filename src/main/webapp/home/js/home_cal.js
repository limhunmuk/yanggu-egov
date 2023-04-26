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
	initSetDayState();
}

function initSetState() {
	$(".next-month").each(function(index) { 
		$(this).css("background-color","#eee");
		$(this).css("cursor","");
		$(this).attr("data-old","1");
	});	
	$(".last-month").each(function(index) { 
		$(this).css("background-color","#eee");
		$(this).css("cursor","");
		$(this).attr("data-old","1");
	});	
}

function initSetDayState() {
	var now19 = getNow19();
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();
//	console.log(nextMonth);
//	console.log(_pickDate);
//	console.log(nextMonth);
	
	var dayNum=dateDiff(_firstDate,_lastDate);
//	_today="2019-10-20";
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		$("#td-"+mydate).css("cursor","pointer");		
		var myMonth = getTrMonth(mydate);
		var myDay = getTrDay(mydate);
		
		if (mydate < _today || (mydate==_today && getNowHour()>=18)) {
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약종료</span>');
			$('#td-'+mydate).css("cursor","");
			$('#td-'+mydate).attr("data-old","1");
		} else if (_pickDate == nowMonth || (_pickDate == nextMonth && _today >= now19)) {
			dayReserveState('4',mydate);
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

function dayReserveState(cseq,mydate) {			
	
	$.post('/API', {kd:'C',cseq:cseq,ctype:'E',date:mydate} , function(result) {

		for (var i = 0; i < result['list'].length; i++) {
			var stat = String(nullCheck(result['list'][i].stat, ''));
			
			if(stat=='N'){
				$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약마감</span>');
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else if(stat=='O'){
				$('#reserve_'+mydate).html('<span class=\"reserve finish\">휴관일</span>');
				$('#td-'+mydate).css("cursor","");
				$('#td-'+mydate).attr("data-old","1");
			}else{
				$('#reserve_'+mydate).html('<span class=\"reserve\">예약가능</span>');
				if(_k==0){
					_optEduPlace = String(nullCheck(result['list'][0].optEduPlace, ''));
					_normalFee = String(nullCheck(result['list'][0].normalFee, ''));
					_hoildayFee = String(nullCheck(result['list'][0].hoildayFee, ''));
					_k=1;
				}
				if(_daySelect==2){
					twoDaySelect(cseq,mydate);
				}
			}
		}
		

		
	}, "json").fail(function(response) {
		alert('Error: ' + response.responseText);
	});
}

function twoDaySelect(cseq,mydate){
	var tomorrow = dayAdd(mydate,1);
	$.post('/API', {kd:'D',cseq:cseq,ctype:'E',date:tomorrow} , function(result) {
		if(result['result']<0) {
			$('#reserve_'+mydate).html('<span class=\"reserve finish\">예약불가</span>');
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
			//console.log('Cal-1 next month');
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
			_pick_dt="";
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

	var now19 = getNow19();
	var nowMonth = getNowMonth();
	
	if($("#td-"+mydate).attr("data-old")==0) {	
		
		var todayD = new Date();
		var todayTime=todayD.getTime();
		
		var local = new Date(getNow19()+" 10:00");
		var localTime=local.getTime();
		
		var outside = new Date(getNow19()+" 14:00");
		var outsideTime=outside.getTime();

		var nextDay = dayAdd(mydate, 1);
		
		var kind="";
			kind="I";
			
			if(mydate != _save){
				$("#td-"+_save).css("background-color","#fff");
				$(".next-month.calendar-day-"+_save).css("background-color","#eee");
				$(".last-month.calendar-day-"+_save).css("background-color","#eee");
			}
			
			if(_daySelect==1){
				$("#td-"+_save2).css("background-color","#fff");
				$("#td-"+_save2).attr("data-close","1");
				$("#td-"+mydate).css("background-color","#e1eaee");
				if(_daySelect==2){
					$("#td-"+_save2).css("background-color","#fff");
					$(".next-month.calendar-day-"+_save2).css("background-color","#eee");
					$(".last-month.calendar-day-"+_save2).css("background-color","#eee");
					$("#td-"+nextDay).css("background-color","#e1eaee");
				}
			}else{
				if(mydate != _save2){
					$("#td-"+_save2).css("background-color","#fff");
					$(".next-month.calendar-day-"+_save2).css("background-color","#eee");
					$(".last-month.calendar-day-"+_save2).css("background-color","#eee");
				}
				$("#td-"+nextDay).css("background-color","#e1eaee");
				$("#td-"+mydate).css("background-color","#e1eaee");
			}
			_save2=nextDay;
			_save=mydate;
			_pick_dt=mydate;

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