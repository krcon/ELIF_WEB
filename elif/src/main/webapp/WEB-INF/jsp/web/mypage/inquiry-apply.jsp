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
    <meta name="title" content="고객문의, 엘리프"/> 
    <meta name="keywords" content="엘리프, 고객문의, MY ELIF, 엘리프"/> 
    <meta name="description" content="궁금하신 내용을 문의할 수 있는 고객문의 페이지입니다. "/>
    <meta property="og:title" content="고객문의, 엘리프">
    <meta property="og:description" content="궁금하신 내용을 문의할 수 있는 고객문의 페이지입니다. ">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>고객문의 | 엘리프</title>
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
                        <li><span>고객 문의</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb small">
                        <ul>
                            <li><a href="../mypage/index">홈</a></li>
                            <li><a href="../mypage/mycomplex">나의 분양 단지</a></li>
                            <li><a href="../mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="../mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="../mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="../mypage/inquiry-apply" class="on">고객 문의</a></li>
                            <li><a href="../mypage/notice">공지사항</a></li>
                            <li><a href="../mypage/elifNews">엘리프 뉴스</a></li>
                            <li><a href="../mypage/FAQ-view">FAQ</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li class="on">
                                <a href="../mypage/inquiry-apply">고객문의​​​</a>
                            </li>
                            <li>
                                <a href="../mypage/inquiry-lookup">문의내역​​​</a>
                            </li> 
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                        <form name="frmSubmit" method="post" action="" class="form-inline text-right navbar-form">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <section class="cont_section">
                                <p class="ess_txt">*표시는 필수 입력 항목입니다.​</p>
                                <div class="info_table">
                                    <table class="table no-head">
                                        <caption>고객문의를 입력하는 테이블입니다.</caption>
                                        <colgroup>
                                            <col style="width:206px">
                                            <col style="width:806px">
                                        </colgroup>
                                        <tbody>
                                            <!-- [D] 0830 : 문의 분류 제거 -->
                                            <tr>
                                                <th scope="row"><label for="type" class="tit ess">문의 구분</label></th>
                                                <td>
                                                    <select id="type" class="wmd" name="type">
                                                        <option value="RV02401">단지 문의</option>
                                                        <option value="RV02402">기타 문의</option>'
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="name" class="tit ess">단지명​</label></th>
                                                <td>
                                                    <select id="name" class="wmd" name="pjt_cd">
                                                        <option value="">선택</option>

                                                        <c:if test="${fn:length(list) > 0}">
                                                        <c:forEach items="${list }" var="row">
                                                        <option value="${row.pjt_cd}" ${param.pjt_cd==row.pjt_cd?'selected':''}>${row.pjt_nm}</option>
                                                        </c:forEach>
                                                        </c:if>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">이름</span></th>
                                                <td>
                                                    <span class="desc_txt">${sessionScope.memberSession.user_nm}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">휴대전화번호</span></th>
                                                <td>
                                                    <span class="desc_txt">${sessionScope.memberSession.hp}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><span class="tit">이메일</span></th>
                                                <td>
                                                    <span class="desc_txt">${sessionScope.memberSession.email}</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label class="tit ess" for="tit">제목</label></th>
                                                <td>
                                                    <input type="text" name="title" id="tit" title="제목을 입력하세요">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="cont" class="tit ess">내용</label></th>
                                                <td>
                                                    <textarea name="inquiry_content" title="내용을 입력하세요" id="cont"></textarea>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </section>
                            <section class="cont_section">
                                <p class="title1">개인정보 수집 및 이용에 대한 동의</p>
                                <div class="border_box">
                                    <p class="refer_txt">문의 내역 상담 진행을 위하여, 귀하의 개인정보를 수집, 이용하는데 있어 귀하의 동의를 받고자 합니다.​</p>
                                    <div class="info_table">
                                        <table class="table normal_table">
                                            <caption>>문의 내역 상담 진행을 수집항목 이용목적 보유 및 이용시간을 구분해 설명합니다</caption>
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
                                                    <td>단지명, 성함, 휴대전화번호, 이메일, 상담 내용​</td>
                                                </tr>
                                                <tr>
                                                    <td>이용 목적</td>
                                                    <td>고객 문의 상담 신청 접수 및 처리, 분쟁조정을 위한 기록​​</td>
                                                </tr>
                                                <tr>
                                                    <td>보유 및 이용기간​​​</td>
                                                    <td>접수일로부터 3년​</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <p class="refer_txt">위 개인정보 수집 및 이용에 대해서 미동의할 수 있으나, 이 경우 고객 문의 상담이 진행 될 수 없음을 알려드립니다.​</p>
                                </div>
                                <div class="agree_area">
                                    <label for="ok" class="agree_txt">개인정보 수집 및 이용에 동의하시겠습니까?​</label>
                                    <span class="radio-wrap">
                                        <input type="radio" name="agree" value="Y" id="ok" ><label for="ok">동의</label>
                                    </span>
                                    <span class="radio-wrap">
                                        <input type="radio" name="agree" value="N" id="no" checked><label for="no">미동의</label>
                                    </span>
                                </div>
                                <div class="btn_area">
                                    <button type="submit" class="btn green">문의 등록</button>
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
    /**
     * 수정일자 : 23.05.11
     * 작업자 : 플레어 (한동호)
     * 내용 : 기타문의 선택시 단지명 선택 가능하도록 처리

    $('[name=type]').on('change',function(){
        if($(this).val()=='RV02401'){
            $('[name=pjt_cd]').closest('tr').show();
        }else if($(this).val()=='RV02402'){
            $('[name=pjt_cd]').val('').closest('tr').hide();
            
        }
    })*/
    $('[name=frmSubmit]').submit(function(){
        if(formValidation('frmSubmit')){
            if(confirm('등록하시겠습니까?')){
                return true;
            }
        }
        return false;
    });
    function formValidation(frm){
        var returnValue = true;
        if($('[name='+frm+'] [name=pjt_cd]').val().length<2&&$('[name='+frm+'] [name=type]').val()=='RV02401'){
            alert('단지명을 입력해주세요.');
            $('[name='+frm+'] [name=pjt_cd]').focus();
            returnValue = false;
        }else if($('[name='+frm+'] [name=title]').val().length<2){
            alert('제목을 입력해주세요.');
            $('[name='+frm+'] [name=title]').focus();
            returnValue = false;
        }else if($('[name='+frm+'] [name=inquiry_content]').val().length<2){
            alert('내용을 입력해주세요.');
            $('[name='+frm+'] [name=inquiry_content]').focus();
            returnValue = false;
        }else if($('[name='+frm+'] [name=agree]:checked').val()!='Y'){
            alert('개인정보 수집 및 이용에 동의 해주세요.');
            $('[name='+frm+'] [name=agree]').focus();
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