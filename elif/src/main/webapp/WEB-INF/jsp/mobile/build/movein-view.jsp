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
    <meta name="title" content="입주단지, 엘리프"/>
    <meta name="keywords" content="입주단지, 아파트, 상가, 입주 진행, 입주 예정, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 입주단지를 안내해드립니다."/>
    <meta property="og:type" content="website" /> 
    <meta property="og:title" content="입주단지, 엘리프">
    <meta property="og:description" content="엘리프의 입주단지를 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <link href="/resources/mobile/css/slick.css" rel="stylesheet">
    <title>공사/입주 | 엘리프 | 모바일</title>
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
                <!-- Visual & Title -->
                <section class="visual build">
                    <h2>공사/입주 정보</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="/mobile/build/construction">공사 단지</a></li>
                            <li><a href="/mobile/build/movein" class="on">입주 단지</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->

                    <!-- 입주단지-view -->
                    <section class="construction">
                        <dl>
                            <dt>
                                <div class="tit_wrap">
                                    <div class="flag">${detail.housing_name}</div>
                                    <div class="tit">${detail.pjt_nm}</div>
                                </div>
                                <div class="sns_wrap">
                                    <button class="sns_btn" type="button"><span class="a11y_hide">sns 공유</span></button>
                                    <div class="sns_panel">
                                        <div class="sns_panel_dim"></div>
                                        <div class="sns_contents">
                                            <div>
                                                <a href="javascript:shareKakao();"><img src="/resources/mobile/images/ico_shareKakao.png" alt="카카오톡 공유하기"><p>카카오톡</p></a>
                                                <a href="javascript:shareStory();"><img src="/resources/mobile/images/ico_shareStory.png" alt="카카오스토리 공유하기"><p>카카오스토리</p></a>
                                                <a href="javascript:shareLine();"><img src="/resources/mobile/images/ico_shareLine.png" alt="네이버 라인 공유하기"><p>라인</p></a>
                                                <a href="javascript:shareBand();"><img src="/resources/mobile/images/ico_shareBand.png" alt="네이버 밴드 공유하기"><p>밴드</p></a>
                                                <a href="javascript:shareBlog();"><img src="/resources/mobile/images/ico_shareBlog.png" alt="네이버 블로그 공유하기"><p>블로그</p></a>
                                                <a href="javascript:shareFacebook();"><img src="/resources/mobile/images/ico_shareFacebook.png" alt="페이스북 공유하기"><p>페이스북</p></a>
                                                <a href="javascript:shareTwitter();"><img src="/resources/mobile/images/ico_shareTwitter.png" alt="트위터 공유하기"><p>트위터</p></a>
                                            </div>
                                            <div class="copyCont">
                                                <label for="ShareUrl" class="a11y_hide">url 주소</label>
                                                <input type="text" id="ShareUrl">
                                                <span class="btn_area">
                                                    <button class="CopyUrl">URL 복사</button>
                                                </span>
                                            </div>
                                            <a href="javascript:void(0)" id="sns_close"><span>닫기</span></a>
                                        </div>
                                    </div>
                                </div>
                            </dt>
                            <dd>
                                <!-- [D] 0915 : 변경 -->
                                <c:if test="${!empty detail.occupancyFileList}">
                                <div class="photo_slider">
                                    <ul class="slider-for">
                                        <!-- [D] 태그 누락 확인 : <li><div> <img> </div></li> -->
                                        <c:forEach items="${detail.occupancyFileList }" var="img_row">
                                            <li><div><img src="${img_row.path_name}${img_row.stored_file_name}" alt="${detail.pjt_nm}"></div></li>
                                        </c:forEach>
                                        
                                    </ul>
                                </div>
                                </c:if>
                                <!-- //[D] 0915 : 변경 -->
                                <div class="movein_detail">
                                    <p class="subtit">단지정보</p>
                                    <div class="info">
                                        <table>
                                            <colgroup>
                                                <col width="30%">
                                                <col width="70%">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <td>위치</td>
                                                    <td>${detail.sllt_info_loc}</td>
                                                </tr>
                                                <tr>
                                                    <td>전용면적</td>
                                                    <td>${detail.area}㎡</td>
                                                </tr>
                                                <tr>
                                                    <td>세대수</td>
                                                    <td>총 <fmt:formatNumber value="${detail.households }" pattern="#,###" />세대</td>
                                                </tr>
                                                <tr>
                                                    <td>규모</td>
                                                    <td>${detail.const_scope}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <c:if test="${(!empty detail.mv_pre_start_date&&!empty detail.mv_pre_end_date)||(!empty detail.mv_start_date&&!empty detail.mv_end_date)}">
                                <div class="movein_detail">
                                    <p class="subtit">입주 정보</p>
                                    <div class="info">
                                        <table>
                                            <colgroup>
                                                <col width="45%">
                                                <col width="55%">
                                            </colgroup>
                                            <tbody>
                                                <c:if test="${!empty detail.mv_pre_start_date&&!empty detail.mv_pre_end_date}">
                                                <tr>
                                                    <td>사전점검 신청 기간</td>
                                                    
                                                    <td>${fn:substring(detail.mv_pre_start_date,0,10)}~${fn:substring(detail.mv_pre_end_date,0,10)}</td>
                                                </tr>
                                                </c:if>
                                                <c:if test="${!empty detail.mv_start_date&&!empty detail.mv_end_date}">
                                                <tr>
                                                    <td>입주 예약 신청 기간</td>
                                                    <td>${fn:substring(detail.mv_start_date,0,10)}~${fn:substring(detail.mv_end_date,0,10)}</td>
                                                </tr>
                                                </c:if>
                                                <c:if test="${!empty detail.mv_cert_date}">
                                                <tr>
                                                    <td>입주 개시일</td>
                                                    <td>${fn:substring(detail.mv_cert_date,0,10)}</td>
                                                </tr>
                                                </c:if>
                                                <tr>
                                                    <td colspan="2">
                                                        <c:if test="${!empty detail.mv_pre_file_name}">
                                                            <!-- <button data-href="${detail.mv_pre_file_path}${detail.mv_pre_file_name}" target="_blank" class="box_style">사전점검 안내문 </button> -->
                                                            <a href="${detail.mv_pre_file_path}${detail.mv_pre_file_name}" data-href="${detail.mv_pre_file_path}${detail.mv_pre_file_name}" download="ELIF_사전점검_안내문" class="btn_file">사전점검 안내문 </a>
                                                        </c:if>
                                                        <c:if test="${!empty detail.mv_file_doc_name}">
                                                            <!-- <button data-href="${detail.mv_file_doc_path}${detail.mv_file_doc_name}" target="_blank" class="box_style">입주 안내문 </button> -->
                                                            <a href="${detail.mv_file_doc_path}${detail.mv_file_doc_name}" data-href="${detail.mv_file_doc_path}${detail.mv_file_doc_name}" download="ELIF_입주_안내문" class="btn_file">입주 안내문 </a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                </c:if>
                                <div class="btn_wrap">
                                <c:if test="${detail.reservationDiff_date==true}">
                                <a href="/mobile/mypage/visit-reservation-01?pjt_cd=${detail.pjt_cd}" class="btn_list c2">사전점검 방문 예약 신청</a>
                                </c:if>
                                <c:if test="${detail.diff_date==true}">
                                <a href="/mobile/mypage/movein-reservation-01?pjt_cd=${detail.pjt_cd}" class="btn_list c2">입주 예약 신청</a>
                                </c:if>
                                <a href="javascript:history.back();" class="btn_list c1">목록</a>
                                </div>
                            </dd>
                        </dl>
                    </section>
                    <!-- // 입주단지-view -->
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
    <script src="/resources/mobile/js/slick.min.js"></script>
    <script>
        elif.slide();
        // elif.snsShare();
    </script>
    <script>
        elif.snsShare();
        $('.box_style').click(function(){
            var win = window.open($(this).data('href'));
        })
    </script>
</body>

</html>