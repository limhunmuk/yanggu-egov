// Call this from the developer console and you can control both instances
var calendars = {};
var _firstDate="";
var _lastDate="";

$(document).ready( function() {
	initCLNDR();
	initSetDay();
	initSetState();
});

function initSetDay() {
	var i=0;
	_firstDate=$(".day:first").attr("data-timestemp");
	_lastDate=$(".day:last").attr("data-timestemp");
	console.log("_firstDate=" + _firstDate);
	console.log("_lastDate=" + _lastDate);
}

function initSetState() {
	console.log("_firstDate=" + _firstDate);
	console.log("_lastDate=" + _lastDate);

	console.log("initSetState()");
	var dayNum=dateDiff(_firstDate,_lastDate);
	console.log("dayNum="+dayNum);
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);
		console.log("mydate="+mydate);
	}
}

function initCLNDR() {
    // Here's some magic to make sure the dates are happening this month.
    var thisMonth = moment().format('YYYY-MM');
    // Events to load into calendar
    var eventArray = [];

    // The order of the click handlers is predictable. Direct click action
    // callbacks come first: click, nextMonth, previousMonth, nextYear,
    // previousYear, nextInterval, previousInterval, or today. Then
    // onMonthChange (if the month changed), inIntervalChange if the interval
    // has changed, and finally onYearChange (if the year changed).
    calendars.clndr1 = $('.cal1').clndr({
        events: eventArray,
        clickEvents: {
            click: function (target) {
                console.log('Cal-1 clicked: ', target);
				console.log(target.date._i);
            },
            today: function () {
                console.log('Cal-1 today');
            },
            nextMonth: function () {
				initSetDay();
				initSetState();
                console.log('Cal-1 next month');
            },
            previousMonth: function () {
				initSetDay();
				initSetState();
                console.log('Cal-1 previous month');
            },
            onMonthChange: function () {
                console.log('Cal-1 month changed');
            },
            nextYear: function () {
                console.log('Cal-1 next year');
            },
            previousYear: function () {
                console.log('Cal-1 previous year');
            },
            onYearChange: function () {
                console.log('Cal-1 year changed');
            },
            nextInterval: function () {
                console.log('Cal-1 next interval');
            },
            previousInterval: function () {
                console.log('Cal-1 previous interval');
            },
            onIntervalChange: function () {
                console.log('Cal-1 interval changed');
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

    // Bind all clndrs to the left and right arrow keys
    $(document).keydown( function(e) {
        // Left arrow
        if (e.keyCode == 37) {
            calendars.clndr1.back();
        }

        // Right arrow
        if (e.keyCode == 39) {
            calendars.clndr1.forward();
        }
    });
}
function formatDay(date, sw) {
	var mydate = new Date(date);
    var mymonth = mydate.getMonth() + 1;
    var myweekday = mydate.getDate();
	var ret="";
	if (sw==1) { //yyyy-mm-dd
		ret = (mydate.getFullYear() + "-" + ((mymonth < 10) ? "0" : "") + mymonth + "-" + ((myweekday < 10) ? "0" : "") + myweekday);
	} else if (sw==2) { //yyyy년 m월 d일 
		ret= "<span class=\"schedule-nav-txt-year\">"+mydate.getFullYear()+"</span>년";
		ret+= "<span class=\"schedule-nav-txt-month\">"+mymonth+"</span>월";
		ret+= "<span class=\"schedule-nav-txt-day\">"+myweekday+"</span>일";
	}  else if (sw==3) { //   m/d
		ret = mymonth + "/" + myweekday;
	}  else if (sw==4) { //   년 월
		ret= "<span class=\"schedule-nav-txt-year\">"+mydate.getFullYear()+"</span>년";
		ret+= "<span class=\"schedule-nav-txt-month\">"+mymonth+"</span>월";
	}  else if (sw==5) { //   m월
		ret = mymonth + "월";
	} else if (sw==6) { //yyyy년 m월 d일 
		ret= "<span class=\"schedule-nav-txt-year\">"+mydate.getFullYear()+"년 </span>";
		ret+= "<span class=\"schedule-nav-txt-month\">"+mymonth+"월 </span>";
		ret+= "<span class=\"schedule-nav-txt-day\">"+myweekday+"일 </span>";
	}
    return ret;
}
function dayAdd(day, num) {
    var mydate = new Date(day);
    mydate.setDate(mydate.getDate() + num);
    return formatDay(mydate,1);
}
function dateDiff(date1,date2) {
	var sdt = new Date(date1);
	var edt = new Date(date2);
	var diff = Math.ceil((edt.getTime()-sdt.getTime())/(1000*3600*24));

    return diff;
}