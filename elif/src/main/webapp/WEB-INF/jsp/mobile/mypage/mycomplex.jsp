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
    <meta name="title" content="나의 분양단지, 엘리프"/> 
    <meta name="keywords" content="나의 분양단지, MY ELIF, 엘리프"/> 
    <meta name="description" content="고객님께서 계약을 진행한 분양단지를 확인할 수 있습니다."/>
    <meta property="og:title" content="나의 분양단지, 엘리프">
    <meta property="og:description" content="고객님께서 계약을 진행한 분양단지를 확인할 수 있습니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    
    <title>나의 분양 단지 | 엘리프 | 모바일</title>
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
                    <nav class="lnb small">
                        <ul>
                            <li><a href="/mobile/mypage/index">홈</a></li>
                            <li><a href="/mobile/mypage/mycomplex" class="on">나의 분양 단지</a></li>
                            <li><a href="/mobile/mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="/mobile/mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="/mobile/mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="/mobile/mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="/mobile/mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <p class="blind">나의 분양단지</p>
                        
                        <!-- 1103 추가 된 내용 (마이>메인과동일)
                            * 등록 버튼 : .btn_add > button
                            * 등록 팝업 : .popupAdd
                        -->

                        <div class="btn_add">
                            <button type="button" class="btn green btn_pop">단지 등록</button>
                        </div>

                        <div class="sale_list no_border my_complex_list">

                                <c:choose>
                                    <c:when test="${fn:length(list) > 0}">
                                        <ul>
                                        <c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
                                        <c:forEach items="${list }" var="row">
                                        <c:choose>
                                        <c:when test="${row.PROGRESS=='RV02201'}">
                                        <c:set var="ctype" value="type2"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02202'}">
                                        <c:set var="ctype" value="type2"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02203'}">
                                        <c:set var="ctype" value="type2"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02206'}">
                                        <c:set var="ctype" value="type4"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02207'}">
                                        <c:set var="ctype" value="type5"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02208'}">
                                        <c:set var="ctype" value="type5"/>
                                        </c:when>
                                        </c:choose>

                                        <li data-idx="${row.idx}">
                                            <dl>
                                                <dt>
                                                    <div class="exp1"> <span class="c2">${row.HOUSING_NAME}</span></div>
                                                    <div class="tit"><em>${row.PJT_NM}</em> <i class="flag ${ctype}">${row.PROGRESS_NAME}</i></div>
                                                    <%-- <div class="exp2"><span class="c1">2021년 08월 예정</span></div> --%>
                                                </dt>
                                                <dd>
                                                    <div class="info">
                                                        <p class="locate">${row.LOCATION}</p>
                                                        <p class="locate BR">${row.BL_NM} ${row.RMNO_NM}호</p>
                                                    </div>
                                                    <div class="btn_area">
                                                        <a href="../mypage/inquiry-apply?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn">고객문의</a>
                                                        <c:choose>
                                                        <c:when test="${row.DIFF_DATE==true}">
                                                        <a href="../mypage/movein-reservation-01?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn">입주예약</a>
                                                        </c:when>
                                                        </c:choose>
                                                        <c:choose>
                                                        <c:when test="${row.RESERVATIONDIFF_DATE==true}">
                                                        <a href="../mypage/visit-reservation-01?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn">사전점검 방문예약</a>
                                                        </c:when>
                                                        </c:choose>
                                                    </div>
                                                </dd>
                                            </dl>
                                        </li>
                                        </c:forEach>


                                    </ul>
                                    </c:when>
                                    <c:otherwise>
                                    <div class="myitem_body sale_list no_data_wrap">
                                        <p class="no_data type04">등록된 단지가 없습니다.</p>
                                        <div class="btn_add">
                                            <button type="button" class="btn green btn_pop">단지 등록</button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>
                        </div>
                        <%-- <div class="btn_area">
                            <button type="button" class="btn border">더 보기</button>
                        </div> --%>
                    </section>
                </div>

                <div class="pop popupAdd">
                    <div class="pop_head">
                        <p>단지 등록</p>
                    </div>
                    <div class="pop_cont progress">
                        <div class="contbox">
                            <p>분양 받으신 단지와<br>동/호수를 선택해주세요.</p>
                            <p class="sub">등록이 완료되시면 홈페이지를 통해<br>다양한 정보 확인이 가능합니다.</p>
                        </div>
                        <div class="contbox">
                            <!-- select -->
                            <div class="info_table">
                                <ul class="info_list">
                                    <li class="info_item">
                                        <div class="info_label">
                                            <label for="name" class="tit ess">단지</label>
                                        </div>
                                        <div class="info_type">
                                            <select id="apt" name="pjt_cd" class="wmd">
                                                <option value="">선택</option>
                                                <c:choose>
                                                <c:when test="${!empty projectMap}">
                                                    <c:forEach items="${projectMap }" var="row">
                                                    <option value="${row.PJT_CD}">${row.PJT_NM}</option>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                </c:otherwise>
                                                </c:choose>
                                            </select>
                                        </div>
                                    </li>
                                    <li class="info_item">
                                        <div class="info_label">
                                            <label for="price" class="tit ess">동/호수</label>
                                        </div>
                                        <div class="info_type">
                                            <div class="muti_input_wrap">
                                                <select id="price" name="bl_cd" class="wsm">
                                                    <option value="">선택</option>
                                                </select>
                                                <label for="detailAddress01" class="unit">동</label>
                                                <select id="detailAddress01" name="rmno_cd" class="wsm">
                                                    <option value="">선택</option>
                                                </select>
                                                <label for="detailAddress02" class="unit">호</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <!-- // select -->
                        </div>
                        <div class="btn_area">
                            <a href="javascript:;" id="sendProject" class="btn green">등록</a>
                        </div>
                    </div>
                                        
                    <!-- 팝업 컨텐츠 2 -->
                    <div class="pop_cont Finished" style="display: none;">
                        <div class="contbox ico">
                            <p>등록이 완료되었습니다.</p>
                            <p>감사합니다.</p>
                        </div>
                        <div class="contbox">
                            <div class="info_address">
                                <p id="project-title"></p>
                            </div>
                        </div>
                        <div class="btn_area">
                            <a href="javascript:void(0);" class="btn green popCls">완료</a>
                        </div>
                    </div>
                    <a href="javascript:void(0);" class="popCls">단지 등록 팝업 닫기</a>
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
        elif.myPopup();
    </script>
    <script>
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
    loadPop("project","","");
    $(document).on('change','[name=pjt_cd]',function(){
        loadPop("dong",$(this).val(),"");
    });
    $(document).on('change','[name=bl_cd]',function(){
        loadPop("hosu",$('[name=pjt_cd]').val(),$(this).val());
    });
    function loadPop(type,pjt_cd,bl_cd){
        var jsonData = {}
        jsonData.type = type;
        if(pjt_cd.length>0){
            jsonData.pjt_cd=pjt_cd;
        }
        if(bl_cd.length>0){
            jsonData.bl_cd=bl_cd;
        }
        $.ajax({
            type: 'POST',
            url: '/pjtComplexAjax',
            data: jsonData,
            dataType: 'json',
            async: true,
            cache: false,
            success: function (data) {
                if(type=='project'){
                    var option = '<option value="">선택</option>';
                    $.each(data.list,function(index,value){
                        option += '<option value="'+value.PJT_CD+'">'+value.PJT_NM+'</option>';
                    });
                    $('[name=pjt_cd]').html(option);
                }else if(type=='dong'){
                    var option = '<option value="">선택</option>';
                    $('[name=rmno_cd]').html(option);
                    $.each(data.list,function(index,value){
                        option += '<option value="'+value.BL_CD+'">'+value.BL_NM+'</option>';
                    });
                    $('[name=bl_cd]').html(option);
                }else if(type=='hosu'){
                    var option = '<option value="">선택</option>';
                    $.each(data.list,function(index,value){
                        option += '<option value="'+value.RMNO_CD+'">'+value.RMNO_NM+'</option>';
                    });
                    $('[name=rmno_cd]').html(option);
                }
            },
            error: function (xhr, status, error) {
                alert('관리자에게 문의하시기 바랍니다.');
            }
        });

    }
    $('#sendProject').click(function(){
        if($('[name=pjt_cd]').val()==''){
            alert('단지를 선택해 주세요.');
            return;
        }else if($('[name=bl_cd]').val()==''){
            alert('동을 선택해 주세요.');
            return;
        }else if($('[name=rmno_cd]').val()==''){
            alert('호수를 선택해 주세요.');
            return;
        }
        var jsonData = {}
        jsonData.pjt_cd=$('[name=pjt_cd]').val();
        jsonData.bl_cd=$('[name=bl_cd]').val();
        jsonData.rmno_cd=$('[name=rmno_cd]').val();
        $.ajax({
            type: 'POST',
            url: '/pjtComplexSubmitAjax',
            data: jsonData,
            dataType: 'json',
            async: true,
            cache: false,
            success: function (data) {
                if(data.result=='ok'){
                    submitOnPorject();
                }else{
                    alert(data.resultMsg);
                    return;
                }
            },
            error: function (xhr, status, error) {
                alert('관리자에게 문의하시기 바랍니다.');
            }
        });
    });
    function submitOnPorject(){
        $('#project-title').html($('[name=pjt_cd]').find('option:checked').html());
        $('.progress').hide();
        $('.Finished').show();
        $('.popupAdd .popCls').on("click", function(){
			window.location.reload();
		});
    }
    </script>
</body>

</html>