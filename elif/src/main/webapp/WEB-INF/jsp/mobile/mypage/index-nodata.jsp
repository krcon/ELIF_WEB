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
    <meta name="title" content="MYELIF 홈, 엘리프"/>
    <meta name="keywords" content="MY ELIF, 엘리프"/>
    <meta name="description" content="MY ELIF 페이지입니다. "/>
    <meta property="og:title" content="MYELIF 홈, 엘리프">
    <meta property="og:description" content="MY ELIF 페이지입니다. ">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>홈 | 엘리프 | 모바일</title>
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
                <section class="visual mypage">
                    <h2>마이 엘리프</h2>
                </section>
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="/mobile/mypage/index" class="on">홈</a></li>
                            <li><a href="/mobile/mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="/mobile/mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="/mobile/mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="/mobile/mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="/mobile/mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="/mobile/mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">나의 분양단지</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap">
                                    <p class="no_data">등록된 분양단지가 없습니다.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section la_mg">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">분양대금 조회</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap">
                                    <p class="no_data">등록된 분양단지가 없습니다.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section la_mg">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">고객 문의 내역</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap board_nodata_wrap">
                                    <p class="no_data">문의 내역이 없습니다.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section la_mg">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">입주 예약 내역</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap">
                                    <p class="no_data">예약 내역이 없습니다.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section la_mg">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">사전점검 방문 예약 내역</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap">
                                    <p class="no_data">예약 내역이 없습니다.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                    
                    <section class="cont_section la_mg">
                        <div class="index_item">
                            <div class="myitem_head">
                                <p class="title1">공지사항</p>
                            </div>
                            <div class="myitem_body">
                                <div class="no_data_wrap board_nodata_wrap">
                                    <p class="no_data">공지사항이 없습니다.</p>
                                </div>
                            </div>
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