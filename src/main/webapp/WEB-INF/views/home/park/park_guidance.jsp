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
			<h2>수목원 소개</h2>
			<p><i class="home_i"></i><span>수목원 소개</span><span class="last">이용 안내</span></p>
		</div>
		<!--<div class="contents sub_content">
			<p style="padding: 150px 0; font-size: 36px;text-align: center;font-weight: 600;">준비중입니다.</p>
		</div>-->
		<div class="contents sub_content">
			<p class="sub_txt_tit mt80">운영시간</p>
			<div class="icon_area time">
				<div class="table_wrap color2">
					<p class="sub_txt_tit2">체험프로그램 운영시간</p>
					<table>
						<caption>체험프로그램소개 목록으로 운영시간, 휴관을 목록으로 표시합니다. </caption>
						<colgroup>
							<col style="width: 50%">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">운영시간</th>
								<th scope="row">휴관</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="align_c">연중 09:00 ~ 18:00 <br> <span class="smt">(설날, 추석 당일은 13:00부터 관람)</span></td>
								<td class="align_c">매주 월요일 <br><span class="smt">(다만, 월요일이 공휴일인 경우 정상운영, 1월 1일 신정은 휴관)</span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<p class="sub_txt_tit">입장료</p>
			<div class="icon_area ticket">
				<div class="table_wrap color2">
					<p class="sub_txt_tit2">입장료</p>
					<div class="ovf_scroll type_ticket">
						<table>
							<caption>체험프로그램 신청목록으로 프로그램 선택, 예약자 명, 전화번호, 신청일, 비고를 목록으로 표시합니다. </caption>
							<colgroup>
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 28%;">
								<col style="width: 22%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" colspan="2">구분</th>
									<th scope="col">개인</th>
									<th scope="col">단체(20인 이상)</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="3">일반 관람객</td>
									<td>일반(만19세 ~ 만64세)</td>
									<td>6,000<br>(양구사랑상품권 3,000원 환급)</td>
									<td>3,000</td>
								</tr>
								<tr>
									<td style="border-left: 1px solid #d5d5d5">청소년(만7세 ~ 만18세)</td>
									<td>3,000</td>
									<td>1,500</td>
								</tr>
							</tbody>
							<!-- 210831 기존 내용
							<tbody>
								<tr>
									<td rowspan="3">일반 관람객</td>
									<td>어른(65세 미만)</td>
									<td>3,000</td>
									<td>2,000</td>
								</tr>
								<tr>
									<td>청소년 및 군인</td>
									<td>2,000</td>
									<td>1,500</td>
								</tr>
								<tr>
									<td>어린이(6세 이상)</td>
									<td>1,000</td>
									<td>700</td>
								</tr>
								<tr>
									<td rowspan="3">양구군민 및 <br>호수문화관광권역 <br>주민</td>
									<td>어른(65세 미만)</td>
									<td>1,500</td>
									<td rowspan="3">----</td>
								</tr>
								<tr>
									<td>청소년 및 군인</td>
									<td>1,000</td>
								</tr>
								<tr>
									<td>어린이(6세 이상)</td>
									<td>500</td>
								</tr>
							</tbody>
							-->
						</table>
					</div>
					<div class="text_wrap">
						<p class="be">
							<span class="th_txt">* 무료입장 : </span>
							<span class="td_txt">만 65세이상, 만6세미만, 장애인, 기초생활수급자, 명예군민, 산림복지서비스이용권 발급자<br>국가유공자(독립/참전/특수임무/5·18민주 유공자, 고엽제후유증환자, 의사상자, 국군포로가족)</span>
						</p>
						<p class="be">
							<span class="th_txt">* 50% 감면 : </span>
							<span class="td_txt"> 양구군민, 관내 군용사, 호수문화권역(춘천시, 홍천군, 화천군, 인제군) 주민,<br>접경지역시장군수협희회시군(강화군, 옹진군, 파주시, 김포시, 연천군, 철원군 고성군)주민</span>
						</p>
						<p class="be">
							<span class="th_txt">* 30% 감면 : </span>
							<span class="td_txt"> 다자녀가정(만 19세 미만 2인 이상)<br> ※ 입장료를 감면받고자 하는 자는 신분증 또는 증명서를 제시하여야 합니다.</span>
						</p>
					</div>
					<!-- 210831 기존 내용
					<div class="text_wrap">
						<p class="be">
							<span class="th_txt">* 무료입장 : </span>
							<span class="td_txt">만 65세 이상, 만 6세 미만, 국가 유공자, 장애인</span>
						</p>
						<p class="be">
							<span class="th_txt">* 50% 감면 : </span>
							<span class="td_txt"> 양구군민, 호수문화관광권역 주민(춘천시, 홍천군, 화천군, 인제군), 기초생활수급자</span>
						</p>
						<p class="be">
							<span class="th_txt">* 30% 감면 : </span>
							<span class="td_txt"> 한부모가족, 다자녀가정(만 19세 미만 3인 이상), 5·18 민주유공자, 산림복지서비스 이용권 발급자, 특수임무유공자<br> ※ 입장료, 체험료를 감면받고자 하는 자는 신분증 또는 증명서를 제시하여야 합니다.</span>
						</p>
					</div>
					-->
				</div>
			</div>
			<p class="sub_txt_tit">관람시 유의사항</p>
			<p class="sub_txt_txt"><span class="c_main">양구수목원은 고산지대의 한국고유 식물과 멸종위기 식물 등 소중한 국내 식물자원의 보유된 곳입니다. </span><br>
				유의사항을 준수하여 식물을 보존 할 수 있도록 하여 주시기 바랍니다.</p>
			<div class="accent_text">
				<div class="l_title">
					<i class="strong_i"></i><span>유의사항</span>
				</div>
				<div class="text_list">
					<p class="be">안내표시판에 게시된 관람요령을 준수하여 관찰 및 관람하여 주시기 바랍니다.</p>
					<p class="be">수목원 및 주변에 식재된 식물(나물, 종자), 곤충, 토석 등을 채취 및 채집 할 수 없습니다.</p>
					<p class="be">수목원내에서는 취사 행위를 할 수 없으며, 다만 포장된 도시락의 반입은 가능합니다.</p>
					<p class="be">관람지역 이외의 출입제한 지역에는 출입을 금합니다.</p>
					<p class="be">수목원의 식물보호를 위하여 식물이 식재된 곳에 들어가지 마십시오.</p>
					<p class="be">단체로 관람코자 하실 때는 사전 예약하여 주시기 바랍니다.</p>
					<p class="be">귀가 시 가져오신 쓰레기는 가급적 가져가 주시기 바랍니다.</p>
					<p class="be">수목원 관리원의 안내에 따라 주시기 바라며, 궁금한 사항은 관리원에게 문의 바랍니다.</p>
					<p class="be">애완동물을 동행하실 수 없습니다.</p>
					<p class="be">삼각대, 텐트, 차광막은 수목원 내에서 설치하실 수 없습니다.</p>
				</div>
			</div>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
</body>
</html>
