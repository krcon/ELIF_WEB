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
    <meta name="title" content="ERROR"/> 
    <meta name="keywords" content="ERROR"/> 
    <meta name="description" content="ERROR"/>
    <meta property="og:title" content="엘리프">
    <meta property="og:description" content="엘리프 분양, 공사/입주, 브랜드, MY ELIF">

    <title>ERROR | 엘리프</title>
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
                <div class="error_box ">
                    <i class="ico">
                        <img src="/resources/web/images/error_ico.svg" alt="">
                    </i>
                    <p class="tit">이용에 불편을 드려 죄송합니다.</p>
                    <p class="box_txt">방문하시려는 웹 페이지의 주소가 잘못 입력되었거나,​<br>서비스 오류로 요청하신 페이지를 찾을 수 없습니다.</p>
                    <div class="btn_area">
                        <a href="/" class="btn green">메인으로 돌아가기​</a>
                    </div>
                </div>
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>