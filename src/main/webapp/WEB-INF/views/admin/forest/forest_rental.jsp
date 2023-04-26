<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/general.css?222"/>
<link rel="stylesheet" type="text/css" href="/ad_css/calendar.css?222"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
       <c:import url="/WEB-INF/views/admin/common/left_forest.jsp">
		</c:import>
		<!--
        <c:import url="/WEB-INF/views/admin/common/left_forest.jsp">
            <c:param name="menuOn" value="2" />
        </c:import>
		-->
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>신청 관리</h3>
				</div>
				<div class="list">
					<form action="" method="post" id="searchFrm">
					<input type="hidden" name="excelUseDate" id="excelUseDate">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="*">
							</colgroup>
							<tbody>
								<tr>	
									<th scope="row">기간조회</th>	
									<td>
										<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" id="startDate" value="${startDate }" autocomplete="off">
										<span class="hypen">~</span>
										<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" id="endDate" value="${endDate }" autocomplete="off">
									</td>
								</tr>
								<tr>
									<th scope="row">상태</th>
									<td>
										<input type="checkbox" name="stat" id="stat_00">
										<label for="stat_00">전체</label>
										<input type="checkbox" name="stat" value="a"<c:if test="${fn:indexOf(statString,'a') != -1}">checked</c:if> id="stat_01">
										<label for="stat_01">신청</label>
										<input type="checkbox" name="stat" value="b"<c:if test="${fn:indexOf(statString,'b') != -1}">checked</c:if> id="stat_02">
										<label for="stat_02">승인</label>
										<input type="checkbox" name="stat" value="c"<c:if test="${fn:indexOf(statString,'c') != -1}">checked</c:if> id="stat_03">
										<label for="stat_03">취소</label>
									</td>
								</tr>
							</tbody>
						</table>
						<!--
						<div class="btn_area align_r mt20">
							<button class="btn_search" type="submit">검색</button>
						</div>
						-->
					</form>
					<div class="cnt_wrap2 forest">
						<div class="left_menu">
						
							<div class="calendar_box2  pj2"></div>
							
							<div class="date_info">
								
								<div class="color_info">
									<span class="c01">예약마감</span>
									<span class="c02">예약가능</span>
									<span class="c03">선택한 날짜</span>
								</div>
							</div>
						</div>
						<form id="frm">
							<input type="hidden" name="useDate" id="useDate" value="">
							<input type="hidden" name="gubun" id="gubun" value="${gubun }">
							<div class="sub_main r_main">
								<div class="align_r">
									<button type="button" class="btn_down" onclick="moveWrite();">신청등록</button>
									<button type="button" class="btn_down" onclick="excelDownload();">엑셀다운로드</button>
									<button type="button" class="btn_search" onclick="search();">검색</button>
								</div>
								<!-- <form id="smsFrm" name="smsFrm" action="" method="post"> -->
									<div class="search_wrap">
										<div class="result">
											<p class="txt" id = "reserveDate"></p>
										</div>
										<table class="search_list">
											<caption>검색결과</caption>
											<colgroup>
												<col style="width: 8%;">
												<col style="*">
											<c:if test="${startDate != null && startDate != ''}">
												<col style="*" id="reservationCol">
											</c:if>
												<col style="*">
												<col style="width: 15%;">
												<col style="width: 12%;">
												<col style="width: 12%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">신청자</th>
												<c:if test="${startDate != null && startDate != ''}">
													<th scope="col" id="reservationTh">예약날짜</th>
												</c:if>
													<th scope="col">시간</th>
													<th scope="col">전화번호</th>
													<th scope="col">참여인원</th>
													<th scope="col">승인현황</th>
												</tr>
											</thead>
											<tbody id="listbody">
												<c:choose>
													<c:when test="${empty list }">
														<c:choose>
															<c:when test="${startDate != null && startDate != ''}">
																<tr><td colspan="7">예약자가 없습니다</td></tr>
															</c:when>
															<c:otherwise>
																<tr><td colspan="6">예약자가 없습니다</td></tr>	
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
													<c:forEach items="${list}" var="list" varStatus="Status">
												<tr>
													<td>${totalCount - ((page -1) * 10 + Status.index)}</td>
													<td><a href="forest_rental_write?seq=${list.seq}" class="c_blue">${list.name}</a></td>
													<c:if test="${startDate != null && startDate != ''}">
													<td>${list.useDate }</td>
													</c:if>
													<td>
													<c:choose>
														<c:when test="${list.entryTime =='1'}">
															오전 10:00 ~ 11:30
														</c:when>
														<c:when test="${list.entryTime =='2'}">
															<c:choose>
																<c:when test="${list.gubun == 'f'}">
																	오후 13:30 ~ 15:00
																</c:when>
																<c:otherwise>
																 	오후 14:00 ~ 15:30
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															오후 15:30 ~ 17:00
														</c:otherwise>
													</c:choose>
													</td>
													<td>${list.mobile}</td>
													<td>${list.cnt}명</td>
													<td>
														<select style="width: 80px;" name="forestStat" onchange="updateStat('${list.seq}','${list.cnt }','${list.useDate }','${list.entryTime}','${list.mobile }','${list.name}','${list.insertDate}',this);">
															<option value="a"<c:if test="${list.stat == 'a'}">selected</c:if>>신청</option>
															<option value="b"<c:if test="${list.stat == 'b'}">selected</c:if>>승인</option>
															<option value="c"<c:if test="${list.stat == 'c'}">selected</c:if>>취소</option>
														</select>
													</td>
												</tr>
												</c:forEach>
												</c:otherwise>
												</c:choose>												
											</tbody>
										</table>
										<div class="pagination mt0">
											 <c:if test="${page gt 1  }">
				                   			 	<a href="?page=${page - 1}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}" class="prev">이전 페이지</a>
						               		 </c:if>
											<c:forEach var="pageLink" items="${pageLinks }">
						                    <c:choose>
						                        <c:when test="${page eq pageLink }">
						                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}" class="on" onclick="return false;">${pageLink }</a>
						                        </c:when>
						                        <c:otherwise>
						                            <a href="?page=${pageLink}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}">${pageLink }</a>
						                        </c:otherwise>
						                    </c:choose>
						                	</c:forEach>
						                	<c:if test="${page lt totalPage}">
						                    	<a class="next" href="?page=${page + 1}&startDate=${startDate}&endDate=${endDate}&search_type=${search_type}${statQuery}">다음 페이지</a>
						                	</c:if>
										</div>
									</div>
									<input type="hidden" id="oldDate" value="${oldUseDate}">
									<input type="hidden" id="stat" >
								</form>
								 <!-- 목재문화체험일때만 안내 노출 -->
								<!--<p class="tit_box" id = "reserveDate"><i></i></p>-->
								<!-- 날싸 선택전 표시-->
								<!--<p id="prevPickP" class="strong_txt"><i></i>수정일을 선택해주세요</p>
								<div class="date_result" style="display: none" id="inputArea">
									<div class="dl_chk" id="reserveInfo" style="display: block;">
										<dl class="c1 last">
											<dt>참가인원 수정 <em class="small_txt" id="nowCnt">(현재 신청자수 : 0명)</em></dt>
											<dd>
												<input type="text" id="saveCnt" name="saveCnt" value="0" style="width:80%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
												<label for="cnt" class="blind">참가인원</label>
												<input type="hidden" id="saveDate" name="saveDate" value="">
												<button type="button" onclick="saveACnt()" class="btn2">저장</button>
											</dd>
										</dl>
									</div>
									<ul class="result_list" id="reserveList" style="display: block;"></ul>
								</div>-->
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="layerpop-box open"><!-- open 클래스 추가하면 팝업 -->
		<div class="modal-bg"></div>
		<div class="layerpopup msg-error" >
			<div class="inner type-rental">
				<div class="msgbox prompt">
					<div class="head_title">신청등록<a href="javascript:;" class="btn_close">닫기</a></div>
					<div class="ctrt_wrap">
						<div class="ctrt">
							<form id="insertFrm">
							<div class="write">
								<table>
									<caption>신청관리</caption>
									<colgroup>
										<col style="width:15%;">
										<col style="*">
									</colgroup>
									<tr>
										<th scope="row">예약일</th>
										<td><input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="adminUseDate" id="adminUseDate" value=""></td>
									</tr>
									<tr>
										<th scope="row">시간 선택</th>
										<td>
											<select style="width:150px;" name="entryTime" id="entryTime">
												<option value="1">오전 10:00 ~ 11:30</option>
											<c:choose>
												<c:when test="${gubun == 'f'}">	
												<option value="2">오후 13:30 ~ 15:00</option>
												</c:when>
												<c:otherwise>
												<option value="2">오후 14:00 ~ 15:30</option>
												</c:otherwise>
											</c:choose>	
											<c:if test="${gubun == 'f'}">
												<option value="3">오후 15:30 ~ 17:00</option>
											</c:if>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row">참가인원</th>
										<td><input type="text" style="width:150px;" name="cnt" id="cnt">
										 <span>
										 <c:choose>
										 	<c:when test="${gubun == 'e'}">
										 		3명 ~ 7명
										 	</c:when>
										 	<c:otherwise>
										 		2명 ~ 10명
										 	</c:otherwise>
										 </c:choose></span>
										 </td>
									</tr>
									<tr>
										<th scope="row">신청자</th>
										<td><input type="text" name="name" id="name"></td>
									</tr>
									<tr>
										<th scope="row">전화번호</th>
										<td>
											<div class="input_area col3">
												<select name="mobile1" id="mobile1">
													<option value="010">010</option>
													<option value="016">016</option>
													<option value="017">017</option>
													<option value="018">018</option>
													<option value="019">019</option>
												</select>
												<input type="text" name="mobile2" id="mobile2">
												<input type="text" name="mobile3" id="mobile3">
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">비고</th>
										<td><input type="text" name="remark" id="remark"></td>
									</tr>
								</table>
								<div class="write_btn mt35">
									<button type="button" class="btn_modify" onclick="insert();">저장</button>
									<button type="button" class="btn btn_close">취소</button>
								</div>
							</div>
							<input type="hidden" name="insertGubun" id="insertGubun" value="${gubun}">
							</form>
						</div>
					</div>
					<!--
					<div class="btn_area">
						<button class="btn btn_close">닫기</button>
					</div>
					-->
				</div>
			</div>
		</div>
	</div>
</div>
<form id="smsFrm" action="/admin/forest/sendSms" method="post">
<input type="hidden" id="gubun" name="gubun" value="${gubun}">
<input type="hidden" id="dseq" name="dseq" >
<input type="hidden" id="msg" name="msg">
<input type="hidden" id="title" name="title">
<input type="hidden" id="mobile" name="mobile">
<input type="hidden" id="smsType" name="smsType" value="S">
</form>
<!-- </div> -->

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
	var strDate = '${startDate}';
	var endDate = '${endDate}';
	var _openDateTime = "${openDate}";
	var _openDate = _openDateTime.substring(0,11);
	var _closeDateTime = "${closeDate}";
	var _closeDate = _closeDateTime.substring(0,11);
	
</script>
<script src="/ad_CLNDR/js/underscore-min.js?v=2020"></script>
<script src="/ad_CLNDR/js/moment.min.js?v=2020"></script>
<script src="/ad_CLNDR/js/clndr.js?v=2020"></script>
<script src="/ad_js/cust/forest_rental.js?v=2021"></script>	
<script src="/js/common.min.js?v=2020"></script>	 
<script>
var txt1 = "";
var txt2 = "유아숲해설테스트";
// var _title = "유아숲/해설 승인문자"; 
var smsMsg = "";

$(function(){
	var gubun = '${gubun}'
	
	$('#gnb ul li').eq(2).addClass('on');
	if (gubun == 'e') {
		$('#lnb ul.menu > li').eq(0).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(0).addClass('on');
	}else{
		$('#lnb ul.menu > li').eq(0).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(1).addClass('on');
	}
	$(".layerpop-box").removeClass("open");
	$('#stat_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
	allValidate();
  	initCLNDR();
	initSetDay();
	initSetState();
	if (strDate != null && strDate != '') {
		$("#reserveDate").html("예약일시 : <strong>"+formatDay(strDate,10)+"("+getInputDayLabel(strDate)+")" + "~" + formatDay(endDate,10)+"("+getInputDayLabel(endDate)+")</strong>");
	}else{
	$("#reserveDate").html("예약일시 : <strong>"+formatDay(_today,10)+"("+getInputDayLabel(_today)+")</strong>");
	}
	$("#inputArea").hide();
});

function choice02(pickDate){
	$("#reserveDate").html("예약일시 : <strong>"+formatDay(pickDate,10)+"("+getInputDayLabel(pickDate)+")</strong>");
	$("#inputArea").show();
	$("#prevPickP").hide();
	changeList(pickDate);
	
}

function changeList(useDate){
	$("#reservationCol").remove();
	$("#reservationTh").remove();
	var gubun = "${gubun}";
	$.post( "/admin/forest/changeList",{useDate:useDate,gubun:gubun}, function(result) {
		var html = jQuery('<table>').html(result);
			//var contents = html.find("tbody#listBodyAjax > tr").html();
			var contents = html.find("tbody#listBodyAjax tr").each(function(i){
			});
				$("#listbody").html(contents);
	}).fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
	
}

function updateStat(seq,cnt,useDate,entryTime,mobile,name,insertDate,obj){
	useDate = useDate.replace("년 ","-");
	useDate = useDate.replace("월 ","-");
	useDate = useDate.replace("일","");
	useDate = useDate.trim();
// 	console.log("useDate : " + useDate);

	var stat = $(obj).val()=="a"?"신청":$(obj).val()=="b"?"승인":"취소";

	$('#useDate').val(useDate);
	var gubun = '${gubun}'
	var time = "";
// 	if ($(obj).val() == 'b') {
	if ($(obj).val() != 'a') {
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
		txt1 = name +"님\n" + useDate+ " " + time + "\n유아숲체험 신청이 " + stat + "되었습니다. \n신청일시 : " + insertDate + (stat == "취소" ? "" : ("\n예약번호 : " + seq + "입니다."));
		txt2 = name +"님\n" + useDate+ " " + time + "\n숲해설 신청이 " + stat + "되었습니다. \n신청일시 : " + insertDate + (stat == "취소" ? "" : ("\n예약번호 : " + seq + "입니다."));
		if (gubun == 'e') {
			smsMsg = txt1;
		}else{
			smsMsg = txt2;
		}
	}
	
	var flag = confirm("상태값을 "+stat+"로 변경하시겠습니까?");
	$('#mobile').val(mobile);
	$('#dseq').val(seq);
	$('#stat').val($(obj).val());
	if(flag){
		$.ajax({
    	    url : "/admin/forest/forest_stat_update"
    	    , data: {seq:seq,stat:$(obj).val(),useDate:useDate,cnt:cnt}
    	    , type: 'post'
    	    , dataType: 'json'
    	    , success : function (data) {
    	    	if(data != 0){
    	    		alert("변경 완료 되었습니다.");
    	    			sendSms();
    	    	}else{
    	    		alert("변경 실패하였습니다.");
    	    		/* location.reload(); */
    	    	}
    	    }, error : function () {
    	    	alert('error');
    	    }
    	});
	}else{
		location.reload();
	}
}

function sendSms(){
	var stat = $('#stat').val();
	
	var _title = "";
	
	if(stat == 'a') {
		_title = "유아숲/해설 신청문자";
	} else if(stat == 'b'){
		_title = "유아숲/해설 승인문자";
	} else if (stat = "a") {
		_title = "유아숲/해설 취소문자";
	}
	
// 	if (stat == 'b') {
		var stringByteLength = getStringLength(smsMsg);
		console.log(stringByteLength + " Bytes");
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
		$.post( "/admin/forest/sendSms",$("#smsFrm").serialize(), function(result) {
			
		}).fail(function(response) {
			console.log('Error: ' + response.responseText);
		});
// 	}
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

function search(){
	var gubun = '${gubun}'
	$("#searchFrm").attr("action","/admin/forest/forest_rental?gubun="+gubun);
	$("#searchFrm").submit();
}

function excelDownload(){
	var form = document.getElementById("searchFrm");
	var input = document.createElement('input');
	input.type ='hidden';
	input.name = 'gubun';
	input.value = '${gubun}';
	form.appendChild(input);
	$("#searchFrm").attr("action","/admin/forest/forest_rental/excel");	
	$("#searchFrm").submit();
}

$(".layerpopup .btn_close").on("click", function () {
	$(".layerpop-box").removeClass("open");
	$('html').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제
});

function moveWrite() {
	$(".layerpop-box").addClass("open");
	$('html').css({'overflow': 'hidden', 'height': '100%'}); //scroll hidden 해제
}

function insert(){
	var gubun=$('#gubun').val();
	var useDate = $('#adminUseDate').val();
	var regNumber = /^[0-9]*$/;
	
	if (useDate == '') {
		alert("날짜를 선택해주세요.");
		$('#adminUseDate').focus();
		return;
	}
	
	var entryTime = $('#entryTime option:selected').val() != undefined? $('#entryTime option:selected').val():'';
	console.log(entryTime);
	if (entryTime == '') {
		alert('시간을 선택해주세요.');
		return;
	}

	var cnt=$("#cnt").val();
    if(!regNumber.test(cnt)){
        alert('숫자만 입력하세요');
        $("#cnt").focus();
        return;
    }
    if (gubun == 'e') {
		if (cnt < 3) {
			alert('인원은 3명 이상 부터 신청 가능합니다.');
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
    
	var name=$("#name").val();
	if (name == '' && name.trim() == '') {
		alert('이름을 입력해주세요.');
		$("#name").focus();
		return;
	}
	var mobile1=$("#mobile1").val();
	var mobile2=$("#mobile2").val();
	var mobile3=$("#mobile3").val();
    
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
	
    
/* 	var teamName=$("#teamName").val();
	if (teamName == '' && teamName.trim() == '') {
		alert('단체 / 기관 명을 입력해주세요.');
		$("#teamName").focus();
		return;
	} */

	if(confirm("예약 하시겠습니까?")){
		
		$.post( "/program/checkDayCloseForest",{"useDate":useDate,"gubun":gubun}, function(result) {					
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
					$.post( "/admin/forest/insertForestExperienceAdmin",$("#insertFrm").serialize(), function(result) {
						var ret = result.result;
						var dSeq = result.dSeq;
						
						if(ret==1){
							alert("예약신청이 완료 되었습니다.");
							
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
							
						    $("#stat").val('a');
						    $("#mobile").val(mobile);
							smsMsg = "예약자 : "+name +"님\n 예약날짜 : " + useDate+ " " + time + "\n예약인원 : " + cnt + "명\n유아숲체험 신청 하였습니다.";
							sendSms();
							
							location.reload();
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
