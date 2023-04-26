<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<div class="sub_visual bg06">
			<h2>체험프로그램</h2>
			<p><i class="home_i"></i><span>체험프로그램</span><span>용늪 출입 신청</span></p>
		</div>
		<div class="contents sub_content">
			<div class="tab_area top">
				<ul class="tab_btn for_resv">
					<li><span>01. 예약 체크사항동의</span></li>
					<li class="on"><span>02. 예약일 선택 및 정보 입력</span></li>
					<li>03. 예약완료</li>
				</ul>
			</div>
			<div class="cnt_wrap2">
				<div class="left_menu">
				
					<div class="calendar_box2  pj2"></div>
					
					<div class="date_info">
						<p>이용신청 - <c:out value="${settingMap.deadline}" />일전 부터 인터넷 선착순 접수 / 총 신청인원 하루 100명 이내입니다</p>
						<div class="color_info">
							<span class="c01">예약마감</span>
							<span class="c02">예약가능</span>
							<span class="c03">선택한 날짜</span>
						</div>
					</div>
				</div>
				<form id="frm">
					<input type="hidden" name="useDate" id="useDate">
					<div class="sub_main r_main">
						 <!-- 목재문화체험일때만 안내 노출 -->
						<a href="/main/reservation_write" class=" side_btn"><i></i>예약 조회/취소</a>
						<p class="tit_box" id = "reserveDate"><i></i></p>
						<!-- 날싸 선택전 표시-->
						<p id="prevPickP" class="strong_txt"><i></i>예약일을 선택해주세요</p>
						<div class="date_result" style="display: none" id="inputArea">
							<div class="dl_chk" id="reserveInfo" style="display: block;">
								<dl class="c1">
									<dt>예약자명</dt>
									<dd>
										<input type="text" name="name" id="name" placeholder="예) 신청자명" >
										<label for="name" class="blind">예약자명</label>
									</dd>
								</dl>
								<dl class="c1">
									<dt>전화번호 <em class="small_txt">(연락가능한 번호를 입력해주세요)</em></dt>
									<dd>
										<div class="tel_area">
											<select name="mobile1" id="mobile1" style="font-weight:700; color: black;">
												<option>010</option>
												<option>016</option>
												<option>017</option>
												<option>018</option>
												<option>019</option>
											</select>
											<label for="mobile1" class="blind">전화번호1</label>
											<input type="text" name="mobile2" id="mobile2" style="font-weight:700;">
											<label for="mobile2" class="blind">전화번호2</label>
											<input type="text" name="mobile3" id="mobile3" style="font-weight:700;" class="last">
											<label for="mobile3" class="blind">전화번호3</label>
										</div>
									</dd>
								</dl>
								<dl class="c1 last">
									<dt>참가인원 <em class="small_txt">(참여자수)</em></dt>
									<dd>
										<input type="text" id="cnt" name="cnt" value="0">
										<label for="cnt" class="blind">참가인원</label>
									</dd>
								</dl>
								<dl class="c1">
									<dt>단체 / 기관 명</dt>
									<dd>
										<input type="text" placeholder="예) 개인, 산악회 등" name="teamName" id="teamName">
										<label for="teamName" class="blind">단체 / 기관 명</label>
									</dd>
								</dl>
							</div>
							<ul class="result_list" id="reserveList" style="display: block;"></ul>
						</div>
					</div>
				</form>
			</div>
			<div class="btn_area m_c2">
				<button type="button" class="btn" onclick="insert()">신청하기</button>
				<button type="button" class="btn form02" onclick="location.replace('/')">취소</button>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>

	<!-- //wrap -->
<script>
	var calendars = {};
	var _save = "";
	var _firstDate = "";
	var _lastDate = "";
	var _pick_dt = "";
	var _msg="";
	var _deadline= '${settingMap.deadline}';
	var _month01 = "${settingMap.month01}";
	var _month02 = "${settingMap.month02}";
	var _month03 = "${settingMap.month03}";
	var _month04 = "${settingMap.month04}";
	var _month05 = "${settingMap.month05}";
	var _month06 = "${settingMap.month06}";
	var _month07 = "${settingMap.month07}";
	var _month08 = "${settingMap.month08}";
	var _month09 = "${settingMap.month09}";
	var _month10 = "${settingMap.month10}";
	var _month11 = "${settingMap.month11}";
	var _month12 = "${settingMap.month12}";
	
	var _today = "${cy}-${cm}-${cd}";
	var _cy = '${cy}';
	var _cny = '${cny}';
	var _cm = '${cm}';
	var _cnm = '${cnm}';
	var _cd = '${cd}';
	var _ch = '${ch}';
</script>
<script src="/CLNDR/js/underscore-min.js?v=2020"></script>
<script src="/CLNDR/js/moment.min.js?v=2020"></script>
<script src="/CLNDR/js/clndr.js?v=2020"></script>
<script src="/js/cust/reservation02.js?v=2020"></script>	
<script>
	$('.calendar_box2 table  button.reserve').on('click', function () {
		$('.calendar_box2 table td').removeClass('on');
		$(this).parent().parent().addClass('on');
	});

	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		minDate: new Date('2019-08-28'),
		yearSuffix: '년'
	 });

	 $(function() {
		$("#datepicker1, #datepicker2").datepicker();
	 });

	var mseq = "${memberSeq}";
	$(function () {
		allValidate();
	  	initCLNDR();
		initSetDay();
		initSetState();
		$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
		$("#inputArea").hide();
	});
	
	function choice02(pickDate){
		$("#reserveDate").html("<i></i>"+formatDay(pickDate,9)+"("+getInputDayLabel(pickDate)+")");
		$("#inputArea").show();
		$("#prevPickP").hide();
	}
	
      $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        minDate: new Date('2019-08-28'),
        yearSuffix: '년'
      });

      $(function() {
        $("#datepicker1, #datepicker2").datepicker();
      });

	  
		$('.box .tab_btn li .btn').on('click', function () {
		//1) 클릭한 버튼 부모li의 인덱스번호 변수 저장
			var tgIdx = $(this).parent().index();
			$(this).parent().addClass('on').siblings().removeClass('on');
			$('#interior .box .tab_list').find('li').eq(tgIdx).addClass('on').siblings().removeClass('on');
		});

		function insert(){
			
			var name=$("#name").val();
			if (name == '' && name.trim() == '') {
				alert('이름을 입력해주세요.');
				$("#name").focus();
				return;
			}
			var mobile1=$("#mobile1").val();
			var mobile2=$("#mobile2").val();
			var mobile3=$("#mobile3").val();
		    var regNumber = /^[0-9]*$/;
		    if(!regNumber.test(mobile1))
		    {
		        alert('숫자만 입력하세요');
		        $("#mobile1").focus();
		        return;
		    }
		    if(!regNumber.test(mobile1))
		    {
		        alert('숫자만 입력하세요');
		        $("#mobile2").focus();
		        return;
		    }
		    if(!regNumber.test(mobile1))
		    {
		        alert('숫자만 입력하세요');
		        $("#mobile3").focus();
		        return;
		    }
		    var phonePattern = /^[0-9]{9,11}$/; 
			var mobile=mobile1+mobile2+mobile3;
		    if (!phonePattern.test(mobile)) {
		        alert('잘못된 전화번호입니다.');
		        $("#mobile1").focus();
		        return;
		    }

			var cnt=$("#cnt").val();
		    if(!regNumber.test(cnt))
		    {
		        alert('숫자만 입력하세요');
		        $("#cnt").focus();
		        return;
		    }
		    if(cnt<1){
		        alert('인원은 1명 이상 부터 신청가능합니다.');
		        $("#cnt").focus();
		        return;
		    }
		    if(cnt>100){
		        alert('인원은 100명을 초과할 수 없습니다.');
		        $("#cnt").focus();
		        return;
		    }
		    
			var teamName=$("#teamName").val();
			if (teamName == '' && teamName.trim() == '') {
				alert('단체 / 기관 명을 입력해주세요.');
				$("#teamName").focus();
				return;
			}

			if(confirm("예약 하시겠습니까?")){
				
				$.post( "/program/checkDayClose","useDate="+_pick_dt , function(result) {					
					var po_ret = result.po_ret;
					var po_aCnt = result.po_aCnt;
					var closeYn = result.po_closeYn;
					if(po_ret==210){
						if(po_aCnt>=cnt){
							$.post( "/program/insertDragonReserve",$("#frm").serialize(), function(result) {
								var ret = result.result;
								var dSeq = result.dSeq;
								
								if(ret==1){
									alert("예약신청이 완료 되었습니다.");
									location.replace('/program/reservation3?dSeq='+dSeq);
									return;
								}else if(ret==-3){
									   alert("선택하신 날짜는 휴장일입니다.");
									   return;
								}else if(ret==-4){
									   alert("예약불가한 날짜입니다.");
									   return;
								}else if(ret==-2){
									   alert("예약불가한 날짜입니다.");
									   return;
								}else if(ret==-1){
									   alert("예약가능 인원이 초과 되었습니다.");
									   return;
								}else{
								   alert("예약신청이 실패하였습니다.");
								   return;
								}		
							}, "json").fail(function(response) {
								alert('Error: ' + response.responseText);
							});
							
						}else{
							if(po_aCnt>0){
								$('#reserve_'+_pick_dt).html('<p class="txt"><strong>'+po_aCnt+'</strong>명 예약가능</p><span class=\"reserve\">예약가능</span>');	
							}else{
								$('#reserve_'+_pick_dt).html('<span class=\"reserve finish\">예약마감</span>');
								$('#td-'+_pick_dt).css("cursor","");
								$('#td-'+_pick_dt).attr("data-old","1");
							}
						   alert("예약가능 인원이 초과 되었습니다.");
						   return;
						}
					}else{
					   alert("예약불가한 날짜입니다.");
					   return;
					}		
				}, "json").fail(function(response) {
					alert('Error: ' + response.responseText);
				});
			}
	    };

</script>

</body>
</html>
