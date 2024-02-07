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
    <meta name="title" content="입주 예약,엘리프"/> 
    <meta name="keywords" content="입주 예약, 입주 예약 신청, MY ELIF, 엘리프"/> 
    <meta name="description" content="입주 예약 신청 및 예약 내역 조회가 가능합니다. "/>
    <meta property="og:title" content="입주 예약,엘리프">
    <meta property="og:description" content="입주 예약 신청 및 예약 내역 조회가 가능합니다. ">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    
    <title>입주 예약 | 엘리프 | 모바일</title>
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
                <section class="visual mypage">
                    <h2>마이 엘리프</h2>
                </section>
                <div class="contents_wrap">
                    <!-- LNB -->
                    
                    <!-- //LNB-->
                    <%-- <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="/mobile/mypage/movein-reservation-01">입주 예약 신청</a>
                            </li>
                            <li>
                                <a href="/mobile/mypage/movein-lookup-01">예약 조회 및 수정</a>
                            </li>
                        </ul>
                    </div> --%>
                    <div class="tab_content_wrap">
                        <div class="tab_content">
                            <section class="cont_section">
                                <p class="title1">입주 예약 신청 및 조회</p>
                                <form name="vnoform" method="post" action="${rpath}/mypage/movein-reservation-n02">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="info_table">
                                    <ul class="info_list">
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="name" class="tit">이름</label>
                                            </div>
                                            <div class="info_type">
                                                <input type="text" name="reqCustNm" id="name" class="wmd" value="${sessionScope.memberSession.user_nm}" placeholder="계약자명">
                                            </div>
                                        </li>
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="birth" class="tit">생년월일</label>
                                            </div>
                                            <div class="info_type">
                                                <input type="text" name="reqPersFirstNo" id="birth" value="${sessionScope.memberSession.yymmdd}" maxlength="6" class="wmd numberonly" placeholder="생년월일 6자리 (예시 : 990909)">
                                            </div>
                                        </li>
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="apt" class="tit">단지</label>
                                            </div>
                                            <div class="info_type">
                                                <select id="apt" name="reqPjtCd" class="wmd">
                                                    <option value="">선택</option>
                                                </select>
                                            </div>
                                        </li>
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="apt" class="tit">동/호수</label>
                                            </div>
                                            <div class="info_type">
                                                <div class="muti_input_wrap">
                                                    <select id="date" name="reqBlCd" class="wsm">
                                                        <option value="">선택</option>
                                                    </select>
                                                    <label class="unit" for="detailAddress">동</label> 
                                                    <select id="date2" name="reqRmnoCd" class="wsm">
                                                        <option value="">선택</option>
                                                    </select>
                                                    <label class="unit" for="date2">호</label> 
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                </form>
                               <div class="btn_area">
                                    <a href="javascript:;" id="sendProject" class="btn green">검색</a>
                               </div>
                            </section>
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
    <script>
        // elif.saleSearch();
    </script>
    <script>
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
    loadPop("project","","");
    $(document).on('change','[name=reqPjtCd]',function(){
        loadPop("dong",$(this).val(),"");
    });
    $(document).on('change','[name=reqBlCd]',function(){
        loadPop("hosu",$('[name=reqPjtCd]').val(),$(this).val());
    });
    function loadPop(type,reqPjtCd,reqBlCd){
        var jsonData = {}
        jsonData.type = type;
        jsonData.reservation = 'mibl';
        if(reqPjtCd.length>0){
            jsonData.reqPjtCd=reqPjtCd;
        }
        if(reqBlCd.length>0){
            jsonData.reqBlCd=reqBlCd;
        }
        $.ajax({
            type: 'POST',
            url: '/reservationAjax',
            data: jsonData,
            dataType: 'json',
            async: true,
            cache: false,
            success: function (data) {
                if(type=='project'){
                    var option = '<option value="">선택</option>';
                    $.each(data.list,function(index,value){
                        var selected = '';
                        if('${param.pjt_cd}'==value.pjt_cd){
                            selected = 'selected';
                            loadPop("dong","${param.pjt_cd}","");
                        }
                        option += '<option value="'+value.pjt_cd+'" '+selected+'>'+value.pjt_nm+'</option>';
                    });
                    if(data.list.length<1){
                        var referer = '';
                        if(document.referrer){
                            var url = new URL(document.referrer);
                            referer = url.pathname;
                        }
                        alert('현재 입주 예약 신청이 가능한 단지가 없습니다. ');
                        if(referer=='/index'||referer=='/mobile/index'){
                            window.location.href="${rpath}/index?intro=f";
                        }else{
                            history.back();
                        }
                    }
                    $('[name=reqPjtCd]').html(option);
                }else if(type=='dong'){
                    var option = '<option value="">선택</option>';
                    $('[name=reqRmnoCd]').html(option);
                    $.each(data.list,function(index,value){
                        var selected = '';
                        if('${param.bl_cd}'==value.BL_CD){
                            loadPop("hosu","${param.pjt_cd}",value.BL_CD);
                            selected = 'selected';
                        }
                        option += '<option value="'+value.BL_CD+'" '+selected+'>'+value.BL_NM+'</option>';
                    });
                    $('[name=reqBlCd]').html(option);
                }else if(type=='hosu'){
                    var option = '<option value="">선택</option>';
                    $.each(data.list,function(index,value){
                        var selected = '';
                        if('${param.rmno_cd}'==value.RMNO_CD){
                            selected = 'selected';
                        }
                        option += '<option value="'+value.RMNO_CD+'" '+selected+'>'+value.RMNO_CD+'</option>';
                    });
                    $('[name=reqRmnoCd]').html(option);
                }
            },
            error: function (xhr, status, error) {
                // alert('관리자에게 문의하시기 바랍니다.');
            }
        });

    }
    $('#sendProject').click(function(){
        if($('[name=pjt_cd]').val()==''){
            alert('단지를 선택해 주세요.');
            return;
        }else if($('[name=reqCustNm]').val()==''){
            alert('이름을 입력해 주세요.');
            return;
        }else if($('[name=reqPersFirstNo]').val()==''){
            alert('생년월일을 입력해 주세요.');
            return;
        }else if($('[name=reqBlCd]').val()==''){
            alert('동을 선택해 주세요.');
            return;
        }else if($('[name=reqRmnoCd]').val()==''){
            alert('호수를 선택해 주세요.');
            return;
        }
        $('[name=vnoform]').submit();
    });
    </script>
</body>

</html>