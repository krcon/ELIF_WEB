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
    <meta name="title" content="비밀번호 변경, 엘리프"/> 
    <meta name="keywords" content="엘리프, 비밀번호, 비밀번호 변경, 인증, 이메일, 휴대전화"/> 
    <meta name="description" content="엘리프 비밀번호 변경 페이지 입니다."/>
    <meta property="og:title" content="비밀번호 변경, 엘리프">
    <meta property="og:description" content="엘리프 비밀번호 변경 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>비밀번호 변경 | 엘리프 | 모바일</title>
</head>
<body>
    <!-- wrap -->
    <div class="wrap">
        <a href="#header" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
        <!-- header -->
        <header id="header" class=""><!-- 마이 엘리프 : my_open / 메뉴 : gnb_open -->
            <!-- gnb include -->
            <%@ include file="../include/header.jsp" %>
        </header>
        <!-- // header -->
        <main class="container" id="container">
            <div class="inner no_pd">
                <div class="login_box_wrap">
                    <div class="box_inner">
                        <h2>비밀번호 변경</h2>
                        <div class="login_box">
                            <p class="login_txt">
                                안전한 홈페이지 사용을 위하여,<br>
                                6개월마다 비밀번호 변경을 권장하고 있습니다.<br>
                                새로운 비밀번호로 변경해주세요.
                            </p>
                            <form name="memberForm" id="memberForm" role="memberForm" method="post" action="">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <input type="hidden" name="returl" value="${param.returl}">
                                <div class="input_row">
                                    <label for="psw2" class="a11y_hide">기존 비밀번호</label>
                                    <input type="password" name="old_password" class="border_input" placeholder="기존 비밀번호" id="psw">
                                </div>
                                <div class="input_row">
                                    <label for="psw1" class="a11y_hide">신규 비밀번호</label>
                                    <input type="password" name="password" class="border_input" placeholder="신규 비밀번호" id="psw1">
                                    <p class="form_txt">8~14자리 이내로 영문 대소문자, 숫자, 특수문자 중 3가지 이상의 조합으로 입력해주시기 바랍니다. </p>
                                </div>
                                <div class="input_row">
                                    <label for="psw2" class="a11y_hide">비밀번호 확인</label>
                                    <input type="password" name="password_confirm" class="border_input" placeholder="비밀번호 확인" id="psw2">
                                </div>
                                <div class="btn_area">
                                    <a href="javascript:;" id="close" class="btn gray">다음에 변경하기</a>
                                    <button type="submit" class="btn green">비밀번호 변경</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- //container -->
        <!-- [blockUi] 로딩시 class에 on -->
        <div id="blockUi"></div>
        <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- //wrap -->
    <%@ include file="../include/javascript.jsp" %>
    <script>
    $('#close').click(function(){
        if($('[name=returl]').val()!=''){
            window.location.href=$('[name=returl]').val();
        }else{
            window.location.href="${rpath}/index";
        }
    });
    $('[name="memberForm"]').submit(function(){
        if(formValidation()){
            return true;
        }
        return false;
    });
    function formValidation(frm){
        var returnValue = true;
        if($('[name=old_password]').val().length<2){
            alert('기존 비밀번호를 입력해주세요.');
            $('[name=old_password]').focus();
            returnValue = false;
        }else if($('[name=password]').val().length<2){
            alert('신규 비밀번호를 입력해주세요.');
            $('[name=password]').focus();
            returnValue = false;
        }else if($('[name=password_confirm]').val().length<2){
            alert('비밀번호 확인을 입력해주세요.');
            $('[name=password_confirm]').focus();
            returnValue = false;
        }else if( !checkPwd($('[name=password]').val(),$('[name=password_confirm]').val(),'Y', '${sessionScope.memberSession.user_id}') ){
            returnValue = false;
        }else if( !nowPasswordCheck('${sessionScope.memberSession.user_id}',$('[name=old_password]').val()) ){
            returnValue = false;
        }
        return returnValue;
    }

    function nowPasswordCheck(userid,pwd){
        var search_bool = true;
        $.ajax({
            type : "POST",
            url : "/member/pwdSearch",
            cache : false,
            async: false,
            data : {'user_id':userid,'pwd':pwd},
            success : function(datakey, statuskey){
            if(datakey.result==true){
                alert('기존 비밀번호가 맞지 않습니다.');
                search_bool = false;
            }
            },
            error : function(data,status){
            // alert( "관리자에게 문의하시기 바랍니다." );
            }
        });
        return search_bool;
    }
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>