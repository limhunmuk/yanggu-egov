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
						<div class="btn_area focus_target">
							<button type="button" class="btn" onclick="menuControl.addMenu()">+ 메뉴추가</button>
							<a href="javascript: window.open('/popup/menu_order_js.html','팝업창','width=600, height=800');" class="btn">순서변경</a>
							<button type="button" class="btn" onclick="menuControl.deleteMenu()">- 메뉴삭제</button>
						</div>
						<div class="main_box">
							<div class="menu_wrap">
								<div class="menu_list focus_target" id="menuListBox">
									<!-- <div class="menu_new">
                                        <p class="txt">등록한 메뉴가 없습니다.</p>
                                    </div> -->

									<!-- <div class="menu_new">
                                        <div class="input_area">
                                            <i class="ico_menu"></i>
                                            <input type="text" title="메뉴이름 입력" placeholder="메뉴이름 입력" style="width: 100%;">
                                        </div>
                                    </div> -->

									<!-- <dl>
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
                                    </dl> -->
								</div>
							</div>
						</div>
						<div class="side_box">
							<div class="view_table mt20" id="menuInputBefore">
								<table>
									<tbody>
									<tr>
										<td class="align_c">
											메뉴를 선택해 주세요
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<div class="view_table mt20 focus_target" id="menuInput" style="display: none;">
								<form id="frmSave" name="frmSave">
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
											<input type="text" id="menu_title" title="메뉴 제목 입력" placeholder="" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">SEO 설정 키워드 <i class="ico_info" data-tooltip-text="SEO 키워드를 메뉴 성격에 맞게 적절하게 입력해주시면 검색 노출이 잘 됩니다."></i></th>
										<td>
											<input type="text" id="menu_keyword" title="SEO 설정 키워드" placeholder="" style="width:100%;">
										</td>
									</tr>
									<tr>
										<th scope="row">메뉴 유형 <span class="asta">*</span></th>
										<td>
											<div>
												<input type="radio" id="boardy_01" name="board" value="1" class="hide_0">
												<label for="boardy_01" class="hide_0">게시판</label>
												<input type="radio" id="boardy_02" name="board" value="2" class="hide_0">
												<label for="boardy_02" class="hide_0">콘텐츠</label>
												<input type="radio" id="boardy_03" name="board" value="3">
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
											<input type="radio" id="viewYn_01" name="viewYn" value="Y" checked="">
											<label for="viewYn_01">노출</label>
											<input type="radio" id="viewYn_02" name="viewYn" value="N">
											<label for="viewYn_02">미노출</label>
										</td>
									</tr>
									<!-- 콘텐츠 -->
									<tr class="hide_0">
										<th scope="row">내용 <span class="asta">*</span></th>
										<td>
											<textarea name="editor" id="editor" cols="30" rows="10">에디터 영역입니다. </textarea>
										</td>
									</tr>
									</tbody>
								</table>
								</form>
							</div>
						</div>
						<div style="clear: both;"></div>
						<div class="write_btn align_r mt35">
							<button type="submit" class="btn_modify focus_target" id="saveBtn" onclick="menuControl.save(event)" style="display: none;">저장</button>
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

		var list;
		$.ajax({
			url : "/admin/manage/menuList/init"
			, data: {}
			, type: 'get'
			, dataType: 'json'
			, success : function (data) {
				if(data.list != null){
					list = data.list;
					console.log("size :" + data.list.length);
					console.log("=================");
					console.log(data.list);
					console.log("=================");
					menuControl.menuData = [];
					for (var i =0; i< data.list.length; i++){
						let obj = data.list[i];
						console.log("===============");
						console.log("seq : " + obj.seq);
						console.log("groupNm : " +obj.groupNm);
						console.log("codeNm : " +obj.codeNm);
						console.log("parent : " +obj.parent);
						console.log("title : " +obj.title);
						console.log("level : " +obj.level);
						console.log("sort : " +obj.sort);
						console.log("===============");
						menuControl.menuData.push(obj);
					}
					//menuControl.menuData = data.list;
					console.log(menuControl.menuData);
					menuControl.init();
				}
			}, error : function () {
				alert('error');
			}
		});

	});

	// 메뉴 관리 초벌
	// 20230918
	// 현재 특정 요소 선택 이후 해제하는 방법이 없는상태
	const menuControl = {
		menuBox: document.getElementById('menuListBox'),
		menuData: [
			/*{
				seq: 1,
				groupCdNm: 1,
				detailCdNm: null,
				upperCdNm: null,
				title: '메뉴1번',
				keyword: '메뉴1번 의 검색 키워드',
				type: null,
				url: null,
				level: 0,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 2,
				groupCdNm: 1,
				detailCdNm: 2,
				upperCdNm: null,
				title: '메뉴1번 하위메뉴',
				keyword: '메뉴1번 하위메뉴 의 검색 키워드',
				type: null,
				url: null,
				level: 1,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 123123123,
				groupCdNm: 123123123,
				detailCdNm: null,
				upperCdNm: null,
				title: '감자칩',
				keyword: '감자칩칩',
				type: null,
				url: null,
				level: 0,
				sort: 1,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 123456123,
				groupCdNm: 123123123,
				detailCdNm: null,
				upperCdNm: null,
				title: '고구마칩22',
				keyword: '고고구국마마칩칩22',
				type: null,
				url: null,
				level: 1,
				sort: 1,
				popupYn: 'N',
				viewYn: 'N',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 564,
				groupCdNm: 123123123,
				detailCdNm: null,
				upperCdNm: null,
				title: '고구마칩',
				keyword: '고고구국마마칩칩',
				type: null,
				url: null,
				level: 1,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 98,
				groupCdNm: 98,
				detailCdNm: null,
				upperCdNm: null,
				title: '안보이는 메뉴',
				keyword: '안보이는 메뉴 키워드',
				type: null,
				url: null,
				level: 0,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 4564,
				groupCdNm: 98,
				detailCdNm: null,
				upperCdNm: null,
				title: '안보이는 메뉴 하위',
				keyword: '안보이는 메뉴 하위 키워드',
				type: null,
				url: null,
				level: 1,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},
			{
				seq: 33,
				groupCdNm: 98,
				detailCdNm: 4564,
				upperCdNm: 4564,
				title: '3dep',
				keyword: '3deppp',
				type: null,
				url: null,
				level: 2,
				sort: 0,
				popupYn: 'N',
				viewYn: 'Y',
				delYn: 'N',
				writer: 'admin'
			},*/
		],
		isEdit: false,
		init: function() {
			if (this.menuData.length === 0) {
				return false;
			} else {
				// 1depth 데이터 세팅
				this.menuData.forEach((_this) => {
					if (_this.level === 0) {
						console.log(_this);

						let viewYn = '';
						if (_this.viewYn == 'N') {
							viewYn = 'disabled';
						}
						let html = `
							<dl id="menu\${_this.seq}" data-seq="\${_this.seq}" class="\${viewYn}">
								<dt class="closest_position" data-seq="\${_this.seq}" data-level="\${_this.level}">
									<a href="javascript:;" class="depth1" data-seq="\${_this.seq}">\${_this.title}</a>
								</dt>
								<dd class="depth_list">
									<ul>
									</ul>
								</dd>
							</dl>
							`;
						this.menuBox.insertAdjacentHTML('beforeend', html);
					}
				});
				// 2depth 데이터 세팅
				this.menuData.forEach((_this) => {
					if (_this.level === 1) {
						console.log(_this);

						let viewYn = '';
						if (_this.viewYn == 'N') {
							viewYn = 'disabled';
						}

						let html = `
							<li class="closest_position \${viewYn}" data-seq="\${_this.seq}" data-level="\${_this.level}">
								<a href="javascript:;" class="depth2" data-seq="\${_this.seq}">\${_this.title}</a>
								<ul id="menu\${_this.seq}">
								</ul>
							</li>
							`;
						this.menuBox.querySelector(`#menu\${_this.groupCdNm} > dd > ul`).insertAdjacentHTML('beforeend', html);
					}
				});
				// 3depth 데이터 세팅
				this.menuData.forEach((_this) => {
					if (_this.level === 2) {
						console.log(_this);

						let viewYn = '';
						if (_this.viewYn == 'N') {
							viewYn = 'disabled';
						}

						let html = `
							<li class="closest_position \${viewYn}" data-seq="\${_this.seq}" data-level="\${_this.level}">
								<a href="javascript:;" class="depth3" data-seq="\${_this.seq}">\${_this.title}</a>
							</li>
							`;
						this.menuBox.querySelector(`#menu\${_this.upperCdNm}`).insertAdjacentHTML('beforeend', html);
					}
				});

				// 메뉴 클릭 이벤트
				this.menuBox.querySelectorAll('a').forEach((_this) => {
					_this.addEventListener('click', (e) => {
						e.preventDefault();

						if (this.isEdit) {
							let changeYn = confirm('수정중인 메뉴가 있습니다.\n메뉴 변경시 데이터가 초기화됩니다.');
							if (!changeYn) {
								return false;
							}
							if (this.menuBox.querySelector('.instantData')) {
								this.menuBox.querySelector('.instantData').remove();
							}
						}
						this.isEdit = false;

						if (this.menuBox.querySelector('.focus_group')) {
							this.menuBox.querySelector('.focus_group').classList.remove('focus_group');
						}
						if (this.menuBox.querySelector('.focus_list')) {
							this.menuBox.querySelector('.focus_list').classList.remove('focus_list');
						}

						_this.closest('dl').classList.add('focus_group');
						_this.closest('.closest_position').classList.add('focus_list');

						this.findData(_this.dataset.seq);
					});
				});

				// focus out
				// document.querySelector('body').addEventListener('click', (e) => {
				// 	if (e.target.closest('.focus_target') == null) {
				// 		if (this.isEdit) {
				// 			let changeYn = confirm('수정중인 메뉴가 있습니다.\n메뉴 변경시 데이터가 초기화됩니다.');
				// 			if (!changeYn) {
				// 				return false;
				// 			}
				// 			if (this.menuBox.querySelector('.instantData')) {
				// 				this.menuBox.querySelector('.instantData').remove();
				// 			}
				// 		}
				// 		this.isEdit = false;

				// 		document.querySelector('.focus_group').classList.remove('focus_group');
				// 		document.querySelector('.focus_list').classList.remove('focus_list');
				// 	}
				// });

				// 메뉴 수정 체크 이벤트
				document.querySelectorAll('#menuInput input[type="text"]').forEach((_this) => {
					_this.addEventListener('keyup', () => {
						this.isEdit = true;
					})
				});
				document.querySelectorAll('#menuInput input[type="radio"]').forEach((_this) => {
					_this.addEventListener('click', () => {
						this.isEdit = true;
					})
				});
				document.querySelectorAll('#menuInput select').forEach((_this) => {
					_this.addEventListener('click', () => {
						this.isEdit = true;
					})
				});
			}
		},
		findData: function(seq, isReturn) {
			this.reset();

			let selectData = '';
			let i = 0;
			while(i < this.menuData.length) {
				if (this.menuData[i].seq == seq) {
					selectData = this.menuData[i];
					break;
				}
				i++;
			};
			if (selectData == '') {
				alert('오류');
				return false;
			}
			console.log(selectData);

			if (isReturn) {
				return selectData;
			}

			// 데이터 input
			// 선택한 메뉴의 데이터 세팅
			document.querySelector('#menu_title').value = selectData.title;
			document.querySelector('#menu_keyword').value = selectData.keyword;
			document.querySelector(`input[name="viewYn"][value="\${selectData.viewYn}"]`).checked = true;

			// 선택한 데이터의 level 값 따라 세팅이 바뀜
			// 실제 데이터 관리시 수정할 필요 있음
			if (selectData.level == 0) {
				document.querySelectorAll('.hide_0').forEach(($el) => {
					$el.style.display = 'none';
				});
			} else {
				document.querySelectorAll('.hide_0').forEach(($el) => {
					$el.style.display = null;
				});
			}

			// 인풋, 기타 요소 block 처리
			document.querySelector('#menuInputBefore').style.display = 'none';
			document.querySelector('#menuInput').style.display = 'block';
			document.querySelector('#saveBtn').style.display = 'inline-block';
		},
		addMenu: function() {
			if (this.isEdit) {
				// 진행중인 수정이 있는경우 경고
				let deleteConfirm = confirm('수정중인 메뉴가 있습니다.\n변경 사항을 삭제하시겠습니까?');
				if (!deleteConfirm) {
					return false;
				}
				// 이미 신규 추가시 기존 추가 영역을 지움
				if (document.querySelector('.instantData')) {
					document.querySelector('.instantData').remove();
				}
			}
			this.isEdit = true;
			if (this.menuBox.querySelector('.focus_group')) {
				// 선택된 메뉴 있을시 2depth
				let focusTarget = document.querySelector('.focus_list').dataset.level;
				let depth = 'depth2'
				if (focusTarget == '1' || focusTarget == '2') {
					depth = 'depth3'
				}
				let addHtml = `
					<li class="instantData">
						<div class="\${depth}">
							<input type="text" style="width: 100%;" placeholder="메뉴이름 입력">
						</div>
					</li>
					`;
				if (depth == 'depth2') {
					this.menuBox.querySelector('.focus_group dd > ul').insertAdjacentHTML('beforeend', addHtml);
				} else {
					this.menuBox.querySelector('.focus_list').closest('ul').insertAdjacentHTML('beforeend', addHtml);
				}
			} else {
				// 선택된 메뉴 없을시 1depth
				let addHtml = `
					<div class="menu_new instantData">
						<div class="input_area">
							<i class="ico_menu"></i>
							<input type="text" title="메뉴이름 입력" placeholder="메뉴이름 입력" style="width: 100%;">
						</div>
					</div>
					`;
				this.menuBox.insertAdjacentHTML('beforeend', addHtml);
			}
			// 기존 포커스 해제
			if (document.querySelector('.focus_list')) {
				document.querySelector('.focus_list').classList.remove('focus_list');
			}

			document.querySelector('#menuInputBefore').style.display = 'none';
			document.querySelector('#menuInput').style.display = 'block';
			document.querySelector('#saveBtn').style.display = 'inline-block';

			this.reset();
		},
		deleteMenu: function() {
			if (this.isEdit && this.menuBox.querySelector('.instantData')) {
				// 추가한 메뉴가 있을때
				let deleteConfirm = confirm('작성중인 메뉴가 있습니다.\n삭제하시겠습니까?');
				if (deleteConfirm) {
					this.isEdit = false;
					this.menuBox.querySelector('.instantData').remove();
				}
			} else if (this.menuBox.querySelector('.focus_list')) {
				// 일반 메뉴 삭제
				let deleteConfirm = confirm('정말 삭제하시겠습니까?');
				if (deleteConfirm) {
					let findData = this.findData(this.menuBox.querySelector('.focus_list a').dataset.seq, true);
					// 삭제할 데이터
					alert('데이터 삭제 처리 seq: '+findData.seq);
					console.log(findData);
				}
			} else {
				// 오류
				alert('선택된 메뉴가 없습니다.');
				return false;
			}
			this.reset();
		},
		reset: function() {
			document.querySelectorAll('#menuInput input[type="text"]').forEach((_this) => {
				_this.value = '';
			});
			document.querySelectorAll('#menuInput textarea').forEach((_this) => {
				_this.value = '';
			});
			document.querySelectorAll('#menuInput input[type="radio"]').forEach((_this) => {
				_this.checked = false;
			});
			document.querySelectorAll('#menuInput select').forEach((_this) => {
				_this.value = '';
			});
		},
		save: function(e) {
			e.preventDefault();
			console.log('/******************************');
			if (document.querySelector('.focus_list')) {
				// 수정된 데이터 케이스
				let changeSeq = document.querySelector('.focus_list').dataset.seq;
				alert('수정된 데이터 seq: ' + changeSeq);
				console.log('바뀐 데이터의 seq');
				console.log(changeSeq);
			} else {
				// 입력된 데이터 저장 필요
				alert('신규 추가 데이터');
				console.log('신규 추가 데이터');
				insertMenu();
			}
			console.log();
			console.log('/******************************');
		}
	}
	//menuControl.init();

	function insertMenu() {
		$.ajax({
			url : "/admin/manage/menuList/save"
			, data: {}
			, type: 'post'
			, dataType: 'json'
			, success : function (data) {
				if(data.result != null){
					alert("ok");
				}
			}, error : function () {
				alert('error');
			}
		});
	}
</script>
</body>

</html>