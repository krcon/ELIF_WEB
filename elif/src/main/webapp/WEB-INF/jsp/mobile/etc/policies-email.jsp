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
    <meta name="title" content="이메일무단수집거부,엘리프"/>
    <meta name="keywords" content="엘리프, 이메일 무단 수집 거부"/>
    <meta name="description" content="엘리프 홈페이지의 이메일무단수집거부에 대해 안내해드립니다."/>
    <meta property="og:title" content="이메일무단수집거부,엘리프">
    <meta property="og:description" content="엘리프 홈페이지의 이메일무단수집거부에 대해 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>이메일 무단 수집 거부 | 엘리프 | 모바일</title>
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
        <main class="container" id="container">
            <div class="inner">
                <!-- Visual & Title -->
                <section class="visual etc">
                    <h2>이메일 무단 수집 거부</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <div class="contents_wrap">

                    <div class="error_box">
                        <i class="ico">
                            <img src="/resources/mobile/images/email_ico.svg" alt=""> <!-- [D] 0915 : 변경 -->
                        </i>
                        <p class="tit">엘리프 웹사이트는<br>이메일 주소 수집을 거부합니다.</p>
                        <p class="box_txt">본 사이트에 게시된 이메일 주소가 전자우편수집 프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.</p>
                        <p class="box_date">게시일 : 2021년 10월 08일</p>
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