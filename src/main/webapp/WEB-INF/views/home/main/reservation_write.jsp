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
			<div class="tab_area top">
				<ul class="tab_btn">
					<li class="on"><a href="javascript:changeGubun(1);">용늪출입신청</a></li>
					<li><a href="javascript:changeGubun(2);">유아숲체험</a></li>
					<li><a href="javascript:changeGubun(3);">숲 해설</a></li>
				</ul>
			</div>
			<form action="reservation_view" method="post">
				<div class="inner2">
					 <p class="color_info">※예약 시 입력한 연락처와 예약번호를 입력해주세요</p>
					<div class="table_wrap m_row for_m_reservation_write">
						<table>
							<caption>결제 정보 확인 목록으로 정보를 최종 결제금액, 결제수단 목록으로 표시합니다. </caption>
							<colgroup>
								<col style="width: 300px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">예약자명<strong class="required">*</strong></th>
									<td>
										<input type="text" name="name" id="name1" class="w320" required>
										<label for="name1" class="blind">예약자명</label>
									</td>
								</tr>
								<tr>
									<th scope="row">전화번호<strong class="required">*</strong></th>
									<td>
										<div class="tel_area2">
											<select id="tel1" name="mobile1">
												<option value="010">010</option>
												<option value="010">011</option>
												<option value="016">016</option>
												<option value="016">017</option>
												<option value="019">019</option>
											</select>
											<input type="text" name="mobile2" id="tel2" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4">
											<label for="tel2" class="blind">전화번호2</label>
											<input type="text" name="mobile3" id="tel3" class="last" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4">
											<label for="tel3" class="blind">전화번호3</label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">예약번호<strong class="required">*</strong></th>
									<td>
										<input type="text" name="reservation_number" id="num" class="w320" required onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
										<label for="num" class="blind">예약번호</label>
										<input type="hidden" name="gubun" id="gubun" value="o">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="btn_area m_c2">
					 <button class="btn" type="submit">예약조회</button>
				</div>
			</form>
		</div>
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<script>
			$('.tab_btn li a').on('click', function () {
				$(this).parent().addClass('on').siblings().removeClass('on');
			});
			function changeGubun(num){
				
				if (num == 1) {
					$('#gubun').val('o');
				}else if (num ==2) {
					$('#gubun').val('e');
				}else{
					$('#gubun').val('f');
				}
			}
	</script>
	<!-- //wrap -->
</body>
</html>
