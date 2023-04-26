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
		<div class="contents sub_content for_m_max790">
			<div class="tab_area top">
				<ul class="tab_btn">
					<li>01. 신청 정보 입력</li>
					<li>02. 신청 정보 확인</li>
					<li class="on">03. 신청 완료</li>
				</ul>
			</div>
			<div class="inner2">
				<div class="result_text03"> 
					<div class="txt_area">
						<p class="be">신청이 완료되었습니다.</p>
						<span class="box">예약번호는 <em class="c_red">${result.seq}</em> 신청일시는 <em class="c_main">${result.insertDate }</em> 입니다.</span>
					</div>
				</div>
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
								<td>${result.name }(${result.mobile})</td>
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
										유아숲해설
									</c:otherwise>
								</c:choose>
								</td>
							<td>
								${result.useDate}
							<c:choose>
								<c:when test="${result.entryTime eq '1'}">오전 10:00 ~ 12:00</c:when>
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
					<p><!--비고 내용 입력--></p>
				</div>
			</div>
			<div class="btn_area m_c2">
				 <button type="button" onclick="location.replace('/');" class="btn">확인</button> 
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	</div>

	<script>
	
	</script>
	<!-- //wrap -->
</body>
</html>
