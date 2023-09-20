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
					<h3>프로그램 관리</h3>
				</div>
				<div class="list">
					<form id="frm">
						<div class="write">
		   					<table>
								<caption>프로그램 관리</caption>
		   						<colgroup>
		   							<col style="width:15%;">
		   							<col style="width:85%;">
		   						</colgroup>
								<tr>
									<th scope="row">구분  <span class="ast">&#42;</span></th>
									<td>
										<select style="width:200px;" name="gubun" id="gubun">
											<option value="e">유아숲체험</option>
											<option value="f">숲 해설</option>
										</select>
									</td>
								</tr>
								<tr>
		   							<th scope="row">접수기간 <span class="ast">&#42;</span></th>
									<td>
										<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="idle_date ico_date" id="startDate" name="startDate" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" autocomplete="off">
										<select style="width:100px;" name="sTime">
											<c:forEach var="i" begin="0" end="23">
												<c:set value="${i>9?i:'0'}${i>9?'':i}" var="sTimeEq"/>
												<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}시</option>
											</c:forEach>
										</select>
										<span class="hypen">~</span>
										<input type="text" title="종료일" placeholder="YYYY-MM-DD" class="idle_date ico_date" id="endDate" name="endDate" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" autocomplete="off">
										<select style="width:100px;" name="eTime">
											<c:forEach var="i" begin="0" end="23">
												<c:set value="${i>9?i:'0'}${i>9?'':i}" var="eTimeEq"/>
												<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}시</option>
											</c:forEach>
										</select>
										<div id="oldOpenDate">
										</div>
									</td>
								</tr>
								<tr>
		   							<th scope="row">휴장일 <span class="ast">&#42;</span></th>
								    <td id="addIdleDate" class="addIdleDate">
										<input type="text" title="시작일" placeholder="YYYY-MM-DD" class="idle_date ico_date" id="iDate" name="iDate" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
										<button type="button" class="btn" onclick="add_idelDate();">+휴장일추가</button>
										<div id="addIdate">
										</div>
									</td>
								</tr>
		   					</table>
							<div class="btn_area align_r">
								<button type="button" class="btn"onclick="add_openDateInsert();">등록</button>
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
	$('#gnb ul li').eq(2).addClass('on');
	$('#lnb ul.menu > li').eq(1).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(0).addClass('on');

	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
	
	allValidate();
	getCloseDateList($('#gubun option:selected').val());
	getOpenDate($('#gubun option:selected').val());
	$("#reserveDate").html("<i></i>"+formatDay(_today,9)+"("+getInputDayLabel(_today)+")");
	$("#inputArea").hide();
});

$('#gubun').change(function(){
	$('#startDate').val("");
	$('#endDate').val("");
	getCloseDateList($('#gubun option:selected').val());
	getOpenDate($('#gubun option:selected').val());
})

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


function getCloseDateList(gubun){
	$.ajax({
	    url : '/admin/forest/getCloseDateList'
	    ,data:{gubun:gubun}
	    , type: 'post'
	    , timeout: 10000
	    , dataType: 'json'
	    , success : function (data) {
	    	var str="";
	    	for(var i=0;i<data.length;i++){
	    		str+= data[i]['iDate']+'<button type="button" class="typeIdle h_day_del" onclick="delIdelDate(\''+data[i]['iDate']+'\');">X</button>';
	    	}
	    	$("#addIdate").html(str);
	    }
	    , error : function (jqXHR, textStatus, errorThrown) {
			alert('ERRORS: ' + textStatus);
		}
	});
}

function getOpenDate(gubun){
	$("#oldOpenDate").html("");
	$.ajax({
	    url : '/admin/forest/getOpenDate'
	    ,data:{gubun:gubun}
	    , type: 'post'
	    , timeout: 10000
	    , dataType: 'json'
	    , success : function (data) {
	    	console.log("data : " + data);
	    	var str="";
	    		str+= '현재 오픈일 : '+data['startDate']+'시'+ ' ~ ' + data['endDate']+'시';
	    	$("#oldOpenDate").html(str);
	    }
	    , error : function (jqXHR, textStatus, errorThrown) {
	    	//alert('ERRORS: ' + textStatus);
	    	//$("#oldOpenDate").remove();
		}
	});
}

function add_idelDate(){	
	var iDate = $('#iDate').val();
	
	if (iDate == "") {
		alert("휴장일을 입력해 주세요.");
		$("#iDate").focus();
		return;
	}
	
	var gubun = $('#gubun option:selected').val();
	var oldIdate = $('#addIdate').text();
		if (oldIdate.includes(iDate)) {
			alert("이미 등록된 휴장일입니다.");
			return;
		}
	$.post( "/admin/forest/iDateInsert", {iDate:iDate,gubun:gubun} , function(result) {
		console.log("result : "+result);
		if(result>=0) {
				$("#iDate").val("");
				getCloseDateList($('#gubun option:selected').val());
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
		$.post( "/admin/forest/iDateDelete", {iDate:iDate,gubun:$('#gubun option:selected').val()} , function(result) {
			if(result == 1) {
				alert("삭제되었습니다.");
				getCloseDateList($('#gubun option:selected').val());
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

function add_openDateInsert(){	
	  var start = document.getElementById('startDate').value;  //시작 날짜
	  var startYyyy = start.substring(0,4);
	  var startmm = start.substring(5,7);
	  var startDd = start.substring(8,10);
	  var startDate = new Date(startYyyy, startmm, startDd);

	  var end = document.getElementById('endDate').value;  //시작 날짜
	  var endYyyy = end.substring(0,4);
	  var endmm = end.substring(5,7);
	  var endDd = end.substring(8,10);
	  var endDate = new Date(endYyyy, endmm, endDd);
	  
	  var now = new Date();         //현재 날짜
	  var nowYyyy = now.getFullYear();
	  var nowmm = now.getMonth() + 1;       //1월 == 0
	  var nowDd = now.getDate();
	  var nowDate = new Date(nowYyyy, nowmm, nowDd); 
	  console.log(nowDate);
	  
	  if (start == '') {
			alert("시작일을 입력해 주세요.");
			$('#startDate').focus();
			return;
		}
	  
	  if (end == '') {
			alert("종료일을 입력해 주세요.");
			$('#endDate').focus();
			return;
		}
	  //시작일이 종료일보다 클 수 없도록
	  if( startDate.getTime() > endDate.getTime() ){
	   		alert("시작일이 종료일보다 클 수 없습니다.");
	   		$('#startDate').focus();
	   		return;
	  }
	  
	/*   //종료일이 현재날짜보다 클 수 없도록
	  if( endDate.getTime() > nowDate.getTime() ){
	   		alert("종료일이 현재일보다 클 수 없다.");
	   		$('#endDate').focus();
	  	 	return;
	  } */
		
	$.post( "/admin/forest/openDate", $("#frm").serialize() , function(result) {
		console.log("result : "+result);
		if(result>=0) {
				alert('설정 저장이 완료되었습니다.');
				getOpenDate($('#gubun option:selected').val());
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
