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
    <%@ include file="../include/head_story.jsp" %>
    
    <meta name="title" content="브랜드 스토리, 엘리프"/> 
    <meta name="keywords" content="브랜드 스토리, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/> 
    <meta name="description" content="엘리프의 브랜드 스토리를 소개합니다. "/>
    <meta property="og:title" content="브랜드 스토리, 엘리프">
    <meta property="og:description" content="엘리프의 브랜드 스토리를 소개합니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>브랜드 스토리 | 엘리프</title>
</head>

<body>
    <div id="wrap">
        <div id="fullpage">
            <!-- header --
            <div id="header">
                <a href="/" class="logo"><img src="/resources/web/images/story/logo.png" alt="ELIF"></a>
                <div class="gnb">
                    <ul>
                        <li><a href="javascript:;">분양 정보</a></li>
                        <li><a href="javascript:;">공사/입주 정보</a></li>
                        <li><a href="javascript:;">브랜드</a></li>
                        <li class="my"><a href="javascript:;">MY ELIF</a></li>
                    </ul>
                </div>
            </div>
            -- header // -->

            <!-- header -->
            <header id="header">
                <!-- gnb include -->
                <%@ include file="../include/header.jsp" %>
            </header>
            <!-- //header -->

            <!-- section01 -->
            <div class="section section01">
                <div class="sub_visual">
                    <div class="inner">
                        <div class="top">
                            <h3>브랜드</h3>
                            <div class="nav_depth">
                                <ul>
                                    <li><a href="/index"><img src="/resources/web/images/story/nav_depth_home_icon.png" alt="메인으로"></a></li>
                                    <li><a href="/brand/story">브랜드</a></li>
                                    <li><a href="jsavascript:void(0);">브랜드 스토리</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="bot">
                            <div class="nav_tab">
                                <ul>
                                    <li class="on"><a href="./story">브랜드 스토리</a></li>
                                    <li><a href="./bi">BI</a></li>
                                    <li><a href="./record">시공실적</a></li>
                                    <li><a href="./community">커뮤니티</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box">
                    <div class="inner">
                        <div class="center">
                            <p data-animationNum1="1">ENHANCE</p>
                            <!-- <p data-animationNum1="2">YOUR</p> -->
                            <div class="slider" data-animationNum1="5">
                                <div class="slider_blank"></div>
                                <div class="text">
                                    <span class="left">BRAND STORY</span>
                                    <span class="right">BRAND STORY</span>
                                </div>
                                <div class="swiper01">
                                    <ul class="swiper-wrapper">
                                        <li class="swiper-slide"><img src="/resources/web/images/story/section01_slider_img01.jpg" alt="img"></li>
                                        <li class="swiper-slide"><img src="/resources/web/images/story/section01_slider_img02.jpg" alt="img"></li>
                                        <li class="swiper-slide"><img src="/resources/web/images/story/section01_slider_img03.jpg" alt="img"></li>
                                    </ul>
                                </div>
                            </div>
                            <p data-animationNum1="3">YOUR LIFE</p>
                            <span data-animationNum1="4">일상을 새롭게 하다</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- section01 //-->
            
            <!-- section02 -->
            <div class="section section02 fp-noscroll" data-animationNum2="4">
                <div class="bg" data-animationNum2="1"></div>
                <div class="inner">
                    <div class="txt">
                        <h3 data-animationNum2="2">
                            주거의 본질에 집중한 엄선된 공간과<br/>
                            그 안에서 펼쳐지는 나만의 개성과 취향,<br/>
                            그 이상의 라이프 스타일을 추구합니다.
                        </h3>
                        <div class="desc" data-animationNum2="3">
                            <p>
                                하루를 새롭게 시작하는 곳,<br/>
                                일상이 새롭게 연결되는 곳 
                            </p>
                            <p>
                                모두에게 새로운 삶의 가치와<br/>
                                여유로운 공간을 제공합니다.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- section02 //-->

            <!-- section03 -->
            <div class="section section03 fp-noscroll">
                <div class="inner">
                    <ul>
                        <li data-animationNum3="1">
                            <span>MISSION</span>
                            <div class="img" style="background-image:url('/resources/web/images/story/section03_img01.jpg')">
                                <p>
                                    모두의 일상에 활력을 주는 집을 짓는다는 마음으로<br/>
                                    입지 선정, 상품개발, 디자인, 시공, 사후서비스 등<br/>
                                    각 분야에서 끊임없이 고민하고 앞서겠습니다.
                                </p>
                            </div>
                        </li>
                        <li data-animationNum3="2">
                            <span>VISION</span>
                            <div class="img_box">
                                <img src="/resources/web/images/story/section03_img02.jpg" alt="img">
                            </div>
                            <p>
                                주거의 핵심에 집중하고, 남다른 프리미엄 공간 구현을 통해<br/>
                                새로운 일상을 추구하는 ELIF가 되겠습니다.
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- section03 //-->

            <!-- section04 -->
            <div class="section section04 fp-noscroll">
                <!-- 2021-12-06 바뀐부분 -->
                <div class="slide_wrap slideup_slider">
                    <div class="fixed_box">
                        <div class="txt03">
                            <span data-animationCommon="2"><b>Brand Value</b></span>
                            <div class="hr" data-animationCommon="1"></div>
                            <div class="text"></div>
                            <div class="hr" data-animationCommon="1"></div>
                        </div>
                    </div>
                    <ul class="slide_container">
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg01.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt01">
                                    <div class="round" data-animationSlide1="3"></div>
                                    <div class="center" data-animationSlide1="4">
                                        <p data-animationSlide1="1">공간을 짓는 것만으로는 집을 완성할 수 없습니다.</p>
                                        <p data-animationSlide1="2">
                                            그 공간에서 함께 만들어가는 일상이,<br/>
                                            비로소 삶을 새롭게 구현하는 집을 완성합니다.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg01.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt01">
                                    <div class="round" data-animationSlide1="3"></div>
                                </div>
                                <div class="txt02">
                                    <ul>
                                        <li>
                                            <div class="round" data-animationSlide1-1="5"></div>
                                            <p data-animationSlide1-1="6">
                                                주거의 본질에<br/>
                                                대한 통찰력
                                            </p>
                                            <div class="hr" data-animationSlide1-1="7"></div>
                                            <span data-animationSlide1-1="8">Insight</span>
                                        </li>
                                        <li>
                                            <div class="round" data-animationSlide1-1="5"></div>
                                            <p data-animationSlide1-1="6">
                                                품질에 대한<br/>
                                                정직한 고집
                                            </p>
                                            <div class="hr" data-animationSlide1-1="7"></div>
                                            <span data-animationSlide1-1="8">Honesty</span>
                                        </li>
                                        <li>
                                            <div class="round" data-animationSlide1-1="5"></div>
                                            <p data-animationSlide1-1="6">
                                                남다름에 대한<br/>
                                                새로운 시도
                                            </p>
                                            <div class="hr" data-animationSlide1-1="7"></div>
                                            <span data-animationSlide1-1="8">Difference</span>
                                        </li>
                                        <li>
                                            <div class="round" data-animationSlide1-1="5"></div>
                                            <p data-animationSlide1-1="6">
                                                여유와 휴식에 대한<br/>
                                                세심한 배려
                                            </p>
                                            <div class="hr" data-animationSlide1-1="7"></div>
                                            <span data-animationSlide1-1="8">Refresh</span>
                                        </li>
                                    </ul>
                                    <p data-animationSlide1-1="9">
                                        엘리프는 모두에게 삶의 진정한 휴식과<br/>
                                        여유로운 공간을 만들어 갑니다.  
                                    </p>
                                </div>
                            </div>
                        </li>
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg02.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt03">
                                    <div class="text">
                                        <span data-animationSlide2="1"><i><img src="/resources/web/images/story/section04_txt03_text01.png" alt="통"></i></span>
                                        <p data-animationSlide2="4">주거의</p>
                                        <span data-animationSlide2="1"><i><img src="/resources/web/images/story/section04_txt03_text02.png" alt="찰"></i></span>
                                        <p data-animationSlide2="4">본질에 대한</p>
                                        <span data-animationSlide2="1"><i><img src="/resources/web/images/story/section04_txt03_text03.png" alt="력"></i></span>
                                    </div>
                                    <span data-animationSlide2="3">삶에 대한 모든 가치가 담긴 공간을 만듭니다.</span>
                                </div>
                            </div>
                        </li>
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg03.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt03">
                                    <div class="text">
                                        <span data-animationSlide3="1"><i><img src="/resources/web/images/story/section04_txt03_text11.png" alt="정"></i></span>
                                        <p data-animationSlide3="4">품질에 대한</p>
                                        <span data-animationSlide3="1"><i><img src="/resources/web/images/story/section04_txt03_text12.png" alt="직"></i></span>
                                        <p data-animationSlide3="4">정직한 고집</p>
                                        <span data-animationSlide3="1"><i><img src="/resources/web/images/story/section04_txt03_text13.png" alt="함"></i></span>
                                    </div>
                                    <span data-animationSlide3="3">실용과 안정에 기반을 둔 브랜드 신뢰를 만듭니다.</span>
                                </div>
                            </div>
                        </li>
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg04.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt03">
                                    <div class="text">
                                        <span data-animationSlide4="1"><i><img src="/resources/web/images/story/section04_txt03_text21.png" alt="새"></i></span>
                                        <p data-animationSlide4="4">남다름에 대한</p>
                                        <span data-animationSlide4="1"><i><img src="/resources/web/images/story/section04_txt03_text22.png" alt="로"></i></span>
                                        <p data-animationSlide4="4">새로운 시도</p>
                                        <span data-animationSlide4="1"><i><img src="/resources/web/images/story/section04_txt03_text23.png" alt="움"></i></span>
                                    </div>
                                    <span data-animationSlide4="3">모두가 함께하는 생활 공동 영역을 만듭니다.</span>
                                </div>
                            </div>
                        </li>
                        <li class="slide_item">
                            <div class="bg_wrap">
                                <div class="bg" style="background-image:url('/resources/web/images/story/section04_bg05.jpg')"></div>
                            </div>
                            <div class="slide-inner">
                                <div class="txt03">
                                    <div class="text">
                                        <span data-animationSlide5="1"><i><img src="/resources/web/images/story/section04_txt03_text31.png" alt="배"></i></span>
                                        <p data-animationSlide5="4">여유와 휴식에 대한</p>
                                        <span data-animationSlide5="1"><i><img src="/resources/web/images/story/section04_txt03_text32.png" alt="려"></i></span>
                                        <p data-animationSlide5="4">세심한 마음</p>
                                        <span data-animationSlide5="1"><i><img src="/resources/web/images/story/section04_txt03_text33.png" alt="심"></i></span>
                                    </div>
                                    <span data-animationSlide5="3">삶의 활력이 향상되는 공간을 만듭니다.</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- 2021-12-06 바뀐부분 //-->
            </div>
            <!-- section04 //-->

            <div class="section section07 fp-noscroll">
                <!-- brand_history -->
                <section class="cont_section_history">
                    <div class="sec_tit">BRAND HISTORY</div>
                    <div class="cont_box">
                        <ul>
                            <li class="item">
                                <div class="inner">

                                    <div><img src="/resources/web/images/story/logo_history_1.png" alt="리슈빌 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        리슈빌 런칭<span>2000</span>
                                    </p>
                                    <p>
                                        설계에서 마감재에 이르기까지<br>
                                        오랜 기간 고객 만족을 창조해 온 리슈빌은<br>
                                        아름다운 삶의 조화를 오케스트라가 지휘하는<br>
                                        모습으로 표현하며 오랫동안 고객들의<br>
                                        사랑을 받아왔습니다.
                                    </p>
                                </div>
                            </li>
                            <li class="item">
                                <div class="inner">

                                    <div><img src="/resources/web/images/story/logo_history_2.png" alt="로렌하우스 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        로덴하우스 런칭<span>2009</span>
                                    </p>
                                    <p>
                                        로덴하우스는 계룡건설이 오랜 세월<br>
                                        주택사업에서 쌓은 역량을 모아 탄생시킨<br>
                                        최고급 프리미엄 주거 브랜드로서<br>
                                        소수를 위한 맞춤형 주거 공간으로 거듭나며<br>
                                        새로운 명품 주거의 시대를 이끌고 있습니다.
                                    </p>
                                </div>
                            </li>
                            <li class="item">
                                <div class="inner">

                                    <div><img src="/resources/web/images/story/logo_history_3.png" alt="엘리프 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        엘리프 런칭<span>2021</span>
                                    </p>
                                    <p>
                                        리슈빌과 로덴하우스의 노하우와<br>
                                        신뢰를 바탕으로 ‘일상을 새롭게 하다’라는<br>
                                        고유의 브랜드 철학을 담아<br>
                                        새로운 주거 브랜드 ‘ELIF’를 런칭합니다.<br>
                                        ELIF는 이제 여러분의 일상 속으로 새롭게 다가갑니다.
                                    </p>

                                </div>
                            </li>
                        </ul>

                    </div>
                </section>
                <!-- //brand_history -->
            </div>

            <!-- section05 -->
            <div class="section section05 fp-noscroll">
                <div class="banner">
                    <div class="inner">
                        <div class="text">
                            <p data-animationNum5="1">
                                당신의 삶에 스타일을 더하는<br>
                                주거 공간의 새로운 기준   
                            </p>
                            <i data-animationNum5="2"><img src="/resources/web/images/story/section05_logo.png" alt="ELIF"></i>
                        </div>
                    </div>
                </div>
            </div>
            <!-- section05 //-->
            
            <!-- section06 -->
            <div class="section section06 fp-noscroll fp-auto-height">
                <!-- 
                    <div id="footer">
                        <img src="/resources/web/images/story/footer.jpg" alt="">
                    </div> 
                -->
                <footer>
                    <div class="inner">
                        <div class="left">
                            <div class="footer_logo">
                                <a href="/index"><img src="/resources/web/images/story/logo_footer.png" alt="ELIF"></a>
                            </div>
                            <div class="fnb">
                                <ul>
                                    <li>
                                        <a href="/etc/policies-privacy" class="btn_f1">개인정보처리방침</a>
                                    </li>
                                    <li>
                                        <a href="/etc/policies-terms" class="btn_f1">이용약관</a>
                                    </li>
                                    <li>
                                        <a href="/etc/policies-email" class="btn_f1">이메일무단수집거부</a>
                                    </li>
                                    <li>
                                        <a href="/etc/sitemap" class="btn_f1">사이트맵</a>
                                    </li>
                                    <li>
                                        <a href="/mypage/notice" class="btn_f1">공지사항</a>
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
                            <div class="family"> <!-- [D] 0830 : 셀렉터 변경(js) -->
                                <select>
                                    <option value="hide" rel="hide">Family Site</option>
                                    <option value="https://www.krcon.co.kr/"rel="javascript();" >계룡건설</option>
                                    <option value="https://www.krindus.co.kr/" rel="javascript();">KR산업</option>
                                    <option value="http://www.krsanup.co.kr/" rel="javascript();">계룡산업</option>
                                </select>
                            </div>
                            <nav class="map_link"> <!-- [D] 0830 : 컨텐츠 변경 -->
                                <dl>
                                    <dt>분양 정보</dt>
                                    <dd>
                                        <ul>
                                            <li class="tit"></li>
                                            <li><a href="/sale/complex">분양 단지</a></li>
                                            <li><a href="/sale/calendar">분양 캘린더</a></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>공사/입주 정보</dt>
                                    <dd>
                                        <ul>
                                            <li class="tit"></li>
                                            <li><a href="/build/construction">공사 단지</a></li>
                                            <li><a href="/build/movein">입주 단지</a></li>
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
            </div>
            <!-- section06 //-->
        </div>
    </div>
    <%@ include file="../include/javascript_story.jsp" %>
    <!-- 2021-12-06 바뀐부분 -->
    <script src="/resources/web/js/story/jquery.junSlider1.1.js"></script>
    <!-- 2021-12-06 바뀐부분 //-->
    <script>
        // $('#header').load('/WEB-INF/jsp/web/include/header.html');
    </script>
</body>

</html>