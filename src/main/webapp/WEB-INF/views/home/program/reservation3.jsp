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
			<p><i class="home_i"></i><span>체험프로그램</span><span>용늪 출입 신청</span></p>
		</div>
		<div class="contents sub_content">
			<div class="tab_area top">
				<ul class="tab_btn for_resv">
					<li><span>01. 예약 체크사항동의</span></li>
					<li><span>02. 예약일 선택 및 정보 입력</span></li>
					<li class="on">03. 예약완료</li>
				</ul>
			</div>
			<div class="inner2">
				<div class="result_text03"> 
					<div class="txt_area">
						<p class="be">신청이 정상적으로 완료되었습니다. </p>
						<span class="box">예약번호는 <em class="c_red"><c:out value="${result.seq}"/></em> 신청일시는 <em class="c_main"><c:out value="${result.insertDate}"/></em> 입니다.</span>
					</div>
				</div>
				<div class="accent_text">
					<div class="l_title">
						<i class="strong_i"></i><span>허가신청방법</span>
					</div>
					<div class="text_list">
						<p class="be">"용늪출입허가신청" 파일을 다운로드 하여 작성합니다.(익일까지 메일 전송하지 않으면, 예약이 취소될 수 있습니다.) 신청서식 : 국가지정문화제 공개 제한지역 출입허가신청서(양식1), 인적사항(양식2)</p>
						<p class="be">신청업무 담당자 메일(jth020628@korea.kr)로 보냅니다.</p>
						<p class="be">출입허가가 완료되면 신청업무 담당자로부터 안내를 받으십니다.</p>
						<p class="be">출입 당일 출입신청자 모든 분들은 "보안서약서"를 1인당 1부씩 작성하시어 "신분증"과 함께 지참하셔야 합니다.</p>
						<p class="be">해설사의 안내를 받으시며 용늪탐방을 합니다.</p>
						<p class="be"><strong class="c_red">하단 서식을 다운로드 받아 담당자 메일로 보내야만 예약이 완료됩니다.</strong></p>
						<div class="btn_box">
							<a href="http://yg-eco.kr/sample/AFRA.zip" class="btn">용늪출입허가신청 파일다운로드 <br> [담당자 메일로 보내는 신청문서]</a>
							<a href="http://yg-eco.kr/sample/securityPledge.hwp" class="btn last">보안서약서 다운로드 <br> [방문시에 작성하셔서 지참하시는 문서]</a>
						</div>
					</div>
				</div>
				<p class="enroll_tit ">신청 정보</p>
				<div class="table_wrap m_row for_m_reservation3">
					<table>
						<caption>결제 정보 확인 목록으로 정보를 최종 결제금액, 결제수단 목록으로 표시합니다. </caption>
						<colgroup>
							<col style="width: 300px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">예약자명</th>
								<td><c:out value="${result.name}"/></td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td>
									<c:out value="${result.mobile}" />
								</td>
							</tr>
							<tr>
								<th scope="row">참여인원 <em class="small_txt">(참여자수)</em></th>
								<td>
									<c:out value="${result.cnt}명"/>
								</td>
							</tr>
							<tr>
								<th scope="row">단체기관명</th>
								<td>
									<c:out value="${result.teamName}"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="accent_text">
					<div class="l_title">
						<i class="strong_i"></i><span>유의사항</span>
					</div>
					<div class="text_list">
						<p class="be">신청기간은 20일 정도 소요되며 20일전까지 변경이 가능합니다.</p>
						<p class="be">1일 방문객은 100명을 초과할 수 없습니다.</p>
						<p class="be">신청업무 담당자 : 정태호 033-480-2530 접수메일 : jth020628@korea.kr</p>
					</div>
				</div>
			</div>
			<div class="btn_area m_c2">
				 <button type="button" onclick="location.replace('/');" class="btn">확인</button>  
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<div class="layerpop-box open"><!-- open 클래스 추가하면 팝업 -->
			<div class="modal-bg"></div>
			<div class="layerpopup msg-error">
				<div class="inner">
					<div class="msgbox prompt">
						<div class="head_title"><i></i>허가신청방법 주의사항<a href="javascript:;" class="btn_close">닫기</a></div>
						<div class="ctrt_wrap">
							<div class="img_box">
								<img class="for_pc" src="/images/sub/permission.png"/>
								<img class="for_m" src="/images/sub/permission_m.png"/>
							</div>
							<ul class="txt_box">
								<li>
									<strong>'공개제한출입허가신청서'</strong>와 <strong>'인적사항'</strong>
									<br><span class="line">다운로드 받아</span> 작성하여 <span class="red_box">담당자에게 메일</span>로 
									보냅니다.
								</li>
								<li>
									<strong>'보안서약서'</strong>를<span class="line">다운로드 받아</span> <span class="red_box">탐방당일</span>에 
									가져옵니다.
								</li>
							</ul>
						</div>
						<div class="btn_area">
							<a href="javascript:;" class="btn btn_close">닫기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		$('.calendar_box2 table  button.reserve').on('click', function () {
			$('.calendar_box2 table td').removeClass('on');
			$(this).parent().parent().addClass('on');
		});

		$(".layerpopup .btn_close").on("click", function () {
		$(".layerpop-box ").removeClass("open");
		$('html').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제
		});

		function popOpen() {
			$(".layerpop-box").addClass("open");
			$('html').css({'overflow': 'hidden', 'height': '100%'}); //scroll hidden 해제
		}
	</script>
	<!-- //wrap -->
</body>
</html>
