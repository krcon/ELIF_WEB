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
                    <!-- brand 커뮤니티 상세내용 -->
                    <section class="cont_section_brand">
                        <dl class="commu_detail">
                            <dt>
                                <p class="title">${map.title}</p>
                                <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${map.start_dtm }"/>
                                <p class="date">${start_dtm}</p>
                            </dt>
                            <dd>
                                <div class="info">
                                <c:set var="uploadFolder" value="${imgDomain}/upload" />
                                <c:out value="${fn:replace(fn:replace(ct:getXssDecode(map.contents), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                                </div>
                            </dd>
                        </dl>

                        <table class="link_wrap">
                            <colgroup>
                                <col style="width:150px">
                                <col style="width:1050px">
                            </colgroup>
                            <tbody>
                                <tr>
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
                                    <td class="link">이전뉴스</td>
                                    <fmt:formatDate var="prev_dtm" pattern="yyyy년 MM월 dd일" value="${prevMap.start_dtm }"/>
                                    <td class="title"><a href="${nurl}"><span>${prevMap.title}</span><span class="right">${prev_dtm}</span></a></td>
                                    </c:when>
                                    <c:otherwise>
                                    <td class="link">이전뉴스</td>
                                    <td class="title"><a href="#"><span>이전 뉴스가 없습니다.​</span></a></td>
                                    </c:otherwise>
                                    </c:choose>
                                </tr>
                                <tr>
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
                                    <td class="link">다음뉴스</td>
                                    <fmt:formatDate var="next_dtm" pattern="yyyy년 MM월 dd일" value="${nextMap.start_dtm }"/>
                                    <td class="title"><a href="${nurl}"><span>${nextMap.title}</span><span class="right">${next_dtm}</span></a></td>
                                    </c:when>
                                    <c:otherwise>
                                    <td class="link">다음뉴스</td>
                                    <td class="title"><a href="#"><span>다음 뉴스가 없습니다.​</span></a></td>
                                    </c:otherwise>
                                    </c:choose>
                                </tr>
                            </tbody>
                        </table>

                        <div class="btn_more">
                            <a href="./community" class="btn_m1 list">목록</a>
                        </div>
                    </section>
                    <!-- //brand 커뮤니티 상세내용 -->
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>