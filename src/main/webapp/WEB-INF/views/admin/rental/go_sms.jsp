<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
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
				<div class="list_tit">
					<h3>SMS 발송</h3>
				</div>
				<div class="list"> 
					<div class="search_wrap">
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:100%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">분류</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="7">
										<input type="radio" id="1" name="smsStat" checked="checked" onchange="pick(1);">
										<label for="1">대암산용늪 허가문자(통문 닫힘)</label>
										<input type="radio" id="2" name="smsStat" onchange="pick(2);">
										<label for="2">대암산용늪 허가문자(통문 열림)</label>
										<input type="radio" id="3" name="smsStat" onchange="pick(3);">
										<label for="3">용늪안내 문자</label>
									</td>
								</tr>
								<tr>
									<td colspan="7">
										<textarea rows="20" cols="20" style="width: 80%; height: 80%;" id="smsTxt" name="smsTxt">
										</textarea>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="write_btn align_r mt35">
							<button type="button" onclick="location.href='/admin/rental/rentalList'" class="btn_list">목록</button>
							<button type="button" class="btn_modify" onclick="sandSms();">발송</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="frm" name="frm" action="/admin/rental/sendSms" method="post">
	<input type="hidden" id="msg" name="msg">
	<input type="hidden" id="title" name="title">
	<input type="hidden" id="rphone" name="rphone" value="${rphone}">
	<input type="hidden" id="dseq" name="dseq" value="${dseq}">
	<input type="hidden" id="smsType" name="smsType" value="S">
</form>
<script>

$(function(){
	$('#gnb ul li').eq(1).addClass('on');
	$('#status_00').on('change', function () {
		$('[name="stat"]').prop('checked', $(this).prop('checked'));
	});
});

var txt1 = "안녕하세요.\n양구군청 대암산용늪출입허가 담당자 엄진영입니다.\n대암산용늪 출입신청 허가가 완료되어 알려드립니다.\n\n※천재지변으로 출입당일 대암산용늪 탐방이 취소 될 수 있습니다※\n\n*16인승이상 버스로 방문 시 지정장소(집결장소 통과 후 2.5km구간)\n꼭 주차하시고 3.9km도보로 이동하셔야 합니다.\n\n출입 당일 지참서류는\n1.보안서약서(출입자 전원 1인당1부씩 자필서명)\n2.신분증(출입자전원) 같이 가져오시면 됩니다.\n\n집결장소는 강원도 양구군 동면 팔랑리 215-6번지\n오전 9시30분까지 늦지 않게 도착하시기 바랍니다.(해설사 대기)\n1시간정도 도보로 이동해야합니다.\n간단한식사(김밥)는 지정장소에서만 드실 수 있습니다.(가아리주차장내)\n\n더 궁금하신 내용 있으시면 033-480-7393 연락주세요";
var txt2 = "안녕하세요.\n양구군청 대암산용늪출입허가 담당자 엄진영입니다.\n대암산용늪 출입신청 허가가 완료되어 알려드립니다.\n\n※천재지변으로 출입당일 대암산용늪 탐방이 취소 될 수 있습니다※\n\n*16인승이상 버스로 방문 시 지정장소(집결장소 통과 후 2.5km구간 전봇대번호 66번~67번사이)꼭 주차하시고 3.9km 위병소까지 도보로 이동하셔야 합니다.\n개인차량으로 오시는분들은 위병소까지 오시면 됩니다.\n출입 당일 지참서류는\n1.보안서약서(출입자 전원 1인당1부씩 자필서명)\n2.신분증(출입자전원) 같이 가져오시면 됩니다.\n\n■집결장소는 강원도 양구군 동면 팔랑리 215-6번지(주변 정자각 야외화장실 있음)에서\n승용차로 오시는경우 용늪가는길로 6.4km 선점소대 위병소까지 오셔야합니다. (오전 10시까지)\n버스로 오시는분들은 집결장소로(오전 8시30분까지) 3.9km(1시간정도)걷는걸 감안하여 늦지않게 도착할 수 있도록 부탁드립니다.\n간단한식사(김밥)는 지정장소에서만 드실 수 있습니다.(가아리주차장내)\n더 궁금하신 내용 있으시면 033-480-7393 연락주세요.";
var txt3 = "안녕하세요.\n양구군청 대암산용늪출입허가 담당자 엄진영입니다.\n미 제출된 서류가 있어 알려드립니다.\n1. 공개제한 출입허가 신청서\n2. 인적사항(차량번호 기입)\n신청서류 양식은 양구수목원 홈페이지 대암산용늪 출입신청란에 다운로드\n작성하여 메일( ujy4525@korea.kr)로 보내주셔야 예약완료입니다.\n더 궁금하신 내용 있으시면 033-480-7393 연락주세요.";
var _title = "대암산용늪 허가문자(통문 닫힘)";
var _msg = "";
$(function(){
	$("#smsTxt").text(txt1);
})

function pick(kind){
	if(kind==1){
		$("#smsTxt").text(txt1);	
		_title = "대암산용늪 허가문자(통문 닫힘)";
		_msg = txt1;
	}else if(kind==2){
		$("#smsTxt").text(txt2);	
		_title = "대암산용늪 허가문자(통문 열림)";
		_msg = txt2;
	}else if(kind==3){
		$("#smsTxt").text(txt3);	
		_title = "용늪안내 문자";
		_msg = txt3;
	}
	
};

function sandSms(){
	_msg = $("textarea#smsTxt").val();
	
	var stringByteLength = getStringLength(_msg);
	console.log(stringByteLength + " Bytes");
	if(stringByteLength>2000){
		alert("문자 길이는 2000 byte를 넘을 수 없습니다.");
		return;
	}else if(stringByteLength<91){
		$("#smsType").val("S");
	}else{
		$("#smsType").val("L");
	}
	$("#msg").val(_msg);
	$("#title").val(_title);
	$("#frm").submit();
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
</body>
</html>
