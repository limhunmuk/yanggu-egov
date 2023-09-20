<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
	<div class="login_bg"></div>
	<div class="login_box">
		<div>
			<img alt="이미지" src="/ad_images/common/_logo_on.png" style="padding-left:50px;"/>
		</div>
		<div class="login">
	
			<p class="txt">양구자연생태공원 관리자 페이지입니다. <br>로그인 하시려면 아이디와 비밀번호를 입력해주세요.</p>
			<form name="frm" action="/admin/login" method="post">
				<fieldset>
					<legend>아이디, 비밀번호</legend>
					<div class="input_id">
						<span><input type="text" title="id" name="adminId" placeholder="Username" value="admin"></span>
					</div>
					<div class="input_pw mt10">
						<span><input type="password" title="password" name="pwd" placeholder="Password" value="1111"></span>
					</div>
					<button type="button" class="btn_login"><span>LOGIN</span></button>
				</fieldset>
			</form>
		</div>
		<div class="login_txt">
			<p style="text-align:center;">5회 로그인 실패 시 접속불가처리됩니다. <br>접속불가시 031-324-3355  <br>문의하여 주십시오.</p>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){

	$(".btn_login").click(function(){
		var frm = document.frm;
		if (validForm(frm)) {

			$.ajax({
				url : '/admin/login'
				, data: {'adminId': frm.adminId.value, 'pwd':frm.pwd.value}
				, type: 'post'
			}).done( function(data){
				obj = JSON.parse(data);
				// console.log(obj.result);
				// console.log(obj.adminId);
				// console.log(obj.pwd);
				// console.log(obj.adminType);
				// console.log(obj.map);
				if (obj.result === 'success') {
					location.href = '/admin/dashboard';
				} else {
					alert(data.msg);
				}
			}).fail( function(data) {
				console.log(data);
				alert('error > ' + data.status);
			});
		}
	});
});

function validForm(frm) {
	var adminId = frm.adminId.value;
	if (adminId == '') {
		alert('아이디를 입력하세요.');
		frm.adminId.focus();
		return false;
	}
	var pwd = frm.pwd.value;
    if (pwd == '') {
        alert('비밀번호를 입력하세요.');
        frm.pwd.focus();
        return false;
    }
    
    return true;
}
</script>
</body>
</html>
