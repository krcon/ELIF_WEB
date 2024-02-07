<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="header"> <!-- 마이 엘리프 : my_open / 메뉴 : gnb_open -->
    <h1><a href="/mobile/index"><img src="/resources/mobile/images/logo.png" alt="ELIF"></a></h1>
    <div class="left_wrap" >
        <div class="left">
            <button type="button" class="btn_myelif" id="myElifBtn"><span>MY ELIF</span></button>
        </div>
        <nav class="my_nav">
            <div class="my_nav_wrap">
                <div class="my_nav_header">

                    <c:choose>
                    <c:when test="${empty sessionScope.memberSession.user_id}">
                    <div class="before"> <!-- 로그인 전 -->
                    <div class="before">
                        <a href="/mobile/member/login" class="login_btn">
                            <span class="login-txt"><em>로그인</em></span>
                            입주 및 사전점검 방문 예약은<br>비회원도 신청 가능합니다.
                        </a>
                    </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                    <div class="after">
                        <c:if test="${!empty sessionScope.memberSession.user_id}">
                        <p class="welcome_txt">${sessionScope.memberSession.user_nm}님 환영합니다.</p>
                        </c:if>
                        <ul class="login_menu_list">
                            <li><a href="javascript:logout();">로그아웃</a></li>
                            <li><a href="/mobile/member/editinfo">회원정보 수정</a></li>
                            <li><a href="/mobile/member/leave-01">회원 탈퇴</a></li>
                        </ul>
                    </div>
                    </c:otherwise>
                    </c:choose>
                    

                </div><!-- //my_nav_header -->
                <div class="my_nav_body">
                    <ul class="my_menu_list">
                        <li><a href="/mobile/mypage/index">홈</a></li>
                        <li><a href="/mobile/mypage/mycomplex">나의 분양 단지</a></li>
                        <li><a href="/mobile/mypage/payment-guide">분양대금 조회</a></li>
                        <li><a href="/mobile/mypage/visit-reservation-01">사전점검 방문 예약</a></li> <!-- [D] 1012 : 로그인 페이지 랜딩 없이 바로 해당 첫화면으로 이동 -->
                        <li><a href="/mobile/mypage/movein-reservation-01">입주 예약</a></li> <!-- [D] 1012 : 로그인 페이지 랜딩 없이 바로 해당 첫화면으로 이동 -->
                        <li><a href="/mobile/mypage/inquiry-apply">고객 문의</a></li>
                        <li><a href="/mobile/mypage/notice">공지사항</a></li>
                        <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li> 
                    </ul>
                </div><!-- //my_nav_body -->
                <button class="close_btn"><span><span class="blind">마이 엘리프 메뉴 닫기</span></span></button>
            </div>
        </nav>
    </div><!-- //left_wrap -->
    <div class="right_wrap">
        <div class="right">
            <button type="button" id="gnbMenuBtn" class="btn_gnb">
                <span>
                    <em>메뉴열기</em>
                </span>
            </button>
        </div>
        <nav class="elf_nav">
            <div class="elf_nav_wrap">
                <div class="elf_nav_body">
                    <ul class="elf_menu_list">
                        <li class="elf_item">
                            <span class="tit">분양 정보</span>
                            <ul class="menu_box">
                                <li><a href="/mobile/sale/complex">분양 단지</a></li>
                                <li><a href="/mobile/sale/calendar">분양 캘린더</a></li>
                            </ul>
                        </li>
                        <li class="elf_item">
                            <span class="tit">공사/입주 정보</span>
                            <ul class="menu_box">
                                <li><a href="/mobile/build/construction">공사 단지</a></li>
                                <li><a href="/mobile/build/movein">입주 단지</a></li>
                            </ul>
                        </li>
                        <li class="elf_item">
                            <span class="tit">브랜드</span>
                            <ul class="menu_box">
                                <li><a href="/mobile/brand/story">브랜드 스토리</a></li>
                                <li><a href="/mobile/brand/bi">BI</a></li>
                                <li><a href="/mobile/brand/record">시공실적</a></li>
                                <li><a href="/mobile/brand/community">커뮤니티</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="etc_wrap">
                        <ul class="etc_menu_list">
                            <li><a href="/mobile/etc/policies-terms">이용약관</a></li>
                            <li><a href="/mobile/etc/policies-email">이메일무단수집거부</a></li>
                            <li><a href="/mobile/etc/policies-privacy">개인정보처리방침</a></li>
                            <li><a href="/mobile/mypage/notice">공지사항</a></li>
                        </ul>
                        <label for="sch_f"><span class="a11y_hide">선택</span></label>
                        <select class="family_select" id="sch_f">
                            <option value="hide" hidden>Family Site</option>
                            <option value="https://www.krcon.co.kr/">계룡건설</option>
                            <option value="https://www.krindus.co.kr/">KR산업</option>
                            <option value="http://www.krsanup.co.kr/">계룡산업</option>
                        </select>
                    </div>
                </div>
            </div>
        </nav>
    </div><!-- //right_wrap -->
    <span class="dim"></span>
</div>

