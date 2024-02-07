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
    <meta name="keywords" content="엘리프, 회원가입, 약관동의, 이용약관"/> 
    <meta name="description" content="엘리프 회원가입 페이지 입니다."/>
    <meta property="og:title" content="회원가입,엘리프">
    <meta property="og:description" content="엘리프 회원가입 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>회원가입 | 엘리프 | 모바일</title>
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
            <div class="inner">
                <section class="visual join">
                    <h2>회원 가입</h2>
                </section>
                <div class="contents_wrap">
                    <section class="cont_section sm_mg">
                        <div class="step_list_wrap">
                            <ol class="step_list">
                                <li class="prev"><span class="step"><em>step1 약관 동의</em></span></li>
                                <li class="on"><span class="step"><em>step2 본인 인증</em></span></li>
                                <li><span class="step"><em>step3 개인정보입력</em></span></li>
                                <li><span class="step"><em>step4 가입완료</em></span></li>
                            </ol>
                        </div>
                    </section>
                    <section class="cont_section sm_mg">
                        <div class="select_box_wrap col">
                            <ul>
                                <li class="s_box">
                                    <i class="box_ico">
                                        <img src="/resources/mobile/images/login_ico01.png" alt="">
                                    </i>
                                    <span class="box_tit">휴대전화 인증</span>
                                    <p class="box_txt">고객님 명의의 휴대전화로<br>본인 인증을 진행해 주시기 바랍니다.</p>
                                </li>
                            </ul>
                            <button class="btn green" type="button" onclick="fnPopup('sms')">인증하기</button>
                        </div>
                    </section>
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
    <form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">				<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="${sms.sEncData}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    </form>
    <form name="vnoform" method="post" action="${rpath}/member/join-03">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" name="DI">
        <input type="hidden" name="sName">
        <input type="hidden" name="sGender">
        <input type="hidden" name="sBirthDate">
        <input type="hidden" name="sMobileNo">
        <input type="hidden" name="param_r1" value="">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">
        <input type="hidden" name="agree01" value="Y">
        <input type="hidden" name="agree02" value="Y">
    </form>
    <script>
    window.name ="Parent_window";

    function fnPopup(type){
        if(type=='ipin'){
            window.open('', 'popupMember', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_ipin.target = "popupMember";
            document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
            document.form_ipin.submit();
        }else{
            window.open('', 'popupMember', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupMember";
            document.form_chk.submit();
        }
    }


    </script>
</body>

</html>