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
    <meta name="title" content="사이트맵,엘리프"/> 
    <meta name="keywords" content="엘리프,사이트맵"/> 
    <meta name="description" content="엘리프 홈페이지의 사이트맵을 안내해드립니다."/>
    <meta property="og:title" content="사이트맵,엘리프">
    <meta property="og:description" content="엘리프 홈페이지의 사이트맵을 안내해드립니다.">
    
    <title>사이트 맵 | 엘리프</title>
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
                <section class="visual etc">
                    <h2>사이트 맵</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><span>사이트 맵</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <section class="cont_section nomt">
                        <div class="sitemap_list_wrap">
                            <ul class="sitemap_list">
                                <li>
                                    <a href="/sale/complex" class="menu_name">분양 정보</a>
                                    <ul class="sub_menu_list">
                                        <li><a href="/sale/complex">분양 단지</a></li>
                                        <li><a href="/sale/calendar">분양 캘린더</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="/build/construction" class="menu_name">공사/입주 정보</a>
                                    <ul class="sub_menu_list">
                                        <li><a href="/build/construction">공사 단지</a></li>
                                        <li><a href="/build/movein">입주 단지</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="/brand/story" class="menu_name">브랜드</a>
                                    <ul class="sub_menu_list">
                                        <li><a href="/brand/story">브랜드 스토리</a></li>
                                        <li><a href="/brand/bi">BI</a></li>
                                        <li><a href="/brand/record">시공실적</a></li>
                                        <li><a href="/brand/community">커뮤니티</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="/mypage/index" class="menu_name">마이 엘리프</a>
                                    <ul class="sub_menu_list">
                                        <li><a href="/mypage/index">홈</a></li>
                                        <li><a href="/mypage/mycomplex">나의 분양 단지</a></li>
                                        <li><a href="/mypage/payment-guide">분양대금 조회</a></li>
                                        <li><a href="/mypage/visit-reservation-01">사전점검 방문 예약</a></li>
                                        <li><a href="/mypage/movein-reservation-01">입주 예약</a></li>
                                        <li><a href="/mypage/inquiry-apply">고객 문의</a></li>
                                        <li><a href="/mypage/notice">공지사항</a></li>
                                        <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="/member/login" class="menu_name">회원</a>
                                    <ul class="sub_menu_list">
                                        <c:choose>
                                        <c:when test="${empty sessionScope.memberSession.user_id}">
                                        <li><a href="/member/join-01">회원가입</a></li>
                                        <li><a href="/member/login">로그인</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li><a href="/member/editinfo">회원정보 수정</a></li>
                                        </c:otherwise>
                                        </c:choose>
                                    </ul>
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
</body>

</html>