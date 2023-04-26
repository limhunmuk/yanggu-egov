<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/header.jsp"%>
</head>
<body>
	<div id="skipNav"><a href="#contents">본문 바로가기</a></div>
	<hr>
	<!-- wrap -->
	<div class="wrap">	
		<%@ include file="../inc/gnb.jsp"%>
		<div class="sub_visual bg08">
			<h2>예약확인</h2>
		</div>
		<div class="contents sub_content top">
			<div class="inner2">
				<div class="result_text03 fr"> 
					<div class="txt_area">
						<p class="be">예약정보</p>
						<span class="box">예약번호는 <em class="c_red">${one.seq}</em> 신청일시는 <em class="c_main">${one.insertDate }</em> 입니다.</span>
					</div>
				</div>
				<p class="enroll_tit">프로그램 신청 정보</p>
				<div class="table_wrap m_row for_m_reservation_write">
					<table>
						<caption>결제 정보 확인 목록으로 정보를 최종 결제금액, 결제수단 목록으로 표시합니다. </caption>
						<colgroup>
							<col style="width: 300px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">예약자명</th>
								<td> <c:out value="${one.name }"/></td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td>
									<c:out value="${one.phone }"/>
								</td>
							</tr>
							<tr>
								<th scope="row">이용일</th>
								<td>
									<c:out value="${one.useDate }"/>
									<c:choose>
										<c:when test="${one.entryTime == 1}">
											오전 10:00 ~ 11:30
										</c:when>
										<c:when test="${one.entryTime == 2 }">
											<c:choose>
												<c:when test="${gubun == 'f' }">
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
							</tr>
							<tr>
								<th scope="row">참여인원<em class="small_txt">(참여자수)</em></th>
								<td>
									<c:out value="${one.cnt }명"/>
								</td>
							</tr>
						<c:if test="${gubun =='o'}">
							<tr>
								<th scope="row">단체기관명</th>
								<td>
									<c:out value="${one.teamName }"/>
								</td>
							</tr>
						</c:if>
							<tr>
								<th scope="row">비고</th>
								<td>${one.remark }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<p class="c_main">※ 당일예약 취소는 033-480-2530(유아숲/숲해설 사무실 전화번호)로 문의 부탁드립니다.</p>
			<div class="btn_area m_c2">
				 <a href="/main/reservation_write" class="btn">확인</a>
				 <button type="button" onclick="cancelReservation();" class="btn">예약취소</button>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<%-- sms 발송 사용시 주석 해체 --%>
	<%-- <form id="smsFrm" action="../program/forest/sendSms" method="post">
		<input type="hidden" id="gubun" name="gubun" value="${gubun}">
		<input type="hidden" id="dseq" name="dseq" >
		<input type="hidden" id="msg" name="msg">
		<input type="hidden" id="title" name="title">
		<input type="hidden" id="mobile" name="mobile">
		<input type="hidden" id="smsType" name="smsType" value="S">
	</form> --%>
	<!-- //wrap -->
	<script>
		var gubun = "${gubun}"
		var difDate = "${one.difDate}";
		function cancelReservation(){
			if(gubun == 'o'){	
				if(difDate>20){
					if(confirm('예약을 취소 하시겠습니까?')){
						$.post( "/main/cancelReserve",{seq:"${one.seq}",gubun:gubun}, function(result) {
							var ret = result.result;
							if(ret==1){
								alert("예약취소가 완료 되었습니다.");
								location.replace('/main/reservation_write');
								return;
							}else{
							   alert("예약취소가 실패하였습니다.");
							   return;
							}		
						}, "json").fail(function(response) {
							console.log('Error: ' + response.responseText);
						});
					}	
				}else{
					alert("취소는 이용일 20일 전에 가능합니다.");
					return;
				}
			}else {
				if(difDate>=1){
					if(confirm('예약을 취소 하시겠습니까?')){
						$.post( "/main/cancelReserve",{seq:"${one.seq}",gubun:gubun}, function(result) {
							var ret = result.result;
							if(ret==1){
								alert("예약취소가 완료 되었습니다.");
// 								sendSms();
								location.replace('/main/reservation_write');
								return;
							}else{
							   alert("예약취소가 실패하였습니다.");
							   return;
							}		
						}, "json").fail(function(response) {
							console.log('Error: ' + response.responseText);
						}); 
					}	
				}else{
					alert("취소는 이용일 1일 전까지 가능합니다.");
					return;
				}
			}
		}
		
		//sms 발송 사용 시 주석 해제
		/* function sendSms(){
			var _title = "유아숲/해설 취소문자";
			
			var entryTime = "${one.entryTime}";
			var gubun = "${one.gubun}";
			
			var time = "";
			if (entryTime == "1") {
				time = "오전 10:00 ~ 11:30";
			}else if (entryTime == "2") {
				if (gubun == 'f') {
					time = "오후 13:30 ~ 15:00";
				}else{
					time = "오후 14:00 ~ 15:30";
				}
			}else{
				time = "오후 15:30 ~ 17:00";
			}
			
			var smsMsg = "${one.name}님\n${one.useDate }" + " " + time + "\n" + (gubun == "e" ? "유아숲체험" : "숲해설") + " 신청이 취소되었습니다.\n신청일시 : ${one.insertDate}";
			
			var stringByteLength = getStringLength(smsMsg);
			if(stringByteLength>2000){
				alert("문자 길이는 2000 byte를 넘을 수 없습니다.");
				return;
			}else if(stringByteLength<91){
				$("#smsType").val("S");
			}else{
				$("#smsType").val("L");
			}
			
			var mobile = "${one.mobile}";
			if(mobile != "") {
				mobile = mobile.replace(/[^0-9]/g, "");
			}
				
			$("#msg").val(smsMsg);
			$("#title").val(_title);
			$("#dseq").val("${one.seq}");
			$("#mobile").val(mobile);
			$.post( "../program/forest/sendSms",$("#smsFrm").serialize(), function(result) {
				
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
		} */
	</script>
</body>
</html>
