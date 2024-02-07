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
    <meta name="title" content="아이디 찾기, 엘리프"/> 
    <meta name="keywords" content="엘리프, 아이디, 아이디 찾기, 인증, 이메일, 휴대전화"/> 
    <meta name="description" content="엘리프 아이디 찾기 페이지 입니다. "/>
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="아이디 찾기, 엘리프">
    <meta property="og:description" content="엘리프 아이디 찾기 페이지 입니다.">

    <title>아이디 찾기 | 엘리프</title>
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
                <div class="login_box_wrap">
                    <div class="box_inner">
                        <h2>아이디 찾기</h2>
                        <div class="login_box type2">
                            <p class="login_txt">일치하는 정보가 없습니다.<br>
                                다시 시도해주시거나<br>
                                회원가입을 진행해주세요.</p>
                            <div class="btn_area">
                                <a href="findid-01" class="btn green">재입력</a>
                                <a href="join-01" class="btn gray">회원가입</a>
                            </div>
                        </div>
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