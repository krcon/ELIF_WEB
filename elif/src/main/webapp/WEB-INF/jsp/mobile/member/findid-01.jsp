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
    <meta name="title" content="아이디 찾기, 엘리프"/> 
    <meta name="keywords" content="엘리프, 아이디, 아이디 찾기, 인증, 이메일, 휴대전화"/> 
    <meta name="description" content="엘리프 아이디 찾기 페이지 입니다. "/>
    <meta property="og:title" content="아이디 찾기, 엘리프">
    <meta property="og:description" content="엘리프 아이디 찾기 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>아이디 찾기 | 엘리프 | 모바일</title>
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
                        <h2>아이디 찾기</h2>
                        <div class="login_box">
                            <!-- <p class="login_txt">원하시는 인증방법을 선택해주세요.</p> -->
                            <div class="select_box_wrap row">
                                <ul>
                                    <li class="s_box">
                                        <i class="box_ico">
                                            <img src="/resources/mobile/images/login_ico01.png" alt="">
                                        </i>
                                        <span class="box_tit">휴대전화 인증</span>
                                        <p class="box_txt">고객님 명의의 휴대전화로<br>본인 인증을 진행해 주시기 바랍니다.</p>
                                        <button class="btn green" type="button" onclick="fnPopup('sms')">인증하기</button>
                                    </li>
                                </ul>
                            </div>
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
    <form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">				<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="${sms.sEncData}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    </form>
    <form name="vnoform" method="post" action="${rpath}/member/findid-02">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" name="DI">
        <input type="hidden" name="sName">
        <input type="hidden" name="sGender">
        <input type="hidden" name="sBirthDate">
        <input type="hidden" name="sMobileNo">
        <input type="hidden" name="param_r1" value="">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">
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

    window.onload=function(){
        <c:if test="${!empty sessionScope.returnRequest}">
        var returnRequest = "${sessionScope.returnRequest}";
        if(returnRequest=='pwd'){
            alert("잘못된 이름 또는 전화번호 입니다.");
        }else if(returnRequest=='none'){
            alert("잘못된 이름 또는 전화번호 입니다.");
        }
        <c:remove var="sessionRequest" scope="session" />
        <c:remove var="returnRequest" scope="session" />
        </c:if>
    }
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });

    </script>
</body>

</html>