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
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <link href="/resources/web/css/swiper-5.4.5.min.css" rel="stylesheet">
    <link href="/resources/web/css/slick.css" rel="stylesheet">
    <link href="/resources/web/css/sub.css" rel="stylesheet">
    <link rel="shortcut icon" href="/resources/web/images/common/favicon.ico" />
    <title>계룡건설 엘리프</title>
</head>

<body class="lock">
    <!-- wrap -->
    <div class="wrap">
        <a href="#header" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
        <!-- header -->
        <header id="header" class="main_header">
            <!-- gnb include -->
            <%@ include file="./include/header.jsp" %>
        </header>
        <!-- //header -->
        <!-- intro -->
        <section class="intro">
            <div class="video_wrap">
                <video id="video" class="video" playsinline muted autoplay>
                    <source src="/resources/web/mov/elif_intro.mp4" type="video/mp4">
                </video>
            </div>
            <div class="skipVideo">
                <button id="skipBtn">SKIP</button>
            </div>
        </section>
        <!-- // End of intro -->
        <main id="container" class="main-container">
            <div class="inner">
                <!-- front1 -->
                <section class="cage front1" id="front1">
                    <!-- line banner -->
                    <c:choose>
                        <c:when test="${fn:length(t_popup) > 0}">
                            <section class="banner_line ${fn:length(t_popup) > 1 ?'dual':''}">
                                <c:forEach items="${t_popup }" var="row" varStatus="status">
                                    <div>
                                        <c:if test="${fn:length(row.url_web) > 0}">
                                            <a href="${row.url_web}" ${row.url_web_target=='Y' ?'target="_blank"':'' }>
                                        </c:if>
                                            <p>${row.desc_web}</p>
                                        <c:if test="${fn:length(row.url_web) > 0}">
                                            </a>
                                        </c:if>
                                        <button type="button" class="lineClose">닫기</button>
                                    </div>
                                </c:forEach>
                            </section>
                        </c:when>
                    </c:choose>
                    <!-- // line banner -->
                
                    <div class="visual_slide swiper-container">
                        <div class="swiper-wrapper">
                            <div class="slide1 swiper-slide">
                                <div class="txt_box">
                                    <div class="txt_wrap left left1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0101.png" alt="EVERYDAY">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0102.png" alt="LIFE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0103.png" alt="IS">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0104.png" alt="FINENESS">
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
                                            <img src="/resources/web/images/main-txt_0201.png" alt="EXPECT">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0202.png" alt="LIFESTYLE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0203.png" alt="IS">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0204.png" alt="FINE">
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
                                            <img src="/resources/web/images/main-txt_0301.png" alt="ENJOYABLE">
                                        </span>
                                    </div>
                                    <div class="txt_wrap left left2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0302.png" alt="LIFETIME">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right1">
                                        <span class="box box1"></span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0303.png" alt="IN">
                                        </span>
                                    </div>
                                    <div class="txt_wrap right right2">
                                        <span class="box box1">
                                            <span class="line"></span>
                                        </span>
                                        <span class="box box2">
                                            <img src="/resources/web/images/main-txt_0304.png" alt="FAMILY">
                                        </span>
                                    </div>
                                </div>
                                <div class="bg bg3">
                                    <div class="bg_mask"></div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
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
                            <a href="/sale/calendar" title="${syear}년 분양 캘린더">${syear}년 분양캘린더</a>
                        </div>
                        
                        <div class="search-wrap ">
                            <label for="wantapt" class="a11y_hide">원하는 분양 단지를 검색해 보세요.</label>
                            <form name="" action="/sale/complex">
                            <input id="wantapt" type="text" name="keyword" placeholder="원하는 분양 단지를 검색해 보세요.">
                                <button type="submit"><i class="ico ico_search"><em>분양단지 검색</em></i></button>
                            </form>
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
                                        <a href="${row.subhome_url}" target="_blank" class="">
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
                                                <span><img src="/resources/web/images/main/${imageRand[status.index%6]}" alt=""></span>
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
                    <div class="right">
                        <ul class="slider-nav">
                            <c:choose>
                                <c:when test="${fn:length(list) > 0}">
                                    <c:set var='imageName'
                                        value='${ct:shuffle("slide1-2.png,slide2-2.png,slide3-2.png,slide4-2.png")}' />
                                    <c:forEach items="${list }" varStatus="status">
                                        <li>
                                            <div>
                                                <img src="/resources/web/images/main-${imageName[status.index%4]}" alt="card-img-1">
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            <!--
                            <li><div><img src="/resources/web/images/main-slide1-2.png" alt="card-img-1"></div></li>
                            <li><div><img src="/resources/web/images/main-slide2-2.png" alt="card-img-2"></div></li>
                            <li><div><img src="/resources/web/images/main-slide3-2.png" alt="card-img-3"></div></li>
                            <li><div><img src="/resources/web/images/main-slide4-2.png" alt="card-img-4"></div></li>
                            -->
                        </ul>
                    </div>
                </section>
                <!-- // End of front3 -->
                <!-- front4 -->
                <section class="cage front4" id="front4">
                    <div class="left">
                        <div class="desc">
                            <h2>ENHANCE YOUR LIFE</h2>
                            <!-- <h3>엘리프는 개성과 취향을 추구하는 주거공간,<br>그 이상의 라이프 스타일을 추구합니다</h3> -->
                            <h3>
                                계룡건설의 브랜드 ELIF는 LIFE의 스펠링을 변형하여 <br>
                                삶을 다르게 보고 일상을 새롭게 만들어 가는 주거 공간을 표현했습니다.<br>
                                <br>
                                ELIF는 개성과 취향을 추구하는 주거 공간, <br>
                                그 이상의 라이프 스타일을 추구합니다.
                            </h3>
                        </div>
                    </div>
                    <div class="right">
                        <ul>
                            <li>
                                <div>
                                    <a href="/brand/story">
                                        <div class="area-txt">
                                            <span>브랜드 스토리</span>
                                            <span>당신의 일상에 새로움을 더하는<br>주거 공간의 특별한 기준을 만들어갑니다.</span>
                                        </div>
                                        <div class="area-bg"><img src="/resources/web/images/main-over1.png" alt="브랜드 스토리 바로가기 배경 이미지"></div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <a href="/brand/bi">
                                        <div class="area-txt">
                                            <span>브랜드 아이덴티티</span>
                                            <span>새로운 일상에 대한 자신감을 보여주며<br>품질에 대한 엘리프의 정직한 고집을 표현합니다.</span>
                                        </div>
                                        <div class="area-bg"><img src="/resources/web/images/main-over2.png" alt="브랜드 아이덴티티 바로가기 배경 이미지"></div>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="bg">
                        <div>
                            <video id="mainstory" autoplay muted loop>
                                <source src="/resources/web/mov/elif_main_story_bg.mp4" type="video/mp4"></source>
                            </video> 
                            <!-- <img src="/resources/web/images/main-bg-cover.png" alt=""> -->
                        </div>
                    </div>
                </section>
                <!-- // End of front4 -->
                <!-- front5 -->
                <section class="cage front5" id="front5">
                    <div class="btn-wrap">
                        <ul class="">
                            <li>
                                <a href="/mypage/mycomplex">
                                    <!-- [D] 기획 링크 설명
                                         1. 클릭 시, 나의 분양단지 /mypage/mycomplex 이동
                                         2. 미 로그인 시, 로그인 /member/login 이동
                                         3. 로그인 후, 분양대금 납부조회 페이지로 이동 
                                    -->
                                    <img src="/resources/web/images/box_btn_img1.png" alt="나의 분양 단지 배경이미지" />
                                    <span>나의 분양 단지</span>
                                </a>
                            </li>
                            <li>
                                <a href="/mypage/payment-guide">
                                    <!-- [D] 기획 링크 설명
                                         1. 클릭 시, 분양대금 납부조회 /mypage/payment-guide 이동
                                         2. 미 로그인 시, 로그인 /member/login 이동
                                         3. 로그인 후, 분양대금 조회 페이지로 이동 
                                    -->
                                    <img src="/resources/web/images/box_btn_img2.png" alt="분양대금 납부조회 배경이미지" />
                                    <span>분양대금 납부조회</span>
                                </a>
                            </li>
                            <li>
                                <a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">
                                    <!-- [D] 기획 링크 설명
                                         1. A/S 신청 메뉴 이동 (아웃링크) , URL 추 후 전달 예정 
                                    -->
                                    <img src="/resources/web/images/box_btn_img3.png" alt="A/S 신청 배경이미지" />
                                    <span>A/S 신청</span>
                                </a>
                            </li>
                            <li>
                                <a href="/mypage/inquiry-apply">
                                    <!-- [D] 기획 링크 설명
                                         1. 클릭 시, 고객문의 /mypage/inquiry-apply 이동
                                         2. 미 로그인 시, 로그인 /member/login 이동
                                         3. 로그인 후, 분양대금 납부조회 페이지로 이동 
                                    -->
                                    <img src="/resources/web/images/box_btn_img4.png" alt="고객문의 배경이미지" />
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
        <!-- [blockUi] 로딩시 class에 on -->
        <div id="blockUi"></div>
        <!-- //[blockUi] -->

        <!--s:메인 팝업-->
        <c:choose>
            <c:when test="${fn:length(g_popup) > 0}">
                <!-- banner -->
                <div class="bannerArea">
                <c:forEach items="${g_popup }" var="row" varStatus="status">
                    <div class="banner" id="popup${status.index}" style="left:${row.pos_x}px; top:${row.pos_y}px;">
                        <div class="zone_cls">
                            <form name="formPop" class="bnn_close">
                                <label class="bnn_close today">오늘 하루동안 보지 않기</label>
                                <input onclick="closeWin('popup${status.index}',this);" class="bye" type='checkbox' name='chkbox[]' value='checkbox' >

                                <!--
                                <input onclick="closeWin('popup${status.index}',this);" class="bye" type="checkbox" name="chkbox[]" value="checkbox" >
                                <label class="bnn_close today">오늘 하루동안 보지 않기</label>
                                -->
                            </form>
                            <button type="button" class="bnn_close bye now"><span>닫기</span></button>
                        </div>
                            <c:if test="${fn:length(row.url_web) > 0}">
                                <a href="${row.url_web}" ${row.url_web_target=='Y' ?'target="_blank"':'' }>
                                </c:if>
                                    <div class="zone_img">
                                        <img src="${imgDomain}${row.img_name}" style="max-width:${row.size_w}px;max-height:${row.size_h}px" alt="">
                                    </div>
                                    <div class="zone_txt">
                                        <p></p>
                                    </div>
                                <c:if test="${fn:length(row.url_web) > 0}">
                                </a>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
                <!-- // banner -->
            </c:when>
        </c:choose>
        <!-- //:메인 팝업-->
        
        <!-- footer -->
        <footer>
            <div class="inner">
                <div class="left">
                    <div class="footer_logo">
                        <a href="./index"><img src="/resources/web/images/logo_footer.png" alt="ELIF"></a>
                    </div>
                    <div class="fnb">
                        <ul>
                            <li>
                                <a href="./etc/policies-privacy" class="btn_f1">개인정보처리방침</a>
                            </li>
                            <li>
                                <a href="./etc/policies-terms" class="btn_f1">이용약관</a>
                            </li>
                            <li>
                                <a href="./etc/policies-email" class="btn_f1">이메일무단수집거부</a>
                            </li>
                            <li>
                                <a href="./etc/sitemap" class="btn_f1">사이트맵</a>
                            </li>
                            <li>
                                <a href="./mypage/notice" class="btn_f1">공지사항</a>
                            </li>
                        </ul>
                    </div>
                    <div class="info">
                        <address>
                            <p>대전광역시 서구 문정로 48번길, 48 계룡건설산업㈜</p>
                            <p>Tel. 042-480-7114 | Fax. 042-483-1341</p>
                        </address>
                        <div class="copy">
                            <p>COPYRIGHT ⓒ 2021 BY KYERYONG CONSTRUCTION<br> INDUSTRIAL CO., LTD. ALL RIGHTS RESERVED.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="right">
                    <div class="family"> 
                        <label for="sch_f"></label> 
                        <select id="sch_f">
                            <option value="hide" rel="hide">Family Site</option>
                            <option value="https://www.krcon.co.kr/" rel="javascript();" >계룡건설</option>
                            <option value="https://www.krindus.co.kr/" rel="javascript();">KR산업</option>
                            <option value="http://www.krsanup.co.kr/" rel="javascript();">계룡산업</option>
                        </select>
                    </div>
                    <nav class="map_link">
                        <dl>
                            <dt>분양 정보</dt>
                            <dd>
                                <ul>
                                    <li class="tit"></li>
                                    <li><a href="./sale/complex">분양 단지</a></li>
                                    <li><a href="./sale/calendar">분양 캘린더</a></li>
                                </ul>
                            </dd>
                        </dl>
                        <dl>
                            <dt>공사/입주 정보</dt>
                            <dd>
                                <ul>
                                    <li class="tit"></li>
                                    <li><a href="./build/construction">공사 단지</a></li>
                                    <li><a href="./build/movein">입주 단지</a></li>
                                </ul>
                            </dd>
                        </dl>
                        <dl>
                            <dt>브랜드</dt>
                            <dd>
                                <ul>
                                    <li class="tit"></li>
                                    <li><a href="./brand/story">브랜드 스토리</a></li>
                                    <li><a href="./brand/bi">BI</a></li>
                                    <li><a href="./brand/record">시공실적</a></li>
                                    <li><a href="./brand/community">커뮤니티</a></li>
                                </ul>
                            </dd>
                        </dl>
                    </nav>
                </div>
            </div>
        </footer>
        <!-- //footer -->
    </div>
    <!-- //wrap -->

    
    <script src="/resources/web/js/jquery-3.6.0.min.js"></script>
    <script src="/resources/web/js/anime.min.js"></script>
    <script src="/resources/web/js/TweenMax.min.js"></script>
    <script src="/resources/web/js/swiper-5.4.5.min.js"></script>
    <script src="/resources/web/js/slick.min.js"></script>
    <script src="/resources/web/js/jquery.alphanum.js"></script>
    <script src="/resources/web/js/main.js" defer></script>
    <script src="/resources/web/js/common.js"></script>
    <script src="/resources/web/js/jquery-ui.js" defer></script>
    <script src="/resources/web/js/custom.js"></script>
    <script>
    <c:if test="${param.intro=='f'}">
        $(".intro").remove();
        $(".main-container").css("opacity","1");
        $('body').removeClass('lock');	
            
        startSwiper();
    </c:if>
        //nav-depth2
            var depth0 = $('#header');
            var depth1 = $('.elif_gnb .gnb_list');
            var depth2 = $('.dep2');
            depth1.on('mouseenter', function(e){
                e.preventDefault();
                $('.my_nav_wrap').fadeOut();
                $("header").addClass("on");
                $(depth2, this).show();
            });
            depth0.on('mouseleave', function(e){
                e.preventDefault();
                $("header").removeClass("on");
                $(depth2, this).hide();
            });
            $(".dep2 li a").on('mouseenter', function(e){
                $(this).parents(".gnb_list > li").children("a").addClass("on");
            });
            $(".dep2 li a").on('mouseleave', function(e){
                $(this).parents(".gnb_list > li").children("a").removeClass("on");
            });
    </script>
    <script>
		function setCookie( name, value, expirehours ) {
			var todayDate = new Date();
			todayDate.setHours( todayDate.getHours() + expirehours );
			document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
		}
		function closeWin(id,checkbox) {
			if (checkbox.checked){
				setCookie( id, "done" , 1 );
			}
			$(this).closest('.banner').fadeOut();
		}
		cookiedata = document.cookie; 
		// popup0
		if ( cookiedata.indexOf("popup0=done") < 0 ){$("#popup0").fadeIn();}else {$("#popup0").fadeOut();$(this).closest('.banner').fadeOut();}
		// popup1
		if ( cookiedata.indexOf("popup1=done") < 0 ){$("#popup1").fadeIn();} else {$("#popup1").fadeOut();$(this).closest('.banner').fadeOut();}
		// popup2
		if ( cookiedata.indexOf("popup2=done") < 0 ){$("#popup2").fadeIn();}else {$("#popup2").fadeOut();$(this).closest('.banner').fadeOut();}
		//  popup3
		if ( cookiedata.indexOf("popup3=done") < 0 ){$("#popup3").fadeIn();}else {$("#popup3").fadeOut();$(this).closest('.banner').fadeOut();}
		// common-clz
		$('.bye').click(function(e) {
			$(this).closest('.banner').fadeOut();
			e.preventDefault();
		});
    </script>
    <c:if test="${not empty SITE_ALERT}">
    <script>
    alert("${sessionScope["SITE_ALERT"]}");
    <c:remove var="SITE_ALERT" scope="session" />
    </script>

    </c:if>

    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-8KHL5B9LYV"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-8KHL5B9LYV');
    </script>
</body>

</html>