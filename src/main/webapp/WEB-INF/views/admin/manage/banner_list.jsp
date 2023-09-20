<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
		<c:import url="/WEB-INF/views/admin/common/left_manage.jsp">
			<c:param name="menuOn" value="6" />
		</c:import>
		<div class="container clearfix">
			<div class="content">
				<div class="list">
					<form action="experiencelist" method="post">
						<table class="search">
							<caption>검색</caption>
							<colgroup>
								<col style="width:14%;">
								<col style="width: auto;">
							</colgroup>
							<tr>
								<th scope="row">키워드</th>
								<td>
									<select style="width:160px;vertical-align:middle;" name="keyword">
										<option value="1">제목</option>
									</select>
									<input type="text" name="searchName" value="">
								</td>
							</tr>
						</table>
						<div class="align_r mt20">
							<button type="button" class="btn_down" onclick="location.href = '';">등록</button>
							<button type="submit" class="btn_search">검색</button>
						</div>
					</form>
					<div class="search_wrap">
						<div class="result">
							<p class="txt">검색결과 총 <span>185</span>건</p>
						</div>
						<table class="search_list">
							<caption>검색결과</caption>
							<colgroup>
								<col style="width:6%;">
								<col style="width:auto;">
								<col style="width:13%;">
								<col style="width:13%;">
								<col style="width:13%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
									<th scope="col">노출기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="5">등록된 데이터가 없습니다.</td>
								</tr>
								<tr>
									<td>20</td>
									<td class="t_left"><a href="./banner_view.html">배너 제목이 표기됩니다.</a></td>
									<td>홍길동</td>
									<td>YYYY-MM-DD</td>
									<td>YYYY-MM-DD ~ YYYY-MM-DD</td>
								</tr>
								<tr>
									<td>19</td>
									<td class="t_left"><a href="./banner_view.html">배너 제목이 표기됩니다.</a></td>
									<td>홍길동</td>
									<td>YYYY-MM-DD</td>
									<td>YYYY-MM-DD ~ YYYY-MM-DD</td>
								</tr>
							</tbody>
						</table>
						<div class="pagination mt0">
							<a href="?page=5&amp;startDate=&amp;endDate=&amp;seq=" class="prev">이전 페이지</a>
							<a href="?page=1&startDate=&endDate=&seq=" class="on" onclick="return false;">1</a>
							<a href="?page=2&startDate=&endDate=&seq=">2</a>
							<a href="?page=3&startDate=&endDate=&seq=">3</a>
							<a href="?page=4&startDate=&endDate=&seq=">4</a>
							<a href="?page=5&startDate=&endDate=&seq=">5</a>
							<a class="next" href="?page=2&startDate=&endDate=&seq=">다음 페이지</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(function(){
		$('#gnb ul li').eq(6).addClass('on');
	});
	function excelDownload(){
		$("#excel").submit();
	}
</script>
</body>
</html>