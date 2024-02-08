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
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="나의 분양단지, 엘리프">
    <meta property="og:description" content="고객님께서 계약을 진행한 분양단지를 확인할 수 있습니다.">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>홈 | 엘리프</title>
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
                        <li><span>나의 분양 단지</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index">홈</a></li>
                            <li><a href="../mypage/mycomplex" class="on">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="../mypage/elifNews">엘리프 뉴스</a></li>
                            <li><a href="../mypage/FAQ">FAQ</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <p class="blind">나의 분양단지</p>


                        
                        <div class="my_block_wrap">
                                <c:choose>
                                    <c:when test="${fn:length(list) > 0}">
                                    <ul>
                                        <c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
                                        <c:forEach items="${list }" var="row">
                                        <c:choose>
                                        <c:when test="${row.PROGRESS=='RV02201'}">
                                        <c:set var="ctype" value="green"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02202'}">
                                        <c:set var="ctype" value="green"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02203'}">
                                        <c:set var="ctype" value="green"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02206'}">
                                        <c:set var="ctype" value="brown"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02207'}">
                                        <c:set var="ctype" value="blue"/>
                                        </c:when>
                                        <c:when test="${row.PROGRESS=='RV02208'}">
                                        <c:set var="ctype" value="blue"/>
                                        </c:when>
                                        </c:choose>
                                        <li class="block_item" data-idx="${row.idx}" >
                                            <div class="img_area">
                                                <c:choose>
                                                <c:when test="${!empty row.SALES_THUMB_NAME}">
                                                <span><img src="${row.SALES_THUMB_PATH}${row.SALES_THUMB_NAME}" alt="" style="max-width:360px"></span>
                                                </c:when>
                                                <c:when test="${!empty row.CONST_THUMB_NAME}">
                                                <span><img src="${row.CONST_THUMB_PATH}${row.CONST_THUMB_NAME}" alt="" style="max-width:360px"></span>
                                                </c:when>
                                                <c:when test="${!empty row.MV_THUMB_NAME}">
                                                <span><img src="${row.MV_THUMB_PATH}${row.MV_THUMB_NAME}" alt="" style="max-width:360px"></span>
                                                </c:when>
                                                <c:otherwise>
                                                <span><img src="/resources/web/images/construction_temp_default.png" alt=""></span>
                                                </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <dl>
                                                <dt>
                                                    <span class="badge ${ctype}">${row.PROGRESS_NAME}</span>
                                                    <span class="cate">${row.HOUSING_NAME}</span>
                                                    <div class="tit">
                                                        <em>${row.PJT_NM}</em>
                                                    </div>
                                                </dt>
                                                <dd>
                                                    <div class="info">
                                                        <p class="locate">${row.LOCATION}</p>
                                                        <p class="locate BR">${row.BL_NM} ${row.RMNO_NM}호</p>
                                                    </div>
                                                </dd>
                                            </dl>
                                            <div class="block_btn_wrap">
                                                <a href="../mypage/inquiry-apply?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn green">고객문의</a>
                                                <c:choose>
                                                <c:when test="${row.DIFF_DATE==true}">
                                                <a href="../mypage/movein-reservation-01?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn green">입주예약</a>
                                                </c:when>
                                                </c:choose>
                                                <c:choose>
                                                <c:when test="${row.RESERVATIONDIFF_DATE==true}">
                                                <a href="../mypage/visit-reservation-01?pjt_cd=${row.PJT_CD}&bl_cd=${row.BL_CD}&rmno_cd=${row.RMNO_CD}" class="btn green">사전점검 방문예약</a>
                                                </c:when>
                                                </c:choose>

                                                
                                            </div>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                    <div class="btn_add">
                                        <button type="button" class="btn green">단지 등록</button>
                                    </div>
                                    </c:when>
                                    <c:otherwise>
                                    <div class="no_data_wrap">
                                        <p class="no_data_txt no_data_ico">등록된 단지가 없습니다.<br>분양 받으신 단지를 등록해주세요.</p>
                                        <div class="btn_add">
                                            <button type="button" class="btn green no_data_btn">단지 등록</button>
                                        </div>
                                    </div>
                                    </c:otherwise>
                                </c:choose>

                        </div>
                    </section>

                    <div class="mypage_popup hide">
                        <div class="dim"></div>
                        <div class="popup_box">
                            <div class="content_box box1">
                                <div class="popup_head">
                                    <img src="/resources/web/images/logo.png" alt="">
                                </div>
                                <div class="popup_content">
                                    <div class="txt_group">
                                        <p class="tit">분양 받으신 단지와 동/호수를 선택해주세요.</p>
                                        <p class="txt">등록이 완료되시면 홈페이지를 통해 다양한 정보 확인이 가능합니다.</p>
                                    </div>
                                    <div class="info_table">
                                        <table class="table no-head">
                                            <caption>비회원 예약 신청 입력하는 테이블입니다.</caption>
                                            <colgroup>
                                                <col style="width:205x">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th scope="row"><label for="detailAddress1" class="tit">단지</label></th>
                                                    <td>
                                                        <div class="muti_input_wrap">
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><label for="detailAddress2" class="tit">동/호수</label></th>
                                                    <td>
                                                        <div class="muti_input_wrap">
                                                            <select id="date" name="bl_cd" class="wsm">
                                                                <option value="">선택</option>
                                                            </select>
                                                            <label class="unit" for="date">동</label>
                                                            <select id="date2" name="rmno_cd" class="wsm">
                                                                <option value="">선택</option>
                                                            </select>
                                                            <label class="unit" for="date2">호</label> 
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="popup_footer">
                                    <button type="button" id="sendProject" class="btn green list">등록</button>
                                    <button class="popup_close"><img src="/resources/web/images/ico_mypage_close.png" alt="닫기"></button>
                                </div>
                            </div>

                            <!-- [D] 1028 : 등록완료 팝업창 -->
                            <div class="content_box box2 hide">
                                <div class="popup_head">
                                    <img src="/resources/web/images/logo.png" alt="">
                                </div>
                                <div class="popup_content">
                                    <div class="txt_group">
                                        <p class="tit">등록이 완료되었습니다. <br>감사합니다.</p>
                                        <div class="txt_box">
                                            <p id="project-title"></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="popup_footer">
                                    <button type="button" class="btn green list clear">완료</button>
                                    <button class="popup_close"><img src="/resources/web/images/ico_mypage_close.png" alt="닫기"></button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div><!-- //contents_wrap -->
            </div><!-- //inner -->

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
    <script>
    elif.myAddPop(); // 팝업
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
        $('.content_box.box1').addClass('hide');
        $('.content_box.box2').removeClass('hide');
        
		$('.content_box.box2 .clear,.content_box.box2 .popup_close').click(function(){
			window.location.reload();
		});
    }
    </script>
</body>

</html>