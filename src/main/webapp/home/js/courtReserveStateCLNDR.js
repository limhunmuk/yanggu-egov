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
	
	var dayNum=dateDiff(_firstDate,_lastDate);
	
	for (var i=0;i<=dayNum;i++) {
		mydate=dayAdd(_firstDate,i);	
		initSetStatList(mydate);
	}
}

function initSetStatList(mydate) {
	var now19 = getNow19();
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();	
	var myMonth = getTrMonth(mydate);
	$('#reserve_'+mydate).html('');
	var str = "";
	var nowTime = getNowHour();

	if(nowMonth=="2019-12"){
		str += "<div class=\"state_wrap\"> ";
		str += "<p><span>예약종료</span></p> ";
		str += "</div> ";
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}else{
			$('#reserve_'+mydate).html(str);
			str="";
		}
	}else if(mydate<_today){
		str += "<div class=\"state_wrap\"> ";
		str += "<p><span>예약종료</span></p> ";
		str += "</div> ";
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}else{
			$('#reserve_'+mydate).html(str);
			str="";
		}
	}else if((_today < now19 && _pickDate == nextMonth) || ( _today == now19 && _pickDate == nextMonth && nowTime < 10)){
		str += "<div class=\"state_wrap\"> ";
		str += "<p><span>준비중</span></p> ";
		str += "</div> ";
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}else{
			$('#reserve_'+mydate).html(str);
		}	
	} else if (_pickDate == nowMonth || (_pickDate == nextMonth && _today >= now19)) {
		$.post( "/sports/reserve_state_list", "pickDate="+mydate+"&cate2="+_courtCate , function(result) {
			str += "<div class=\"state_wrap\"> ";
			for(var i=0;i<result.length;i++){
				var label="";
				
				if(result[i].labelType=='1' && result[i].label != "휴관일"){
					label = "예약완료";
				}else{
					label = result[i].label;
				}
				if(mydate>=_today){
					console.log("result[i].yesno : "+result[i].yesno);
					if(result[i].yesno == '0'){
						str += "<p><span style='cursor:pointer;' onclick=\"location='/sports/courtReserve_date?cate1="+_cate1+"&cate2="+_cate2+"'\">"+result[i].hourBeginEnd+" <span class='tbe296'>"+label+"</span></span></p> ";
					}else{
						str += "<p><span>"+result[i].hourBeginEnd+" "+label+"</span></p> ";
					}
				}
			}
			str += "</div> ";
			
			if (myMonth != _pickDate) {
				$('#reserve_'+mydate).html('');
			}else{
				$('#reserve_'+mydate).html(str);
				str="";
			}

		}, "json").fail(function(response) {
			console.log('Error: ' + response.responseText);
		});	
		
	} else {
		str += "<div class=\"state_wrap\"> ";
		str += "<p><span>준비중</span></p> ";
		str += "</div> ";
		if (myMonth != _pickDate) {
			$('#reserve_'+mydate).html('');
		}else{
			$('#reserve_'+mydate).html(str);
			str="";
		}		
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

function dayStateToggle(mydate) {

	/*var now19 = getNow19();
	var nowMonth = getNowMonth();
	var nextMonth = getNextMonth();*/
	
	/*var noCheckTxt = "<tr> <td colspan=\"2\" class=\"no-check\"> <div class=\"chk_area\"> ";
	noCheckTxt += "<strong><i>!</i>예약가능한 날짜를 선택해주세요.</strong> </td> </tr>";*/
	
/*	if($("#td-"+mydate).attr("data-old")==0) {
		var kind="";
			kind="I";
			$("#"+mydate).attr("data-close","1");
			$("#td-"+mydate).css("background-color","#ffc8e3");
			
			if(mydate != _save){
			$("#td-"+_save).css("background-color","#fff");
			$(".next-month.calendar-day-"+_save).css("background-color","#eee");
			$(".last-month.calendar-day-"+_save).css("background-color","#eee");
			}
			
			_save=mydate;
			
			$("#datePick").html(formatDay(mydate,2));
			timeList(mydate,_cate2);
			
			if (mydate <= _today) {
				return;
			} else if (_today < now19 && mydate > now19) {
				$("#datePick").html("");
				$("#timeBody").html(noCheckTxt);
				return;
			} else if (_pickDate > nextMonth) {
				$("#datePick").html("");
				$("#timeBody").html(noCheckTxt);
				return;
			} else if ( _pickDate == nextMonth && myDay>="20") {
				$("#datePick").html("");
				$("#timeBody").html(noCheckTxt);
				return;
			} else {			
				$.ajaxSettings.async = false;
				var cnt = dayReserveState(_cate2,mydate);
				$.ajaxSettings.async = true;
				if(cnt==0){
					$("#datePick").html(formatDay(mydate,2));
					timeList(mydate,_cate2);
				}else if(cnt==1){
					$("#datePick").html("");
					$("#timeBody").html(noCheckTxt);
					return;
				}else if(cnt==2){
					$("#datePick").html("");
					$("#timeBody").html(noCheckTxt);
					return;
				}
				
			}
			

	}*/
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