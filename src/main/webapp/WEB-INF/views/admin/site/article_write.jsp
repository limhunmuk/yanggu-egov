<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/admin/common/head.jsp"/>
<style>
    .search_wrap table.search_list td{padding:0 10px;}
    .search_wrap table.search_list td.t_left{text-align:left;}
    .search_wrap table.search_list td.t_center{text-align:center;}
    .search_wrap table.search_list td a{display:inline-block;width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;vertical-align:middle;}
</style>
</head>
<body id="nav_3">
<div id="wrap" class="skin_type01">
    <c:import url="/WEB-INF/views/admin/common/gnb.jsp"/>
    <div class="sub_wrap">
        <c:import url="/WEB-INF/views/admin/common/left_site.jsp">
            <c:param name="menuOn" value="8" />
        </c:import>
        <div class="container clearfix">
            <div class="content">
                <a href="javscript:;" class="btn_refresh" onclick="location.reload();">새로고침</a>
                <div class="list_tit">
                    <h3>게시판 등록</h3>
                </div>
                <div class="write">
                    <form id="frm" onsubmit="return frm_submit(this);">
                        <table>
                            <caption>작성</caption>
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:85%;">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row">GNB 메뉴명 <span class="asta">*</span></th>
                                <td>
                                    <select name="sort1" id="sort1" style="width:200px;">
                                        <option value="">1depth 명</option>
                                    </select>
                                    <select name="sort2" id="sort2" style="width:200px;">
                                        <option value="">2depth 명</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">게시판 유형 <span class="asta">*</span></th>
                                <td>
                                    <input type="radio" id="text" name="noti">
                                    <label for="text">텍스트</label>
                                    <input type="radio" id="thumb" name="noti" checked="checked">
                                    <label for="thumb">썸네일</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">게시판 소개글</th>
                                <td>
                                    <input type="radio" id="noti4" name="open1" checked="checked">
                                    <label for="noti4">ON</label>
                                    <input type="radio" id="noti5" name="open1">
                                    <label for="noti5">OFF</label>
                                    <div class="mt10">
                                        <textarea name="contents" title="답변입력" placeholder="100자 이내로 입력해주세요"></textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">게시판 사용 여부 <span class="asta">*</span></th>
                                <td>
                                    <input type="radio" id="noti6" name="open2" checked="checked">
                                    <label for="noti6">ON</label>
                                    <input type="radio" id="noti7" name="open2">
                                    <label for="noti7">OFF</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">공지기능 <span class="asta">*</span></th>
                                <td>
                                    <input type="radio" id="text5" name="open7" checked="checked">
                                    <label for="text5">ON</label>
                                    <input type="radio" id="text6" name="open7">
                                    <label for="text6">OFF</label>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="write_btn align_r mt35">
                            <a href="./board_list.html" class="btn_list">목록</a>
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
        $('#gnb ul li').eq(3).addClass('on');
    });
    function excelDownload(){
        $("#excel").submit();
    }
</script>
</body>
</html>