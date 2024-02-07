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
    <meta name="title" content="BI, 엘리프"/>
    <meta name="keywords" content="BI, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 BI를 소개합니다."/>
    <meta property="og:title" content="BI, 엘리프">
    <meta property="og:description" content="엘리프의 BI를 소개합니다. ">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>BI | 엘리프 | 모바일</title>
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
                <!-- Visual & Title -->
                <section class="visual brand">
                    <h2>브랜드</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./story">브랜드 스토리</a></li>
                            <li><a href="./bi" class="on">BI</a></li>
                            <li><a href="./record">시공실적</a></li>
                            <li><a href="./community">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <p class="bi_eng_title">Brand Identity</p>
                        <div class="brand_cont_box">
                            <div class="elif_motto">
                                <p class="elif_tit">'일상을 새롭게 하다'</p>
                                <p class="elif_txt">LIFE의 스펠링을 ELIF로 변형하여<br> 삶을 다르게 보고<br> 일상을 새롭게 만들어 가는<br> 엘리프의 주거공간을 표현하였습니다.</p>
                                <img src="/resources/mobile/images/bi.svg" alt="ELIF BI">
                            </div>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="bi_eng_title">Color System</p>
                        <div class="brand_cont_box">
                            <p class="bi_eng_title2">Primary Color </p>
                            <ul class="color-table-list">
                                <li class="color-item primary color_w">
                                    <div class="color_define">
                                        <strong>ELIF GREEN </strong>
                                        PANTONE 3308C
                                    </div>
                                    <div class="color_value">
                                        C91&nbsp;&nbsp;M47&nbsp;&nbsp;Y73&nbsp;&nbsp;50<br>
                                        R28&nbsp;&nbsp;G67&nbsp;&nbsp;B65<br>
                                        #054438
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="brand_cont_box">
                            <p class="bi_eng_title2">Secondary Color</p>
                            <ul class="color-table-list">
                                <li class="color-item pale_green">
                                    <div class="color_define">
                                        <strong>ELIF PALE GREEN</strong>
                                        PANTONE 9063C
                                    </div>
                                    <div class="color_value">
                                        C7&nbsp;&nbsp;M5&nbsp;&nbsp;Y13&nbsp;&nbsp;K0<br>
                                        R235&nbsp;&nbsp;G233&nbsp;&nbsp;B219<br>
                                        #EBE9DC
                                    </div>
                                </li>
                                <li class="color-item lime">
                                    <div class="color_define">
                                        <strong>ELIF LIME</strong>
                                        PANTONE 2274C
                                    </div>
                                    <div class="color_value">
                                        C15&nbsp;&nbsp;M6&nbsp;&nbsp;Y32&nbsp;&nbsp;K0<br>
                                        R218&nbsp;&nbsp;G221&nbsp;&nbsp;B183<br>
                                        #DADDB9
                                    </div>
                                </li>
                                <li class="color-item beige">
                                    <div class="color_define">
                                        <strong>ELIF BEIGE</strong>
                                        PANTONE 7528C
                                    </div>
                                    <div class="color_value">
                                        C22&nbsp;&nbsp;M23&nbsp;&nbsp;Y34&nbsp;&nbsp;K0<br>
                                        R210&nbsp;&nbsp;G187&nbsp;&nbsp;B166<br>
                                        #C8BAA7
                                    </div>
                                </li>
                                <li class="color-item lime2 color_w">
                                    <div class="color_define">
                                        <strong>ELIF WARM GRAY</strong>
                                        PANTONE WARMGRAY 9C
                                    </div>
                                    <div class="color_value">
                                        C58&nbsp;&nbsp;M52&nbsp;&nbsp;Y52&nbsp;&nbsp;K6<br>
                                        R120&nbsp;&nbsp;G116&nbsp;&nbsp;B114<br>
                                        #787472
                                    </div>
                                </li>
                            </ul>
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
    </script>
</body>

</html>