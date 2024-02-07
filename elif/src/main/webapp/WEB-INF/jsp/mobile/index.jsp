<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="./include/head.jsp" %>
    <meta name="title" content="계룡건설 엘리프"/> 
    <meta name="keywords" content="계룡건설 엘리프, 엘리프, ELIF, 계룡건설, 분양, 공사, 입주, 프리미엄 주거 공간"/> 
    <meta name="description" content="계룡건설의 신규 주거 브랜드 ELIF(엘리프)의 공식 홈페이지 입니다."/>
    <meta property="og:title" content="계룡건설 엘리프">
    <meta property="og:description" content="계룡건설의 신규 주거 브랜드 ELIF(엘리프)의 공식 홈페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <link rel="stylesheet" href="/resources/mobile/css/plugin/swiper-5.4.5.min.css">
    <title>계룡건설 엘리프</title>
</head>

<body>
    <!-- 메인 비주얼 브라우저 상하단 바 상관없이 화면에 꽉 차게 하는 영역 -->
    <div id="viewportSizeCheck" class="viewport_size"></div>
    <!-- // 메인 비주얼 브라우저 상하단 바 상관없이 화면에 꽉 차게 하는 영역 -->

    <!-- wrap -->
    <div class="wrap">
        <a href="#header" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
      <!-- header -->
      <header id="header" class=""><!-- 마이 엘리프 : my_open / 메뉴 : gnb_open -->
        <!-- gnb include -->
        <%@ include file="./include/header.jsp" %>
    </header>
    <!-- // header -->
        <main id="container" class="main-container">
            <div class="inner">
                    <c:choose>
                        <c:when test="${fn:length(g_popup) > 0}">
                                <!-- banner -->
                        <div class="bannerArea">
                        <c:forEach items="${g_popup }" var="row" varStatus="status">
                            <div class="banner bnn${status.index}">
                                <a href="javascript:void(0);" class="bnn_close"><span class="blind">닫기</span></a>
                                
                                <c:if test="${fn:length(row.url_mobile) > 0}">
                                    <a href="${row.url_mobile}" ${row.url_mobile_target=='Y' ?'target="_blank"':'' }>
                                </c:if>
                                    <div class="zone_img">
                                        <img src="/resources/mobile/images/pop/bnn${row.theme}.png" alt="">
                                        <!-- 
                                            [D] 테마 4종 관련  배경 이미지
                                            ▶ /bnn1 ~ 4.png

                                            ※ 'bnn숫자'클래스와 무관합니다
                                        -->
                                    </div>
                                    <div class="zone_txt">
                                        <p>${row.desc_mobile}</p>
                                    </div>
                                <c:if test="${fn:length(row.url_mobile) > 0}">
                                    </a>
                                </c:if>
                            </div>
                        </c:forEach>
                        </div>
                        <!-- // banner -->
                        </c:when>
                    </c:choose>
                    <!-- 2개 이상일 경우 -->
                <!-- intro -->
                <section class="intro">
                    <div class="skipIntro">
                        <button id="skipBtn">SKIP</button>
                    </div>
                    <div class="typo_wrap">
                        <svg xmlns="http://www.w3.org/2000/svg" width="216.018" height="75.889" viewBox="0 0 216.018 54.889">
                            <pattern id="wave" width=".25" height="1.1" patternContentUnits="objectBoundingBox">
                                <path fill="#ffffff" d='M-300,-267 C1207,-596 -444,1160 -300,-267'/>
                            </pattern>
                            <path id="elif_ee" class="efectELIF" d="M440.868,319.526v-4.6H412.85V369.7h10.817V345.043H438.23v-4.6H423.667V319.526Z" transform="translate(-224.85 -314.93)" />
                            <path id="elif_ll" class="efectELIF" d="M388.047,318.268h-10.87v46.889H388.2Z" transform="translate(-240.177 -310.268)" />
                            <path id="elif_ii" class="efectELIF" d="M388.047,318.268h-10.87v46.889H405.2v-4.595H388.047Z" transform="translate(-308.177 -310.268)"/>
                            <path id="elif_ff" class="efectELIF" d="M366.563,343.95h14.564v-4.595H366.563v-19.83h17.2V314.93H355.747V369.7h29.227v-4.594H366.563Z" transform="translate(-355.747 -314.93)" />
                            <mask id="text_mask">
                                <use x="0" y="0" xlink:href="#elif_ee" opacity="1" fill="#ffffff"/>
                                <use x="0" y="0" xlink:href="#elif_ll" opacity="1" fill="#ffffff"/>
                                <use x="0" y="0" xlink:href="#elif_ii" opacity="1" fill="#ffffff"/>
                                <use x="0" y="0" xlink:href="#elif_ff" opacity="1" fill="#ffffff"/>
                            </mask>
                            <use x="0" y="0" xlink:href="#elif_ee" fill="#011612"/>
                            <use x="0" y="0" xlink:href="#elif_ll" fill="#011612"/>
                            <use x="0" y="0" xlink:href="#elif_ii" fill="#011612"/>
                            <use x="0" y="0" xlink:href="#elif_ff" fill="#011612"/>
                            <rect class="water-fill" mask="url(#text_mask)" fill="url(#wave)" x="0" y="0" rx="400" ry="400" />
                        </svg>

                        <div>
                            <p>개성과 취향을 추구하는 주거 공간,<br>그 이상의 라이프 스타일을 추구합니다</p>
                        </div>
                    </div>
                </section>
                <!-- // End of intro -->
                <!-- front1 -->
                <section class="visual_sec">
                    <!-- visual_slide -->
                    <div class="visual_slide swiper-container">
                        <div class="swiper-wrapper">
                            <div class="slide1 swiper-slide">
                                <div class="txt_box">
                                    <div class="txt_wrap left left1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0101.png" alt="EVERYDAY">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0102.png" alt="LIFE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0103.png" alt="IS">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0104.png" alt="FINENESS">
                                        </span>
                                    </div>
                                </div>
                                <div class="bg bg1">
                                    <div class="bg_mask"></div>
                                </div>
                            </div>
        
                            <div class="slide2 swiper-slide">
                                <div class="txt_box">
                                    <div class="txt_wrap left left1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0201.png" alt="EXPECT">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0202.png" alt="LIFESTYLE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0203.png" alt="IS">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0204.png" alt="FINE">
                                        </span>
                                    </div>
                                </div>
                                <div class="bg bg2">
                                    <div class="bg_mask"></div>
                                </div>
                            </div>
        
                            <div class="slide3 swiper-slide">
                                <div class="txt_box">
                                    <div class="txt_wrap left left1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0301.png" alt="ENJOYABLE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0302.png" alt="LIFETIME">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0303.png" alt="IN">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/mobile/images/main/txt_0304.png" alt="FAMILY">
                                        </span>
                                    </div>
                                </div>
                                <div class="bg bg3">
                                    <div class="bg_mask"></div>
                                </div>
                            </div>
                        </div>
                        <div class="slide_indigater swiper-pagination"></div>
                    </div>
                    <!-- //visual_slide  -->
                </section>
                <!-- // End of front1 -->
                <!-- front2 -->
                <section class="cage front2" id="front2">
                    <h2 class="text-roller">
                        <div class="text-roller-wrapper">
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                            <span>ENHANCE YOUR LIFE WITH ELIF, </span>
                        </div>
                    </h2>
                    <h3>ELIF는 개성과 취향을 추구하는 주거 공간,<br>그 이상의 라이프 스타일을 추구합니다.</h3>
                    <!-- 
                    <h3>
                        계룡건설의 브랜드 ELIF는 LIFE의 스펠링을 변형하여 <br> 
                        삶을 다르게 보고 일상을 새롭게 만들어 가는 주거 공간을 표현했습니다.<br>
                        <br>
                        ELIF는 개성과 취향을 추구하는 주거공간, <br>
                        그 이상의 라이프 스타일을 추구합니다. 
                    </h3>
                     -->
                </section>
                <!-- // End of front2 -->
                <!-- front3 -->
                <section class="cage front3 clear" id="front3">
                    <div class="left">
                        <div class="btn-wrap ">
                            <c:set var="now" value="<%=new java.util.Date()%>" />
                            <c:set var="syear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
                            <a href="/mobile/sale/calendar" title="${syear}년 분양 캘린더">${syear}년 분양캘린더</a>
                        </div>
                        <div class="sld-wrap">
                            <ul class="slider-for">
                            <c:choose>
                                <c:when test="${fn:length(list) > 0}">
                                    <c:set var='imageRand' value='${ct:shuffle("thum01.jpg,thum02.jpg,thum03.jpg,thum04.jpg,thum04.jpg,thum05.jpg,thum06.jpg")}' />
                                    <c:forEach items="${list }" var="row" varStatus="status">
                                    <li data-pjt_cd="${row.pjt_cd}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
                                        <c:choose>
                                        <c:when test="${!empty row.subhome_url}">
                                        <a href="${row.subhome_url}" target="_blank" class="btn_detail">
                                        </c:when>
                                        <c:otherwise>
                                        <a href="javascript:;" class="btn_detail no-data">
                                        </c:otherwise>
                                        </c:choose>
                                            <div class="img_area">
                                                <c:choose>
                                                <c:when test="${!empty row.sales_main_name}">
                                                <span><img src="${row.sales_main_path}${row.sales_main_name}" alt=""></span>
                                                </c:when>
                                                <c:otherwise>
                                                <span><img src="/resources/mobile/images/main/${imageRand[status.index%6]}" alt=""></span>
                                                </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <dl class="info">
                                                <dt class="tit">${row.pjt_nm}</dt>
                                                <dd class="sub">${fn:replace(row.main_comment, newLineChar, "<br/>")}</dd>
                                                <dd>
                                                    <i class="flag_type color2">
                                                        <c:choose>
                                                        <c:when test="${row.progress=='RV02204'||row.progress=='RV02205'}">
                                                        분양완료
                                                        </c:when>
                                                        <c:otherwise>
                                                        ${row.progress_name}
                                                        </c:otherwise>
                                                        </c:choose>
                                                    </i>
                                                </dd>
                                            </dl>
                                        </a>
                                    </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            </ul>
                        </div>
                    </div>
                </section>
                <!-- // End of front3 -->
                <!-- front4 -->
                <section class="cage front4" id="front4">
                    <div class="left">
                        <div class="desc">
                            <div class="txt_group">
                                <h2>ENHANCE<br>YOUR LIFE</h2>
                                <!-- <h3>엘리프는 개성과 취향을 추구하는 주거공간, <br>그 이상의 라이프스타일을 추구합니다</h3> -->
                                <h3>
                                    계룡건설의 브랜드 ELIF는 LIFE의 스펠링을<br>
                                    변형하여 삶을 다르게 보고 일상을 새롭게<br>
                                    만들어가는 주거 공간을 표현했습니다.<br>
                                    <br>
                                    ELIF는 개성과 취향을 추구하는 주거 공간, <br>
                                    그 이상의 라이프 스타일을 추구합니다. 
                                </h3>
                            </div>
                            <div class="box_imgs">
                                <img src="/resources/mobile/images/main-slide2-1.png" alt="라이프스타일">
                                <img src="/resources/mobile/images/main-slide2-2.png" alt="라이프스타일">
                                <img src="/resources/mobile/images/main-slide2-3.png" alt="라이프스타일">
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <ul>
                            <li>
                                <div>
                                    <a href="/mobile/brand/bi">
                                        <div class="area-txt">
                                            <span>브랜드 아이덴티티</span>
                                            <span class="hd">새로운 일상에 대한 자신감을 보여주며<br>품질에 대한 엘리프의 정직한 고집을 표현합니다.</span>
                                        </div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <a href="/mobile/brand/story">
                                        <div class="area-txt">
                                            <span>브랜드 스토리</span>
                                            <span class="hd">당신의 일상에 새로운을 더하는<br>주거 공간의 특별한 기준을 만들어갑니다.</span>
                                        </div>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </section>
                <!-- // End of front4 -->
                <!-- front5 -->
                <section class="cage front5" id="front5">
                    <div class="btn-wrap">
                        <p class="front_tit">My ELIF</p>
                        <ul class="">
                            <li>
                                <a href="/mobile/mypage/mycomplex">
                                    <img src="/resources/mobile/images/box_btn_img1.png" alt="나의 분양 단지" />
                                    <span class="white">나의 분양 단지</span>
                                </a>
                            </li>
                            <li>
                                <a href="/mobile/mypage/payment-guide">
                                    <img src="/resources/mobile/images/box_btn_img2.png" alt="분양대금 납부조회" />
                                    <span>분양대금 납부조회</span>
                                </a>
                            </li>
                            <li>
                                <a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">
                                    <img src="/resources/mobile/images/box_btn_img3.png" alt="A/S 신청" />
                                    <span>A/S 신청</span>
                                </a>
                            </li>
                            <li>
                                <a href="/mobile/mypage/inquiry-apply">
                                    <img src="/resources/mobile/images/box_btn_img4.png" alt="고객문의" />
                                    <span>고객문의</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </section>
                <!-- // End of front5 -->
                
            </div>
        </main>
        <!-- //container -->
        <%@ include file="./include/footer.jsp" %>
    </div>
    <%@ include file="./include/javascript.jsp" %>
    <script src="/resources/mobile/js/TweenMax.min.js"></script>
    <script src="/resources/mobile/js/swiper-5.4.5.min.js"></script>
    <script src="/resources/mobile/js/main.js"></script>
    </script>
    <c:if test="${not empty SITE_ALERT}">
    <script>
    alert("${sessionScope["SITE_ALERT"]}");
    <c:remove var="SITE_ALERT" scope="session" />
    </script>
    </c:if>
   

</html>