<%@ include file="../inc/header.jsp"%>
<script>
	var url = "${url}";
	var msg = "${msg}";
	$(function(){
		url = url.replace( '!', '&' );
		alert(msg);
		location.replace(url);
	});
</script>