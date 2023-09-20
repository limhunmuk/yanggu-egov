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
        <c:import url="/WEB-INF/views/admin/common/left_rental.jsp">
            <c:param name="menuOn" value="4" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javascript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>용늪신청 관리</h3>
				</div>
				<div class="list">
					<div class="cnt_wrap2">
						<div class="left_menu">
						
							<div class="calendar_box2  pj2"></div>
							
							<div class="date_info">
								<p id="tip">이용신청 - 방문일로부터 최소 <c:out value="${settingMap.deadline}" />일전 인터넷 선착순 접수 / 총 신청인원 하루 100명 이내입니다</p>
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
								<p class="tit_box" id = "reserveDate"><i></i></p>
								<!-- 날싸 선택전 표시-->
								<p id="prevPickP" class="strong_txt"><i></i>수정일을 선택해주세요</p>
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
								</div>
							</div>
						</form>
					</div>
					

					<p class="tit mt40">예약제한 및 휴장 월 관리</p>
					<form id="tmpFrm01">
						<div class="write">
		   					<table>
		                        <caption>예약제한 및 휴장 월 관리</caption>
		   						<colgroup>
		   							<col style="width:15%;">
		   							<col style="width:85%;">
		   						</colgroup>
		   						<tr>
		   							<th scope="row">예약제한(현재일부터) <span class="ast">&#42;</span></th>
		   							<td>
		   								<input type="text" title="예약제한일 수" id="deadline" name="deadline" value="${settingMap.deadline}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		   							</td>
		   						</tr>
		                            <tr>
		                                <th scope="row">휴장 월 기간 설정 <span class="ast">&#42;</span></th>
		                                <td>
		                                    <input type="checkbox" title="1월" id="month01" name="month01" value="Y" <c:if test="${settingMap.month01 eq 'Y'}">checked</c:if>>
		                                    <label for="month01" class="radio_label">1월</label>
		                                    <input type="checkbox" title="2월" id="month02" name="month02" value="Y" <c:if test="${settingMap.month02 eq 'Y'}">checked</c:if>>
		                                    <label for="month02" class="radio_label">2월</label>
		                                    <input type="checkbox" title="3월" id="month03" name="month03" value="Y" <c:if test="${settingMap.month03 eq 'Y'}">checked</c:if>>
		                                    <label for="month03" class="radio_label">3월</label>
		                                    <input type="checkbox" title="4월" id="month04" name="month04" value="Y" <c:if test="${settingMap.month04 eq 'Y'}">checked</c:if>>
		                                    <label for="month04" class="radio_label">4월</label>
		                                    <input type="checkbox" title="5월" id="month05" name="month05" value="Y" <c:if test="${settingMap.month05 eq 'Y'}">checked</c:if>>
		                                    <label for="month05" class="radio_label">5월</label>
		                                    <input type="checkbox" title="6월" id="month06" name="month06" value="Y" <c:if test="${settingMap.month06 eq 'Y'}">checked</c:if>>
		                                    <label for="month06" class="radio_label">6월</label>
		                                    <input type="checkbox" title="7월" id="month07" name="month07" value="Y" <c:if test="${settingMap.month07 eq 'Y'}">checked</c:if>>
		                                    <label for="month07" class="radio_label">7월</label>
		                                    <input type="checkbox" title="8월" id="month08" name="month08" value="Y" <c:if test="${settingMap.month08 eq 'Y'}">checked</c:if>>
		                                    <label for="month08" class="radio_label">8월</label>
		                                    <input type="checkbox" title="9월" id="month09" name="month09" value="Y" <c:if test="${settingMap.month09 eq 'Y'}">checked</c:if>>
		                                    <label for="month09" class="radio_label">9월</label>
		                                    <input type="checkbox" title="10월" id="month10" name="month10" value="Y" <c:if test="${settingMap.month10 eq 'Y'}">checked</c:if>>
		                                    <label for="month10" class="radio_label">10월</label>
		                                    <input type="checkbox" title="11월" id="month11" name="month11" value="Y" <c:if test="${settingMap.month11 eq 'Y'}">checked</c:if>>
		                                    <label for="month11" class="radio_label">11월</label>
		                                    <input type="checkbox" title="12월" id="month12" name="month12" value="Y" <c:if test="${settingMap.month12 eq 'Y'}">checked</c:if>>
		                                    <label for="month12" class="radio_label">12월</label>
		                                </td>
		                            </tr>
		   					</table>
							<div class="btn_area m_c2">
								<button type="button" class="btn"onclick="add_fSettingInsert();">설정 저장</button>
							</div>
						</div>
					</form>
					
					<p class="tit mt40">휴장 일 관리</p>
					<form id="tmpFrm02">
						<div class="write">
		   					<table>
								<caption>휴장 일 관리</caption>
		   						<colgroup>
		   							<col style="width:15%;">
		   							<col style="width:85%;">
		   						</colgroup>
								<tr>
		   							<th scope="row">휴장일 범위 <span class="ast">&#42;</span></th>
									<td>
										<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="idle_date ico_date" id="sdate" name="sdate" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
										<span class="hypen">~</span>
										<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="idle_date ico_date" id="edate" name="edate" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
									</td>
								</tr>
								<tr>
		   							<th scope="row">휴장일 <span class="ast">&#42;</span></th>
								    <td id="addIdleDate">
										<!-- <div>2019-08-08 ~ 2019-08-08<button type="button" class="h_day_del">X</button></div> -->
									</td>
								</tr>
		   					</table>
							<div class="btn_area m_c2">
								<button type="button" class="btn"onclick="add_idelDate();">휴장일 추가</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

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
<script src="/ad_CLNDR/js/underscore-min.js?v=2020"></script>
<script src="/ad_CLNDR/js/moment.min.js?v=2020"></script>
<script src="/ad_CLNDR/js/clndr.js?v=2020"></script>
<script src="/ad_js/cust/rentalSetting.js?v=2020"></script>	
<script src="/js/common.min.js?v=2020"></script>	 
<script>

$(function(){
	var subMenuNo = '${subMenuNo}'
	$('#gnb ul li').eq(1).addClass('on');
	$('#lnb ul.menu > li').eq(3).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(2).addClass('on');
	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
	
	allValidate();
  	initCLNDR();
	initSetDay();
	initSetState();
	getCloseDateList();
	$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
	$("#inputArea").hide();
});

function choice02(pickDate){
	$("#reserveDate").html("<i></i>"+formatDay(pickDate,9)+"("+getInputDayLabel(pickDate)+")");
	$("#inputArea").show();
	$("#prevPickP").hide();
}

function saveACnt(){
	var aCnt = $("#saveCnt").val();
    var regNumber = /^[0-9]*$/;
    if(!regNumber.test(aCnt))
    {
        alert('숫자만 입력하세요');
        $("#saveCnt").focus();
        return;
    }
    
    if(aCnt>100){
        alert('참가인원은 100명을 초과할 수 없습니다.');
        $("#saveCnt").focus();
        return;
    }

	if(confirm("저장 하시겠습니까?")){
		$.post( "/admin/setting/aCntUpdate",$("#frm").serialize(), function(result) {
			if(result==0){
				alert("참여인원 수정 완료되었습니다.");
				initSetDayState();
			}else if(result==-1){
			   alert("현재 신청자수 이하로 수정할 수 없습니다.");
			   return;
			}else if(result==-3){
				   alert("권한이 없습니다.");
				   return;
			}else{
			   alert("참여인원 수정 실패했습니다.");
			   return;
			}
		}, "json").fail(function(response) {
			alert('Error: ' + response.responseText);
		});
	}
}


function getCloseDateList(){
	$.ajax({
	    url : '/admin/setting/getCloseDateList'
	    ,data:{}
	    , type: 'post'
	    , timeout: 10000
	    , dataType: 'json'
	    , success : function (data) {
	    	var str="<div>";
	    	for(var i=0;i<data.length;i++){
	    		str+= data[i]['iDate']+'<button type="button" class="typeIdle h_day_del" onclick="delIdelDate(\''+data[i]['iDate']+'\');">X</button>';
	    	}
	    	str+="</div>";
	    	$("#addIdleDate").html(str);
	    }
	    , error : function (jqXHR, textStatus, errorThrown) {
			alert('ERRORS: ' + textStatus);
		}
	});
}

function add_idelDate(){	
	if ($("#sdate").val() == "") {
		alert("휴장일 시작날짜를 입력해 주세요.");
		$("#sdate").focus();
		return;
	}
	if ($("#edate").val() == "") {
		alert("휴장일 종료날짜를 입력해 주세요.");
		$("#edate").focus();
		return;
	}
	if($("#sdate").val()>$("#edate").val()){
		alert("휴장일 종료날짜를 다시 확인해 주세요.");
		$("#edate").focus();
		return;
	}
		
	$.post( "/admin/setting/idleDateInsert", $("#tmpFrm02").serialize() , function(result) {
		console.log("result : "+result);
		if(result>=0) {
				$("#sdate").val("");
				$("#edate").val("");
				getCloseDateList();
				initSetDayState();
		}else if(result==-1){
			alert('이미 등록된 휴장일입니다.');
			return;
		}else if(result==-3){
			alert("권한이 없습니다.");
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}

function delIdelDate(iDate){
	if(confirm(iDate+" 휴장일을 삭제하겠습니까?")){
		$.post( "/admin/setting/idleDateDelete", "iDate="+iDate , function(result) {
			if(result == 1) {
				alert("삭제되었습니다.");
				getCloseDateList();
				initSetDayState();
			}else if(result==-3){
				alert("권한이 없습니다.");
				return;
			}else {
				alert('삭제 실패했습니다.');
			}
		}, "json").fail(function(response) {
			console.log('Error: ' + response.responseText);
		});
	}
}

function add_fSettingInsert(){	
	if ($("#deadline").val() == "") {
		$("#deadline").val(0);
	}
		
	$.post( "/admin/setting/fSettingInsert", $("#tmpFrm01").serialize() , function(result) {
		console.log("result : "+result);
		if(result>=0) {
				alert('설정 저장이 완료되었습니다.');
				_deadline=$("#deadline").val();
				$("#tip").text("이용신청 - "+_deadline+"일전 부터 인터넷 선착순 접수 / 총 신청인원 하루 100명 이내입니다");
				if($("input:checkbox[name=month01]").is(":checked") == true) { _month01="Y" }else{ _month01="N" }
				if($("input:checkbox[name=month02]").is(":checked") == true) { _month02="Y" }else{ _month02="N" }
				if($("input:checkbox[name=month03]").is(":checked") == true) { _month03="Y" }else{ _month03="N" }
				if($("input:checkbox[name=month04]").is(":checked") == true) { _month04="Y" }else{ _month04="N" }
				if($("input:checkbox[name=month05]").is(":checked") == true) { _month05="Y" }else{ _month05="N" }
				if($("input:checkbox[name=month06]").is(":checked") == true) { _month06="Y" }else{ _month06="N" }
				if($("input:checkbox[name=month07]").is(":checked") == true) { _month07="Y" }else{ _month07="N" }
				if($("input:checkbox[name=month08]").is(":checked") == true) { _month08="Y" }else{ _month08="N" }
				if($("input:checkbox[name=month09]").is(":checked") == true) { _month09="Y" }else{ _month09="N" }
				if($("input:checkbox[name=month10]").is(":checked") == true) { _month10="Y" }else{ _month10="N" }
				if($("input:checkbox[name=month11]").is(":checked") == true) { _month11="Y" }else{ _month11="N" }
				if($("input:checkbox[name=month12]").is(":checked") == true) { _month12="Y" }else{ _month12="N" }
				getCloseDateList();
				initSetDayState();
		}else if(result==-1){
			alert('등록중 에러가 발생하였습니다.');
			return;
		}else if(result==-3){
			alert("권한이 없습니다.");
			return;
		}
	}, "json").fail(function(response) {
		console.log('Error: ' + response.responseText);
	});
}
</script>
</body>
</html>
