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
			<c:choose>
				<c:when test="${gubun == 'e' }">
					<p><i class="home_i"></i><span>체험프로그램</span><span>유아숲체험 신청</span></p>	
				</c:when>
				<c:otherwise>
					<p><i class="home_i"></i><span>체험프로그램</span><span>숲해설 신청</span></p>
				</c:otherwise>			
			</c:choose>
			
		</div>
		<div class="contents sub_content for_m_max790">
			<div class="tab_area top">
				<ul class="tab_btn">
					<li class="on">01. 신청 정보 입력</li>
					<li>02. 신청 정보 확인</li>
					<li>03. 신청 완료</li>
				</ul>
			</div>
			<div class="cnt_wrap2">
				<div class="left_menu">
					
					<div class="calendar_box2  pj2"></div>
					
					<div class="date_info">
						<p><em>이용일로부터 1일</em> 전까지 신청 하실 수 있습니다.(금일부터 1일 이후 접수가능)</p>
						<div class="color_info">
							<span class="c01">예약마감</span>
							<span class="c02">예약가능</span>
							<span class="c03">선택한 날짜</span>
						</div>
					</div>
				</div>
				<form id="frm">
					<input type="hidden" name="useDate" id="useDate">
					<input type="hidden" name="gubun" id="gubun" value="${gubun }">
				<div class="sub_main r_main">
				<p class="tit_box" id = "reserveDate"><i></i></p>
					<!-- 날싸 선택전 표시-->
					<!--<p id="prevPickP" class="strong_txt"><i></i>예약일을 선택해주세요</p>-->
					<p id="prevPickP" class="strong_txt"><i></i>예약일을 선택해주세요</p>
					<div class="table_wrap color3" id="checkArea" style="display: none">
						<table>
							<caption></caption>
							<colgroup>
								<col style="width: 19%;">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th>선택</th>
									<th>시간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="firstTime">
									<td>
										<div class="fr_chk">
											<input type="radio" name="entryTime" id="rd1_1" value="1">
											<label for="rd1_1" class="chk">
												<i class="ico_chk"></i>
											</label>
										</div>
									</td>
									<td id="firstTime"><strong class="c_red"></strong></td>
								</tr>
								<tr class="secondTime">
									<td>
										<div class="fr_chk">
											<input type="radio" name="entryTime" id="rd1_2" value="2">
											<label for="rd1_2" class="chk">
												<i class="ico_chk"></i>
											</label>
										</div>
									</td>
									<td id="secondTime"></td>
								</tr>
								<c:if test="${gubun == 'f'}">
								<tr class="thirdTime">
									<td>
										<div class="fr_chk">
											<input type="radio" name="entryTime" id="rd1_3" value="3">
											<label for="rd1_3" class="chk">
												<i class="ico_chk"></i>
											</label>
										</div>
									</td>
									<td id="thirdTime"></td>
								</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="date_result" style="display: none" id="inputArea">
						<div class="dl_chk" id="reserveInfo" style="display: block;">
							<dl class="c1">
								<dt>신청자명<em class="c_red">*</em></dt>
								<dd>
									<input type="text" name="name" id="name">
									<label for="name" class="blind">신청자명</label>
								</dd>
							</dl>
							<dl class="c1">
								<dt>전체참가인원<em class="c_red">*</em></dt>
								<dd>
									<input type="text" name="cnt" id="cnt">
									<label for="cnt" class="blind">전체참가인원</label>
									<c:choose>
										<c:when test="${gubun == 'e' }">
											<span><!-- 00명/ --><em class="small_txt">(모집정원은 <strong class="c_red">3~7명</strong>입니다.)</em></span>
										</c:when>
										<c:otherwise>
											<span><!-- 00명/ --><em class="small_txt">(모집정원은 <strong class="c_red">2~10명</strong>입니다.)</em></span>
										</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl class="c1">
								<dt>전화번호<em class="c_red">*</em></dt>
								<dd>
									<div class="tel_area">
										<select name="mobile1" id="mobile1" style="font-weight:700; color: black;">
												<option>010</option>
												<option>016</option>
												<option>017</option>
												<option>018</option>
												<option>019</option>
										</select>
										<!-- <input type="text" name="mobile1" id="mobile1"> -->
										<label for="mobile1" class="blind">전화번호1</label>
										<input type="text" name="mobile2" id="mobile2">
										<label for="mobile2" class="blind">전화번호2</label>
										<input type="text" name="mobile3" id="mobile3" class="last">
										<label for="mobile3" class="blind">전화번호3</label>
									</div>
								</dd>
							</dl>
							<dl class="c1">
								<dt>비고</dt>
								<dd>
									<input type="text" name="remark" id="remark">
									<label for="remark" class="blind">비고 입력</label>
								</dd>
							</dl>
						</div>
						<ul class="result_list" id="reserveList" style="display: block;"></ul>
					</div>
					<!--
					<div class="table_wrap">
						<table id="timeTable" style="display:none;">
							<caption>목공예 체험교실 정보를 선택 시간을 목록으로 표시합니다. </caption>
							<colgroup>
								<col style="width: 30%;">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">시간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<input type="radio" name="emailYn" id="chk_list05">
										<label for="chk_list05" class="blind"> 시간선택</label>
									</td>
									<td>오전 10:00~12:00</td>
								</tr>
								<tr>
									<td>
										<input type="radio" name="emailYn" id="chk_list06">
										<label for="chk_list06" class="blind"> 시간선택</label>
									</td>
									<td>
										<span class="af_on">오전 10:00~12:00</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="man_num">
						<input type="text" id="recCnt" placeholder="신청 인원수 입력 (ex)00 숫자만 입력)" style="display:none;">
						<label for="recCnt" class="blind"> 신청 인원수 입력</label>
					</div>
					-->
				</div>
			</form>
			</div>
			<div class="btn_area m_c2">
				<button type="button" class="btn" onclick="insert()">신청하기</button>
				<button type="button" class="btn form02" onclick="location.replace('/')">취소</button>
			</div>
		</div>
<form id="smsFrm" action="/program/forest/sendSms" method="post">
<input type="hidden" id="gubun" name="gubun" value="${gubun}">
<input type="hidden" id="dseq" name="dseq" >
<input type="hidden" id="msg" name="msg">
<input type="hidden" id="title" name="title">
<input type="hidden" id="mobile" name="mobile">
<input type="hidden" id="smsType" name="smsType" value="S">
</form>
		<%@ include file="../inc/footer.jsp"%>
<script>
var calendars = {};
var _save = "";
var _firstDate = "";
var _lastDate = "";
var _pick_dt = "";
var _msg="";
var _deadline= '';
var _startDateTime = "${startDate}";
var _startDate = _startDateTime.substring(0,11);
var _endDateTime = "${endDate}";
var _endDate = _endDateTime.substring(0,11);
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
<script src="/js/cust/forest_reservation01.js?v=2021"></script>
<script>
var txt1 = "";
var txt2 = "유아숲해설테스트";
var _title = "유아숲/해설 신청문자"; 
var smsMsg = "";

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
				$("#checkArea").hide();
				$("#inputArea").hide();
			});
			
			function choice02(pickDate){
				$("#reserveDate").html("<i></i>"+formatDay(pickDate,9)+"("+getInputDayLabel(pickDate)+")");
				$("#checkArea").show();
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
				
				//$('.cnt_wrap2 .table_wrap.color3 table tr.firstTime .fr_chk input[type=radio]').attr('disabled', true);
	function insert(){
			var gubun=$('#gubun').val();
		
			var entryTime = $('input[name="entryTime"]:checked').val() != undefined? $('input[name="entryTime"]:checked').val():'';
			console.log(entryTime);
			if (entryTime == '') {
				alert('시간을 선택해주세요.');
				return;
			}
		
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
		    if(!regNumber.test(mobile2))
		    {
		        alert('숫자만 입력하세요');
		        $("#mobile2").focus();
		        return;
		    }
		    if(!regNumber.test(mobile3))
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
		    if (gubun == 'e') {
		    	if(cnt<3){
			        alert('인원은 3명 이상 부터 신청가능합니다.');
			        $("#cnt").focus();
			        return;
			    }	
			}else{
				if(cnt<2){
			        alert('인원은 2명 이상 부터 신청가능합니다.');
			        $("#cnt").focus();
			        return;
			    }	
			}
		    
		    if (gubun == 'e') {
		    	if(cnt>7){
			        alert('인원은 7명을 초과할 수 없습니다.');
			        $("#cnt").focus();
			        return;
			    }	
			}else{
				if(cnt>10){
			        alert('인원은 10명을 초과할 수 없습니다.');
			        $("#cnt").focus();
			        return;
			    }
			}
		    
		    var time = "";
		    if (entryTime == 1) {
				time = "오전 10:00 ~ 11:30";
			}else if (entryTime == 2) {
				if (gubun == 'f') {
					time = "오후 13:30 ~ 15:00";
				}else{
					time = "오후 14:00 ~ 15:30";
				}
			}else{
				time = "오후 15:30 ~ 17:00";
			}
		    
			txt1 = "예약자 : "+name +"님\n 예약날짜 : " + _pick_dt+ " " + time + "\n예약인원 : " + cnt + "명\n유아숲체험 신청 하였습니다.";
			txt2 = "예약자 : "+name +"님\n 예약날짜 : " + _pick_dt+ " " + time + "\n예약인원 : " + cnt + "명\n숲해설 신청 하였습니다." ;
			
			if (gubun == 'e') {
				smsMsg = txt1;
			}else{
				smsMsg = txt2;
			}
		    

			if(confirm("예약 하시겠습니까?")){
				
				$.post( "/program/checkDayCloseForest",{"useDate":_pick_dt,"gubun":gubun}, function(result) {					
					var po_ret = result.po_ret;
					var po_aCnt = 0;
					var po_bCnt = 0;
					var po_cCnt = 0;
					if (entryTime == 1) {
						po_aCnt = result.po_aCnt;
					}else if(entryTime == 2){
						po_bCnt = result.po_bCnt;
					}else{
						po_cCnt = result.po_cCnt;
					}				
					var closeYn = result.po_closeYn;
					if(po_ret==210){
						if(po_aCnt>=cnt || po_bCnt>=cnt || po_cCnt>=cnt){
							$.post( "/program/insertForestExperience",$("#frm").serialize(), function(result) {
								var ret = result.result;
								var dSeq = result.dSeq;
								
								if(ret==1){
									alert("예약신청이 완료 되었습니다.");
									$("#dseq").val(dSeq);
									sendSms();
									location.replace('/program/forest_reservation2?dSeq='+dSeq);
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
	    
	    function sendSms(){
	    		var stringByteLength = getStringLength(smsMsg);
// 	    		console.log(stringByteLength + " Bytes");
	    		if(stringByteLength>2000){
	    			alert("문자 길이는 2000 byte를 넘을 수 없습니다.");
	    			return;
	    		}else if(stringByteLength<91){
	    			$("#smsType").val("S");
	    		}else{
	    			$("#smsType").val("L");
	    		}
	    		$("#msg").val(smsMsg);
	    		$("#title").val(_title);

	    		var mobile = $("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val();
	    		$(":hidden[name=mobile]").val(mobile)
	    		
	    		$.post( "/program/forest/sendSms",$("#smsFrm").serialize(), function(result) {
	    			
	    		}).fail(function(response) {
	    			console.log('Error: ' + response.responseText);
	    		});
	    		
	    }
	    
	    
	    function getStringLength (str){
	    	var retCode = 0;
	    	var strLength = 0;

	    	for (i = 0; i < str.length; i++){
	    		var code = str.charCodeAt(i)
	    		var ch = str.substr(i,1).toUpperCase()
	    		
	    		code = parseInt(code)
	    		
	    		if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0)))
	    		strLength = strLength + 2;
	    		else
	    		strLength = strLength + 1;
	    	}
	    	return strLength;
	    }	    
</script>
	</div>
	<!-- //wrap -->
</body>
</html>
