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
		<div class="sub_visual bg06">
			<h2>체험프로그램</h2>
			<p><i class="home_i"></i><span>체험프로그램</span><span class="last">체험프로그램 신청</span></p>
		</div>
		<div class="contents sub_content top">
			<form action="/program/program_write_action" method="post">
				<div class="table_wrap for_m_program_reserv">
					<table>
						<caption>체험프로그램 신청목록으로 프로그램 선택, 예약자 명, 전화번호, 신청일, 비고를 목록으로 표시합니다. </caption>
						<colgroup>
							<col style="width: 300px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">프로그램명</th>
								<td>
									<c:out value="${product.title}"/>
									<input type="hidden" name="seq" value="${product.seq}"/>
									<!--
									<select id="search_kind" name="seq" class="w320" required> 
										<c:forEach items="${list }" var="item">
											<option value="${item.seq}"><c:out value="${item.title }"/></option>
										</c:forEach>
									</select>-->
								</td>
							</tr>
							<tr>
								<th scope="row">예약자 명</th>
								<td>
									<input type="text" name="name" id="name1" class="w320" required>
									<label for="name1" class="blind">예약자명</label>
								</td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td>
									<div class="tel_area2">
										<input type="text" name="mobile1" id="tel1" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3">
										<label for="tel1" class="blind">전화번호1</label>
										<input type="text" name="mobile2" id="tel2" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4">
										<label for="tel2" class="blind">전화번호2</label>
										<input type="text" name="mobile3" id="tel3" class="last" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4">
										<label for="tel3" class="blind">전화번호3</label>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">신청일</th>
								<td>
									 <input type="text" id="datepicker1" name="useDate" readonly required>
									 <label for="datepicker1el3" class="blind">달력</label>
								</td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td>
									<input type="text" name="remark" id="text1" required>
									<label for="text1" class="blind">비고</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="notice_box be_off">
					<p>
						<span class="tit">&lt; 개인정보 수집·활용 동의 및 필수항목 고지&gt;</span><br>
						개인정보의 수집 목적 : 아래 입력한 개인정보는 이용자 식별(본인확인), 교육운영에 대한 연락 및 안내, 교육효과 및 통계분석 활용을 위해 참고용으로 수집·활용됨 수집하는 개인정보의 항목 : 성명, 생년월일, 연락처, 거주지 메일정보 항목보유 및 이용 기간 : 3년간 보유 및 이용 이후 파기 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익의 내용 : 개인정보는 필수 입력 사항이며 동의하지 않을 시 글쓰기 제한
					</p>
				</div>
				<div class="chk_area alone">
					<input type="checkbox" id="join_chk03" required>
					<label for="join_chk03" class="chk">
						<i class="ico_chk"></i>
						위 사항에 대해 인지하고 입력항목에 대해 수집 및 활용에 동의합니다. <span class="small">(만 14세 미만의 아동의 경우 법정대리인(부모 등)의 동의를 받았음)</span>
					</label>
				</div>
				<div class="btn_area m_c2">
					 <button type="submit" class="btn">확인</button> 
				</div>
			</form>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
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
				minDate: new Date("${product.startDate}"),
				maxDate: new Date("${product.endDate}"),
				yearSuffix: '년',
				beforeShowDay: showDays
			  });

			  $(function() {
				$("#datepicker1, #datepicker2").datepicker();
			  });
			  
			//정원 완료된 날자 비활성화
			function showDays(date){
				var ableDays = ${product.ableDays};
	
				var year = date.getFullYear();
				var month = ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1);
				var day = (date.getDate() < 10 ? "0" : "") + date.getDate();
					  
				var ymd = year + '-' + month + '-' + day;
					  
				for(let i = 0; i < ableDays.length; i++) {
					if($.inArray(ymd, ableDays) >= 0){
						return [true,"",""];
					} else {
						return [false,"",""];
					}
				}
			}
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
