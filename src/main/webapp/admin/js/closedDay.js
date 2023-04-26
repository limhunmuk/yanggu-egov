function initSetDay() {
	var i=0;
	_firstDate=$(".day:first").attr("data-day");
	_lastDate=$(".day:last").attr("data-day");
}

function initSetState() {
	var dayNum=dateDiff(_firstDate,_lastDate);
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		dayState(mydate);
		$(".next-month.calendar-day-"+mydate).css("background-color","#eee");
		$(".last-month.calendar-day-"+mydate).css("background-color","#eee");
		$(".next-month.calendar-day-"+mydate).attr("data-old","1");
		$(".last-month.calendar-day-"+mydate).attr("data-old","1");
		$(".next-month.calendar-day-"+mydate).css("cursor","");
		$(".last-month.calendar-day-"+mydate).css("cursor","");
	}
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
			//console.log('Cal-1 next month');
		},
		previousMonth: function () {
			initSetDay();
			initSetState();
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

function dayState(mydate) {
		$("#td-"+mydate).css("cursor","pointer");
		$("#td-"+mydate).attr("data-old","0");
}
function dayStateToggle(mydate) {
	if($("#td-"+mydate).attr("data-old")==0) {
		var kind="";
			kind="I";
			$("#"+mydate).attr("data-close","1");
			$("#td-"+mydate).css("background-color","#ffc8e3");
			
			if(mydate != _save){
			$("#td-"+_save).css("background-color","#fff");
			$(".next-month.calendar-day-"+_save).css("background-color","#eee");
			$(".last-month.calendar-day-"+_save).css("background-color","#eee");
			}
			$("#datePick").html(formatDay(mydate,2));
			
			_save=mydate;
			//console.log(mydate);
			getList(mydate);
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