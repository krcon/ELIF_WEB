<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp" %>
    <meta name="title" content="회원가입,엘리프"/> 
    <meta name="keywords" content="엘리프, 회원가입, 개인정보 입력, 아이디, 비밀번호"/> 
    <meta name="description" content="엘리프 회원가입 페이지 입니다."/>
    <meta property="og:title" content="회원가입,엘리프">
    <meta property="og:description" content="엘리프 회원가입 페이지 입니다.">

    <title>회원가입 | 엘리프</title>
</head>

<body>
    <!-- wrap -->
    <div class="wrap">
        <a href="#header" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
        <!-- header -->
        <header id="header">
            <!-- gnb include -->
            <%@ include file="../include/header.jsp" %>
        </header>
        <!-- //header -->
        <main id="container">
            <div class="inner">
                <!-- Visual & Title -->
                <section class="visual member">
                    <h2>회원가입</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><span>회원가입</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <section class="cont_section nomt">
                        <div class="guide_box">
                            <ul class="guide_list number">
                                <li><span class="num">1.</span>엘리프에서 제공하는 분양정보, 공사현장정보등을 문자, 이메일 등으로 제공 받으실 수 있습니다.</li>
                                <li><span class="num">2.</span>일반회원과 계약회원으로 구분됩니다. 일반회원은 분양정보를 등록하시면 계약회원으로 전환됩니다.</li>
                                <li><span class="num">3.</span>계약회원은 나의 분양정보를 통하여 중도금 납부 내역 조회 등의 서비스를 받으실 수 있습니다.</li>
                                <!-- <li><span class="num">4.</span>고객센터의 1:1상담서비스인 고객문의, A/S신청,당첨자 조회 등의 서비스를 받으실 수 있습니다.</li> -->
                            </ul>
                        </div>
                        <div class="step_list_wrap"> 
                            <ol class="step_list">
                                <li class="prev"><span class="step">step1</span>약관 동의</li>
                                <li class="prev"><span class="step">step2</span>본인 인증</li>
                                <li class="on"><span class="step">step3</span>개인정보입력</li>
                                <li><span class="step">step4</span>가입완료</li>
                            </ol>
                        </div>
                    </section>
                    <form name="frmJoinForm" id="frmJoinForm" role="form" method="post" action="/member/joinProc">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="idcheck" value="">
                    <input type="hidden" name="deposit_yymm" value="">

                    <input type="hidden" name="user_nm" value="${param.sName}">
                    <input type="hidden" name="hp" value="${param.sMobileNo}">
                    <input type="hidden" name="yymmdd" value="${param.sBirthDate}">
                    <section class="cont_section">
                        <p class="title1">필수 입력 정보</p>
                        <p class="ess_txt">*표시는 필수 입력 항목입니다.</p>
                        <div class="info_table">
                            <table class="table no-head">
                                <caption>필수 입력 정보를 입력하는 테이블입니다.</caption>
                                <colgroup>
                                    <col style="width:206px">
                                    <col style="width:806px">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><span class="tit">이름</span></th>
                                        <td>
                                            <span class="desc_txt">${param.sName}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span class="tit">휴대전화번호</span></th>
                                        <td>
                                            <span class="desc_txt">${param.sMobileNo}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span class="tit">생년월일</span></th>
                                        <td>
                                            <span class="desc_txt">${param.sBirthDate}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="id" class="tit ess">아이디</label></th>
                                        <td>
                                            <input type="text" name="user_id" id="id" class="wla">
                                            <button type="button" id="idCheck" class="btn border md">중복확인</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="pw" class="tit ess">비밀번호</label></th>
                                        <td>
                                            <input type="password" name="password" id="pw" class="wla">
                                            <span class="gray_smtxt block">8~14자리 이내로 영문 대소문자, 숫자, 특수문자 중 3가지 이상의 조합으로 
입력해주시기 바랍니다</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="rePw" class="tit ess">비밀번호 확인</label></th>
                                        <td>
                                            <input type="password" name="password_confirm" id="rePw" class="wla">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="address01" class="tit ess">주소</label></th>
                                        <td>
                                            <div class="input_row">
                                                <input type="text" name="zipcd" id="address01" class="wla" readOnly>
                                                <button type="button" onclick="openDaumAddr();" class="btn border md" >우편번호 검색</button>
                                            </div>
                                            <div class="input_row">
                                                <label for="address02" class="a11y_hide">주소</label>
                                                <input type="text" name="ftn_addr" id="address02" class="wxla">
                                            </div>
                                            <div class="input_row">
                                                <label for="address03" class="a11y_hide">상세 주소를 입력해주세요.</label>
                                                <input type="text" name="dtl_addr" id="address03" class="wxla" placeholder="상세 주소를 입력해주세요.">
                                                <span class="gray_smtxt block">우편물 수령 시 주소 변경은 본사 분양관리부로 연락주시기 바랍니다. TEL 070-4470-7901,7902 </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="email" class="tit ess">이메일 확인</label></th>
                                        <td>
                                            <input type="email" name="email" id="email" class="wla">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="ok01" class="tit ess">수신 동의</label></th>
                                        <td>
                                            <ul class="receive_list">
                                                <li>
                                                    <label for="ok01">ELIF에서 제공하는 정보의 이메일 수신에 동의합니다.</label>
                                                    <div class="agree_ch_wrap">
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="email_send_yn" value="Y" id="ok01" ><label for="ok01">동의</label>
                                                        </span>
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="email_send_yn" value="N" id="no01"><label for="no01">미동의</label>
                                                        </span>
                                                    </div>
                                                </li>
                                                <li>
                                                    <label for="ok02">ELIF에서 제공하는 정보의 문자 수신에 동의합니다.</label>
                                                    <div class="agree_ch_wrap">
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="sms_send_yn" value="Y" id="ok02" ><label for="ok02">동의</label>
                                                        </span>
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="sms_send_yn" value="N" id="no02"><label for="no02">미동의</label>
                                                        </span>
                                                    </div>
                                                </li>
                                                <li>
                                                    <label for="ok03">전자동의서 사용에 동의합니다.</label>
                                                    <div class="agree_ch_wrap">
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="agree_yn" value="Y" id="ok03" ><label for="ok03">동의</label>
                                                        </span>
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="agree_yn" value="N" id="no03"><label for="no03">미동의</label>
                                                        </span>
                                                    </div>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="title1">부가 입력 정보</p>
                        <div class="info_table">
                            <table class="table no-head">
                                <caption>가 입력 정보를 입력하는 테이블입니다.</caption>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="livingSort" class="tit">주거구분</label></th>
                                        <td>
                                            <select id="livingSort" name="live_fg_cd1" class="wla">
                                                <option value="">선택</option>
                                                <option value="자가">자가</option>
                                                <option value="전세">전세</option>
                                                <option value="월세">월세</option>
                                                <option value="임대">임대</option>
                                                <option value="기타">기타</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="livingType" class="tit">주거종류</label></th>
                                        <td>
                                            <select id="livingType" name="live_fg_cd2" class="wla">
                                                <option value="">선택</option>
                                                <option value="아파트">아파트</option>
                                                <option value="단독">단독</option>
                                                <option value="빌라연립">빌라연립</option>
                                                <option value="다세대가구">다세대가구</option>
                                                <option value="오피스텔">오피스텔</option>
                                                <option value="주상복합">주상복합</option>
                                                <option value="기타">기타</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="wedding01" class="tit">결혼유무</label></th>
                                        <td>
                                            <div class="radio_group">
                                                <span class="radio-wrap">
                                                    <input type="radio" name="marry_fg_cd" value="Y" id="wedding01"><label for="wedding01">미혼</label>
                                                </span>
                                                <span class="radio-wrap">
                                                    <input type="radio" name="marry_fg_cd" value="N" id="wedding02"><label for="wedding02">기혼</label>
                                                </span>
                                            </div>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="bankbook01" class="tit">청약 통장 보유 유무</label></th>
                                        <td>
                                            <div class="radio_group">
                                                <span class="radio-wrap">
                                                    <input type="radio" name="deptsit_yn" value="Y" id="bankbook01" ><label for="bankbook01" onclick="showDeposit();">보유</label>
                                                </span>
                                                <span class="radio-wrap">
                                                    <input type="radio" name="deptsit_yn" value="N" id="bankbook02"><label for="bankbook02" onclick="hideDeposit();">미보유</label>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="depositline ">
                                        <th scope="row"><label for="join01" class="tit">청약 통장 가입일</label></th>
                                        <td>
                                            <!-- 
                                                 [D] 마크업과 상이함. 
                                                <span class="inner_input">
                                                    <input type="text" class="transparent_input" id="join01">
                                                    <label for="join01">년</label> [D] 1001 : label추가
                                                    <input type="text" class="transparent_input" id="join02">
                                                    <label for="join02">월</label> [D] 1001 : label추가
                                                </span>
                                            -->
                                            <span class="inner_input">
                                                <select  name="deposit_yy" class="transparent_input" id="join02" style="padding: 0 30px 0 19px;min-width:100px">
                                                    <option value="">선택</option>
                                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                                    <fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
                                                    <c:forEach begin="0" end="100" var="idx" step="1">
                                                    <option value="<c:out value="${yearStart - idx}" />" ${fn:substring(map.BIRTH_DAY,0,4)==(yearStart - idx)?'selected="selected"':''}><c:out value="${yearStart - idx}" /></option>
                                                    </c:forEach>
                                                </select>
                                                년
                                                <select  name="deposit_mm" class="transparent_input" id="join02" style="padding: 0 30px 0 19px;min-width:90px">
                                                    <option value="">선택</option>
                                                    <c:forEach begin="1" end="12" var="idx" step="1">
                                                    <fmt:formatNumber var="no" minIntegerDigits="2" value="${idx}" type="number"/>
                                                    <option value="<c:out value="${no}" />" ${fn:substring(map.BIRTH_DAY,4,6)==no?'selected="selected"':''}><c:out value="${no}" /></option>
                                                    </c:forEach>
                                                </select>
                                                월
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="btn_area">
                            <a href="javascript:;" onclick="onSubmit('frmJoinForm');" class="btn green">다음</a>
                        </div>
                    </section>
                    </form>
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>

    <div id="zipcode_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;z-index: 9999;">
    <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>

    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script>

    function showDeposit(){
        $(".depositline").removeClass('hide');
    }
    function hideDeposit(){
        $(".depositline").addClass('hide').find('select').val('');
    }
	$('[name=user_id]').change(function(){
		$('[name=idcheck]').val('N');
	}).keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,'').toLowerCase());
		}
	});;
    function onSubmit(frm){
        if(formValidation(frm)){
            if($('[name=idcheck]').val()!="Y"){
                alert('아이디 중복체크를 해주세요.');
                return;
            }
            $('[name=deposit_yymm]').val($('[name=deposit_yy]').val()+'-'+$('[name=deposit_mm]').val());
            $('#'+frm).submit();
        }
    }
    function formValidation(frm){
        var returnValue = true;
        if($('[name=user_nm]').val().length<2){
            alert('이름을 입력해주세요.');
            $('[name=user_nm]').focus();
            returnValue = false;
        }else if($('[name=hp]').val().length<2){
            alert('휴대전화번호를 입력해주세요.');
            $('[name=hp]').focus();
            returnValue = false;
        }else if($('[name=yymmdd]').val().length<2){
            alert('생년월일을 입력해주세요.');
            $('[name=yymmdd]').focus();
            returnValue = false;
        }else if($('[name=user_id]').val().length<2){
            alert('아이디를 입력해주세요.');
            $('[name=user_id]').focus();
            returnValue = false;
        }else if($('[name=password]').val().length<2){
            alert('비밀번호를 입력해주세요.');
            $('[name=password]').focus();
            returnValue = false;
        }else if($('[name=password_confirm]').val().length<2){
            alert('비밀번호 확인을 입력해주세요.');
            $('[name=password_confirm]').focus();
            returnValue = false;
        }else if( !checkPwd($('[name=password]').val(),$('[name=password_confirm]').val(),'', $('[name=user_id]').val()) ){
            returnValue = false;
        }else if($('[name=zipcd]').val().length<2){
            alert('우편번호를 입력해주세요.');
            $('[name=zipcd]').focus();
            returnValue = false;
        }else if($('[name=ftn_addr]').val().length<2){
            alert('주소를 입력해주세요.');
            $('[name=ftn_addr]').focus();
            returnValue = false;
        }else if($('[name=dtl_addr]').val().length<2){
            alert('상세 주소를 입력해주세요.');
            $('[name=dtl_addr]').focus();
            returnValue = false;
        }else if($('[name=email]').val().length<2){
            alert('이메일을 입력해주세요.');
            $('[name=email]').focus();
            returnValue = false;
        }else if(!validateEmail($('[name=email]').val())){
            alert('올바른 이메일을 입력해주세요.');
            $('[name=email]').focus();
            returnValue = false;
        }else if(!$('[name=email_send_yn]').is(':checked')){
            alert('이메일 수신을 체크해주세요.');
            $('[name=email_send_yn]').focus();
            returnValue = false;
        }else if(!$('[name=sms_send_yn]').is(':checked')){
            alert('문자 수신을 체크해주세요.');
            $('[name=sms_send_yn]').focus();
            returnValue = false;
        }else if(!$('[name=agree_yn]').is(':checked')){
            alert('전자동의서 사용을 체크해주세요.');
            $('[name=agree_yn]').focus();
            returnValue = false;
        }else if($('[name=deptsit_yn]').is(':checked')){
            if($('[name=deposit_yy]').val()==''){
                alert('청약 통장 가입일을 선택해 주세요.');
                returnValue = false;
            }else if($('[name=deposit_mm]').val()==''){
                alert('청약 통장 가입일을 선택해 주세요.');
                returnValue = false;
            }
        }
        return returnValue;
    }
	$('#idCheck').click(function(){
		if($('[name=user_id]').val().length>5){
			$.ajax({
				type : "POST",
				url : "/member/idSearch",
				cache : false,
				data : {'user_id':$('[name=user_id]').val()},
				success : function(datakey, statuskey){
					if(datakey.result==false){
						alert("사용할 수 없는 아이디 입니다.");
						return false;
					}else if(datakey.result==true){
						$('[name=idcheck]').val('Y');
						alert("사용할 수 있는 아이디 입니다.");
					}
				},
				error : function(data,status){
					alert( "관리자에게 문의하시기 바랍니다." );
				}
			});
		}else{
			alert('아이디를 6자이상 입력해 주세요.');
		}
	});


    var element_layer = document.getElementById('zipcode_layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function openDaumAddr(){
        var daumZip = new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
        
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
                $('[name=zipcd]').val(data.zonecode); //5자리 새우편번호 사용
                $('[name=ftn_addr]').val(fullRoadAddr);
                if(!$('html').hasClass('is-ie')){
                    element_layer.style.display = 'none';
                    $("[name=dtl_addr]").focus();
                }						
                //지번주소
                //$('[name=addr1]').val(data.jibunAddress);
            },
            width : '100%'
        });
        if($('html').hasClass('is-ie')){
            daumZip.open();
        }else{
            daumZip.embed(element_layer);
            // iframe을 넣은 element를 보이게 한다.
            element_layer.style.display = 'block';
        
            // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
            initLayerPosition();
        }
        

    }
    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 320; //우편번호서비스가 들어갈 element의 width
        var height = 460; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>
