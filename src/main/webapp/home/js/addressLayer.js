/**FILEDESC
공통:주소 처리 js 파일
*/
function my_zip_callback(data) {
		var fullAddr = "";
		var extraAddr = "";
		fullAddr += "(" +data.zonecode+ ") ";
		if (data.userSelectedType === "R") {
			fullAddr += data.roadAddress;
		} else {
			fullAddr += data.jibunAddress;
		}
		if (data.userSelectedType === "R") {
			if (data.bname !== "") {
				extraAddr += data.bname;
			}
			if (data.buildingName !== "") {
				extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
			}

			fullAddr += (extraAddr !== "" ? extraAddr + " " : "");
		}

		var frm = document.forms["joinFrm"];	
		frm.elements["companyAddress"].value = fullAddr;
		frm.elements["companyAddressDetail"].focus();
		
	}

function zip_open(zip_callback, embed_dialog, embed_here) {
	if (typeof daum != "undefined") {
		var options = {};
		options.oncomplete = function (data) {
			if (typeof embed_dialog != "undefined") {
				zip_callback(data);
				$(embed_dialog).hide();
			} else {
				zip_callback(data);
			}
		};
		if (typeof embed_dialog != "undefined") {
			options.width = "100%";
			options.height = "100%";
		}
		var daum_zip = new daum.Postcode(options);
		if (typeof embed_dialog != "undefined") {
			daum_zip.embed($(embed_here).get(0));
			$(embed_dialog).show();
		} else {
			daum_zip.open();
		}
	}
	return false;
}

function execDaumPostcode() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                //document.getElementById("companyAddressDetail").value = extraAddr;
            
            } else {
                //document.getElementById("companyAddressDetail").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            //document.getElementById('sample6_postcode').value = data.zonecode;
            //document.getElementById("sample6_address").value = addr;
            document.getElementById("companyAddress").value = data.zonecode + " " + addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("companyAddressDetail").focus();
        }
    }).open();
}


function AddAddress(){			
	var filter = "win16|win32|win64|mac|macintel"; 	
	if ( navigator.platform ) {
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {								
			//console.log('mobile 접속'); 
			zip_open(my_zip_callback, '#zip_layer', '#zip_layer');
			
		} else {
			//console.log('pc 접속');
			execDaumPostcode();
				
		} 
	}
}

