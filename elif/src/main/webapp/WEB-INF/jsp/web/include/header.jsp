<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="inner">
    <h1><a href="/index"><img src="/resources/web/images/logo.png" alt="ELIF"></a></h1>
    <div class="nav_wrap">
        <nav class="elif_gnb">
            <ul class="gnb_list">
                <li><a href="/sale/complex">분양 정보</a>
                    <ul class="dep2">
                        <li><a href="/sale/complex">분양 단지</a></li>
                        <li><a href="/sale/calendar">분양 캘린더</a></li>
                    </ul>
                </li>
                <li><a href="/build/construction">공사/입주 정보</a>
                    <ul class="dep2">
                        <li><a href="/build/construction">공사 단지</a></li>
                        <li><a href="/build/movein">입주 단지</a></li>
                    </ul>
                </li>
                <li><a href="/brand/story">브랜드</a>
                    <ul class="dep2">
                        <li><a href="/brand/story">브랜드 스토리</a></li>
                        <li><a href="/brand/bi">BI</a></li>
                        <li><a href="/brand/record">시공실적</a></li>
                        <li><a href="/brand/community">커뮤니티</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <nav class="my_gnb">
            <button class="my_link" type="button">MY ELIF</button>
            <div class="my_nav_wrap" style="display: none;">
                <div class="my_nav_header">
                    <c:choose>
                    <c:when test="${empty sessionScope.memberSession.user_id}">
                    <div class="before"> <!-- 로그인 전 -->
                        <a href="/member/login" class="login_btn">
                            <span class="login-txt">로그인</span>
                            입주 및 사전점검 방문 예약은<br>비회원도 신청 가능합니다.
                        </a>
                    </div>
                    </c:when>
                    <c:otherwise>
                    <div class="after"> <!-- 로그인후 -->
                        <c:if test="${!empty sessionScope.memberSession.user_id}">
                        <p class="welcome_txt">${sessionScope.memberSession.user_nm}님 환영합니다.</p>
                        </c:if>
                        <ul class="login_menu_list">
                            <li><a href="javascript:logout();">로그아웃</a></li>
                            <li><a href="/member/editinfo">회원정보 수정</a></li>
                            <li><a href="/member/leave-01">회원 탈퇴</a></li>
                        </ul>
                    </div>
                    </c:otherwise>
                    </c:choose>
                    
                </div>
                <div class="my_nav_body">
                    <ul class="my_nav_list">
                        <li><a href="/mypage/index">홈</a></li>
                        <li><a href="/mypage/mycomplex">나의 분양 단지</a></li>
                        <li><a href="/mypage/payment-guide">분양대금 조회</a></li>
                        <li><a href="/mypage/visit-reservation-01">사전점검 방문 예약</a></li> <!-- [D] 1012 : 로그인 페이지 랜딩 없이 해당 바로 첫화면으로 이동 -->
                        <li><a href="/mypage/movein-reservation-01">입주 예약</a></li> <!-- [D] 1012 : 로그인 페이지 랜딩 없이 바로 해당 첫화면으로 이동 -->
                        <li><a href="/mypage/inquiry-apply">고객 문의</a></li>
                        <li><a href="/mypage/notice">공지사항</a></li>
                        <li><a href="/mypage/elifNews">엘리프 뉴스</a></li>
                        <li><a href="/mypage/FAQ">FAQ</a></li>
                        <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                    </ul>
                </div>
                <button type="button" class="nav_close_btn"><span class="blind">메뉴 닫기</span></button>
            </div>
        </nav>
    </div>
</div>
