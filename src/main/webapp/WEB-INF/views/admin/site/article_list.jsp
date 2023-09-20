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
            <c:param name="menuOn" value="7" />
        </c:import>
        <div class="container clearfix">
            <div class="content">
                <div class="list">
                    <form action="experiencelist" method="post">
                        <table class="search">
                            <caption>검색</caption>
                            <colgroup>
                                <col style="width:14%;">
                                <col style="width:auto;">
                                <col style="width:14%;">
                                <col style="width:auto;">
                            </colgroup>
                            <tr>
                                <th scope="row">게시판 사용여부</th>
                                <td>
                                    <input type="radio" id="" name="" value="" checked="">
                                    <label for="">전체</label>
                                    <input type="radio" id="" name="" value="">
                                    <label for="">On</label>
                                    <input type="radio" id="" name="" value="">
                                    <label for="">Off</label>
                                </td>
                                <th scope="row">유형</th>
                                <td>
                                    <input type="radio" id="" name="" value="" checked="">
                                    <label for="">전체</label>
                                    <input type="radio" id="" name="" value="">
                                    <label for="">썸네일</label>
                                    <input type="radio" id="" name="" value="">
                                    <label for="">텍스트</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">등록일</th>
                                <td colspan="3">
                                    <input type="text" title="시작일" placeholder="YYYY-MM-DD" class="ico_date" name="startDate" value="" autocomplete="off" id="dp1693895913224">
                                    <span class="hypen">~</span>
                                    <input type="text" title="종료일" placeholder="YYYY-MM-DD" class="ico_date" name="endDate" value="" autocomplete="off" id="dp1693895913225">
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
                            <caption>검색 결과</caption>
                            <colgroup>
                                <col style="width:5%;">
                                <col style="width:auto;">
                                <col style="width:25%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:15%;">
                                <col style="width:10%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col" rowspan="2">번호</th>
                                <th scope="col" colspan="2">GNB메뉴명</th>
                                <th scope="col" rowspan="2">유형</th>
                                <th scope="col" rowspan="2">등록자</th>
                                <th scope="col" rowspan="2">등록일</th>
                                <th scope="col" rowspan="2">게시판 사용 여부</th>
                            </tr>
                            <tr>
                                <th scope="col" class="border_l">1 depth</th>
                                <th scope="col">2 depth</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span>20</span>
                                </td>
                                <td>
                                    <a href="./board_view.html">이용안내</a>
                                </td>
                                <td>
                                    <a href="./board_view.html">양구 수목원 소개</a>
                                </td>
                                <td>썸네일</td>
                                <td>홍길동</td>
                                <td>YYYY-MM-DD</td>
                                <td>OFF</td>
                            </tr>
                            <tr>
                                <td>
                                    <span>19</span>
                                </td>
                                <td>
                                    <a href="./board_view.html">1Depth명</a>
                                </td>
                                <td>
                                    <a href="./board_view.html">2Depth 메뉴명</a>
                                </td>
                                <td>텍스트</td>
                                <td>홍길동</td>
                                <td>YYYY-MM-DD</td>
                                <td>ON</td>
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
        $('#gnb ul li').eq(3).addClass('on');
    });
    function excelDownload(){
        $("#excel").submit();
    }
</script>
</body>
</html>