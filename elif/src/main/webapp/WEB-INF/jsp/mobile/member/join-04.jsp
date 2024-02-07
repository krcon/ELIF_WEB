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
                    <section class="cont_section">
                        <div class="step_list_wrap">
                            <ol class="step_list">
                                <li class="prev"><span class="step"><em>step1 약관 동의</em></span></li>
                                <li class="prev"><span class="step"><em>step2 본인 인증</em></span></li>
                                <li class="prev"><span class="step"><em>step3 개인정보입력</em></span></li>
                                <li class="on"><span class="step"><em>step4 가입완료</em></span></li>
                            </ol>
                        </div>
                    </section>
                    <section class="cont_section sm_mg">
                        <div class="finish_box">
                            <p class="title1">회원가입이 완료되었습니다.</p>
                            <div class="info_box">
                                <ul class="my_info_list">
                                    <li><span class="dt">아이디</span>${member.user_id}</li>
                                    <li><span class="dt">이름</span>${member.user_nm}</li>
                                </ul>
                            </div>
                        </div>
                        <div class="btn_area">
                            <a href="/mobile/member/login" class="btn green">로그인</a>
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
    <script>
        // elif.saleSearch();
    </script>
</body>

</html>