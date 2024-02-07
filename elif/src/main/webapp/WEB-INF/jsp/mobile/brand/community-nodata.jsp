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
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>커뮤니티 | 엘리프 | 모바일</title>
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
                <section class="visual brand">
                    <h2>브랜드</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./story">브랜드 스토리</a></li>
                            <li><a href="./bi">BI</a></li>
                            <li><a href="./record">시공실적</a></li>
                            <li><a href="./community" class="on">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <!-- [D] 전체 검색결과 없을 경우 -->
                        <div class="no_data_wrap">
                            <p class="no_data type02">등록된 콘텐츠가 없습니다.</p>
                        </div>
                        <!-- [D] 전체 검색결과 없을 경우 -->


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

                        <!-- [D] 탭의 검색결과 없을 경우 -->
                        <div class="no_data_wrap">
                            <p class="no_data type02">등록된 콘텐츠가 없습니다.</p>
                            <div class="btn_area">
                                <a href="./community" class="btn_g1">전체목록</a>
                            </div>
                        </div>

                        <!-- // [D] 검색결과 없을 경우 -->

                        <!-- [D] 검색결과가 있을 경우 -->
                        <div>
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
        elif.communityCheckbox();
    </script>
</body>

</html>