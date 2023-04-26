<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">
<div id="loading" style="display:none"><img id="loading-image" src="/ad_images/common/loading.gif" alt="Loading..." /></div>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/> -->
<meta name="format-detection" content="telephone=no"/>
<meta name="Keywords" content=""/>
<meta name="Description" content=""/>
<title>ADMINISTRATOR</title>

<link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon/favicon-16x16.png">
<link rel="manifest" href="/favicon/site.webmanifest">
<link rel="mask-icon" href="/favicon/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">

<link rel="stylesheet" type="text/css" href="/ad_css/jquery-ui.css?111"/>
<link rel="stylesheet" type="text/css" href="/ad_css/general.css?222"/>
<script type="text/javascript" src="/ad_js/jquery-1.12.4.min.js?3333"></script>
<script type="text/javascript" src="/ad_js/jquery-ui.js?444"></script>
<script type="text/javascript" src="/ad_js/layout.js?555"></script>
<script type="text/javascript" src="/ad_js/common.js?666"></script>
<script type="text/javascript" src="/ad_js/common.min.js?777"></script>
<script>
    $(function () {
        $('.ico_date').datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'yy-mm-dd'
        });
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
            yearSuffix: '년'
          });
    });
</script>
<style>
#loading { width: 100%; height: 100%; top: -100px; left: 0px; position: fixed; display: block;  opacity: 0.7;  background-color: #fff;  z-index: 99;  text-align: center; }
#loading-image { position: absolute;  top: 50%;  left: 50%; z-index: 100; }
.down_file{position: absolute; right:0; top:0 ;width:85px; height:32px; line-height:32px; text-align:center; background-color:#5e5e5e; color:#fff; font-size:14px; margin-right:-100%; border-radius:3px;}
</style>