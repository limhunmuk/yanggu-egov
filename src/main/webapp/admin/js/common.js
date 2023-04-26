//페이징 이동
function fn_egov_link_page(pageNo){
	document.listForm.pageIndex.value = pageNo;
	//document.listForm.action = "<c:url value='/egovSampleList.do'/>";
   	document.listForm.submit();
}

//공백 체크
function checkInput(id, text) {
	if( $("#"+id).val() == "" ){
		alert(text+" 입력해주세요.");
		$("#"+id).focus();
		return false;
	}
	return true;
}

//공백 체크
function checkInputReturn(id) {
	if( $("#"+id).val() == "" ){
		return false;
	}
	return true;
}
//공백 체크 select
function checkInputSelect(id, text) {
	if( $("#"+id).val() == "" ){
		alert(text+" 선택해주세요.");
		$("#"+id).focus();
		return false;
	}
	return true;
}

//number 체크
function checkNumber(id, text){	
	if( $.isNumeric( $("#"+id).val() ) ){
		return true;
	}else{
		alert("숫자를 입력해주세요.");
		$("#"+id).focus();
		return false;
	}
	return true;	
}

//float 체크
function floatCheck(obj){
	 var num_check=/^([0-9]*)[\.]?([0-9])?$/;
		if(!num_check.test(obj)){
		return false;
	}
	return true;
}

//ajax call
function ajaxCall(url, data, callBack, errorMsg){
	$.ajax({
		type : "POST",	
		url : url,	
		data : data,	
		success : function(obj){	
		callBack(obj);	
		},error : function() {	
			console.log(errorMsg+"에러가 발생되었습니다");	
		}	
	});
}

//ajax call json
function ajaxCallJson(url, data, callBack, errorMsg){
	$.ajax({
		type : "POST",	
		url : url,	
		data : data,	
		dataType : "json",
		success : function(obj){	
		callBack(obj);	
		},error : function() {	
			console.log(errorMsg+"에러가 발생되었습니다");	
		}	
	});
}

//날짜포맷
function getFormatDate(date){
	var year = date.getFullYear();                                 //yyyy
	var month = (1 + date.getMonth());                     //M
	month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
	var day = date.getDate();                                        //d
	day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
	return  year + '-' + month + '-' + day;
}

function changeDate(obj,month){

	var d = new Date()
	$("#datepicker2").val( getFormatDate(d) );
		
	
    var monthOfYear = d.getMonth()
    d.setMonth(monthOfYear - month)
	$("#datepicker1").val( getFormatDate(d) );    
    
    $(".month").removeClass("on")
    $(obj).addClass("on")   
    
}

function changeDateWeek(obj,month){
	
	var d = new Date()
	$("#datepicker2").val( getFormatDate(d) );
	
	var dayOfMonth = d.getDate()
	d.setDate(dayOfMonth - 7)		
	$("#datepicker1").val( getFormatDate(d) );    
    
    $(".month").removeClass("on")
    $(obj).addClass("on")   
    
}


//textarea 값 엔터처리
function textareaSave(val){	
	val = val.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	return val
}

function textareaLoad(val){	
	val = val.split('<br/>').join("\r\n");	
	return val;
}

//3자리마다 숫자 콤마
function AddComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

//xss필터
function xssFilter(s) {
	return s.replace(/\</, '&lt;').replace(/\>/, '&gt;');
}
