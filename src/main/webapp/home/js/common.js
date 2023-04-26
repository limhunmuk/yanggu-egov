var pwdPattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/;
var idPattern = /^[A-Za-z0-9+]{8,20}$/; 
var mailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

$(function() {	
	//검색 엔터처리
  	$("#searchKeyword").keypress(function (e) {
         if (e.which == 13){
        	 searchList();
         }
     });
});

//페이징 이동
function fn_egov_link_page(pageNo){
	if( $("#boardGubun").val() == "sign" ){
		//간판DB일 경우는 페이징처리 따로
		signPaging(pageNo);
	}else{
		document.listForm.pageIndex.value = pageNo;
		//document.listForm.action = "<c:url value='/egovSampleList.do'/>";
	   	document.listForm.submit();
	}
 	
	
}

//리스트검색
function searchList(){
	$("#pageIndex").val(1);
	$("#listForm")[0].submit();
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

//3자리마다 숫자 콤마
function AddComma(num)
{
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

