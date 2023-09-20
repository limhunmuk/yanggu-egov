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
            <c:param name="menuOn" value="1" />
        </c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list">
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
								<p class="tit_box" id = "reserveDate"><i></i></p>
								<!-- 날싸 선택전 표시-->
								<p id="prevPickP" class="strong_txt"><i></i>예약일을 선택해주세요</p>
								<div class="date_result" style="display: none" id="inputArea">
									<div class="dl_chk" id="reserveInfo" style="display: block;">
										<dl class="c1">
											<dt>예약자명</dt>
											<dd>
												<input type="text" name="name" id="name">
												<label for="name" class="blind">예약자명</label>
											</dd>
										</dl>
										<dl class="c1">
											<dt>전화번호 <em class="small_txt">(연락가능한 번호를 입력해주세요)</em></dt>
											<dd>
												<div class="tel_area">
													<input type="text" name="mobile1" id="mobile1">
													<label for="mobile1" class="blind">전화번호1</label>
													<input type="text" name="mobile2" id="mobile2">
													<label for="mobile2" class="blind">전화번호2</label>
													<input type="text" name="mobile3" id="mobile3" class="last">
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
												<input type="text" name="teamName" id="teamName">
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
<script src="/ad_CLNDR/js/underscore-min.js?v=2023"></script>
<script src="/ad_CLNDR/js/moment.min.js?v=2023"></script>
<script src="/ad_CLNDR/js/clndr.js?v=2023"></script>
<script src="/ad_js/cust/rentalWrite.js?v=2023"></script>
<script src="/js/common.min.js?v=2023"></script>
<script>

$(function(){

	var subMenuNo = '${subMenuNo}';
	$('#gnb ul li').eq(1).addClass('on');
	$('#lnb ul.menu > li').eq(0).find(' > a ').addClass('skin_bg').next().show().find('>li').eq(subMenuNo).addClass('on');
	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
	
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

	if(confirm("예약 하시겠습니까?!!")){
		
		$.post( "/admin/rental/checkDayClose","date="+_pick_dt , function(result) {
			var ret = result.result.ret;
			var rcnt = result.result.cnt;
			if(ret==0){
				
				if((100-rcnt)>=cnt){
					$.post( "/admin/rental/insertDragonReserve", $("#frm").serialize(), function(result) {
						var ret = result.result;
						var dSeq = result.result.dSeq;
						console.log("ret : "+ret);
						console.log("dSeq : "+dSeq);
						if(ret==1){
							alert("예약신청이 완료 되었습니다.");
							location.replace('/admin/rental/rentalList?subMenuNo=2');
							return;
						}else{
						   alert("예약신청이 실패하였습니다.");
						   return;
						}		
					}, "json").fail(function(response) {
						alert('Error: ' + response.responseText);
					});
					
				}else{
					if(rcnt<100){
						$('#reserve_'+_pick_dt).html('<p class="txt"><strong>'+(100-rcnt)+'</strong>명 예약가능</p><span class=\"reserve\">예약가능</span>');	
					}else{
						$('#reserve_'+_pick_dt).html('<span class=\"reserve finish\">예약마감</span>');
						$('#td-'+_pick_dt).css("cursor","");
						$('#td-'+_pick_dt).attr("data-old","1");
					}
				   alert("예약가능 인원이 초과 되었습니다.");
				   return;
				}
			}else if(ret<0){
			   alert("예약가능 인원이 초과 되었습니다.");
			   return;
			}		
		}, "json").fail(function(response) {
			alert('Error1: ' + response.responseText);
		});
	}
}
</script>
</body>
</html>
