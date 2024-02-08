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
                            <li><a href="../mypage/elifNews">엘리프 뉴스</a></li>
                            <li><a href="../mypage/FAQ-view">FAQ</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section title"> <!-- [D] 1028 : 마크업 변경-->
                        <div class="tit">
                            <p><span>더 위버</span>님. 환영합니다.</p>
                        </div>
                    </section>
                    <section class="cont_section remt">
                        <div class="myitem_head">
                            <p class="title1">나의 분양단지</p>
                        </div>
                        <div class="no_data_wrap">
                            <p class="no_data_txt no_data_ico">등록된 단지가 없습니다.<br>분양 받으신 단지를 등록해주세요.</p>
                            <div class="btn_add">
                                <button type="button" class="btn green no_data_btn">단지 등록</button>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section remt">
                        <div class="myitem_head">
                            <p class="title1">공지사항</p>
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
                                        <tr>
                                            <td colspan="3">
                                                <p class="no_data narrow">등록된 공지사항이 없습니다.</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                    <section class="cont_section as">
                        <ul>
                            <li>
                                <div class="as_box">
                                    <div class="as_img">
                                        <img src="/resources/web/images/ico_mypage_inquiry.png" alt="">
                                    </div>
                                    <div class="txt_box">
                                        <span class="tit">고객문의</span>
                                        <p class="txt">궁금하신 내용을 남겨주시면<br>친절하고 신속하게 답변해드립니다.</p>
                                    </div>
                                    <a href="../mypage/inquiry-apply.html">문의하기</a>
                                </div>
                            </li>
                            <li>
                                <div class="as_box">
                                    <div class="as_img">
                                        <img src="/resources/web/images/ico_mypage_as.png" alt="">
                                    </div>
                                    <div class="txt_box">
                                        <span class="tit">A/S 신청</span>
                                        <p class="txt">간편한 A/S 신청을 통해<br>불편사항을 해결해드립니다.</p>
                                    </div>
                                    <a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">신청하기</a>
                                </div>
                            </li>
                        </ul>
                    </section>
                    <div class="mypage_popup hide">
                        <div class="dim"></div>
                        <div class="popup_box">
                            <div class="content_box box1">
                                <div class="popup_head">
                                    <img src="/resources/web/images/logo.png" alt="">
                                </div>
                                <div class="popup_content">
                                    <div class="txt_group">
                                        <p class="tit">분양 받으신 단지와 동/호수를 선택해주세요.</p>
                                        <p class="txt">등록이 완료되시면 홈페이지를 통해 다양한 정보 확인이 가능합니다.</p>
                                    </div>
                                    <div class="info_table">
                                        <table class="table no-head">
                                            <caption>비회원 예약 신청 입력하는 테이블입니다.</caption>
                                            <colgroup>
                                                <col style="width:205x">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th scope="row"><label for="apt" class="tit">단지</label></th>
                                                    <td>
                                                        <div class="muti_input_wrap">
                                                            <select id="apt" class="wmd">
                                                                <option value="hide">선택​</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><label for="detailAddress2" class="tit">동/호수</label></th>
                                                    <td>
                                                        <div class="muti_input_wrap">
                                                            <select id="detailAddress2" class="wsm"> <!-- [D] 1005 : g id 값 변경 -->
                                                                <option value="hide">선택​</option>
                                                            </select>
                                                            <label class="unit" for="detailAddress2">동</label> <!-- [D] 1005 : g label로 변경 -->
                                                            <select id="date" class="wsm">
                                                                <option value="hide">선택​</option>
                                                            </select>
                                                            <label class="unit" for="date">호</label> <!-- [D] 1005 : g label로 변경 -->
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="popup_footer">
                                    <button type="button" class="btn green list push">등록</button>
                                    <button class="popup_close"><img src="/resources/web/images/ico_mypage_close.png" alt="닫기"></button>
                                </div>
                            </div>

                            <!-- [D] 1028 : 등록완료 팝업창 -->
                            <div class="content_box box2 hide">
                                <div class="popup_head">
                                    <img src="/resources/web/images/logo.png" alt="">
                                </div>
                                <div class="popup_content">
                                    <div class="txt_group">
                                        <p class="tit">등록이 완료되었습니다. <br>감사합니다.</p>
                                        <div class="txt_box">
                                            <p>충남 아산 탕정지구 공동주택용지 A13블럭<br> 102동 1002호</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="popup_footer">
                                    <button type="button" class="btn green list clear">완료</button>
                                    <button class="popup_close"><img src="/resources/web/images/ico_mypage_close.png" alt="닫기"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>