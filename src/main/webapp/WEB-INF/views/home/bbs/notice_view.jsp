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
		<hr>
		<!-- container -->
		<div class="sub_container">
			<div class="sub_visual bg07">
				<h2 class="title">참여마당</h2>
				<p><i class="home_i"></i><span>참여마당</span><span class="last">공지사항</span></p>
			</div>
			<div id="container" class="sub_content">
				<div class="view_container">
                    <div class="view_title">
                        <p><c:if test="${one.kind == 'Y' }"><em class="bg_green">공지</em></c:if> <c:out value="${one.title }"/></p>
                        <div class="view_writer">
							<p>
								<span><fmt:formatDate pattern="yyyy-MM-dd" value="${one.insertDate }"/></span>
								<span>조회 :<strong><fmt:formatNumber value="${one.read_cnt+1 }" pattern="#,###"/></strong></span>
							</p>
						</div>
                    </div>
                    <div class="view_con">
                        <div>
							<c:out value="${one.content }" escapeXml="false"/> 
						</div>
                    </div>
					<c:if test="${not empty one.attachment1 or not empty one.attachment2 or not empty one.attachment3}">
						<p class="file_txt">첨부파일 </p>
						<ul class="file_list">
							<li><c:if test="${not empty one.attachment1 }"><a href="javascript:fileDownLoad('notice','${one.attachment1}','${one.attachment1_org}');" class="down_btn"><i></i><span>${one.attachment1_org}</span></a></c:if></li>
							<li><c:if test="${not empty one.attachment2 }"><a href="javascript:fileDownLoad('notice','${one.attachment2}','${one.attachment2_org}');" class="down_btn"><i></i><span>${one.attachment2_org}</span></a></c:if></li>
							<li><c:if test="${not empty one.attachment3 }"><a href="javascript:fileDownLoad('notice','${one.attachment3}','${one.attachment3_org}');" class="down_btn"><i></i><span>${one.attachment3_org}</span></a></c:if></li>
						</ul>
					</c:if>
                    <div class="btn_area">
                        <a href="/bbs/notice_list" class="btn list_btn"><i></i>목록</a>
                    </div>

                </div>
			</div>
		</div>
		<!-- //container -->
		<hr>        
		<%@ include file="../inc/footer.jsp"%>
	</div>
	<!-- //wrap -->
<iframe name="frmHidden" id="frmHidden" style="visibility: hidden; display: none"></iframe>
<form action="/file/download" method="post" id="fileform" name="fileform" >
	<input type="hidden" name="src">
	<input type="hidden" name="org">
	<input type="hidden" name="tmp">
</form>
<script>
	function fileDownLoad(src,tmp,org){
    	$("input[name='src']").val(src);
    	$("input[name='org']").val(org);
    	$("input[name='tmp']").val(tmp);
    	$("#fileform").submit();
    }
</script>
</body>
</html>


