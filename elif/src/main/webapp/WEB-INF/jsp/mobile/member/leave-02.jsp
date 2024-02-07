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
    <meta name="title" content="회원탈퇴, 엘리프"/> 
    <meta name="keywords" content="회원탈퇴, 엘리프"/> 
    <meta name="description" content="엘리프 회원탈퇴 페이지 입니다."/>
    <meta property="og:title" content="회원탈퇴, 엘리프">
    <meta property="og:description" content="엘리프 회원탈퇴 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>회원 탈퇴 | 엘리프 | 모바일</title>
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
                        <h2>회원 탈퇴</h2>
                        <div class="login_box small">
                            <p class="login_txt">회원 탈퇴가 완료되었습니다. <br>그동안 이용해 주셔서 감사합니다.</p>
                            <div class="btn_area">
                                <a href="/" class="btn green">확인</a>
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
    <script>
        // elif.saleSearch();
    </script>
</body>

</html>