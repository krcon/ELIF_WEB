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
    <meta name="title" content="분양대금 납부조회, 엘리프"/> 
    <meta name="keywords" content="분양대금 납부 조회, 분양 가이드, MY ELIF, 엘리프"/> 
    <meta name="description" content="분양금 납부 관련 내용을 안내해 드립니다. "/>
    <meta property="og:title" content="분양대금 납부조회, 엘리프">
    <meta property="og:description" content="분양금 납부 관련 내용을 안내해 드립니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>분양대금조회 | 엘리프</title>
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
                <section class="visual myelif">
                    <h2>마이 엘리프</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><a href="/mypage/index"><span>마이 엘리프</span></a></li>
                        <li><span>분양대금 조회</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index">홈</a></li>
                            <li><a href="../mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide" class="on">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="../mypage/payment-guide">분양 가이드​</a>
                            </li>
                            <li>
                                <a href="../mypage/payment-lookup">중도금 조회​​</a>
                            </li>
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class=tab_content_wrap>
                        <div class="tab_content" id="tab01">
                            <section class="cont_section">
                                <p class="title1">분양금 납부</p>
                                <div class="guide_box">
                                    <%-- <ul class="guide_list number gap_wide">
                                        <li>
                                            <span class="num">1.</span>분양금, 발코니확장금, PLUS옵션금, 중도금대출이자(중도금이자 후불제 분양 시 해당), 중도금대출보증금(중도금이자 후불제 분양 시 해당), 임대보증금(임대분양 시 해당)은 납부용 계좌(가상계좌)가 별도로 있습니다. 공급(공사)계약서 확인 후 납부하시기 바랍니다.​
                                        </li>
                                        <li>
                                            <span class="num">2.</span>중도금대출금은 신청기간(별도안내)내 서류접수 하여야 중도금 납부 약정일에 맞추어 입금됩니다.​
                                        </li>
                                        <li>
                                            <span class="num">3.</span>분양금, 발코니확장금, 플러스옵션금, 중도금대출이자(중도금이자 후불제 분양 시 해당), 중도금대출보증금(중도금이자 후불제 분양 시 해당), 임대보증금(임대분양 시 해당) 납부 입금증(무통장입금증, 이체확인증 등)은 보관하시기 바랍니다.​
                                        </li>
                                        <li>
                                            <span class="num">4.</span>분양금, 발코니확장금, 플러스옵션금, 중도금대출이자(중도금이자 후불제 분양 시 해당), 중도금대출보증금(중도금이자 후불제 분양 시 해당), 임대보증금(임대분양 시 해당)의 초과(착오)납부 또는 중도금대출상환금을 착오입금 한 경우 환불금 지급신청은 해당분양사무소로 문의하시기 바랍니다.<br>
                                            <ul class="guide_list bar mt20">
                                                <li>준비서류 : 환불요청서(분양사무소 비치), 통장사본, 신분증, 입금증(무통장입금증, 이체확인증 등)</li>
                                            </ul>
                                        </li>
                                    </ul> --%>
                                    <c:out value="${ct:getXssDecode(payment.comments)}" escapeXml="false" />
                                </div>
                            </section>
                            <section class="cont_section">
                                <p class="title1">취득세</p>
                                <div class="guide_box">
                                    <%-- <ul class="guide_list number gap_wide">
                                        <li>
                                            <span class="num">1.</span>취득세 (지방세법 제7조, 지방세법시행령 제20조)​
                                            <p class="guide_txt bar">취득일로부터 60일 이내 해당 시·군·구청 세무과로 자진신고 및 납부하여야 합니다.​</p>
                                            <p class="guide_txt refer">취득일 : 준공일(사용/임시사용승인일) 이전 잔금납부 시 준공일(사용/임시사용승인일)​<br>
                                                준공일(사용/임시사용승인일) 이후 잔금납부 시 잔금납부일​
                                            </p>
                                        </li>
                                        <li>
                                            <span class="num">2.</span>재산세 (지방세법 제107조, 제114조)​
                                            <p class="bar">재산세 과세기준일(매년6월1일) 현재 재산을 사실 상 소유(잔금납부일 또는 등기일 중 선행일)하고 있는 자는 재산세를 납부할 의무가 있습니다.</p>
                                        </li>
                                    </ul> --%>
                                    <c:out value="${ct:getXssDecode(tag.comments)}" escapeXml="false" />
                                </div>
                            </section>
                        </div>
                    </div><!-- //tab_content_wrap -->
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>