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
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="MYELIF 홈, 엘리프">
    <meta property="og:description" content="MY ELIF 페이지입니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>홈 | 엘리프</title>
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
                        <li><span>홈</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index" class="on">홈</a></li>
                            <li><a href="../mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <div class="column_wrap">
                            <div class="column_item">
                                <div class="myitem_head">
                                    <p class="title1">나의 분양 단지</p>
                                    <a href="#" class="plus_link"><span class="blind">나의 분양단지 더보기</span></a>
                                </div>
                                <div class="myitem_body">
                                    <ul class="myitem_list">
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="column_item">
                                <div class="myitem_head">
                                    <p class="title1">분양대금 조회​</p>
                                </div>
                                <div class="myitem_body"> 
                                    <ul class="mycheck_list">
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section">
                        <div class="column_wrap">
                            <div class="column_item">
                                <div class="myitem_head">
                                    <p class="title1">입주 예약 내역</p>
                                    <a href="#" class="plus_link"><span class="blind">입주 예약 내역 더보기</span></a>
                                </div>
                                <div class="myitem_body">
                                    <ul class="myitem_list">
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                                <span class="re_date">2021년 3월 2일</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                                <span class="re_date">2021년 3월 2일</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="column_item">
                                <div class="myitem_head">
                                    <p class="title1">사전점검 방문 예약 내역​</p>
                                </div>
                                <div class="myitem_body">
                                    <ul class="myitem_list">
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                                <span class="re_date">2021년 3월 2일</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="my_link">
                                                <span class="cate">아파트</span>제천강저리슈빌NHF아파트
                                                <span class="re_date">2021년 3월 2일</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section">
                        <div class="myitem_head">
                            <p class="title1">고객 문의 내역​</p>
                            <a href="#" class="plus_link"><span class="blind">고객 문의 내역​ 더보기</span></a>
                        </div>
                        <div class="myitem_body">
                            <div class="info_table board">
                                <table class="table normal_table">
                                    <colgroup>
                                        <!-- <col style="width:150px"> -->
                                        <!-- <col style="width:900px"> -->
                                        <!-- <col style="width:150px"> -->
                                        <col style="width:1000px">
                                        <col style="width:200px">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <!-- <td class="category">홈페이지 문의</td> -->
                                            <td><a href="#" class="title"> 홈페이지 가입은 어디에서 하면 되나요?</a></td>
                                            <td class="tc date">2021년 7월 3일</td>
                                        </tr>
                                        <tr>
                                            <!-- <td class="category">분양 문의</td> -->
                                            <td><a href="#" class="title"> 홈페이지 가입은 어디에서 하면 되나요?</a></td>
                                            <td class="tc date">2021년 7월 3일</td>
                                        </tr>
                                        <tr>
                                            <!-- <td class="category">홈페이지 문의</td> -->
                                            <td><a href="#" class="title"> 홈페이지 가입은 어디에서 하면 되나요?</a></td>
                                            <td class="tc date">2021년 7월 3일</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="blind">기타 메뉴</p>
                        <ul class="box_btn_list">
                            <li class="box_item">
                                <a href="#">
                                    <span>입주예약</span>
                                    <img src="/resources/web/images/box_btn_img1.png" alt="">
                                </a>
                            </li>
                            <li class="box_item">
                                <a href="#">
                                    <span>사전점검 방문 예약</span>
                                    <img src="/resources/web/images/box_btn_img2.png" alt="">
                                </a>
                            </li>
                            <li class="box_item">
                                <a href="#">
                                    <span>A/S 신청</span>
                                    <img src="/resources/web/images/box_btn_img3.png" alt="">
                                </a>
                            </li>
                            <li class="box_item">
                                <a href="#">
                                    <span>고객문의</span>
                                    <img src="/resources/web/images/box_btn_img4.png" alt="">
                                </a>
                            </li>
                        </ul>
                    </section> <!-- [D] 1005 : 순서 변경 -->
                    <section class="cont_section">
                        <div class="myitem_head">
                            <p class="title1">공지사항</p>
                            <a href="#" class="plus_link"><span class="blind">공지사항 더보기</span></a>
                        </div>
                        <div class="myitem_body">
                            <div class="info_table board">
                                <table class="table normal_table">
                                    <colgroup>
                                        <col style="width:104px">
                                        <col style="width:946px">
                                        <col style="width:150px">
                                    </colgroup>
                                    <tbody>
                                        <tr class="notice">
                                            <td class="no_pds tc">공지</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                        <tr>
                                            <td class="no_pds tc">5</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                        <tr>
                                            <td class="no_pds tc">4</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                        <tr>
                                            <td class="no_pds tc">3</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                        <tr>
                                            <td class="no_pds tc">2</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                        <tr>
                                            <td class="no_pds tc">1</td>
                                            <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                            <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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