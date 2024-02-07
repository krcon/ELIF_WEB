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
    <meta name="title" content="시공실적, 엘리프"/>
    <meta name="keywords" content="시공실적, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 시공 실적을 안내해드립니다."/>
    <meta property="og:title" content="시공실적, 엘리프">
    <meta property="og:description" content="엘리프의 시공 실적을 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>브랜드스토리 | 엘리프 | 모바일</title>
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
                <!-- Visual & Title -->
                <section class="visual sale brand">
                    <h2>브랜드</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap w">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./story" class="on">브랜드 스토리</a></li>
                            <li><a href="./bi">BI</a></li>
                            <li><a href="./record">시공실적</a></li>
                            <li><a href="./community">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <div class="tit_group active">
                            <div class="brand_tit">
                                <div class="tit_top">
                                    <p>ENHANCE</p>
                                </div>
                                <div class="tit_bot">
                                    <p>YOUR LIFE</p>
                                    <span>일상을 새롭게 하다</span>
                                </div>
                            </div>
                            <div class="brand_img">
                                <div class="line"></div>
                                <div class="img_box">
                                    <div class="img_con">
                                        <img src="/resources/mobile/images/life_img01.png" class="active" alt="라이프 스타일 배너">
                                        <img src="/resources/mobile/images/life_img02.png" alt="라이프 스타일 배너">
                                        <img src="/resources/mobile/images/life_img03.png" alt="라이프 스타일 배너">
                                    </div>
                                </div>
                            </div>
                            <span class="br_txt left">BRAND STORY</span>
                            <span class="br_txt right">BRAND STORY</span>
                        </div>
                    </section>
                    <section class="cont_section">
                        <div class="info_group brand_mg">
                            <div class="info_inner">
                                <div class="txt_group">
                                    <div class="info_tit">
                                        <p>주거의 본질에 집중한 엄선된 공간과​<br>그 안에서 펼쳐지는 나만의 개성과 취향,​<br>그 이상의 라이프 스타일을​ 추구합니다.</p>
                                    </div>
                                    <div class="info_content">
                                        <p>하루를 새롭게 시작하는 곳,​<br>일상이 새롭게 연결되는 곳</p>
                                        <p>모두에게 새로운 삶의 가치와​<br>여유로운 공간을 제공합니다.</p>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </section>
                    <section class="cont_section brand_mission">
                        <div class="brand_mivi">
                            <div class="brand_mission mivi">
                                <span class="mivi_title">MISSION</span>
                                <p>모두의 일상에 활력을 주는 집을 짓는다는 마음으로 입지 선정, 상품개발, 디자인, 시공, 사후서비스 등 각 분야에서 끊임없이 고민하고 앞서겠습니다.</p>
                            </div>
                            <div class="brand_vision mivi">
                                <div class="img_box"><span class="mivi_title">VISION</span></div>
                                <p>주거의 핵심에 집중하고, 남다른 프리미엄 공간 구현을 통해
                                    새로운 일상을 추구하는 ELIF가 되겠습니다.</p>
                            </div>
                        </div> 
                    </section>
                    <section class="cont_section">
                        <div class="brand-slide">
                            <div class="slide_bg slide1">
                                <div class="slide_txt">
                                    <p>공간을 짓는 것만으로는<br />집을 완성할 수 없습니다.</p>
                                    <p>그 공간에서 함께 만들어가는 일상이,<br />비로소 삶을 새롭게 구현하는<br />집을 완성합니다.</p>
                                </div>
                            </div>
                            <div class="slide_bg slide2">
                                <ul>
                                    <li>
                                        <div>
                                            <p>주거의 본질에 <br/> 대한 통찰력</p>
                                            <span>Insight</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <p>품질에 대한 <br/> 정직한 고집</p>
                                            <span>Honesty</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <span>Difference</span>
                                            <p class="top">남다름에 대한 <br/> 새로운 시도</p>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <span>Refresh</span>
                                            <p class="top">여유와 휴식에 대한 <br/> 세심한 배려</p>
                                        </div>
                                    </li>
                                </ul>
                                <!-- <p class="slide_txt">엘리프는 모두에게 삶의 진정한 휴식과<br>여유로운 공간을 만들어 갑니다.</p> -->
                            </div>
                            <div class="slide_bg slide3">
                                <span class="slide_tit">BRAND VALUE</span>
                                <ul class="value_txt">
                                    <li class="big">
                                        <span class="hide">통</span>
                                        <img src="/resources/mobile/images/value1_1.png" alt="">
                                    </li>
                                    <li>
                                        <span>주거의</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">찰</span>
                                        <img src="/resources/mobile/images/value1_2.png" alt="">
                                    </li>
                                    <li>
                                        <span>본질에 대한</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">력</span>
                                        <img src="/resources/mobile/images/value1_3.png" alt="">
                                    </li>
                                </ul>
                                <p class="slide_txt">삶에 대한 모든 가치가<br />담긴 공간을 만듭니다.</p>
                            </div>
                            <div class="slide_bg slide4">
                                <span class="slide_tit">BRAND VALUE</span>
                                <ul class="value_txt">
                                    <li class="big">
                                        <span class="hide">정</span>
                                        <img src="/resources/mobile/images/value2_1.png" alt="">
                                    </li>
                                    <li>
                                        <span>품질에 대한</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">직</span>
                                        <img src="/resources/mobile/images/value2_2.png" alt="">
                                    </li>
                                    <li>
                                        <span>정직한 고집</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">함</span>
                                        <img src="/resources/mobile/images/value2_3.png" alt="">
                                    </li>
                                </ul>
                                <p class="slide_txt">실용과 안정에 기반을<br />둔 브랜드 신뢰를 만듭니다.</p>
                            </div>
                            <div class="slide_bg slide5">
                                <span class="slide_tit">BRAND VALUE</span>
                                <ul class="value_txt">
                                    <li class="big">
                                        <span class="hide">새</span>
                                        <img src="/resources/mobile/images/value3_1.png" alt="">
                                    </li>
                                    <li>
                                        <span>남다름에 대한</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">로</span>
                                        <img src="/resources/mobile/images/value3_2.png" alt="">
                                    </li>
                                    <li>
                                        <span>새로운 시도</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">움</span>
                                        <img src="/resources/mobile/images/value3_3.png" alt="">
                                    </li>
                                </ul>
                                <p class="slide_txt">모두가 함께하는<br />생활 공동 영역을 만듭니다.</p>
                            </div>
                            <div class="slide_bg slide6">
                                <span class="slide_tit">BRAND VALUE</span>
                                <ul class="value_txt">
                                    <li class="big">
                                        <span class="hide">배</span>
                                        <img src="/resources/mobile/images/value4_1.png" alt="">
                                    </li>
                                    <li>
                                        <span>휴식에 대한</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">려</span>
                                        <img src="/resources/mobile/images/value4_2.png" alt="">
                                    </li>
                                    <li>
                                        <span>세심한 마음</span>
                                    </li>
                                    <li class="big">
                                        <span class="hide">심</span>
                                        <img src="/resources/mobile/images/value4_3.png" alt="">
                                    </li>
                                </ul>
                                <p class="slide_txt">삶에 활력이 향상되는<br />공간을 만듭니다.</p>
                            </div>
                        </div>
                    </section>
                    <!-- brand_history -->
                    <section class="cont_section history">
                        <div class="sec_tit">BRAND HISTORY</div>
                        <div class="brand-slide">
                            <div class="slide1 item">
                                <div class="inner">

                                    <div><img src="/resources/mobile/images/logo_history_1.png" alt="리슈빌 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        <span>2000</span>리슈빌 런칭
                                    </p>
                                    <p>
                                        설계에서 마감재에 이르기까지<br>
                                        오랜 기간 고객 만족을 창조해 온 리슈빌은<br>
                                        아름다운 삶의 조화를 오케스트라가 지휘하는<br>
                                        모습으로 표현하며 오랫동안 고객들의<br>
                                        사랑을 받아왔습니다.
                                    </p>
                                </div>
                            </div>
                            <div class="slide1 item">
                                <div class="inner">

                                    <div><img src="/resources/mobile/images/logo_history_2.png" alt="로렌하우스 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        <span>2009</span>로덴하우스 런칭
                                    </p>
                                    <p>
                                        로덴하우스는 계룡건설이 오랜 세월<br>
                                        주택사업에서 쌓은 역량을 모아 탄생시킨<br>
                                        최고급 프리미엄 주거 브랜드로서<br>
                                        소수를 위한 맞춤형 주거 공간으로 거듭나며<br>
                                        새로운 명품 주거의 시대를 이끌고 있습니다.
                                    </p>
                                </div>
                            </div>
                            <div class="slide1 item">
                                <div class="inner">

                                    <div><img src="/resources/mobile/images/logo_history_3.png" alt="엘리프 로고"></div>
                                    <span class="timespot"></span>
                                    <p class="timetit">
                                        <span>2021</span>엘리프 런칭
                                    </p>
                                    <p>
                                        리슈빌과 로덴하우스의 노하우와<br>
                                        신뢰를 바탕으로 ‘일상을 새롭게 하다’라는<br>
                                        고유의 브랜드 철학을 담아<br>
                                        새로운 주거 브랜드 ‘ELIF’를 런칭합니다.<br>
                                        ELIF는 이제 여러분의 일상 속으로 새롭게 다가갑니다.
                                    </p>

                                </div>
                            </div>
                        </div>
                    </section>
                    <!-- //brand_history -->
                    <section class="cont_section story_last">
                        <div class="cont_box brand_mg">
                            <div class="cont_group">
                                <p>당신의 삶에 스타일을 더하는<br>주거 공간의 새로운 기준</p>
                                <img src="/resources/mobile/images/brand_story_logo.png" alt="elif">
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
        elif.storyAll();
    </script>
</body>

</html>