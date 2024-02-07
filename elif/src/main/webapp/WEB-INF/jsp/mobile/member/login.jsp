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
    <meta name="title" content="로그인,엘리프"/> 
    <meta name="keywords" content="엘리프, 회원, 로그인"/> 
    <meta name="description" content="엘리프 로그인 페이지 입니다."/>
    <meta property="og:title" content="로그인,엘리프">
    <meta property="og:description" content="엘리프 로그인 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>로그인 | 엘리프 | 모바일</title>
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
            <div class="inner no_pd">
                <div class="login_box_wrap">
                    <div class="box_inner">
                        <h2>로그인</h2>
                        <div class="login_box">
                            <p class="login_txt">엘리프 홈페이지 방문을<br>환영합니다!</p>
                            <form name="memberForm" id="memberForm" role="memberForm" method="post" action="">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="input_row">
                                    <label for="login_txt" class="a11y_hide">아이디 입력</label>
                                    <input type="text" id="login_txt" name="user_id" class="border_input" value="${sessionScope.sessionRequest eq null?'':sessionScope.sessionRequest.user_id}" placeholder="아이디" autocomplete="off"> <!-- 1008 : id 추가 -->
                                </div>
                                <div class="input_row">
                                    <label for="login_psw" class="a11y_hide">비밀번호 입력</label> 
                                    <input type="password" id="login_psw" name="password" class="border_input" placeholder="비밀번호"> <!-- 1008 : id 추가 -->
                                </div>
                                <div class="btn_area">
                                    <button class="btn green">로그인</button>
                                </div>
                                
                            </form>
                            <ul class="find_info_list">
                                <li><a href="findid-01">아이디 찾기</a></li>
                                <li><a href="findpw-01">비밀번호 찾기</a></li>
                                <li><a href="join-01">회원가입</a></li>
                            </ul>
                        </div>
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

    <div id="zipcode_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;z-index: 9999;">
    <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>

    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script>
    window.onload=function(){
        <c:if test="${!empty sessionScope.returnRequest}">
        var returnRequest = "${sessionScope.returnRequest}";
        if(returnRequest=='pwd'){
            alert("잘못된 아이디 또는 패스워드 입니다.");
        }else if(returnRequest=='none'){
            alert("잘못된 아이디 또는 패스워드 입니다.");
        }else if(returnRequest=='login'){
            alert("로그인 후 이용해 주세요.");
        }else if(returnRequest=='pwd_ok'){
            alert("비밀번호가 정상적으로 변경되었습니다.");
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
        }else if($('[name=password]').val().length<2){
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