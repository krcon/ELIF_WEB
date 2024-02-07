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
    <meta name="title" content="개인정보처리방침,엘리프"/>
    <meta name="keywords" content="엘리프, 개인정보 처리방침"/>
    <meta name="description" content="엘리프 홈페이지의 개인정보처리방침을 안내해드립니다."/>
    <meta property="og:title" content="개인정보처리방침,엘리프">
    <meta property="og:description" content="엘리프 홈페이지의 개인정보처리방침을 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>개인정보처리방침 | 엘리프 | 모바일</title>
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
                <section class="visual etc">
                    <h2>개인정보 처리방침​</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <div class="contents_wrap">

                    <div class="select_wrap">
                        <label for="sch"><span class="a11y_hide">선택</span></label> <!-- 1011 : label 추가 -->
                        <select class="border-select wla" name="privacy_select"  id="sch"> <!-- 1011 : id 추가 -->
                        <c:choose>
                            <c:when test="${fn:length(list) > 0}">
                                <c:set var="num" value="${fn:length(list)}"/>
                                <c:forEach items="${list }" var="row">
                                    <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${row.start_dtm }"/>
                                    <option value="${row.idx}" ${row.idx==param.q?'selected':''}>${start_dtm} 개정</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                        </select>
                    </div>

                    <div class="gray_box">
                        <p class="guide_list ">
                            (주)계룡건설'은 (이하 '회사'는) 고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호에 관한
                            법률" 및 "개인정보보호법" 등 사업자가 준수하여야 할 관련 법령상의 개인정보보호 규정을 준수하며, <br>
                            관련 법령에 의거한 개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다. <br>
                            회사는 개인정보처리방침을 통하여 회원님들께 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
                        </p>
                    </div>
                    <div class="guide_box term_box">
                        <c:set var="uploadFolder" value="${imgDomain}/upload" />
                        <c:out value="${fn:replace(fn:replace(ct:getXssDecode(detail.contents), '&nbsp;', ' '), '/upload', uploadFolder)}" escapeXml="false" />
                    </div>
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
    $('[name=privacy_select]').on('change',function(){
        window.location.href="?q="+$(this).val();
    });
    </script>
</body>

</html>