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
    <meta name="title" content="휴면 계정 복구,엘리프"/> 
    <meta name="keywords" content="엘리프, 회원, 휴면 계정 복구"/> 
    <meta name="description" content="엘리프 휴면 계정 복구 페이지 입니다."/>
    <meta property="og:title" content="휴면 계정 복구,엘리프">
    <meta property="og:description" content="엘리프 휴면 계정 복구 페이지 입니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>휴면 계정 복구 | 엘리프 | 모바일</title>
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
                        <h2>휴면계정 해제 안내</h2>
                        <div class="login_box">
                            <!-- <img src="/resources/web/images/logo.png" alt="ELIF"> -->
                            <p class="login_txt">고객님의 계정은 현재 휴면 상태입니다.</p>
                            <p class="desc_txt">ELIF 홈페이지에 1년 이상 로그인하지 않아 <br>휴면 상태로 전환되었습니다. 원활한 서비스 이용을 <br>원하신다면 휴면 해제를 선택해주세요.</p>
                            <div class="border_box gray">
                                <ul class="my_info_list">
                                    <li>
                                        마지막 접속 일자
                                        <fmt:formatDate var="fnl_login_dtm" pattern="yyyy년 MM월 dd일" value="${member.fnl_login_dtm }"/>
                                        <span>${fnl_login_dtm}</span>
                                    </li>
                                    <li>
                                        휴면 계정 전환 일자
                                        <fmt:formatDate var="dormancy_dt" pattern="yyyy년 MM월 dd일" value="${member.dormancy_dt }"/>
                                        <span>${dormancy_dt}</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="btn_area">
                                <button class="btn green" type="button"  onclick="fnPopup('sms')">휴면 해제</button>
                            </div>
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
    <form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">				<!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="${sms.sEncData}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    </form>
    <form name="vnoform" method="post" action="${rpath}/member/dormancy_complete">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" name="DI">
        <input type="hidden" name="sName">
        <input type="hidden" name="sGender">
        <input type="hidden" name="sBirthDate">
        <input type="hidden" name="sMobileNo">
        <input type="hidden" name="param_r1" value="${member.user_id}">
        <input type="hidden" name="param_r2" value="${member.user_nm}">
        <input type="hidden" name="param_r3" value="">
    </form>
    <script>
    window.name ="Parent_window";

    function fnPopup(type){
        if(type=='ipin'){
            window.open('', 'popupMember', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_ipin.target = "popupMember";
            document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
            document.form_ipin.submit();
        }else{
            window.open('', 'popupMember', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupMember";
            document.form_chk.submit();
        }
    }

    window.onload=function(){
        <c:if test="${!empty sessionScope.returnRequest}">
        var returnRequest = "${sessionScope.returnRequest}";
        if(returnRequest=='pwd'){
            alert("일치하는 회원 정보가 없습니다. 휴대전화를 확인해주세요.");
            window.history.back();
        }else if(returnRequest=='none'){
            alert("일치하는 회원 정보가 없습니다. 휴대전화를 확인해주세요.");
            window.history.back();
        }
        <c:remove var="sessionRequest" scope="session" />
        <c:remove var="returnRequest" scope="session" />
        </c:if>
    }
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>