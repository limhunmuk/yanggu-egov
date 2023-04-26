<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<ul class="reserv_list">
				<!-- 체험 프로그램 -->
				<li>
					<div class="img_box" style="background-image:url(/uploads/product/${product.banner}); background-size: cover"></div>
					<div class="txt_box">
						<p class="tit">수목원 체험 프로그램</p>
						<p class="info">매월 둘째주, 넷째주 가족단위 및 어린이를 대상으로 양구 수목원에서 즐길 수 있는 다채로운 프로그램들을 선정하여 운영하는 체험활동입니다.</p>
						<p class="be">
							<span class="be_tit">주제 :</span>
							<span><c:out value="${product.title}"/></span>
						</p>
						<p class="be">
							<span class="be_tit">기간 :</span>
							<span><c:out value="${product.text_date}"/></span>
						</p>
						<p class="be">
							<span class="be_tit">예약 :</span>
							<span>홈페이지</span>
						</p>
						<p class="be">
							<span class="be_tit">대상 :</span>
							<span><c:out value="${product.mubiao}"/></span>
						</p>
						<p class="be">
							<span class="be_tit">인원 :</span>
							<span>
								<c:if test="${empty one.seq}">
									<c:forEach items="${product.numberList}" var="nData" varStatus="status">
										<fmt:parseDate value="${nData.date}" var="dateValue" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${dateValue}" pattern="MM월 dd(E)" var="date"/>
										${date} <c:out value="${nData.number}"/><c:out value="${nData.type}"/>${status.last ? (nData.type eq '팀' ? '<em>(가족단위)</em>' : '') :' / '}
									</c:forEach>
								</c:if>
<%-- 							3월 26일(토)<c:out value="${product.number}"/>팀 / 27일(일)<c:out value="${product.number}"/>팀 <em>(가족단위)</em> --%>
							</span>
						</p>
						<p class="be">
							<span class="be_tit">시간 :</span>
							<span><c:out value="${product.text_time}"/></span>
						</p>
						<p class="be">
							<span class="be_tit">체험료 :</span>
							<span class="block"><c:out value="${product.price}"/><em>(재료비 포함)</em></span>
							<span class="block non_b">*체험료 입금계좌(농협 301-0221-8328-91 양구군청)</span>
						</p>
						<p class="be">
							<span class="be_tit">유의사항 :</span>
							<span class="block">
								${product.content}
							</span>
						</p>
						<p class="be">
							<span class="be_tit">문의사항 :</span>
							<span>양구수목원 033) 480-7395</span>
						</p>
						<c:choose>
							<c:when test="${product.openYn eq 'Y'}">
								<div class="btn_area">
									<a class="btn link" href="javascript:fn_goReservPage();"><span>신청하기</span></a>
								</div>
							</c:when>
							<c:otherwise>
								<p class="be">
									<span>온라인 신청이 마감되었습니다.</span>
<!-- 									<span>접수 기간이 종료되었습니다.</span> -->
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</li>
				<!-- //체험프로그램 -->
				<!-- 숲해설 -->
				<li>
					<div class="img_box" style="background-image:url(/images/sub/forest1.png)"></div>
					<div class="txt_box">
						<p class="tit">숲 해설</p>
						<p class="info">양구수목원에서 관람객을 대상으로 운영하는 숲해설 프로그램은 숲해설가 선생님들과 함께 수목원을 탐방하여 계절별 꽃과 나무를 관찰하고 자연을 체험하는 활동입니다.</p>
						<p class="be">
							<span class="be_tit">기간 :</span>
							<span>3월 ~ 11월 중 휴원일(월요일)을 제외한 화요일 ~ 일요일 운영</span>
						</p>
						<p class="be">
							<span class="be_tit">예약 :</span>
							<span>인터넷 사전예약 또는 현장신청<em>(사전예약이 완료된 경우 현장접수는 조기마감됩니다.)</em></span>
						</p>
						<p class="be">
							<span class="be_tit">대상 :</span>
							<span>초등학생 ~ 성인</span>
						</p>
						<p class="be">
							<span class="be_tit">인원 :</span>
							<span>2명 ~ 10명<em>(10명 초과 시 전화문의, 단체는 평일에만 운영가능합니다.)</em></span>
						</p>
						<p class="be">
							<span class="be_tit">시간 :</span>
							<span>3회<strong>(10:00 ~ 11:30 / 13:30 ~ 15:00 / 15:30 ~ 17:00)</strong></span>
						</p>
						<p class="be">
							<span class="be_tit">체험료 :</span>
							<span>무료</span>
						</p>
						<p class="be">
							<span class="be_tit">유의사항 :</span>
							<span>수목원 해설예약을 신청하시면 진행상태가 대기로 뜨며, 승인으로 변경되어야 예약확정임을 알려드립니다. 우천시나 기상 재해시 취소될 수 있습니다.</span>
						</p>
						<c:if test="${fClose != 'Y' }">
						<div class="btn_area">
							<button class="btn link" onclick="move('f');"><span>신청하기</span></button>
						</div>
						</c:if>
					</div>
				</li>
				<!-- //숲해설 -->
				<!-- 유아숲 -->
				<li>
					<div class="img_box" style="border-radius: 5px;-webkit-border-radius: 5px; background-image:url(/images/sub/forest_children.jpg); background-size: cover;"></div>
					<div class="txt_box">
						<p class="tit">유아숲</p>
						<p class="info">양구수목원 유아숲체험원에서 유아 관람객을 대상으로 운영하는 유아숲 프로그램은 유아숲체험 지도사님과 함께 자연을 관찰하고 체험하는 활동입니다.</p>
						<p class="be">
							<span class="be_tit">기간 :</span>
							<span>3월 ~ 11월 중 휴원일(월요일)과 공휴일을 제외한 화요일 ~ 토요일 운영</span>
						</p>
						<p class="be">
							<span class="be_tit">예약 :</span>
							<span>인터넷 사전예약 또는 현장신청<em>(사전예약이 완료된 경우 현장접수는 조기마감됩니다.)</em></span>
						</p>
						<p class="be">
							<span class="be_tit">대상 :</span>
							<span>5 ~ 7세 어린이</span>
						</p>
						<p class="be">
							<span class="be_tit">인원 :</span>
							<span>3명 ~ 7명<em>(7명 초과 시 전화문의)</em></span>
						</p>
						<p class="be">
							<span class="be_tit">시간 :</span>
							<span>2회<strong>(10:00 ~ 11:30 / 14:00 ~ 15:30)</strong></span>
						</p>
						<p class="be">
							<span class="be_tit">체험료 :</span>
							<span>무료</span>
						</p>
						<p class="be">
							<span class="be_tit">유의사항 :</span>
							<span>유아숲 해설예약을 신청하면 진행상태가 대기로 뜨며, 승인으로 변경되어야 예약확정임을 알려드립니다. 우천시나 기상 재해시 취소될 수 있습니다. 아동을 대상으로 하는 무료체험으로 예약은 매월 1회로 제한합니다. 체험기회를 고르게 제공하고자 함이므로, 매월 1회 초과 신청시 관리자 권한으로 임의 취소됩니다.</span>
						</p>
						<c:if test="${eClose != 'Y'}">
						<div class="btn_area">
							<button class="btn link" onclick="move('e')"><span>신청하기</span></button>
						</div>
						</c:if>
					</div>
				</li>
				<!-- //유아숲 -->

				<!-- 목제문화체험은 내용받은 후 적용 -->
				<!-- // 목재문화체험 -->
			</ul>
			<!--
			<div class="table_wrap">
				<table>
					<caption>체험프로그램 신청목록으로 프로그램 선택, 예약자 명, 전화번호, 신청일, 비고를 목록으로 표시합니다. </caption>
					<colgroup>
						<col style="width: 300px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">프로그램 선택</th>
							<td> 
								<select id="search_kind" name="search_kind" class="w320"> 
									<option value="1">제목</option>
									<option value="2">내용</option>
									<option value="3">작성자</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">예약자 명</th>
							<td>
								<input type="text" name="name" id="name1" class="w320">
								<label for="name1" class="blind">예약자명</label>
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<div class="tel_area2">
									<select id="tel1" name="srch_sel">
										<option value="all">010</option>
										<option value="title">---</option>
										<option value="content">---</option>
									</select>
									<input type="text" name="name" id="tel2">
									<label for="tel2" class="blind">전화번호2</label>
									<input type="text" name="name" id="tel3" class="last">
									<label for="tel3" class="blind">전화번호3</label>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">신청일</th>
							<td>
								 <input type="text" id="datepicker1" readonly>
								 <label for="datepicker1el3" class="blind">달력</label>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td>
								<input type="text" name="text1" id="text1">
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
				<input type="checkbox" id="join_chk03">
				<label for="join_chk03" class="chk">
					<i class="ico_chk"></i>
					위 사항에 대해 인지하고 입력항목에 대해 수집 및 활용에 동의합니다. <span class="small">(만 14세 미만의 아동의 경우 법정대리인(부모 등)의 동의를 받았음)</span>
				</label>
			</div>
			<div class="btn_area m_c2">
				 <button type="button" class="btn">확인</button> 
			</div>
			-->
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
				yearSuffix: '년',
			  });

			  $(function() {
				$("#datepicker1, #datepicker2").datepicker();
			  });
			  function move(gubun){
				location.href = "/program/forest_reservation1?gubun="+gubun;
			  }
			  
			  function fn_goReservPage(){
				  var data = {"seq":"${product.seq}"};
				  var url = "./program_reserv";
				  
				  if($("#detailFm").length == 0){
						var fm = "<form id='detailFm'></form>";
						$("body").append(fm);
					}
					
					var input = "";
					$.each(data, function(key, value){
						input += "<input type='hidden' name='" + key + "' value='" + value + "'/>";
					});
					
					$("#detailFm").html("");
					$("#detailFm").html(input);
					$("#detailFm").attr("action", url);
					$("#detailFm").attr("method", "post");
					
					$("#detailFm").submit();
			  }
		</script>
	</div>

	<!-- //wrap -->
</body>
</html>
