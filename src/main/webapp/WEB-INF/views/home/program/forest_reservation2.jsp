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
				<c:when test="${result.gubun == 'e' }">
					<p><i class="home_i"></i><span>체험프로그램</span><span>유아숲체험 신청</span></p>	
				</c:when>
				<c:otherwise>
					<p><i class="home_i"></i><span>체험프로그램</span><span>숲 해설 신청</span></p>
				</c:otherwise>			
			</c:choose>
		</div>
		<div class="contents sub_content top for_m_max790">
			<div class="tab_area">
				<ul class="tab_btn">
					<li>01. 신청 정보 입력</li>
					<li class="on">02. 신청 정보 확인</li>
					<li>03. 신청 완료</li>
				</ul>
			</div>
			<p class="enroll_tit">체험프로그램 신청 정보</p>
			<div class="table_wrap type-fr">
				<table>
					<caption>체험프로그램 신청목록으로 프로그램 선택, 예약자 명, 전화번호, 신청일, 비고를 목록으로 표시합니다. </caption>
					<colgroup>
						<col>
						<col>
					</colgroup>
					<tbody>
					 
						<tr>
							<th scope="col">신청자 정보</th>
							<th scope="col">참가 인원</th>
						</tr>
						<tr>
							<td>${result.name}(${result.mobile})</td>
							<td>${result.cnt}명</td>
						</tr>
						<tr>
							<th scope="col">프로그램명</th>
							<th scope="col">예약정보</th>
						</tr>
						<tr>
							<td>
							<c:choose>
								<c:when test="${result.gubun == 'e'}">
									유아숲체험
								</c:when>
								<c:otherwise>
									숲해설
								</c:otherwise>
							</c:choose>
							
							</td>
							<td>
							${result.useDate}
							<c:choose>
								<c:when test="${result.entryTime eq '1'}">오전 10:00 ~ 11:30</c:when>
								<c:when test="${result.entryTime eq '2'}">
									<c:choose>
										<c:when test="${result.gubun eq 'e' }">
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
							<input type="hidden" name="dSeq" id="dSeq" value="${result.seq}">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="notice_box be_off for_m_notice_box">
				<p style="text-align: center; font-size: 20px; font-weight: 600; padding: 10px 0;" class="for_m_notice_box_p">${result.remark}</p>
				<p></p>
			</div>
			<div class="notice_box be_off">
				<p>
					<span class="tit">&lt; 개인정보 수집·활용 동의 및 필수항목 고지&gt;</span><br>
					개인정보의 수집 목적 : 아래 입력한 개인정보는 이용자 식별(본인확인), 교육운영에 대한 연락 및 안내, 교육효과 및 통계분석 활용을 위해 참고용으로 수집·활용됨 수집하는 개인정보의 항목 : 성명, 생년월일, 연락처, 거주지 메일정보 항목보유 및 이용 기간 : 3년간 보유 및 이용 이후 파기 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익의 내용 : 개인정보는 필수 입력 사항이며 동의하지 않을 시 글쓰기 제한
				</p>
			</div>
			<div class="chk_area alone">
				<input type="checkbox" id="join_chk" name="join_chk">
				<label for="join_chk" class="chk">
					<i class="ico_chk"></i>
					위 사항에 대해 인지하고 입력항목에 대해 수집 및 활용에 동의합니다. <span class="small">(만 14세 미만의 아동의 경우 법정대리인(부모 등)의 동의를 받았음)</span>
				</label>
			</div>
			<div class="btn_area m_c2">
				 <button type="button" class="btn" onclick="agree();">신청하기</button>
				 <button type="button" class="btn form02" onclick="location.replace('/')">취소</button>
			</div>
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
				minDate: new Date('2019-08-28'),
				yearSuffix: '년'
			  });

			  $(function() {
				$("#datepicker1, #datepicker2").datepicker();
			  });
			  
			  function agree() {
				 if (!$('#join_chk').prop("checked")) {
					alert("약관에 동의해 주세요.");
					return;
				}else{
					alert("약관에 동의 하셨습니다.")
					location.href="/program/forest_reservation3?dSeq="+$('#dSeq').val();
				}
			  }
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
