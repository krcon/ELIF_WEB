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
    <meta name="title" content="분양대금 납부조회, 엘리프"/> 
    <meta name="keywords" content="분양대금 납부 조회, 중도금 조회, 입금내역, 예상 입금액, MY ELIF, 엘리프"/> 
    <meta name="description" content="고객님의 분양대금을 조회할 수 있습니다. "/>
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="분양대금 납부조회, 엘리프">
    <meta property="og:description" content="고객님의 분양대금을 조회할 수 있습니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>분양대금조회 | 엘리프</title>
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
                        <li><span>분양대금 조회</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index">홈</a></li>
                            <li><a href="../mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide" class="on">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li>
                                <a href="payment-guide">분양 가이드​</a>
                            </li>
                            <li class="on">
                                <a href="payment-lookup">중도금 조회​​</a>
                            </li>
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                            <section class="cont_section">
                                <div class="info_table">
                                    <table class="table no-head">
                                        <caption>사업자 명과 금액 구분을 선택하는 테이블입니다.</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:994px">
                                        </colgroup>
                                        <tr>
                                            <th scope="row"><label for="name" class="tit">사업장 명​</label></th>
                                            <td>
                                                <select id="apt" name="pjt_cd" class="wmd">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><label for="price" class="tit">금액 구분​</label></th>
                                            <td>
                                                <select id="price" name="comAmtFg" class="wmd">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div><!-- info_table -->
                                <div class="btn_area">
                                    <a href="javascript:;" id="payment-lookup" class="btn green">조회</a>
                                </div>
                            </section>
                            <section class="cont_section krpl hide">
                                <p class="title1">계약 내역</p>
                                <div class="info_table">
                                    <table class="table no-head">
                                        <caption>계약내역을 설명합니다.</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:394px">
                                            <col style="width:206px">
                                            <col style="width:394px">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">사업장 명​</th>
                                                <td colspan="3"><span class="desc_txt" id="pjtMrkgNm"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">동호수​</th>
                                                <td><span class="desc_txt" id="blNm-rmnoNm"></span>​</td>
                                                <th scope="row">사업장 구분​​</th>
                                                <td><span class="desc_txt" id="slltFgNm"></span></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">평형타입</th>
                                                <td><span class="desc_txt" id="ptpNm"></span>​</td>
                                                <th scope="row">전용면적​​</th>
                                                <td><span class="desc_txt" id="fnlDvrsSqms"></span></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">이름</th>
                                                <td colspan="3"><span class="desc_txt" id="custNm"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">전화번호​</th>
                                                <td><span class="desc_txt" id="telNo"></span>​</td>
                                                <th scope="row">휴대전화번호​</th>
                                                <td><span class="desc_txt" id="mp1No"></span></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">등기 주소​</th>
                                                <td colspan="3"><span class="desc_txt" id="rgsAddr"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">연락 주소​​</th>
                                                <td colspan="3"><span class="desc_txt" id="cttAddr"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">계약 일자​</th>
                                                <td><span class="desc_txt" id="slltContDt"></span>​</td>
                                                <th scope="row">입주 일자​</th>
                                                <td><span class="desc_txt" id="miblSchDt"></span>​</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div><!-- info_table -->
                            </section>
                            <section class="cont_section krpl hide">
                                <p class="title1">입금 정보​</p>
                                <div class="info_table">
                                    <table class="table no-head">
                                        <caption>입금 정보​</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:394px">
                                            <col style="width:206px">
                                            <col style="width:394px">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">은행 명​</th>
                                                <td><span class="desc_txt" id="bnkNm"></span>​</td>
                                                <th scope="row">계좌 구분​​</th>
                                                <td><span class="desc_txt" id="bacctFgNm"></span>​</td>
                                            </tr>좌
                                            <tr>
                                                <th scope="row">예금주​</th>
                                                <td><span class="desc_txt" id="dpstrNm">​​</span>​</td>
                                                <th scope="row">계좌번호​</th>
                                                <td><span class="desc_txt" id="bano"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">분양금액</th>
                                                <td colspan="3"><span class="desc_txt" id="slltAmt"></span>​</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">과오납금액</th>
                                                <td><span class="desc_txt" id="mstkDamt"></span>​</td>
                                                <th scope="row">과오납 환불 금액</th>
                                                <td><span class="desc_txt" id="rexpndAmt"></span>​</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </section>
                        </div>
                    </div><!-- //tab_content_wrap -->
                    <div class="tab_linker_wrap krpl hide" id="account-btn">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="javascript:;" data-tab="account-tab-01">입금 내역​</a>
                            </li>
                            <li>
                                <a href="javascript:;" data-tab="account-tab-02">예상 입금액​​​</a>
                            </li>
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class="tab_content_wrap krpl hide" id="account-tab">
                        <!-- 입금 내역​ -->
                        <div class="tab_content" id="account-tab-01">
                            <section class="cont_section">
                                <p class="title1">입금 내역</p>
                                <div class="info_table board">
                                    <table class="table normal_table">
                                         <colgroup>
                                            <col style="width:120px">
                                            <col style="width:168px">
                                            <col style="width:140px">
                                            <col style="width:160px">
                                            <col style="width:140px">
                                            <col style="width:96px">
                                            <col style="width:96px">
                                            <col style="width:130px">
                                            <col style="width:150px">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">차수</th>
                                                <th scope="col">약정 일자</th> 
                                                <th scope="col">약정 금액</th> 
                                                <th scope="col">입금 일자</th> 
                                                <th scope="col">통장 입금액</th> 
                                                <th scope="col">일수</th> 
                                                <th scope="col">연체료</th> 
                                                <th scope="col">할인료</th> 
                                                <th scope="col">납부금액</th> 
                                            </tr>
                                        </thead>
                                        <tbody id="accountInfo">
                                            <tr>
                                                <td colspan="9">검색된 내용이 없습니다.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="comment">※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</p> 
                            </section>
                            <section class="cont_section">
                                <p class="title1">연체 할인율</p>
                                <div class="info_table board">
                                    <table class="table normal_table">
                                        <caption>연체할인율을 기준일자 할인율 연체율을 구분해서 설명합니다.</caption>
                                        <colgroup>
                                            <col span="6" style="width:16.6%">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th rowspan="2" scope="col">기준일자</th>
                                                <th rowspan="2" scope="col">할인율</th>
                                                <th colspan="4" scope="col">연체율</th>
                                            </tr>
                                            <tr>
                                                <th scope="col">30일 미만</th>
                                                <th scope="col">90일 이하</th>
                                                <th scope="col">180일 이하</th>
                                                <th scope="col">180일 이상</th>
                                            </tr>
                                        </thead>
                                        <tbody id="discountTbody">
                                            <tr>
                                                <td colspan="6">검색된 내용이 없습니다.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="comment">※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</p>
                            </section>
                        </div>
                        <!-- 예상 입금액​​​ -->
                        <div class="tab_content hide" id="account-tab-02">
                            <section class="cont_section">
                                <div class="money-search-wrap">
                                    <!-- [D] 0830 : datepicker 관련
                                        1. autocomplete, placeholder 추가
                                        2. elif.datepicker();스크립트 호출
                                    -->
                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                    <fmt:formatDate value="${now}" pattern="yyyyMMdd" var="xptDpstDt"/> 
                                    <label for="datepicker" class="a11y_hide">예상 입금 일자</label>
                                    <input type="text" name="xptDpstDt" id="datepicker_custom" class="border_input sm datepicker" autocomplete="off" placeholder="예상 입금 일자" value="${xptDpstDt}">
                                    <label for="xptFg" class="a11y_hide">입금 구분</label>
                                    <select name="xptFg" id="xptFg" class="sm border-select payment_lookup_selectbox_01"> 
                                        <option value="01">예상 입금 차수</option>
                                        <option value="02">예상 입금액</option>
                                    </select>
                                    <label for="xptEnggDgr" class="a11y_hide">중도금 구분</label>
                                     <select name="xptEnggDgr" id="" class="sm border-select payment_lookup_selectbox_02" >
                                        <%--
                                        <option value="1">계약</option>
                                        <option value="2">중도금1차</option>
                                        <option value="2">중도금2차</option>
                                        <option value="2">중도금3차</option>
                                        <option value="2">중도금4차</option>
                                        <option value="2">중도금5차</option>
                                        <option value="2">잔금</option>
                                        --%>
                                    </select>
                                    <label for="txt" class="a11y_hide">금액 입력</label>
                                    <input type="text" name="xptDamt" class="border_input sm tr payment_lookup_inputbox" value="0" onkeyup="inputNumberFormat(this);">
                                    <button type="button" id="saveXptDpstBtn" class="btn sm border">조회</button>
                                </div>
                                <div class="info_table board">
                                    <table class="table normal_table">
                                        <caption>차수, 약정일자, 약정 금액, 구분, 입금 일자, 실 납부 금액, 일수, 연체료, 할인료, 납부금액을 알려줍니다.</caption>
                                        <colgroup>
                                            <col style="width:110px">
                                            <col style="width:158px">
                                            <col style="width:130px">
                                            <col style="width:90px">
                                            <col style="width:150px">
                                            <col style="width:130px">
                                            <col style="width:86px">
                                            <col style="width:96px">
                                            <col style="width:120px">
                                            <col style="width:130px">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">차수</th>
                                                <th scope="col">약정 일자</th> 
                                                <th scope="col">약정 금액</th> 
                                                <th scope="col">구분</th> 
                                                <th scope="col">입금 일자</th> 
                                                <th scope="col">실 납부 금액</th> 
                                                <th scope="col">일수</th> 
                                                <th scope="col">연체료</th> 
                                                <th scope="col">할인료</th> 
                                                <th scope="col">납부금액</th> 
                                            </tr>
                                        </thead>
                                        <tbody id="saveXptDpst">
                                            <tr>
                                                <td colspan="10">검색된 내용이 없습니다.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="comment">※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</p> 
                            </section>
                            <section class="cont_section">
                                <div class="info_table board">
                                    <table class="table normal_table">
                                        <caption>연체할인율을 기준일자 할인율 연체율을 구분해서 설명합니다.</caption>
                                        <colgroup>
                                            <col span="4" style="width:25%">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">예상 통장 입금액</th>
                                                <th scope="col">예상 납부 금액</th>
                                                <th scope="col">예상 연체료</th>
                                                <th scope="col">예상 할인료</th>
                                            </tr>
                                        </thead>
                                        <tbody id="saveXptDpst2">
                                            <tr>
                                               <td class="tr" id="rdpst">0원</td>
                                               <td class="tr" id="rcgAmt">0원</td>
                                               <td class="tr" id="odufe">0원</td>
                                               <td class="tr" id="dcfe">0원</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="comment">※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</p> 
                            </section>
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
        elif.datepicker();
        elif.paymentLookup();
        
        $("#datepicker_custom").datepicker({
            dateFormat: 'yymmdd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월'
            ],
            monthNamesShort: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월'
            ],
            dayNames: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            dayNamesShort: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            dayNamesMin: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            showMonthAfterYear: true,
            yearSuffix: '년',
            // maxDate: 0, //오늘 이후 날짜 선택 불가
            // yearRange: "2000:2021" //연도 범위
        });
        //자릿수
        function comma(str) {
            str = String(str);
            return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
        };
        function uncomma(str) {
            str = String(str);
            return str.replace(/[^\d]+/g, '');
        };
        function inputNumberFormat(obj) {
            obj.value = comma(uncomma(obj.value));
        };
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
            }
        });

        $('[name=xptDamt]').on('keyup',function(){
            $(this).val(plprice($(this).val()));
        });

        $('#account-btn [data-tab]').on('click',function(){
            $('#account-btn li').removeClass('on');
            $(this).closest('li').addClass('on');
            if($(this).data('tab')=='account-tab-01'){
                $('#account-tab-01').removeClass('hide');
                $('#account-tab-02').addClass('hide');
            }else{
                // 5. 예상입금액- 조회
                $('#account-tab-01').addClass('hide');
                $('#account-tab-02').removeClass('hide');
            }
        });
        $('#saveXptDpstBtn').on('click',function(){
            loadExpectation();
        });

        var pjt_cd='';
        var bl_cd='';
        var rmno_cd='';
        var cont_seq='0';
        var contKndCd='';
        var data = {}
        $('#pop_presale').on('click',function(){
            document.form_dtl.pjtCd.value	= pjt_cd;
            document.form_dtl.blCd.value	= bl_cd;
            document.form_dtl.rmnoCd.value	= rmno_cd;
            document.form_dtl.contSeq.value	= cont_seq;

            document.form_dtl.action		= "https://eps.kyeryong.net/jsp/hs/hcst/hs_hcst850_cust_info_p02_new.jsp";
            document.form_dtl.target		= "popupMyAptDtl";
            document.form_dtl.submit();
        });
        if(loadMyinfo()==true){
        }
        function loadMyinfo(){
            var retBool = false;
            retBool = true;
            $.ajax({
                type : "POST",
                url : "/mypage/presale",
                cache : false,
                async: false,
                data : {},//추후에 삭제
                success : function(data){
                    if(data.result==true){
                        var options = '';
                        $.each(data.list,function(key,value){
                            console.log(data.list);
                            options += '<option value="'+value.PJT_CD+'" data-pjt_cd="'+value.PJT_CD+'" data-bl_cd="'+value.BL_CD+'" data-rmno_cd="'+value.RMNO_CD+'" data-cont_seq="'+value.CONT_SEQ+'">'+value.PJT_NM+"("+value.BL_NM+")"+'</option>';
                        });
                        $('[name=pjt_cd]').append(options);
                    }else{
                        console.log('분양정보를 가져올 수 없습니다.')
                    }
                },
                error : function(data,status){
                    alert( "관리자에게 문의하시기 바랍니다." );
                }
            });
            return retBool;
        }
        $(document).on('change','[name=pjt_cd]',function(){
            var optFg = "";
            var selected = $(this).find('option:selected');
            if(selected.data('cont_seq')=="0"){
                optFg = "<option value='HS00301'>분양금액</option><option value='HS00303'>PLUS옵션금액</option><option value='HS00302'>발코니확장금액</option><option value='HS00309'>상가</option>";
            }else{
                optFg = "<option value='HS00305'>임대보증금액</option>";
            }
            $('[name=comAmtFg]').html(optFg);
            
        })

        $(document).on('click','#payment-lookup',function(){
            $('.krpl').addClass('hide');
            if($('[name=pjt_cd]').val()==''){
                alert('사업장 명을 선택해주세요.');
                return;
            }
            var selected = $('[name=pjt_cd]').find('option:selected');
            data = {'coCd':'10','pjtCd':selected.data('pjt_cd'),'blCd':selected.data('bl_cd'),'rmnoCd':selected.data('rmno_cd'),'contSeq':selected.data('cont_seq')};
            $('#account-btn li').removeClass('on').eq(0).addClass('on');
            
            $('#account-tab-01').removeClass('hide');
            $('#account-tab-02').addClass('hide');
            
            loadAjaxSort();
        });
        
        function loadAjaxSort(){
            // 0. 계약자 정보
            loadMyRgsInfo()

            // 1. 계약내역- 조회
            loadMyPreSale();

            // 2. 연체할인율- 조회
            loadDiscount();
            // 3. 입금계좌정보- 조회
            loadAccount();
            // 4. 입금내역정보- 조회
            loadAccountInfo();
            // 5. 예상입금액- 조회
            // loadExpectation();
            좌
            // 예상입금액- 차수 조회
            loadExpectationDegree();

            $('.krpl').removeClass('hide');
            $([document.documentElement, document.body]).animate({
                scrollTop: $("#payment-lookup").offset().top
            }, 300);
        }

        // 0. 계약자 정보
        function loadMyRgsInfo(){
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/cpsndtls/retrieveCpsnDtls.ajax";
            data.url = mysale_url;
            data.contKndCd = $('[name=comAmtFg]').val();
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                async: false,
                success : function(res){
                    var resData = res[0];
                    console.log('0. 계약자 정보',resData.records);
                    $.each(resData.records,function(key,value){
                        $('#telNo').text(value.telNo);
                        $('#mp1No').text(value.mp1No);
                        $('#rgsAddr').text(value.rgsAddr);
                        $('#cttAddr').text(value.cttAddr);
                        $('#slltContDt').text(value.slltContDt);
                        $('#fnlDvrsSqms').text(value.fnlDvrsSqms);
                        $('#slltAmt').text(value.slltAmt);
                        $('#landAmt').text(value.landAmt);
                        $('#archAmt').text(value.archAmt);
                        $('#vat').text(value.vat);
                        $('#mstkDamt').text(value.mstkDamt);
                        $('#rexpndAmt').text(value.rexpndAmt);
                        $('#miblSchDt').text(value.miblSchDt);
                    });

                    
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
            return true;
        }
        // 1. 계약내역- 조회
        function loadMyPreSale(){
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/cpsndtls/retrieveCpsnInfo.ajax";
            data.url = mysale_url;
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                async: false,
                success : function(res){
                    var resData = res[0];
                    console.log('1. 계약내역- 조회',resData.records);
                    $.each(resData.records,function(key,value){
                        $('#pjtMrkgNm').text(value.pjtMrkgNm);
                        $('#custNm').text(value.custNm);
                        $('#blNm-rmnoNm').text(value.blNm+''+' '+value.rmnoNm+'호');
                        $('#pjtMrkgComboNm').text(value.pjtMrkgComboNm);
                        $('#ptpNm').text(value.ptpNm);
                        $('#slltFgNm').text(value.slltFgNm);
                        $('#ptpNm').text(value.ptpNm);
                    });

                    
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
            return true;
        }
        // 2. 연체할인율- 조회
        function loadDiscount(){
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/odudcrt/retrieveOduDcrt.ajax";
            data.url = mysale_url;
            data.contKndCd = $('[name=comAmtFg]').val();
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                async: false,
                success : function(res){
                    var resData = res[0];
                    console.log('2. 연체할인율- 조회',resData.records);
                    var tbody = "";
                    $.each(resData.records,function(key,value){
                        tbody += '\
                        <tr>\
                            <td class="tc">'+nvl(value.dpstBssDt, "")+'</td>\
                            <td class="tc">'+nvl(value.dcrt, "")+'</td>\
                            <td class="tr">'+nvl(value.d30UndOdurt, "")+'</td>\
                            <td class="tr">'+nvl(value.d90UndOdurt, "")+'</td>\
                            <td class="tr">'+nvl(value.d180UndOdurt, "")+'</td>\
                            <td class="tr">'+nvl(value.d180OvrOdurt, "")+'</td>\
                        </tr> \
                        ';
                    });
                    $('#discountTbody').html(tbody);
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
            
        }
        // 3. 입금계좌정보- 조회
        function loadAccount(){
            //var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/dpstbacctinfo/retrieveDpstBacctInfo.ajax";
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/dpstbacctinfo/retrieveDpstBacctInfoVrtl.ajax";
            data.url = mysale_url;
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                async: false,
                success : function(res){
                    var resData = res[0];
                    console.log('3. 입금계좌정보- 조회',resData.records);
                    $('#bacctFgNm').text("");
                    $('#bano').text("");
                    $('#bnkNm').text("");
                    $('#dpstrNm').text("");
                    $.each(resData.records,function(key,value){
                        if($('[name=comAmtFg]').val() == 'HS00301' && value.bacctFgCd == 'HS01402' && value.bacctFgNm == '일반'){
                            if(value.bano != null && value.vrtlBano != null){
                                $('#bacctFgNm').text(value.bacctFgNm);
                                $('#bano').text(value.vrtlBano);
                                $('#bnkNm').text(value.bnkNm);
                                $('#dpstrNm').text(value.dpstrNm);
                            }else{
                                if(value.vrtlBano != null){
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.vrtlBano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }else{
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.bano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }
                            }
                        }else if($('[name=comAmtFg]').val() == 'HS00309' && value.bacctFgCd == 'HS01410' && value.bacctFgNm == '상가'){
                            if(value.bano != null && value.vrtlBano != null){
                                $('#bacctFgNm').text(value.bacctFgNm);
                                $('#bano').text(value.vrtlBano);
                                $('#bnkNm').text(value.bnkNm);
                                $('#dpstrNm').text(value.dpstrNm);
                            }else{
                                if(value.vrtlBano != null){
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.vrtlBano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }else{
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.bano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }
                            }
                        }else if($('[name=comAmtFg]').val() == 'HS00302' && value.bacctFgCd == 'HS01405' && value.bacctFgNm == '발코니확장'){
                            if(value.bano != null && value.vrtlBano != null){
                                $('#bacctFgNm').text(value.bacctFgNm);
                                $('#bano').text(value.vrtlBano);
                                $('#bnkNm').text(value.bnkNm);
                                $('#dpstrNm').text(value.dpstrNm);
                            }else{
                                if(value.vrtlBano != null){
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.vrtlBano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }else{
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.bano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }
                            }
                        }else if($('[name=comAmtFg]').val() == 'HS00303' && value.bacctFgCd == 'HS01406' && value.bacctFgNm == 'PLUS옵션'){
                            if(value.bano != null && value.vrtlBano != null){
                                $('#bacctFgNm').text(value.bacctFgNm);
                                $('#bano').text(value.vrtlBano);
                                $('#bnkNm').text(value.bnkNm);
                                $('#dpstrNm').text(value.dpstrNm);
                            }else{
                                if(value.vrtlBano != null){
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.vrtlBano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }else{
                                    $('#bacctFgNm').text(value.bacctFgNm);
                                    $('#bano').text(value.bano);
                                    $('#bnkNm').text(value.bnkNm);
                                    $('#dpstrNm').text(value.dpstrNm);
                                }
                            }
                        }
                    })

                },
                error : function(data,status){
                    console.log( status );
                }
            });

        }
        // 4. 입금내역정보- 조회
        function loadAccountInfo(){
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/dpstdtls/retrieveDpstDtls.ajax";
            data.url = mysale_url;
            data.contKndCd = $('[name=comAmtFg]').val();
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                async: false,
                success : function(res){
                    var resData = res[0];
                    console.log('4. 입금내역정보- 조회',resData.records);
                    var tbody = "";
                    $.each(resData.records,function(key,value){
                        tbody += '\
                        <tr>\
                            <td class="tc">'+nvl(value.enggDgrNm, "")+'</td>\
                            <td class="tc">'+nvl(value.enggDt, "")+'</td>\
                            <td class="tr">'+nvl(value.enggAmt, "")+'</td>\
                            <td class="tc">'+nvl(value.dpstDt, "")+'</td>\
                            <td class="tr">'+nvl(value.rdpst, "")+'</td>\
                            <td class="tc">'+nvl(value.dcnt, "")+'</td>\
                            <td class="tr">'+nvl(value.odufe, "")+'</td>\
                            <td class="tr">'+nvl(value.dcfe, "")+'</td>\
                            <td class="tr">'+nvl(value.rcgAmt, "")+'</td>\
                        </tr> \
                        ';
                    });
                    $('#accountInfo').html(tbody);
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
            
        }
        
        // 5. 예상입금액- 조회
        function loadExpectation(){
            //var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/xptdpst/retrieveXptDpst.ajax";
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/xptdpst/saveXptDpst.ajax";
            data.url = mysale_url;
            data.contKndCd = $('[name=comAmtFg]').val();
            
            if($('[name=xptFg]').val()==''){
                alert('조회 구분을 선택해주세요.');
                return;
            }else{
                data.xptFg = $('[name=xptFg]').val();// 예상입금액 탭 예상입금구분(차수별:01, 입금액별:02)

                if($('[name=xptFg]').val()=='01'){
                    if($('[name=xptEnggDgr]').val()==''){
                        alert('입금 차수를 선택해주세요.');
                        return;
                    }else{
                        data.xptEnggDgr = $('[name=xptEnggDgr]').val();
                        data.fg= 'B';
                        data.xptDamt = "0";
                        data.regpsnId="1291";
                       
                    }
                }else{
                    
                    if($('[name=xptEnggDgr]').val()==''){
                        data.xptEnggDgr = "잔금";
                    }else{
                        data.xptEnggDgr = nvl($('[name=xptEnggDgr]').find('option').eq(1).val(), "");
                    }
                    data.fg= 'B';
                    data.regpsnId="1291";
                    data.xptDamt = $('[name=xptDamt]').val()==''?0:$('[name=xptDamt]').val();// 예상입금액 탭 예상입금액
                    data.xptDamt = data.xptDamt.replace(/,/gi,'');
                }
            }
            console.log( $('[name=xptDpstDt]').val());
            data.xptDpstDt = $('[name=xptDpstDt]').val();// 예상입금액 탭 예상입금일자
            
            
             //예상입금 차수
            // data.regpsnId= '';
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : data,
                success : function(res){
                    var resData = res[0];
                    console.log('5. 예상입금액- 조회',resData.records);

                    var tbody = "";
                    $.each(resData.records,function(key,value){
                        tbody += '\
                        <tr>\
                            <td class="tc">'+nvl(value.enggDgrNm, "")+'</td>\
                            <td class="tc">'+pldate(nvl(value.enggDt, ""))+'</td>\
                            <td class="tr">'+plprice(nvl(value.enggAmt, "0"))+'</td>\
                            <td class="tc">'+nvl(value.dpstRmks, "")+'</td>\
                            <td class="tr">'+pldate(nvl(value.dpstDt, ""))+'</td>\
                            <td class="tc">'+plprice(nvl(value.rdpst, "0"))+'</td>\
                            <td class="tr">'+plprice(nvl(value.dcnt, "0"))+'</td>\
                            <td class="tr">'+plprice(nvl(value.odufe, "0"))+'</td>\
                            <td class="tr">'+plprice(nvl(value.dcfe, "0"))+'</td>\
                            <td class="tr">'+plprice(nvl(value.rcgAmt, "0"))+'</td>\
                        </tr> \
                        ';
                        if(value.dpstRmks=='예상입금'){
                            $('#rdpst').html(plprice(value.rdpst)+'원');
                            $('#rcgAmt').html(plprice(value.rcgAmt)+'원');
                            $('#odufe').html(plprice(value.odufe)+'원');
                            $('#dcfe').html(plprice(value.dcfe)+'원');

                        }
                    });
                    $('#saveXptDpst').html(tbody);
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
        
            
        }

        $(document).on('change','[name=xptFg]',function(){
            if($(this).val()=='01'){
                // $("#datepicker_custom").datepicker("option", "maxDate", 0);
                loadExpectationDegree();
            }else{
                // $("#datepicker_custom").datepicker("option", "maxDate", 365);
            }
        });

        // 5. 예상입금액- 차수 조회
        // https://eps.kyeryong.net/hs/hcst/s850/enggdgr/retrieveEnggDgr.ajax?pjtCd=175180&blCd=0006&rmnoCd=0203&contSeq=0&contKndCd=HS00301&fgCd=A
        function loadExpectationDegree(){
            var mysale_url = "https://eps.kyeryong.net/hs/hcst/s850/enggdgr/retrieveEnggDgr.ajax";
            var dataDegree = {};
            dataDegree.url = mysale_url;
            dataDegree.pjtCd= data.pjtCd;
            dataDegree.blCd= data.blCd;
            dataDegree.rmnoCd= data.rmnoCd;
            dataDegree.contSeq= data.contSeq;
            dataDegree.contKndCd= data.contKndCd;
            dataDegree.fgCd= 'A';// 예상입금액 탭 예상입금액 조회용 조회조건
            // data.regpsnId= '';
            $.ajax({
                type : "GET",
                url : "/krcon/api",
                dataType: 'json',
                data : dataDegree,
                success : function(res){
                    var resData = res[0];
                    console.log('5. 예상입금액- 차수 조회',resData.records);
                    var tbody = '';
                    var count = 0;
                    $.each(resData.records,function(key,value){
                        tbody += '<option value="'+value.slltCd+'">'+value.slltCdNm+'</option>';
                        count++;
                    });
                    if(count>0){
                        $('[name=xptEnggDgr]').addClass('on').html(tbody);
                    }
                    
                    
                },
                error : function(data,status){
                    console.log( status );
                }
            });
        
            
        }
    /**
     * 문자열이 빈 문자열인지 체크하여 기본 문자열로 리턴한다.
     * @param str           : 체크할 문자열
     * @param defaultStr    : 문자열이 비어있을경우 리턴할 기본 문자열
     */
    function nvl(str, defaultStr){
        str = String(str);
        if(str == "undefined" || str == "" || str == "null")
            str = defaultStr ;
         
        return str ;
    }
    function plprice(str){
        str = String(str);
        if(str == "undefined" || str == "" || str == "null"){
            str = 0 ;
        }else{
            str = str.replace(/,/gi,'').replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
        }
        return str ;
    }
    function pldate(str){
        str = String(str);
        if(str == "undefined" || str == "" || str == "null"){
            str = '' ;
        }else{
            if(str.length>7){
                str = str.substring(0,4)+'-'+str.substring(4,6)+'-'+str.substring(6,8);
            }
        }
        return str ;
    }
    </script>
</body>

</html>