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
                        <h2>비밀번호 찾기</h2>
                        <div class="login_box type2">
                            <p class="login_txt gap_wide">아이디와 이름을 입력해주세요.</p>
                            <form name="memberForm" id="memberForm" role="memberForm" method="post" action="findpw-02">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="input_row">
                                    <label for="txt" class="a11y_hide"></label>
                                    <input type="text" name="user_id" class="border_input" value="${sessionScope.sessionRequest eq null?'':sessionScope.sessionRequest.user_id}" placeholder="아이디" id="txt" autocomplete="off">
                                </div>
                                <div class="input_row">
                                    <label for="psw" class="a11y_hide"></label>
                                    <input type="text" name="user_nm" class="border_input" value="${sessionScope.sessionRequest eq null?'':sessionScope.sessionRequest.user_nm}" placeholder="이름" id="psw"> 
                                </div>
                                <div class="btn_area">
                                    <button class="btn green">다음</button>
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

    window.onload=function(){
        <c:if test="${!empty sessionScope.returnRequest}">
        var returnRequest = "${sessionScope.returnRequest}";
        if(returnRequest=='pwd'){
            alert("일치하는 회원 정보가 없습니다. 아이디 또는 이름을 확인해주세요.");
        }else if(returnRequest=='none'){
            alert("일치하는 회원 정보가 없습니다. 아이디 또는 이름을 확인해주세요.");
        }
        <c:remove var="sessionRequest" scope="session" />
        <c:remove var="returnRequest" scope="session" />
        </c:if>
    }
	$('[name=user_id]').keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,'').toLowerCase());
		}
	});;
    $('[name="memberForm"]').submit(function(){
        if(formValidation()){
            return true;
        }
        return false;
    });
    
    function formValidation(){
        var returnValue = true;
        if($('[name=user_id]').val().length<2){
            alert('아이디를 입력해주세요.');
            $('[name=user_id]').focus();
            returnValue = false;
        }else if($('[name=user_nm]').val().length<2){
            alert('이름을 입력해주세요.');
            $('[name=user_nm]').focus();
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
