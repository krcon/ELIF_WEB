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
    <meta name="title" content="고객문의, 엘리프"/> 
    <meta name="keywords" content="엘리프, 고객문의, MY ELIF, 엘리프"/> 
    <meta name="description" content="궁금하신 내용을 문의할 수 있는 고객문의 페이지입니다. "/>
    <meta property="og:title" content="고객문의, 엘리프">
    <meta property="og:description" content="궁금하신 내용을 문의할 수 있는 고객문의 페이지입니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>고객문의 | 엘리프</title>
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
                        <li><span>고객 문의</span></li>
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
                            <li><a href="../mypage/inquiry-apply" class="on">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="../mypage/elifNews">엘리프 뉴스</a></li>
                            <li><a href="../mypage/FAQ-view">FAQ</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li>
                                <a href="#">고객문의​​​</a>
                            </li>
                            <li class="on">
                                <a href="#">문의내역​​​</a>
                            </li> 
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                            <section class="cont_section">
                                <div class="list_view_wrap">
                                    <div class="list-title">
                                        <p class="tit"><span class="tit_txt">${map.title}​</span><span class="badge  ${map.reply_status=='RV02301'?'':'gray' }">${map.reply_status=='RV02301'?'접수완료':'답변완료' }</span></p>
                                        <fmt:formatDate var="crea_dtm" pattern="yyyy년 MM월 dd일" value="${map.crea_dtm }"/>
                                        <span class="list-date">${crea_dtm}</span>
                                    </div>
                                    <div class="list_cont">
                                        <c:set var="uploadFolder" value="${imgDomain}/upload" />
                                        <c:out value="${fn:replace(fn:replace(ct:getXssDecode(map.inquiry_content), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                                    </div>
                                    <c:if test="${map.reply_status!='RV02301'}">
                                    <div class="reply">
                                        <dl>
                                            <dt>답변​</dt>
                                            <dd>
                                                <c:set var="uploadFolder" value="${imgDomain}/upload" />
                                                <c:out value="${fn:replace(fn:replace(ct:getXssDecode(map.reply_content), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                                            </dd>
                                        </dl>
                                    </div>
                                    </c:if>
                                    
                                </div>
                                <div class="btn_area">
                                    <c:url value="./inquiry-lookup" var="turl">
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
                        </div>
                    </div><!-- //tab_content_wrap -->
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>