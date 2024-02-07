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
    <meta name="title" content="사전점검 방문 예약, 엘리프"/> 
    <meta name="keywords" content="사전점검 방문 예약, 방문 예약 신청 MY ELIF, 엘리프"/> 
    <meta name="description" content="사전점검 방문 예약 신청 및 예약 내역 조회가 가능합니다. "/>
    <meta property="og:title" content="사전점검 방문 예약, 엘리프">
    <meta property="og:description" content="사전점검 방문 예약 신청 및 예약 내역 조회가 가능합니다. ">
    <link href="/resources/web/css/sub.css" rel="stylesheet">
    <link rel="shortcut icon" href="/resources/web/images/common/favicon.ico" />
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>방문 예약 신청 | 사전점검 방문 예약 | 엘리프</title>
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
                        <li><span>방문 예약 신청</span></li>
                        <li><span>사전점검 방문 예약</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    
                    <!-- //LNB-->
                    <%-- <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="../mypage/visit-reservation-01">방문 예약 신청​​​</a>
                            </li>
                            <li>
                                <a href="../mypage/visit-lookup-01">예약 조회 및 수정​</a>
                            </li> 
                        </ul>
                    </div><!-- //tab_linker_wrap --> --%>
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                            <section class="cont_section">
                                <p class="title1">사전점검 예약 신청 및 조회</p>
                                <div class="info_table">
                                <form name="vnoform" method="post" action="${rpath}/mypage/visit-reservation-n02">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <table class="table no-head">
                                        <caption>예약 신청 입력하는 테이블입니다.</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:806px">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><label for="name" class="tit">이름</label></th>
                                                <td>
                                                    <input type="text" name="reqCustNm" id="name" class="wmd" value="${sessionScope.memberSession.user_nm}" placeholder="계약자명">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="birth" class="tit">생년월일</label></th>
                                                <td>
                                                    <input type="text" name="reqPersFirstNo" id="birth" value="${sessionScope.memberSession.yymmdd}" maxlength="6" class="wmd numberonly" placeholder="생년월일 6자리 (예시 : 990909)">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="apt" class="tit">단지</label></th>
                                                <td>
                                                    <select id="apt" name="reqPjtCd" class="wmd">
                                                        <option value="">선택</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="detailAddress" class="tit">동/호수</label></th>
                                                <td>
                                                    <div class="muti_input_wrap">
                                                        <select id="date" name="reqBlCd" class="wsm">
                                                            <option value="">선택</option>
                                                        </select>
                                                        <label class="unit" for="detailAddress">동</label>
                                                        <select id="date2" name="reqRmnoCd" class="wsm">
                                                            <option value="">선택</option>
                                                        </select>
                                                        <label class="unit" for="date">호</label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                                </div>
                               <div class="btn_area">
                                    <a href="javascript:;" id="sendProject" class="btn green">검색</a>
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
        jsonData.reservation = 'bfchk';
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
                        alert('현재 사전점검 방문 예약 신청이 가능한 단지가 없습니다.');
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