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
    <meta name="description" content="고객님의 분양대금을 조회할 수 있습니다."/>
    <meta property="og:title" content="분양대금 납부조회, 엘리프">
    <meta property="og:description" content="고객님의 분양대금을 조회할 수 있습니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />

    <title>분양대금조회 | 엘리프 | 모바일</title>
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
                            <li><a href="/mobile/mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="/mobile/mypage/payment-guide" class="on">분양대금 조회</a></li>
                            <!-- <li><a href="/mobile/mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="/mobile/mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="/mobile/mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="/mobile/mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li>
                                <a href="/mobile/mypage/payment-guide">분양 가이드</a>
                            </li>
                            <li class="on">
                                <a href="/mobile/mypage/payment-lookup">중도금 조회</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tab_content_wrap">
                        <div class="tab_content">
                            <section class="cont_section">
                                <div class="menu_sel_wrap">
                                    <select class="menu_sel" title="선택, 입금내역, 예상 입금액 선택">
                                        <%-- <option value="">선택</option>  --%>
                                        <option value="01">입금내역</option>
                                        <option value="02">예상 입금액</option>
                                    </select>
                                </div>
                                <div class="info_table">
                                    <ul class="info_list">
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="apt" class="tit ess">사업장 명</label>
                                            </div>
                                            <div class="info_type">
                                                <select id="apt" name="pjt_cd" class="wmd">
                                                    <option value="">선택</option>
                                                </select>
                                            </div>
                                        </li>
                                        <li class="info_item">
                                            <div class="info_label">
                                                <label for="price" class="tit ess">금액 구분</label>
                                            </div>
                                            <div class="info_type">
                                                <select id="price" name="comAmtFg" class="wmd">
                                                    <option value="">선택</option>
                                                </select>
                                            </div>
                                        </li>


                                        <li class="info_item acc_item-02 hide">
                                            <div class="info_label">
                                                <label for="date" class="date">예상 입금 일자</label>
                                            </div>
                                            <div class="info_type">
                                                <c:set var="now" value="<%=new java.util.Date()%>" />
                                                <fmt:formatDate value="${now}" pattern="yyyyMMdd" var="xptDpstDt"/> 
                                                <input type="text" name="xptDpstDt" id="date" class="date" autocomplete="off" placeholder="예상 입금 일자" value="${xptDpstDt}">
                                            </div>
                                        </li>
                                        <li class="info_item acc_item-02 hide">
                                            <div class="info_label">
                                                <label for="xptFg" class="tit">구분</label>
                                            </div>
                                            <div class="info_type">
                                                <select name="xptFg" id="xptFg" class="sm border-select payment_lookup_selectbox_01"> 
                                                    <option value="01">예상 입금 차수</option>
                                                    <option value="02">예상 입금액</option>
                                                </select>
                                            </div>
                                        </li>
                                        <li class="info_item acc_item-02 hide">
                                            <div class="info_label">
                                                <label for="times" class="tit">입금 차수</label>
                                            </div>
                                            <div class="info_type">
                                                <select name="xptEnggDgr" id="times">
                                                </select>
                                            </div>
                                        </li>
                                        <li class="info_item acc_item-02 hide">
                                            <div class="info_label">
                                                <label for="xptDamt" class="tit">예상 입금액</label>
                                            </div>
                                            <div class="info_type">
                                                <input type="text" name="xptDamt" value="0" onkeyup="inputNumberFormat(this);">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="btn_area">
                                    <button type="button" id="payment-lookup" class="btn green">조회</button>
                                </div>
                            </section>
                            <section class="cont_section la_mg krpl hide">
                                <ul class="acc_list">
                                    <li class="acc_item">
                                        <div class="acc_header">
                                            <button type="button" class="acc_btn">
                                                계약 내역
                                                <i class="acc_ico"></i>
                                            </button>
                                        </div>
                                        <div class="acc_body">
                                            <div class="info_table">
                                                <ul class="info_list">
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">사업장 명</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="pjtMrkgNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">동호수</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="blNm-rmnoNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">평형타입</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="ptpNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">사업장 구분</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="slltFgNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">전용면적</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="fnlDvrsSqms"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">이름</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="custNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">전화번호</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="telNo"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">휴대전화번호</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="mp1No"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">등기 주소</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="rgsAddr"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">연락 주소</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="cttAddr"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">계약 일자</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="slltContDt"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">입주 일자</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt"id="miblSchDt"></span>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div><!-- //acc_body -->
                                    </li>
                                    <li class="acc_item">
                                        <div class="acc_header">
                                            <button type="button" class="acc_btn">
                                                입금 정보
                                                <i class="acc_ico"></i>
                                            </button>
                                        </div>
                                        <div class="acc_body">
                                            <div class="info_table">
                                                <ul class="info_list">
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">은행 명</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt"id="bnkNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">계좌 구분</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="bacctFgNm"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">예금주</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="dpstrNm">​​</span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">계좌번호</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="bano"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">분양 금액</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="slltAmt"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">과오납 금액</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="mstkDamt"></span>
                                                        </div>
                                                    </li>
                                                    <li class="info_item">
                                                        <div class="info_label">
                                                            <span class="tit">과오납 환불 금액</span>
                                                        </div>
                                                        <div class="info_type">
                                                            <span class="desc_txt" id="rexpndAmt"></span>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div><!-- //acc_body -->
                                    </li>
                                    <li class="acc_item acc_item-01">
                                        <div class="acc_header">
                                            <button type="button" class="acc_btn">
                                                입금 내역
                                                <i class="acc_ico"></i>
                                            </button>
                                        </div>
                                        <div class="acc_body">
                                            <div class="scroll_x_box">
                                                <div class="table_wrap">
                                                    <table class="table">
                                                        <caption>차수, 약정 일자, 약정 금액, 구분, 입금 일자, 실 납부 금액, 일수, 연체료, 할인료, 납부금액을 선택 또는 입력하는 테이블입니다.</caption>
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
                                            </div>
                                            <sub>※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</sub>
                                        </div><!-- //acc_body -->
                                    </li>
                                    <li class="acc_item acc_item-01">
                                        <div class="acc_header">
                                            <button type="button" class="acc_btn">
                                                연체 할인율
                                                <i class="acc_ico"></i>
                                            </button>
                                        </div>
                                        <div class="acc_body">
                                            <div class="info_table">
                                                <ul class="info_list" id="discountTbody">
                                                </ul>
                                            </div>
                                            <sub>※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</sub>
                                        </div><!-- //acc_body -->
                                    </li>


                                    <li class="acc_item acc_item-02 hide">
                                        <div class="acc_header">
                                            <button type="button" class="acc_btn">
                                                예상 입금액
                                                <i class="acc_ico"></i>
                                            </button>
                                        </div>
                                        <div class="acc_body">
                                            <div class="scroll_x_box">
                                                <div class="table_wrap">
                                                    <table class="table">
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
                                            </div>
                                            <p class="comment">※ 잔금 약정일자는 임의 지정일로 추후 입주개시 일자 확정 시 선납할인 금액은 변경될 수 있습니다.</p>
                                            <dl class="amount_list">
                                                <div class="item">
                                                    <dt class="item_tit">예상 통장 입금액</dt>
                                                    <dd class="item_amount" id="rdpst">0원</dd>
                                                </div>
                                                <div class="item">
                                                    <dt class="item_tit">예상 납부 금액</dt>
                                                    <dd class="item_amount" id="rcgAmt">0원</dd>
                                                </div>
                                                <div class="item">
                                                    <dt class="item_tit">예상 연체료</dt>
                                                    <dd class="item_amount" id="odufe">0원</dd>
                                                </div>
                                                <div class="item">
                                                    <dt class="item_tit">예상 할인료</dt>
                                                    <dd class="item_amount" id="dcfe">0원</dd>
                                                </div>
                                            </dl>
                                        </div><!-- //acc_body -->
                                    </li>
                                </ul>
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
        // 자릿수
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

        var firstLoad = false;
        var accitem = false;
        $(document).on('change','.menu_sel',function(){
            if($(this).val()=='01'){
                $('.acc_item-01').removeClass('hide');
                $('.acc_item-02').addClass('hide');
            }else{
                if(firstLoad==false){
                    alert('먼저 입금내역을 조회해 주세요.');
                    $(this).val('01');
                    return false;
                }
                // 5. 예상입금액- 조회
                $('.acc_item-01').addClass('hide');
                $('.acc_item-02').removeClass('hide');
                
            }
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
            accitem = true;
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
            if($('[name=pjt_cd]').val()==''){
                alert('사업장 명을 선택해주세요.');
                return;
            }
            var selected = $('[name=pjt_cd]').find('option:selected');
            data = {'coCd':'10','pjtCd':selected.data('pjt_cd'),'blCd':selected.data('bl_cd'),'rmnoCd':selected.data('rmno_cd'),'contSeq':selected.data('cont_seq')};
            $('#account-btn li').removeClass('on').eq(0).addClass('on');
            console.log($('.menu_sel').val());
            if($('.menu_sel').val()=='01'){
                $('.krpl').addClass('hide');
                $('#account-tab-01').removeClass('hide');
                $('#account-tab-02').addClass('hide');
                loadAjaxSort();
                firstLoad = true;
            }else{
                loadExpectation();
            }
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

            loadExpectationDegree();
            $('.krpl').removeClass('hide');
            console.log($("#payment-lookup").offset().top);
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
                        <li class="info_item">\
                            <div class="info_label">\
                                <span class="tit">기준 일자</span>\
                            </div>\
                            <div class="info_type">\
                                <span class="desc_txt">'+nvl(value.dpstBssDt, "")+'</span>\
                            </div>\
                        </li>\
                        <li class="info_item">\
                            <div class="info_label">\
                                <span class="tit">할인율</span>\
                            </div>\
                            <div class="info_type">\
                                <span class="desc_txt">'+nvl(value.dcrt, "")+'</span>\
                            </div>\
                        </li>\
                        <li class="info_item">\
                            <div class="info_label">\
                                <span class="tit">연체율</span>\
                            </div>\
                            <div class="info_type">\
                                <span class="desc_txt">\
                                    '+nvl(value.d30UndOdurt, "")+' <br>\
                                    '+nvl(value.d90UndOdurt, "")+'<br>\
                                    '+nvl(value.d180UndOdurt, "")+'<br>\
                                    '+nvl(value.d180OvrOdurt, "")+'\
                                </span>\
                            </div>\
                        </li>\
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
            delete data.fgCd;
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
                loadExpectationDegree();
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
                    var count=0;
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
