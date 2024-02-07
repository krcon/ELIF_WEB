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
    <meta name="title" content="커뮤니티, 엘리프"/> 
    <meta name="keywords" content="커뮤니티, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/> 
    <meta name="description" content="엘리프 관련 최신 소식을 확인하실 수 있습니다. "/>
    <meta property="og:title" content="커뮤니티, 엘리프">
    <meta property="og:description" content="엘리프 관련 최신 소식을 확인하실 수 있습니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>커뮤니티 | 엘리프</title>
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
                <section class="visual brand">
                    <h2>브랜드</h2>
                </section>        
                <!-- //Visual & Title -->
                <!-- 페이지 위치 --> 
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><a href="/brand/story"><span>브랜드</span></a></li>
                        <li><span>커뮤니티</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <!-- contents_wrap  -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="./story">브랜드 스토리</a></li>
                            <li><a href="./bi">BI</a></li>
                            <li><a href="./record">시공실적</a></li>
                            <li><a href="./community" class="on">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section_brand">
                        <!-- [D] 등록된 컨텐츠 없음 & sns 탭 있음 : class: hide 로 제어 --> 
                        <!-- <div class="no_data_wrap_sns hide"> -->
                        <div class="no_data_wrap_sns ">
                            <div class="tab_linker_wrap commu">
                                <ul class="tab_linker">
                                    <li>
                                        <a href="#">
                                            <input type="checkbox" id="all" name="all" value="all">
                                            <label for="all">전체</label>
                                        ​​​</a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <input type="checkbox" id="news" name="news" value="news" data-tit="sub" checked>
                                            <label for="news">뉴스</label>
                                        ​</a>
                                    </li> 
                                    <li>
                                        <a href="#">
                                            <input type="checkbox" id="youtube" name="youtube" value="youtube" data-tit="sub">
                                            <label for="youtube">유튜브</label>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <input type="checkbox" id="sns" name="sns" value="sns" data-tit="sub">
                                            <label for="sns">웹진</label>
                                        </a>
                                    </li> 
                                </ul>
                            </div>
    
                            <div class="no_data_wrap">
                                <p class="no_data_txt no_contents_ico">등록된 컨텐츠가 없습니다.</p>
                                <div class="btn_more">
                                    <a href="./community" class="btn_m1 list">전체목록</a>
                                </div>
                            </div>
                        </div>
                        <!-- //[D] 등록된 컨텐츠 없음 & sns 탭 있음--><br>

                        <!-- [D] 등록된 컨텐츠 없음 : class: hide  로 제어 -->
                        <!-- <div class="no_data_wrap hide"> -->
                        <div class="no_data_wrap ">
                            <p class="no_data_txt no_contents_ico">등록된 컨텐츠가 없습니다.</p>
                        </div>

                        <!-- // [D] 등록된 컨텐츠 없음 -->

                        <!-- 등록된 컨텐츠 있을 경우, 리스트 보여주기 -->
                        <div>
                        </div>
                    </section>
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- //wrap -->
    <%@ include file="../include/javascript.jsp" %>
    <script>
        elif.communityCheckbox();
    </script>
</body>
</html>