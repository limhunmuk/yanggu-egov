<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
	<div class="sub_wrap">
		<c:import url="/WEB-INF/views/admin/common/left_manage.jsp">
			<c:param name="menuOn" value="3" />
		</c:import>
		<div class="container clearfix">
			<div class="content">
				<a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
				<div class="list_tit">
					<h3>메뉴 관리</h3>
				</div>
				<div class="write">
					<form id="frm" onsubmit="return frm_submit(this);">
						<div class="btn_area">
							<button type="button" class="btn">+ 메뉴추가</button>
							<a href="javascript: window.open('../popup/menu_order.html','팝업창','width=600, height=800');" class="btn">순서변경</a>
							<button type="button" class="btn">- 메뉴삭제</button>
						</div>
						<div class="main_box">
							<div class="menu_wrap">
								<div class="menu_list">
									<div class="menu_new">
										<p class="txt">등록한 메뉴가 없습니다.</p>
										<div class="input_area">
											<i class="ico_menu"></i>
											<input type="text" title="메뉴이름 입력" placeholder="메뉴이름 입력" style="width: 100%;">
										</div>
									</div>
									<dl>
										<dt>
											<a href="javascript:;" class="depth1">1depth 이름 A</a>
										</dt>
										<dd class="depth_list">
											<ul>
												<li>
													<a href="javascript:;" class="depth2">2depth 이름 a1</a>
												</li>
												<li>
													<div class="depth2">
														<input type="text" style="width: 100%;" placeholder="메뉴이름 입력">
													</div>
												</li>
											</ul>
										</dd>
									</dl>
									<dl>
										<dt>
											<a href="javascript:;" class="depth1">1depth 이름 B</a>
										</dt>
										<dd class="depth_list">
											<ul>
												<li>
													<a href="javascript:;" class="depth2">2depth 이름 b1</a>
												</li>
												<li>
													<a href="javascript:;" class="depth2">2depth 이름 b2</a>
												</li>
												<li>
													<a href="javascript:;" class="depth2">2depth 이름 b3</a>
												</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="side_box">
							<div class="view_table mt20">
								<table>
									<caption>작성</caption>
									<colgroup>
										<col style="width:20%;">
										<col style="width:80%;">
									</colgroup>
									<tbody>
									<tr>
										<th scope="row">메뉴 제목 <span class="asta">*</span></th>
										<td>
											<input type="text" title="메뉴 제목 입력" placeholder="" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">SEO 설정 키워드 <i class="ico_info" data-tooltip-text="SEO 키워드를 메뉴 성격에 맞게 적절하게 입력해주시면 검색 노출이 잘 됩니다."></i></th>
										<td>
											<input type="text" title="SEO 설정 키워드" placeholder="" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">메뉴 유형 <span class="asta">*</span></th>
										<td>
											<div>
												<input type="radio" id="boardy_01" name="board" value="">
												<label for="boardy_01">게시판</label>
												<input type="radio" id="boardy_02" name="board" value="">
												<label for="boardy_02">콘텐츠</label>
												<input type="radio" id="boardy_03" name="board" value="">
												<label for="boardy_03">링크</label>
											</div>
											<!-- 링크 -->
											<div class="mt10">
												<input type="text" title="링크 URL" id="url" value="" style="width: 70%;">
												<label for="url" class="blind">링크 URL 작성</label>
												<select name="linkList" id="linkList" style="width: 150px; vertical-align: top;">
													<option value="">현재창</option>
													<option value="">새창</option>
													<option value="">링크없음</option>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">노출상태 <span class="asta">*</span></th>
										<td>
											<input type="radio" id="open_01" name="open" value="" checked="">
											<label for="open_01">노출</label>
											<input type="radio" id="open_02" name="open" value="">
											<label for="open_02">미노출</label>
										</td>
									</tr>
									<!-- 콘텐츠 -->
									<tr>
										<th scope="row">내용 <span class="asta">*</span></th>
										<td>
											<textarea name="editor" id="editor" cols="30" rows="10">에디터 영역입니다. </textarea>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="write_btn align_r mt35">
							<button type="submit" class="btn_modify">저장</button>
						</div>
					</form>
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