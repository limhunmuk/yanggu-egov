function ProgramCalendar( pIdx, gubun, type, gubunList, typeList, eduStYmd, eduEdYmd ) {
    var cal = this;
    var calendars = {};
    
    var today = getToday();			// 오늘
    var nowMonth = getNowMonth();;	// 이번 달
    var nextMonth = getNextMonth();	// 다음 달
    var nowTime = getNowHour()*1;	// 현재시간
    var after3 = dayAdd(today, 3); // 현재일로부터 3일 후
    var after14 = dayAdd(today, 14); // 현재일로부터 2주 후
    var after60 = dayAdd(today, 60); // 현재일로부터 60일 후
    var pickYear;					// 선택된 년
    var pickMonth;					// 선택된 달
    var pickYm;						// 선택된 날짜형식(yyyy-MM)
    var fistDate;					// 선택된 달 첫번째 일(yyyy-MM-dd)
    var lastDate;					// 선택된 달 마지막 일(yyyy-MM-dd)
    var pCase;						// 프로그램 Case
    var recDataList = [];			// 접수일 데이터 리스트
    var recStYmd; 					// 접수 시작일(yyyy-MM-dd)
    var recEdYmd; 					// 접수 종료일(yyyy-MM-dd)
    var recStTime; 					// 접수 시작시간(00)
    var recFacList = [];			// 접수기관 리스트
    
    this.init = function() {
        pCase = cal.setCase();
        cal.CreateCalendar();
        cal.setDayInfo();
        cal.getRecPeriod();
    }
    
    // 프로그램 일 정보 set
    this.setDayInfo = function() {
        firstDate = $(".day:first").attr("data-day");
        lastDate = $(".day:last").attr("data-day");
        pickYear = $(".month").attr("data-nowYear");
        pickMonth = $(".month").attr("data-nowMonth");
        pickMonth = pickMonth<10 ? '0' + pickMonth : pickMonth;
        pickYm = pickYear + "-" + pickMonth;
    }
    
    // 프로그램 상태값 set
    this.setDayState = function() {
        
        var thisDate, thisWeek;
        
        for ( var i = 0 ; i <= dateDiff(firstDate,lastDate) ; i++ ) {
            
            thisDate = dayAdd(firstDate,i);
            
            
            if( pCase == 2 ) { // 또래숲일 경우
                
                thisWeek = new Date(thisDate).getDay();
            
                if( after3 >= thisDate || after14 < thisDate ) { // 3일 후 부터 2주 후까지만 예약 가능
                    cal.setTd(thisDate, 'M');
                } else {
                    cal.setTd(thisDate, recDataList[thisDate]);
                }
                
            } else { // 그 외
                
                // 현재부터 3일 후는 공통 예약불가
                // 숲해설 - 찾아가는 숲해설 제외 다른 프로그램은 60일 이후도 불가
                if( after3 >= thisDate || (pCase != 3 && after60 < thisDate) ) {
                    cal.setTd(thisDate, 'M');
                } else {
                    
                    if( recStYmd == thisDate ) { // 접수시작일일때 시간까지 확인
                        
                        if( nowTime >= recStTime ) {
                            cal.setTd(thisDate, recDataList[thisDate]);
                        } else {
                            cal.setTd(thisDate, 'M');
                        }
                        
                    } else if( recStYmd < thisDate && recEdYmd >= thisDate ) { // 접수중일때
                        cal.setTd(thisDate, recDataList[thisDate]);
                    } else { // 마감일일때
                        cal.setTd(thisDate, 'M');
                    }
                    
                }
                
            }
            
            if (getTrMonth(thisDate) != pickYm) { // 선택된 달 이외의 일자는 공란
                $('#reserve_'+thisDate).html('');
            }
        }
    }
    
    // 프로그램 분기처리
    this.setCase = function() {
        var returnCase;
        
        if( gubun == gubunList[0] ) { // 목재프로그램
            returnCase = 1;
        } else if( gubun == gubunList[1] && type == typeList[3] ) { // 또래숲
            returnCase = 2;
        } else if( gubun == gubunList[2] && type == typeList[6] ) { // 숲해설 - 찾아가는숲해설
            returnCase = 3;
        } else { // 그 외
            returnCase = 4;
        }
        
        return returnCase;
    }
    
    // 프로그램 CLNDR 기본 세팅
    this.CreateCalendar = function() {
        var thisMonth = moment().format('YYYY-MM');
        var eventArray = [];

        calendars.clndr1 = $('.calendar_box2').clndr({
            events: eventArray,
            clickEvents: {
            click: function (target) {
                if( $('#td-' + target.date._i).attr('data-old') == '0' ) {
                    // 스타일
                    $('.day').css('background-color','#fff');
                    $('#td-' + target.date._i).css('background-color','rgb(225, 234, 238)');
                    
                    // 처리
                    cal.selectDay(target.date._i);
                }
            },
            today: function () {
                //console.log('Cal-1 today');
            },
            nextMonth: function () {
                cal.setDayInfo();
                cal.setDayState();
                //console.log('Cal-1 next month');
            },
            previousMonth: function () {
                cal.setDayInfo();
                cal.setDayState();
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
    }
    
    // 접수기간 가져옴
    this.getRecPeriod = function() {
        $.ajax({
            url: './readRecPeriod',
            data: {idx: $('#idx').val()},
            async: false,
            type: 'post',
            dataType: 'json',
            success: function(pvoList) {
                if( pvoList.length != 0 ) {
                    recStYmd = pvoList[0].thisDate;
                    recEdYmd = pvoList[pvoList.length-1].thisDate;
                    recStTime = pvoList[0].rec_st_time;
                    
                    for( idx in pvoList ) { // 접수일 리스트 생성
                        recDataList[pvoList[idx].thisDate] = pvoList[idx].state;
                    }
                }
                
                cal.setDayState();
            },
            error: function(e) {
                console.log(e);
                alert('오류가 발생했습니다');
            }
        });
    }
    
    // Td Html 생성
    this.setTd = function( thisDate, state ) {
        if( state == 'N' ) { // 예약가능
            if( eduStYmd <= thisDate && eduEdYmd >= thisDate ) { // 교육기간 내
                $('#reserve_'+thisDate).html('<span class=\"reserve\">예약가능</span>');
                $('#td-'+thisDate).css("cursor","pointer");
            } else {
                $('#reserve_'+thisDate).html('<span class=\"reserve finish\">예약불가</span>');
                $('#td-'+thisDate).attr("data-old","1");
            }
        } else if( state == 'H' ) { // 휴관일
            $('#reserve_'+thisDate).html('<span class=\"reserve finish\">휴관일</span>');
            $('#td-'+thisDate).attr("data-old","1");
        } else if( state == 'E' ) { // 예약마감
            $('#reserve_'+thisDate).html('<span class=\"reserve finish\">예약불가</span>');
            $('#td-'+thisDate).attr("data-old","1");
        } else { // 예약불가
            $('#reserve_'+thisDate).html('<span class=\"reserve finish\">예약불가</span>');
            $('#td-'+thisDate).attr("data-old","1");
        }
    }
    
    // 날짜 선택 시 액션
    this.selectDay = function( selDate ) {
        cal.selDate = selDate;
        
        if( pCase == 2 ) { // 또래숲
            $('#timeTable tbody').html('');
            $('#timeTable').hide();
            cal.readRecFacilityList(selDate);
        } else { // 그 외
            cal.readRecTimeInfo(selDate);
        }
        cal.setRecCntInput('H');
    }

    // 시간, 정원 조회
    this.readRecTimeInfo = function( reserDate ) {
        $.ajax({
            url: './readRecTimeInfo',
            data: {idx: pIdx, reserDate: reserDate},
            type: 'post',
            dataType: 'json',
            async: false,
            success: function(data) {
                if( data == null ) {
                    alert('예약이 종료되었습니다.');
                    location.reload();
                }
                
                $('#prevPickP').hide();
                cal.createTimeTable(data);
            }, error: function(e) {
                console.log(e);
            }
        });
    }
    
    // 접수 기관 조회
    this.readRecFacilityList = function( reserDate ) {
        $.ajax({
            url: './readRecFacilityList',
            data: {pIdx: pIdx, reserDate: reserDate},
            type: 'post',
            dataType: 'json',
            async: false,
            success: function(data) {
                if( data == null ) {
                    alert('예약이 종료되었습니다.');
                    location.reload();
                }
                
                $('#prevPickP').hide();
                recFacList = {};
                var ulHtml = '';
                
                for( idx in data ) {
                    recFacList[data[idx].code_seq] = data[idx];
                    ulHtml += cal.createFacLi(data[idx]);
                }
                
                $('#facListUl').html(ulHtml);
                $('#facListUl').show();
            }, error: function(e) {
                console.log(e);
            }
        });
    }
    
    // 시간 테이블 생성
    this.createTimeTable = function( timeInfo ) {
        
        var recMax = timeInfo.rec_max;
        var html = '';
        
        if( pCase == 1 ) {
            
            for( var i=10 ; i<=17 ; i++ ) {
                html += cal.createTimeTr(recMax - timeInfo['time' + i], i);
            }
            
        } else {
            html += cal.createTimeTr(recMax - timeInfo['time10'], 10);
            html += cal.createTimeTr(recMax - timeInfo['time14'], 14);
        }
        
        $('#timeTable tbody').html(html);
        $('#timeTable').show();
        cal.setRecCntInput('H');
        
    }
    
    // 시간 TR 생성
    this.createTimeTr = function(rmCnt, time) {
        var html = ''
            +	'<tr>'
            +		'<td>'
            +			'<input type="radio" name="recTime" id="rectime_' + time + '" value="' + time + ':00" onclick="Pcal.selectTime(this)"' + (rmCnt <= 0 ? 'disabled' : '') + '>'
            +		'</td><td ' + (rmCnt <= 0 ? 'style="text-decoration: line-through;"' : '') + '>'
            +		'<label for="rectime_' + time + '">';
        
        if( pCase == 1 ) html += time + ':00';
        else html += (time < 12 ? '오전 ' : '오후 ') + time + ':00~' + (time+2) + ':00';
        
        if(rmCnt > 0) html += '(' + rmCnt + '명)';
        html += '</label></td></tr>';
        
        return html;
    }
    
    // 기관 li 생성
    this.createFacLi = function( facInfo ) {
        var html = ''
            +	'<li>'
            +		'<input type="radio" name="recFac" id="recFac_' + facInfo.code_seq + '" value="' + facInfo.code_seq + '"'
            +			' onclick="Pcal.createFacTimeTable(this)"> '
            +		'<label for="recFac_' + facInfo.code_seq + '">' + facInfo.fac_name + '</label>'
            +	'</li>';
        
        return html;
    }
    
    // 기관 시간 테이블 생성
    this.createFacTimeTable = function( obj ) {
        var thisFacSeq = $(obj).val();
        var html = '';
        if( recFacList[thisFacSeq].am_yn == 'Y' ) {
            html += cal.createTimeTr(recFacList[thisFacSeq].rec_max - recFacList[thisFacSeq].time10, 10);
        }
        if( recFacList[thisFacSeq].pm_yn == 'Y' ) {
            html += cal.createTimeTr(recFacList[thisFacSeq].rec_max - recFacList[thisFacSeq].time14, 14);
        }
        $('#timeTable tbody').html(html);
        $('#timeTable').show();
        cal.setRecCntInput('H');
    }
    
    // 시간 선택
    this.selectTime = function( radio ) {
        cal.selTime = $(radio).val();
        cal.setRecCntInput('S');
    }
    
    // 정원 입력 칸 show hide
    this.setRecCntInput = function( m ) {
        if( m == 'S' ) {
            $('#recCnt').show();
        } else {
            $('#recCnt').hide();
            $('#recCnt').val('');
        }
    }
    
    // 신청
    this.beforeSubmitCheckRecTime = function() {
        
        var send_data = {
            p_idx: pIdx,
            reser_date_str: cal.selDate,
            reser_time: cal.selTime,
            parti_cnt: $('#recCnt').val(),
            f_idx: $('input[name=recFac]:checked').val()
        };
        
        if( send_data.p_idx == null ) {
            alert('오류가 발생했습니다');
            history.back();
        }
        if( send_data.reser_date_str == null || send_data.reser_date_str == '' ) {
            alert('일자를 선택 해 주세요');
            return false;
        }
        if( send_data.reser_time == null || send_data.reser_time == '' ) {
            alert('시간을 선택 해 주세요');
            return false;
        }
        if( send_data.parti_cnt == null || send_data.parti_cnt == '' || isNaN(send_data.parti_cnt) ) {
            alert('신청인원을 입력 해 주세요');
            return false;
        }
        
        $.ajax({
            url: './checkRec',
            data: send_data,
            type: 'post',
            dataType:'json',
            success: function(data) {
                if( data.rst ) {
                    location.href='./rsvWrite2?idx=' + pIdx + '&a_idx=' + data.idx;
                } else {
                    alert(data.rstMsg);
                    location.reload();
                }
            },
            error: function(e) {
                console.log(e);
            }
        });
    }
    
    
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