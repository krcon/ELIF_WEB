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
                <section class="visual brand">
                    <h2>브랜드</h2>
                </section>
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
                        <div class="list_view_wrap">
                            <div class="list_title">
                                <p class="tit">
                                    <span class="tit_txt">${map.title}</span>
                                    <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${map.start_dtm }"/>
                                    <span class="list_date">${start_dtm}</span>
                                </p>
                            </div>
                            <div class="list_cont">
                                <c:set var="uploadFolder" value="${imgDomain}/upload" />
                                <c:out value="${fn:replace(fn:replace(ct:getXssDecode(map.contents), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                            </div>
                            <div class="board-pagination-wrap">
                                <ul>
                                    <li class="item prev">
                                    <c:choose>
                                    <c:when test="${!empty prevMap}">
                                    <c:url value="./community-view" var="nurl">
                                        <c:param name="idx" value="${prevMap.idx}" />
                                        <c:if test="${!empty target}">
                                        <c:param name="target" value="${param.target}" />
                                        </c:if>
                                        <c:if test="${!empty keyword}">
                                        <c:param name="keyword" value="${param.keyword}" />
                                        </c:if>
                                        <c:if test="${!empty currentPageNo}">
                                        <c:param name="currentPageNo" value="${currentPageNo}" />
                                        </c:if>
                                    </c:url>
                                    <strong>이전 뉴스</strong>
                                    <p><a href="${nurl}">${prevMap.title}</a></p>
                                    </c:when>
                                    <c:otherwise>
                                    <strong>이전 뉴스</strong>
                                    <p><a href="javascript:;"><span>이전 뉴스가 없습니다.​</span></a></p>
                                    </c:otherwise>
                                    </c:choose>
                                    </li>
                                    <li class="item next">
                                        <c:choose>
                                        <c:when test="${!empty nextMap}">
                                        <c:url value="./community-view" var="nurl">
                                            <c:param name="idx" value="${nextMap.idx}" />
                                            <c:if test="${!empty target}">
                                            <c:param name="target" value="${param.target}" />
                                            </c:if>
                                            <c:if test="${!empty keyword}">
                                            <c:param name="keyword" value="${param.keyword}" />
                                            </c:if>
                                            <c:if test="${!empty currentPageNo}">
                                            <c:param name="currentPageNo" value="${currentPageNo}" />
                                            </c:if>
                                        </c:url>
                                        <strong>다음 뉴스</strong>
                                        <p><a href="${nurl}"><span>${nextMap.title}</span></a></p>
                                        </c:when>
                                        <c:otherwise>
                                        <strong>다음 뉴스</strong>
                                        <p><a href="javascript:;"><span>다음 뉴스가 없습니다.​</span></a></p>
                                        </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
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
        elif.saleSearch();
    </script>
</body>

</html>