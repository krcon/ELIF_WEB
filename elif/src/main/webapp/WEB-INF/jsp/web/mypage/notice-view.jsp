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
    <meta name="title" content="공지사항, 엘리프"/> 
    <meta name="keywords" content="엘리프, 공지사항, MY ELIF, 엘리프"/> 
    <meta name="description" content="엘리프 관련 공지사항을 안내해드립니다. "/>
    <meta property="og:title" content="공지사항, 엘리프">
    <meta property="og:description" content="엘리프 관련 공지사항을 안내해드립니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>공지사항 | 엘리프</title>
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
                        <li><span>공지사항</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index">홈</a></li>
                            <li><a href="../mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice" class="on">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <div class="list_view_wrap">
                            <div class="list-title">
                                <p class="tit"><span class="tit_txt">${map.title}</span></p>
                                <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${map.start_dtm }"/>
                                <span class="list-date">${start_dtm}</span>
                            </div>
                            <div class="list_cont">
                        	<c:set var="uploadFolder" value="${imgDomain}/upload" />
                            <c:out value="${fn:replace(fn:replace(ct:getXssDecode(map.contents), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                            </div>
                            <c:choose>
                            <c:when test="${fn:length(files)>0}">
                            <div class="attach_file_wrap">
                                <dl>
                                    <dt>첨부파일​</dt>
                                <dd>
                                    <ul>
                                    <c:forEach items="${files }" var="row">
                                           <li><a href="${row.path_name}${row.stored_file_name}" target="_blank">${row.original_file_name}</a></li>
                                    </c:forEach>
                                    </ul>
                                </dd>
                                </dl>
                            </div>
                            </c:when>
                            </c:choose>
                           <div class="board-pagination-wrap">
                                <ul>
                                    <li class="item prev">
                                        <c:choose>
                                        <c:when test="${!empty prevMap}">
                                        <c:url value="./notice-view" var="nurl">
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
                                            <strong>이전 글</strong>
                                            <a href="${nurl}">
                                                <span>${prevMap.title}</span>
                                                <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${prevMap.start_dtm }"/>
                                                <span class="list-date">${start_dtm}</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#">
                                                <span>이전 글이 없습니다.​</span>
                                            </a>
                                        </c:otherwise>
                                        </c:choose>
                                    </li> 
                                    <li class="item next"> 
                                        <c:choose>
                                        <c:when test="${!empty nextMap}">
                                        <c:url value="./notice-view" var="nurl">
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
                                        <strong>다음 글</strong>
                                        <a href="${nurl}">
                                            <span>${nextMap.title}</span>
                                            <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${nextMap.start_dtm }"/>
                                            <span class="list-date">${start_dtm}</span>
                                        </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#">
                                                <span>다음 글이 없습니다.​</span>
                                            </a>
                                        </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                           </div>
                        </div>
                        <div class="btn_area">
                            <c:url value="./notice" var="turl">
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
                            <a href="${turl}" class="btn green">목록</a>
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