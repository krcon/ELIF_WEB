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
    <meta name="title" content="비밀번호 찾기, 엘리프"/> 
    <meta name="keywords" content="엘리프, 비밀번호, 비밀번호 찾기, 인증, 이메일, 휴대전화"/> 
    <meta name="description" content="엘리프 비밀번호 찾기 페이지 입니다."/>
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="비밀번호 찾기, 엘리프">
    <meta property="og:description" content="엘리프 비밀번호 찾기 페이지 입니다.">

    <title>비밀번호 찾기 | 엘리프</title>
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
                        <h2>비밀번호 변경</h2>
                        <div class="login_box type5">
                            <p class="login_txt">안전한 홈페이지 사용을 위하여,<br> 6개월마다 비밀번호 변경을 권장하고 있습니다.<br>새로운 비밀번호로 변경해주세요.</p>
                            <form>
                                <div class="input_box">
                                    <div class="input_row">
                                        <label for="psw1" class="a11y_hide">기존 비밀번호</label>
                                        <input type="password" class="border_input" placeholder="기존 비밀번호" id="psw1">
                                    </div>
                                    <div class="input_row">
                                        <label for="psw2" class="a11y_hide">신규 비밀번호</label>
                                        <input type="password" class="border_input" placeholder="신규 비밀번호" id="psw2">
                                        <p class="form_txt">8~14자리 이내로 영문 대소문자, 숫자, 특수문자 중 3가지 이상의 조합으로 입력해주시기 바랍니다.</p>
                                    </div>
                                    <div class="input_row">
                                        <label for="psw3" class="a11y_hide">비밀번호 확인</label>
                                        <input type="password" class="border_input" placeholder="비밀번호 확인" id="psw3">
                                    </div>
                                    <div class="btn_area">
                                        <a href="#" class="btn green">비밀번호 변경</a>
                                        <a href="../index.html" class="btn gray">다음에 변경하기</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
</body>

</html>
