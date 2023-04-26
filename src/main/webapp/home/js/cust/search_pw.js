/**FILEDESC
홈페이지:비밀번호 찾기 script 파일
*/

function ipinChk(){
	openCBAWindow();
}

function hpChk(){
	openPCCWindow();
}

//휴대폰인증
var PCC_window; 
function openPCCWindow(){ 
    var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

    if(PCC_window == null){ 
		 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
    }

    document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
    document.reqPCCForm.target = 'PCCV3Window';
    document.reqPCCForm.submit();

	return true;
}	

//아이핀인증
var CBA_window; 
function openCBAWindow(){ 
	CBA_window = window.open('', 'IPINWindow', 'width=450, height=500, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

	if(CBA_window == null){ 
		alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	}

	document.reqCBAForm.action = 'https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp';
	document.reqCBAForm.target = 'IPINWindow';
    document.reqCBAForm.submit();
}