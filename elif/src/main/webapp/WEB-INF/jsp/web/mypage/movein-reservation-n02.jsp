<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<%
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp" %>
    <meta name="title" content="입주 예약,엘리프"/> 
    <meta name="keywords" content="입주 예약, 입주 예약 신청, MY ELIF, 엘리프"/> 
    <meta name="description" content="입주 예약 신청 및 예약 내역 조회가 가능합니다. "/>
    <meta property="og:title" content="입주 예약,엘리프">
    <meta property="og:description" content="입주 예약 신청 및 예약 내역 조회가 가능합니다. ">
    <link href="/resources/web/css/sub.css" rel="stylesheet">
    <link href="/resources/web/css/calendar_ui.css" rel="stylesheet">
    <link rel="shortcut icon" href="/resources/web/images/common/favicon.ico" />
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>입주 예약 | 엘리프</title>
    <script>
    <c:if test="${fn:length(time)<1}">
    alert("계약자 정보가 없습니다.");
    history.back();
    </c:if>
    </script>
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
                        <li><span>입주 예약</span></li>
                        <li><span>입주 예약 신청</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    
                    <!-- //LNB-->
                    <%-- <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="../mypage/movein-reservation-01">입주 예약 신청​​​</a>
                            </li>
                            <li>
                                <a href="../mypage/movein-lookup-01">예약 조회 및 수정​</a>
                            </li> 
                        </ul>
                    </div><!-- //tab_linker_wrap --> --%>
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                            <form name="vnoform" method="post" action="${rpath}/mypage/movein-reservation-n03">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="custPnm" value="${param.reqCustNm}" />
                            <input type="hidden" name="reqCustNm" value="${param.reqCustNm}" />
                            <input type="hidden" name="miblLnNo" value="${map.MIBL_LN_NO}" />
                            <input type="hidden" name="reqPjtCd" value="${param.reqPjtCd}" />
                            <input type="hidden" name="reqPjtNm" value="${detail.pjt_nm}" />
                            <input type="hidden" name="blCd" value="${param.reqBlCd}" />
                            <input type="hidden" name="reqBlCd" value="${param.reqBlCd}" />
                            <input type="hidden" name="rmnoCd" value="${param.reqRmnoCd}" />
                            <input type="hidden" name="reqRmnoCd" value="${param.reqRmnoCd}" />
                            <input type="hidden" name="reqResTmSeq" value="" />
                            <input type="hidden" name="reqMiblElvrUseYn" value="" />
                            <input type="hidden" name="reqMiblLadderUseYn" value="" />
                            <input type="hidden" name="miblResDt" value="" />
                            <input type="hidden" name="reqPersFirstNo" value="${param.reqPersFirstNo}" />
                            <section class="cont_section">
                                <p class="title1">신청 정보</p>
                                <%-- <p class="ess_txt">*표시는 필수 입력 항목입니다.</p> --%>
                                <div class="info_table">
                                    <table class="table no-head">
                                        <caption>신청 정보 입력를 입력하는 테이블입니다.</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:806px">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><span class="tit">단지</span></th>
                                                <td>
                                                    <span class="desc_txt const_w">${detail.pjt_nm}</span>
                                                    <span class="gray_smtxt">* ${map.VIEW_MSG}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">이름</span></th>
                                                <td>
                                                    <span class="desc_txt">${param.reqCustNm}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">생년월일</span></th>
                                                <td>
                                                    <span class="desc_txt">${param.reqPersFirstNo}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">동/호수</span></th>
                                                <td>
                                                    <span class="desc_txt">${map.BL_NM} ${map.RMNO_NM}호</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="mobile" class="tit">휴대전화번호</label></th>
                                                <td>
                                                    <c:choose>
                                                    <c:when test="${!empty map.MIBL_SCH_DT}">
                                                        <input type="hidden" name="miblHpNo"  value="${!empty map.MIBL_HP_NO?map.MIBL_HP_NO:sessionScope.memberSession.hp}">
                                                    <span class="desc_txt">${!empty map.MIBL_HP_NO?map.MIBL_HP_NO:sessionScope.memberSession.hp}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <input type="text" name="miblHpNo" class="wmd" value="${!empty map.MIBL_HP_NO?map.MIBL_HP_NO:''}" placeholder="“-” 포함해서 입력해주세요">
                                                    <span class="gray_smtxt">예)010-0000-000</span>
                                                    </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            
                                            <%--<tr>
                                                <th scope="row"><label for="date" class="tit">일정</label></th>
                                                <td>
                                                    &lt;%&ndash;
                                                    <div class="muti_input_wrap">
                                                    <c:choose>
                                                    <c:when test="${!empty map.MIBL_SCH_DT}">
                                                    <span class="desc_txt">${map.YMDD_MSG} ${map.HHMM_MSG}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <select name="miblResDt" id="date" class="" style="width:280px">
                                                        <c:choose>
                                                            <c:when test="${fn:length(time) > 0}">
                                                                <option value="">선택</option>
                                                                <c:forEach items="${time }" var="row">
                                                                <option value="${row.YMDD}">${row.YMDDYO}</option>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="">선택 일수 없음</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </select>
                                                    </c:otherwise>
                                                    </c:choose>
                                                    </div> 
                                                    &ndash;%&gt;
                                                    <div class="ymdd-wrap table_wrap scroll-table">
                                                        <table id="datetable" class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th class="tc" style="padding-left:0" scope="col">일자</th>
                                                                    <th class="tc" style="padding-left:0" scope="col">예약</th>
                                                                    <th class="tc" style="padding-left:0" scope="col">잔여</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:choose>
                                                                <c:when test="${fn:length(time) > 0}">
                                                                        <c:forEach items="${time}" var="row">
                                                                        <tr class="hover" data-ymdd="${row.YMDD}">
                                                                            <td class="tc"><a href="javascript:;">${row.YMDDYO}</a></td>
                                                                            <td class="tc">${row.APL_CNT}</td>
                                                                            <td class="tc">${row.REMAIN_CNT}</td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr><td colspan="3">선택 일수 없음</td></tr>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${fn:length(time) > 0}">
                                                            <div class="hhmm-wrap table_wrap">
                                                            <c:forEach items="${time }" var="row">
                                                                <c:if test="${fn:length(row.hhmm)>0}">
                                                                <div class="hhmm-list hhmm-${row.YMDD}" style="display:none;margin-top:30px">
                                                                <table id="timetable" class="table">
                                                                    <thead>
                                                                        <tr>
                                                                            <th class="tc" style="padding-left:0" scope="col">예약시간</th>
                                                                            <th class="tc" style="padding-left:0" scope="col">승강기</th>
                                                                            <th class="tc" style="padding-left:0" scope="col">사다리차</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <c:forEach items="${row.hhmm }" var="timerow" varStatus="status">
                                                                        <tr>
                                                                            <td class="tc">${timerow.HHMM}</td>
                                                                            <c:choose>
                                                                            <c:when test="${timerow.ELVR_ENABLE_YN=='Y'&&timerow.RES_SEQ=='0'}">
                                                                                <td class="tc"><input type="checkbox" value="Y" data-tm_seq="${timerow.MIBL_SCH_TM_SEQ}" data-hhmm="${timerow.HHMM}" data-type="elvr" data-ymdd="${row.YMDD}" title="예약하기" style="appearance:checkbox;-webkit-appearance:checkbox;width:auto;height:auto;position: relative;margin: 0;padding: 0;vertical-align: middle;"/></td>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <td class="tc">불가</td>
                                                                            </c:otherwise>
                                                                            </c:choose>
                                                                            <c:choose>
                                                                            <c:when test="${timerow.LADDER_ENABLE_YN=='Y'&&timerow.RES_SEQ=='0'}">
                                                                                <td class="tc"><input type="checkbox" value="Y" data-tm_seq="${timerow.MIBL_SCH_TM_SEQ}" data-hhmm="${timerow.HHMM}" data-type="ladder" data-ymdd="${row.YMDD}" title="예약하기" style="appearance:checkbox;-webkit-appearance:checkbox;width:auto;height:auto;position: relative;margin: 0;padding: 0;vertical-align: middle;"/></td>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <td class="tc">불가</td>
                                                                            </c:otherwise>
                                                                            </c:choose>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                                </div>
                                                                </c:if>
                                                            </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>--%>

                                            <tr>
                                                <c:choose>
                                                    <c:when test="${!empty map.MIBL_SCH_TM_SEQ}">
                                                        <th scope="row"><label for="date" class="tit">일정</label></th>
                                                        <td>
                                                            <div class="muti_input_wrap">
                                                                <span class="desc_txt const_w">${map.VIEW_MSG}</span>
                                                            </div>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${fn:length(time) > 0}">
                                                                <td colspan="2">
                                                                    <div class="total-box">
                                                                        <!--달력박스-->
                                                                        <div class="calendar-box">
                                                                            <div class="n-title"  style="margin-bottom:0px;">예약날짜 선택</div>
                                                                            <div class="select-day">
                                                                                <div class="select-day-pre"><a href="javascript:prevCalendar();">◀</a></div>
                                                                                <div class="select-day-title"><span id="calYear"></span>년 <span id="calMonth"></span>월</div>
                                                                                <div class="select-day-next"><a href="javascript:nextCalendar();">▶</a></div>
                                                                            </div>

                                                                            <div class="new-calendar">
                                                                                <div class="day-name">일</div>
                                                                                <div class="day-name">월</div>
                                                                                <div class="day-name">화</div>
                                                                                <div class="day-name">수</div>
                                                                                <div class="day-name">목</div>
                                                                                <div class="day-name">금</div>
                                                                                <div class="day-name">토</div>
                                                                            </div>
                                                                            <div class="new-calendar" id="calBody"> </div>

                                                                                <%--<div class="info-text">
                                                                                    - 입주 예약은 입주희망일 7일 전까지 신청이 가능합니다.<br>
                                                                                    - 달력의 날짜를 클릭하시면 오른쪽에 입주 신청 시간이 표시됩니다.
                                                                                </div>--%>

                                                                        </div>
                                                                        <!--날짜박스-->
                                                                        <div class="day-box" style="display: none" >
                                                                            <div class="n-title" style="margin-bottom:0px;">예약시간 선택</div>
                                                                            <div class="info-text" style="margin-top:0px; margin-bottom:30px;">예약시간을 클릭하시면 선택이 됩니다.</div>
                                                                            <c:choose>
                                                                                <c:when test="${fn:length(time) > 0}">
                                                                                    <c:forEach items="${time }" var="row">
                                                                                        <c:if test="${fn:length(row.hhmm)>0}">
                                                                                            <div class="reser time_select hhmm-list hhmm-${row.YMDD}"  style="display: none">
                                                                                            <c:forEach items="${row.hhmm }" var="timerow" varStatus="status">
                                                                                                <div data-elvr="${timerow.ELVR_ENABLE_YN}" data-ladder="${timerow.LADDER_ENABLE_YN}" data-res_seq="${timerow.RES_SEQ}" data-ymdd="${row.YMDD}" data-hhmm="${timerow.HHMM}" data-tm_seq="${timerow.MIBL_SCH_TM_SEQ}" ${((timerow.ELVR_ENABLE_YN=='Y' && timerow.RES_SEQ=='0') || (timerow.LADDER_ENABLE_YN=='Y' && timerow.RES_SEQ=='0'))?' onclick="selectTime(this)"':' class="disabled"'}> ${timerow.HHMM}</div>
                                                                                            </c:forEach>
                                                                                            </div>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <div class="diviceDiv" style="display: none">
                                                                                        <div class="n-title" style="margin-bottom:0px; margin-top:20px;">운송 수단 선택</div>
                                                                                        <div class="info-text" style="margin-top:0px; margin-bottom:20px;">운송수단을 클릭하시면 선택이 됩니다.
                                                                                        </div>
                                                                                        <div class="reser">
                                                                                            <div class="elvr" style="display:none" onclick="selectElvr(this)">승강기</div>
                                                                                            <div class="ladder" style="display:none" onclick="selectLadder(this)">사다리차</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <th scope="row"><label for="date" class="tit">일정</label></th>
                                                                <td>
                                                                    <div class="muti_input_wrap">
                                                                        <span class="desc_txt const_w">선택 일수 없음</span>
                                                                    </div>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="guide_box">
                                    <p class="guide_box_tit">${detail.pjt_nm} 유의 사항​</p>
                                    <ul class="guide_list number">
                                        <%-- <li>
                                            <span class="num">1.</span>유의사항 영역
                                        </li>
                                        <li>
                                            <span class="num">2.</span>유의사항 영역
                                        </li>
                                        <li>
                                            <span class="num">3.</span>유의사항 영역
                                        </li>
                                        <li>
                                            <span class="num">4.</span>유의사항 영역 
                                        </li> --%>

                                        ${fn:replace(detail.reservation_comment, crcn, br)}
                                    </ul>
                                </div>
                            </section>
                            <section class="cont_section">
                                <p class="title1">개인정보 수집 및 이용에 대한 동의</p>
                                <div class="border_box">
                                    <p class="refer_txt">입주 예약 진행을 위하여, 귀하의 개인정보를 수집, 이용하는데 있어 귀하의 동의를 받고자 합니다.</p>
                                    <div class="info_table">
                                        <table class="table normal_table">
                                            <caption>입주 예약 진행을 위하여 수집항목 이용목적 보유 및 이용시간을 구분해 설명합니다</caption>
                                            <colgroup>
                                                <col style="width:206px">
                                                <col style="width:806px">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">구분</th>
                                                    <th scope="col">내용</th> 
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>수집 항목</td>
                                                    <td>성명, 휴대전화번호</td>
                                                </tr>
                                                <tr>
                                                    <td>이용 목적</td>
                                                    <td>입주 예약에 대한 정보 수집</td>
                                                </tr>
                                                <tr>
                                                    <td>보유 및 이용기간​</td>
                                                    <td>입주 예약 후 90일 이내​</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <p class="refer_txt">위 개인정보 수집 및 이용에 대해서 미동의할 수 있으나, 이 경우 사전점검 예약 및 입주 예약 안내 SMS 수신에 제한을 받으실 수 있습니다.</p>
                                </div>
                                <div class="agree_area">
                                    <label for="ok" class="agree_txt">개인정보 수집 및 이용에 동의하시겠습니까?</label>
                                    <span class="radio-wrap">
                                        <input type="radio" name="agree" id="ok" checked="" value="Y"><label for="ok">동의</label>
                                    </span>
                                    <span class="radio-wrap">
                                        <input type="radio" name="agree" id="no" value="N"><label for="no">미동의</label>
                                    </span>
                                </div>
                                <div class="btn_area">
                                    <c:choose>
                                    <c:when test="${!empty map.MIBL_SCH_DT}">
                                    <input type="hidden" name="type" value="delete" />
                                    <button type="submit" class="btn gray">취소</button>
                                    </c:when>
                                    <c:otherwise>
                                    <input type="hidden" name="type" value="reservation" />
                                    <button type="submit" class="btn green">예약 신청</button>
                                    </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>
                            </form>
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
    $('[name=miblResDt]').change(function(){
        $('.hhmm-list').hide();
        $('.hhmm-'+$('[name=miblResDt]').val()).show();
    });
    $('.ymdd-wrap [data-ymdd]').click(function(){
        $('.hhmm-list').hide();
        $('[name=miblResDt]').val($(this).data('ymdd'));
        $('.ymdd-wrap tr').removeClass('active');
        $(this).closest('tr').addClass('active');
        $('.hhmm-'+$(this).data('ymdd')).show();
    });
    $(document).on('change','#timetable [type="checkbox"]',function(){
        var thisEle = $(this);
        $(this).closest('.hhmm-wrap').find('[type="checkbox"]').each(function(index,data){
            if($(data).data('ymdd')==thisEle.data('ymdd')&&$(data).data('tm_seq')==thisEle.data('tm_seq')){
                if(thisEle.data('type')=='elvr'){
                    if(thisEle.is(':checked')){
                        $('[name=reqMiblElvrUseYn]').val("Y");
                    }else{
                        $('[name=reqMiblElvrUseYn]').val("N");
                    }
                }else if(thisEle.data('type')=='ladder'){
                    if(thisEle.is(':checked')){
                        $('[name=reqMiblLadderUseYn]').val("Y");
                    }else{
                        $('[name=reqMiblLadderUseYn]').val("N");
                    }
                }
                $('[name=reqResTmSeq]').val(thisEle.data('tm_seq'));
            }else{
                $(this).prop('checked',false);
            }
            if($('[name=reqMiblElvrUseYn]').val()=="N"&&$('[name=reqMiblLadderUseYn]').val()=="N"){
                $('[name=reqResTmSeq]').val("");
            }
        });
    });
    $('[name=vnoform]').submit(function(){
        if($('[name=type]').val()=='delete'){
            if(confirm('신청을 취소하시겠습니까?')){
                if($('[name=agree]:checked').val()!='Y'){
                    alert('개인정보 수집 및 이용에 대한 동의를 해주세요.');
                    return false;
                }else{
                    return true;
                }
            }else{
                return false;
            }
        }else{
            if($('[name=miblHpNo]').val()==''){
                alert('휴대폰전화번호를 입력해주세요.');
                return false;
            }else if($('[name=miblResDt]').val()==''){
                alert('예약날짜를 선택해주세요.');
                return false;
            }else if($('[name=reqResTmSeq]').val()==''){
                alert('예약시간을 선택해주세요.');
                return false;
            }else if($('[name=reqMiblElvrUseYn]').val()!='Y' && $('[name=reqMiblLadderUseYn]').val()!='Y'){
                alert('운송 수단을 선택해주세요.');
                return false;
            }else if($('[name=agree]:checked').val()!='Y'){
                alert('개인정보 수집 및 이용에 대한 동의를 해주세요.');
                return false;
            }
            if(confirm('신청 하시겠습니까?')){
                return true;
            }else{
                return false;
            }
        }
    });



    /**
     * 수정일자:2023.05.16
     * 수정내용 : 초기화 호출(달력 생성)
     * 작업자 : (flare) 한동호
     */
    let timeData = JSON.parse('${time2}');
    let mapData = JSON.parse('${map2}');
    let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
    let toDay = new Date();     // 페이지를 로드한 날짜를 저장

    console.log(timeData);
    //console.log(mapData);
    toDay.setHours(0,0,0,0);    // 비교 편의를 위해 today의 시간을 초기화
    $(function(){
        if(timeData){
            buildCalendar();
        }
    });

    /**
     * 수정일자:2023.05.16
     * 수정내용 : 시간 선택시 선택시간 일정 값
     * 작업자 : (flare) 한동호
     */
    function selectTime(obj){
        if($('[name=miblResDt]').val()==''){
            alert('예약 날짜를 선택해 주세요');
            return false;
        }

        $('[name=reqResTmSeq]').val('');
        $('[name=reqMiblElvrUseYn]').val('');
        $('[name=reqMiblLadderUseYn]').val('');
        $('.time_select > div').removeClass('click');
        $('.elvr').removeClass('click');
        $('.ladder').removeClass('click');


        $('[name=reqResTmSeq]').val($(obj).data('tm_seq'));
        $('[name=miblResDt]').val($(obj).data('ymdd'));

        //엘베 선택 가능
        if($(obj).data('elvr') =="Y" && $(obj).data('res_seq') == 0){
            $('.elvr').css('display','');
            $('.diviceDiv').css('display','');
        }

        //사다리차 선택 가능
        if($(obj).data('ladder') =="Y" && $(obj).data('res_seq') == 0){
            $('.ladder').css('display','');
            $('.diviceDiv').css('display','');
        }

        $(obj).addClass('click');


        console.log($('[name=miblResDt]').val());
        console.log($('[name=reqResTmSeq]').val());
    };

    /**
     * 수정일자:2023.05.16
     * 수정내용 : 승강기 선택시 선택시간 일정 값
     * 작업자 : (flare) 한동호
     */
    function selectElvr(obj){
        if($('[name=miblResDt]').val()==''){
            alert('예약 날짜를 선택해 주세요');
            return false;
        }
        if($('[name=reqResTmSeq]').val()==''){
            alert('예약 시간을 선택해 주세요');
            return false;
        }

        $('[name=reqMiblElvrUseYn]').val('');
        $('.elvr').removeClass('click');
        $(obj).addClass('click');

        $('[name=reqMiblElvrUseYn]').val('Y');
        console.log($('[name=miblResDt]').val());
        console.log($('[name=reqResTmSeq]').val());
        console.log($('[name=reqMiblElvrUseYn]').val());
    };

    /**
     * 수정일자:2023.05.16
     * 수정내용 : 사다리차 선택시 선택시간 일정 값
     * 작업자 : (flare) 한동호
     */
    function selectLadder(obj){
        if($('[name=miblResDt]').val()==''){
            alert('예약 날짜를 선택해 주세요');
            return false;
        }
        if($('[name=reqResTmSeq]').val()==''){
            alert('예약 시간을 선택해 주세요');
            return false;
        }

        $('[name=reqMiblLadderUseYn]').val('');
        $('.ladder').removeClass('click');
        $(obj).addClass('click');

        $('[name=reqMiblLadderUseYn]').val('Y');
        console.log($('[name=miblResDt]').val());
        console.log($('[name=reqResTmSeq]').val());
        console.log($('[name=reqMiblLadderUseYn]').val());
    };

    /**
     * 수정일자:2023.05.16
     * 수정내용 : 예약 일정 달력 만들기
     * 작업자 : (flare) 한동호
     */
    function buildCalendar(){
        let doMonth = new Date(toDay.getFullYear(), toDay.getMonth(), 1);
        let lastDate = new Date(toDay.getFullYear(), toDay.getMonth() + 1, 0);
        //console.log(doMonth, lastDate , nowMonth);

        let tbCalendar = document.querySelector("#calBody");

        document.getElementById("calYear").innerText = doMonth.getFullYear();                       // @param YYYY월
        document.getElementById("calMonth").innerText = leftPad((toDay.getMonth() + 1), 2);   // @param MM월


        // @details 이전 캘린더의 출력결과가 남아있다면, 이전 캘린더를 삭제한다.
        while(tbCalendar.children.length > 0) {
            tbCalendar.removeChild(tbCalendar.childNodes[tbCalendar.children.length - 1]);
        }

        // @param 첫번째 개행
        //let row = tbCalendar.insertRow();


        // @details 시작일의 요일값( doMonth.getDay() ) + 해당월의 전체일( lastDate.getDate())을  더해준 값에서
        //               7로 나눈값을 올림( Math.ceil() )하고 다시 시작일의 요일값( doMonth.getDay() )을 빼준다.
        let daysLength = (Math.ceil((doMonth.getDay() + lastDate.getDate()) / 7) * 7) - doMonth.getDay();

        // @param 달력 출력
        // @details 시작값은 1일을 직접 지정하고 요일값( doMonth.getDay() )를 빼서 마이너스( - )로 for문을 시작한다.
        for(let day = 1 - doMonth.getDay(); daysLength >= day; day++) {

            let column = document.createElement("div");
            tbCalendar.appendChild(column);
            // @param 평일( 전월일과 익월일의 데이터 제외 )
            if(Math.sign(day) == 1 && lastDate.getDate() >= day) {

                // @param 평일 날짜 데이터 삽입
                column.innerText = leftPad(day, 2);
                column.classList.add("not-day");


            }
            // @param 평일 전월일과 익월일의 데이터 날짜변경
            else {
                let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
                column.innerText = leftPad(exceptDay.getDate(), 2);
                column.classList.add("out-day");
            }

            let printDay = doMonth.getFullYear()+'-'+leftPad((doMonth.getMonth() + 1), 2)+'-'+ leftPad(day);
            let okDayCheck = '';

            if(timeData.length > 0 ){
                timeData.filter(it => {
                    if(it.YYMMDD === printDay && it.REMAIN_CNT > 0){
                        column.classList.remove("not-day");
                        column.classList.remove("out-day");
                        column.style.cursor = "pointer";
                        column.onclick = function(){ choiceDate(this)};
                    }
                })
            }
        }

    }

    // 날짜 선택
    function choiceDate(nowColumn) {
        let choiceDay = document.getElementById("calYear").innerText + "-" +
            document.getElementById("calMonth").innerText + "-" +
            nowColumn.innerText;

        let choiceDay2 = document.getElementById("calYear").innerText +
            document.getElementById("calMonth").innerText +
            nowColumn.innerText;

        $("#calBody > div").removeClass('check-day');
        nowColumn.classList.add("check-day");

        $('.hhmm-list').hide();
        $('[name=miblResDt]').val(choiceDay2);
        $('[name=reqResTmSeq]').val('');
        $('[name=reqMiblElvrUseYn]').val('');
        $('[name=reqMiblLadderUseYn]').val('');
        $('.hhmm-'+choiceDay2).show();
        $('.time_select > div').removeClass('click');
        $('.elvr').removeClass('click');
        $('.ladder').removeClass('click');
        $('.day-box').show();

        $('.diviceDiv').css('display','none');
        $('.elvr').css('display','none');
        $('.ladder').css('display','none');


        console.log($('[name=miblResDt]').val());
    }

    // 이전달 버튼 클릭
    function prevCalendar() {
        toDay = new Date(toDay.getFullYear(), toDay.getMonth() - 1, toDay.getDate());
        buildCalendar();    // @param 전월 캘린더 출력 요청
    }

    // 다음달 버튼 클릭
    function nextCalendar() {
        toDay = new Date(toDay.getFullYear(), toDay.getMonth() + 1, toDay.getDate());
        buildCalendar();    // @param 명월 캘린더 출력 요청
    }

    // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
    function leftPad(value) {
        if (value < 10) {
            value = "0" + value;
            return value;
        }
        return value;
    }

    </script>
</body>

</html>