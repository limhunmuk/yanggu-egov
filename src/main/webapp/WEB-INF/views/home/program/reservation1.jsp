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
					<li class="on"><span>01. 예약 체크사항동의</span></li>
					<li><span>02. 예약일 선택 및 정보 입력</span></li>
					<li>03. 예약완료</li>
				</ul>
			</div>
			<ul class="table_row">
				<li>
					<div class="row90">
						<p><span class="c_main">양구군은 대암산(1,304m) 정상 등반(탐방로만 이용가능과)</span> 용늪 출입로(6.4km)와 용늪탐방(4km)만 가능하며 장시간 도보 및 탐방이 어려운 어린이나 노약자는 참여하실 수 없습니다.</p>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk01" name="join_chk">
						<label for="join_chk01" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<li>
					<div class="row90">
						<p>양구군에서는 원주지방환경청, 산림청, 문화재청, 국방부의 용늪출입 허가기관에 귀하의 신청을 대행해 드리고 있습니다. 산불조심 기간은 출입이 통제되며, 천재지변, 출입로 산사면 낙석 및 붕괴, 군부대 작전 및 훈련 상황, 악천후 등으로 신청이 취소될 수 있습니다. (산불 조심기간은 매년 11월 1일 부터 ~5월 15일 까지이며 기후 및 상황에 따라 변동될 수 있음)</p>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk02" name="join_chk">
						<label for="join_chk02" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<li>
					<div class="row90">
						<p>용늪은 민통선출입지역, 습지보호지역, 천연보호지역, 산림유전자원보호구역으로 <span class="c_main">인솔자의 통제 및 지시사항을 반드시 준수</span>할 것 이며, 취사, 음주, 흡연, 야생동식물 무단채취 및 포획, 허가된 산책로 이탈, 애완동물 동반, 시설 훼손, 허가된 지역 외에 촬영, 인화성물질 소지는 엄격히 금지하고 있으며 이를 위반 시에는 해당 법률에 의해 처벌 받으실 수 있습니다.</p>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk03" name="join_chk">
						<label for="join_chk03" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<li>
					<div class="row90">
						<div class="be_box">
							<p class="be">출입신청은 출입예정일 20일 전에 <span class="c_main">신청하셔야 하며 신청취소와 변경은 20일 전까지만</span> 가능합니다. </p>
							<p class="be">하루 출입허가 기능 <span class="c_main">인원은 100명</span>입니다. </p> 
							<p class="be">제공된 신청서식에 따라 <span class="c_main">사실만을 기입</span>하셔야 합니다.</p> 
							<p class="be">탐방 신청 후 빈번한 취소, 동일인의 반복신청, 거짓된 정보 기입은 신청 허가가 거부될 수 있습니다. </p>
							<p class="be"><span class="c_main">"보안서약서"는 출입당일에 "신분증"과 함께 소지</span>하셔야 출입이 가능합니다.  <br>
							(용늪 출입전 위병소에서 "보안서약서"와 "신분증"으로 신원확인을 받으셔야 출입이 가능합니다.)</p>
						</div>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk04" name="join_chk">
						<label for="join_chk04" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<li>
					<div class="row90">
						<p>출입 및 탐방 시에 발생하는 사고 및 손해에 대해서 <span class="c_red">양구군과 인허가 관련기관이 책임지지 않으므로 사고방지 및 안전에 유의</span>하시길 바라며, <span class="c_red">사고 발생에 대비해 보험 가입 후에 용늪출입신청을 하실 것을 권고</span> 합니다.</p>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk05" name="join_chk">
						<label for="join_chk05" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<li>
					<div class="row90">
						<div class="be_box">
							<p class="c_main">개인정보의 수집 및 이용에 대한 안내 (필수)</p>
							<p class="be">개인정보의 수집 및 이용 목적: 온라인 예약신청 관리 및 예약 서비스 제공을 위해 개인정보를 수집합니다. 수집한 개인정보는 목적 이외의 어떠한 용도로도 사용하지 않으며 이용 목적이 변경될 시에는 사전 동의를 구할 예정입니다.</p> 
							<p class="be">수집하려는 개인정보의 항목: 예약자명, 전화번호, 생년월일, 주소</p> 
							<p class="be">개인정보의 보유 및 이용 기간: 3년</p>
							<p class="be">이용자는 개인정보 수집 및 이용 동의에 대한 거부 권리가 있습니다. 단, 개인정보 수집 및 이용에 동의를 하지 않으실 경우에는 예약이 제한됩니다.</p>
						</div>
					</div>
					<div class="chk_area">
						<input type="checkbox" id="join_chk06" name="join_chk">
						<label for="join_chk06" class="chk">
							<i class="ico_chk"></i>
							확인
						</label>
					</div>
				</li>
				<!-- <div class="chk_area all">
					<input type="checkbox" id="all_chk">
					<label for="all_chk" class="chk">
						<i class="ico_chk"></i>
						전체선택
					</label>
				</div> -->
			</ul>
			<div class="btn_area m_c2">
				<button type="button" class="btn" onclick="agree();">다음</button>
				<button type="button" class="btn form02" onclick="location.replace('/')">취소</button>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
		<script>
			function agree() { 
				var chkbox = document.getElementsByName('join_chk'); 
				var chk = false; 
				
				for(var i=0 ; i<chkbox.length ; i++) { 
					if(chkbox[i].checked) { 
						chk = true; 
					} else { 
						chk = false;
						break;
					} 
				}
				
				if(chk) { 
					alert("모든 약관에 동의 하셨습니다."); 
					location.href="/program/reservation2";
					return false; 
				} else { 
					alert("모든 약관에 동의해 주세요.") 
				} 
			}
			
			$('.calendar_box2 table  button.reserve').on('click', function () {
				$('.calendar_box2 table td').removeClass('on');
				$(this).parent().parent().addClass('on');
			});
			
			//임시 스크립트(나중에 지울것)
			$('.calendar_box2 .clndr table td .reserve').on('click', function () {
				$('.sub_main.r_main .strong_txt').hide();
				$('.date_result').show();
			});
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
