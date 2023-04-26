/**FILEDESC
공통:게시글 등록 js 파일
*/
var file_num = 1;
// 파일 추가
function change_b_file(tag){
	var chk_file = "ppt, pptx, xls, xlsx, doc, docx, pdf, jpg, jpge, gif, zip".split(", ");
	var value_arr = $(tag).val().split('\\');
	
	var f_len = $('#refer_area').children('span').length;
	if(f_len>=10){
		alert('파일은 10개까지만 등록 가능합니다.');
		return false;
	}
	
	if($("#attach_file")[0].files[0].size > 1024*1024*5){ // 5mb
		//console.log($("#attach_file")[0].files[0].size);
		alert('파일의 용량이 너무 큽니다.');
		return false;
	}
	
	if(!chk_file.includes(value_arr[value_arr.length-1].split('.')[1])){
		//console.log(value_arr[value_arr.length-1].split('.')[1]);
		alert('업로드 할 수 없는 형식입니다.');
		return false;
	}
	
	var org_file_html = '<input type="file" id="attach_file" onchange="change_b_file(this)" class="upload-hidden">';
	var add_html = '<span>' + value_arr[value_arr.length-1] + '<button type="button" value="' + file_num + '" onclick="del_b_file(this)" class="btn">삭제</button></span>';	
	value_arr = value_arr[value_arr.length-1].split('.');
		
	$('#refer_area').append(add_html);
	$('#file_area').append(org_file_html);
	$(tag).attr('id','b_file'+file_num);
	$(tag).attr('name','b_file'+file_num);
	file_num++;
}

// 파일 삭제
function del_b_file(tag){
	var f_num = $(tag).val();
	$('#b_file'+f_num).remove();
	$(tag).parent('span').remove();
}

function regQna(){	
	if(!checkInput("qnaTitle", "제목을")) return;
	if(!checkInput("qnaContents", "내용을")) return;

	formSubmit();
}

function formSubmit(){
	var form = $('#fmt')[0];		
	var formData = new FormData(form);
	
	$.ajax({
		url: 'qna.do',
		data: formData,
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		method: 'post',
		success: function(data){			
			console.log(data);
			if(data > 0){
				alert('등록하였습니다.');			
				location.reload();
			}else{
				alert('오류가 발생했습니다.');
			}
		},
		error : function() {	
			alert('오류가 발생했습니다.');
		}	
	});
}

function delAll(){	
	$('#refer_area').html("");
}