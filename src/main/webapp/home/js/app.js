// 품목 추가
function addSub() {
    var sCnt = $('#programSubDd').find('.subDiv').length + 1;
    
    // 총 품목 종류보다 select가 많아질 수 없음
    if( sCnt > cost_list.length ) {
        alert('더 이상 품목을 추가 할 수 없습니다');
        return false;
    }
    
    var sel_list = []; // 선택된 cost_idx list
    $('#programSubDd').find('select[name=sub_list] option:selected').each(function() {
        sel_list.push($(this).val()*1);
    });
    
    $('#programSubDd').append(createSubHtml(sCnt,sel_list)); // 품목Html 추가
    
    // 선택된 option들 disalbed 처리
    $('#programSubDd').find('select[name=sub_list] option').each(function() {
        if( !$(this).prop('selected') && sel_list.includes($(this).val()*1) ) $(this).prop('disabled',true);
    });
    
    calPrice();
}

// 품목 Html 생성
var subIdx = 1; // 품목관련 ID를 위한 idx값
function createSubHtml( sCnt, sel_list ) {
    if( $('#programSubDd .subDiv').length >= 5 ) {
        alert('품목은 5개까지 등록 가능합니다');
        return false;
    }
    
    var subHtml = ''
        + '<div class="subDiv all_box01">'
        +	'<span class="subTxt txt">품목' + sCnt + '</span>'
        +	'<select id="date_choice' + subIdx + '" name="sub_list" onchange="changeSub()">';
    
    // 품목 select박스( selected: default:첫번째, 첫번째가 이미 선택되어있을 때 미선택된 option select )
    var ck_flag = true;
    for( idx in cost_list ) {
        subHtml += '<option value="' + cost_list[idx].idx + '"';
        if( ck_flag && !sel_list.includes(cost_list[idx].idx) ) {
            subHtml += ' selected';
            ck_flag = false;
            sel_list.push(cost_list[idx].idx);
        }
        subHtml += '>' + cost_list[idx].title + ' (' 
            + numberWithCommas(cost_list[idx].total_fee) + '원)</option>';
    }
    
    subHtml += ''
        +	'</select>'
        +	'<label for="date_choice' + subIdx + '" class="blind">검색조건 선택</label> '
        +	'<select id="num_choice' + subIdx + '" name="cnt_list" class="num" onchange="calPrice()">'
        +	'<option value="">개수</option>';
    
    for( var i=1 ; i<=50 ; i++ ) {
        subHtml += '<option>' + i + '</option>';
    }
    subHtml += ''
        +	'</select>'
        +	'<label for="num_choice' + subIdx + '" class="blind">검색조건 선택</label>'
        +	'<button class="delete_btn btn" onclick="delSub(this)">삭제</button>'
        + '</div>';
    
    subIdx++;
    
    return subHtml;
}

// 품목, 수량 변경
function changeSub() {
    checkSubDisalbed();
    calPrice();
}

// 품목 삭제
function delSub( btn ) {
    $(btn).closest('.subDiv').remove();
    $('#programSubDd').find('.subDiv .subTxt').each(function(e) {
        $(this).text('품목 ' + (e+1));
    });
    checkSubDisalbed();
    calPrice();
}

// 품목 가격 get
function getSubEntryFee( idx ) {
    var entry_fee;
    for( i in cost_list ) {
        if( cost_list[i].idx == idx ) {
            entry_fee = cost_list[i].entry_fee;
        }
    }
    return entry_fee;
}
function getSubBookFee( idx ) {
    var book_fee;
    for( i in cost_list ) {
        if( cost_list[i].idx == idx ) {
            book_fee = cost_list[i].book_fee;
        }
    }
    return book_fee;
}


// 선택된 품목 disabled
function checkSubDisalbed() {
    // 선택된 option들 disalbed 처리
    var sel_list = []; // 선택된 cost_idx list
    $('#programSubDd').find('select[name=sub_list] option:selected').each(function() {
        sel_list.push($(this).val()*1);
    });
    $('#programSubDd').find('select[name=sub_list] option').each(function() {
        if( !$(this).prop('selected') && sel_list.includes($(this).val()*1) ) $(this).prop('disabled',true);
        else $(this).prop('disabled',false);
    });
}

// 품목 전체가격 계산
function calPrice() {
    var entry_price = 0;
    var book_price = 0;
    var total_cnt = 0;
    
    var entry_fee, book_fee, cnt;
    $('#programSubDd').find('.subDiv').each(function() {
        entry_fee = getSubEntryFee($(this).find('select[name=sub_list]').val());
        book_fee = getSubBookFee($(this).find('select[name=sub_list]').val());
        cnt = $(this).find('select[name=cnt_list]').val();
        
        entry_price += entry_fee * (cnt == '' ? 0 : cnt);
        book_price += book_fee * (cnt == '' ? 0 : cnt);
        total_cnt += (cnt == '' ? 0 : cnt)*1;
    });
    
    if( total_cnt >= 20 ) entry_price = Math.round(entry_price*0.9);
    
    $('#price').val(numberWithCommas(entry_price + book_price));
}

//신청하기
function submitApp( idx ) {
    
    if( appCase == '1' ) { // 목재문화체험일 경우
        // 품목 수량 체크
        var cnt_ck = false;
        $('select[name=cnt_list]').each(function() {
            if( $(this).val() == '' ) {
                alert('수량을 선택 해 주세요');
                cnt_ck = true;
                return false;
            }
        });
        
        if( cnt_ck ) return false;
    }
    
    if( !$('#confirm_chk').prop('checked') ) {
        alert('개인정보 수집,활용에 동의 해 주세요');
        return false;
    }
    
    var appData = {
        idx: idx,
        group_name: $('#group_name').val().trim(),
        remark: $('#remark').val().trim()
    }; // 기본 신청 Data
    
    if( appCase == '1' ) { // 목재문화체험일 경우
        appData.price = removeCommas($('#price').val());
        
        var sub_list = [];
        $('#programSubDd').find('.subDiv').each(function(e) {
            var sub_data = {
                s_idx: $(this).find('select[name=sub_list]').val(),
                cnt: $(this).find('select[name=cnt_list]').val(),
                i_order: e+1
            };
            sub_list.push(sub_data);
        });
        appData.sub_list_str = JSON.stringify(sub_list);
    }
    
    $.ajax({
        url: './updateAppInfo',
        data: appData,
        type: 'post',
        dataType: 'json',
        success: function(data) {
            if( data.rst ) {
                location.replace('./rsvComplete?idx=' + appData.idx);
            } else {
                alert('오류가 발생했습니다');
            }
        }, error: function(e) {
            alert('오류가 발생했습니다');
            console.log(e);
        }
    });
}

// 유아숲 신청하기(정기형, 체험형, 찾아가는유아숲)
function submitKidApp( idx ) {
    if( !$('#confirm_chk').prop('checked') ) {
        alert('개인정보 수집,활용에 동의 해 주세요');
        return false;
    }
    
    var appData = {
        p_idx: idx,
        group_name: $('#group_name').val().trim(),
        remark: $('#remark').val().trim(),
        parti_cnt: 1
    };
    
    $.ajax({
        url: './insertKidApp',
        data: appData,
        type: 'post',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            if( data.rst ) {
                location.replace('./rsvKidComplete?idx=' + data.idx);
            } else {
                alert(data.msg);
            }
        }, error: function(e) {
            alert('오류가 발생했습니다');
            console.log(e);
        }
    });
}

/** 숫자변환 **/
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCommas(x) {
    if( x == '' ) return 0;
    return x.toString().replace(/,/gi,'');
}