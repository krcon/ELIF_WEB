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
    <meta name="title" content="회원탈퇴, 엘리프"/> 
    <meta name="keywords" content="회원탈퇴, 엘리프"/> 
    <meta name="description" content="엘리프 회원탈퇴 페이지 입니다."/>
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="회원탈퇴, 엘리프">
    <meta property="og:description" content="엘리프 회원탈퇴 페이지 입니다.">

    <title>회원 탈퇴 | 엘리프</title>
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
                        <h2>회원 탈퇴</h2>
                        <div class="login_box type4">
                            <p class="login_txt gap_wide">비밀번호를 입력해주세요.</p>
                            <form name="memberForm" id="memberForm" role="memberForm" method="post" action="">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="input_row">
                                    <label for="psw" class="a11y_hide">비밀번호</label> 
                                    <input type="password" name="password" class="border_input" placeholder="비밀번호" id="psw"> 
                                </div>
                                <div class="btn_area">
                                    <button type="submit" class="btn green">회원탈퇴</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div><!-- //inner -->

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
    <script>
        elif.dataEffect();
    </script>
    <script>

    window.onload=function(){
        <c:if test="${!empty sessionScope.returnRequest}">
        var returnRequest = "${sessionScope.returnRequest}";
        if(returnRequest=='error'){
            alert("로그인 후 이용해 주세요.");
        }else if(returnRequest=='none'){
            alert("비밀번호가 맞지 않습니다.");
        }else if(returnRequest=='dberr'){
            alert("관리자에게 문의 하세요.");
        }
        <c:remove var="sessionRequest" scope="session" />
        <c:remove var="returnRequest" scope="session" />
        </c:if>
    }
    $('[name="memberForm"]').submit(function(){
        if(formValidation()){
            return true;
        }
        return false;
    });
    function formValidation(frm){
        var returnValue = true;
        if($('[name=password]').val().length<2){
            alert('비밀번호를 입력해주세요.');
            $('[name=password]').focus();
            returnValue = false;
        }
        return returnValue;
    }
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>
