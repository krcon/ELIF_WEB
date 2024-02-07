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
    <meta name="keywords" content="엘리프, 회원가입, 본인 인증, 이메일, 아이핀"/> 
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
                                <li class="on"><span class="step">step2</span>본인 인증</li>
                                <li><span class="step">step3</span>개인정보입력</li>
                                <li><span class="step">step4</span>가입완료</li>
                            </ol>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="blind">본인 인증</p>
                        <div class="select_box_wrap">
                            <ul>
						        <!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
                                <li class="s_box join">
                                    <i class="box_ico">
                                        <img src="/resources/web/images/login_ico01.png" alt="">
                                    </i>
                                    <span class="box_tit">휴대전화 인증​</span>
                                    <span class="box-txt">고객님 명의의 휴대전화로<br>본인 인증을 진행해 주시기 바랍니다.</span> 
                                    <button class="btn green" onclick="fnPopup('sms')">인증하기</button>
                                </li>
                            </ul>
                        </div>
                    </section>
                    
                    
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
    <form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">				<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="${sms.sEncData}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    </form>
    <form name="vnoform" method="post" action="/member/join-03">
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