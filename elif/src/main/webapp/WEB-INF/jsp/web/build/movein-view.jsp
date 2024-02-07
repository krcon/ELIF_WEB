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
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <link href="/resources/web/css/slick.css" rel="stylesheet">
    <title>공사/입주 | 엘리프</title>
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
                <section class="visual build">
                    <h2>공사/입주 정보</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><a href="/build/construction"><span>공사/입주 정보</span></a></li>
                        <li><span>입주 단지</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./construction">공사 단지</a></li>
                            <li><a href="./movein" class="on">입주 단지</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->

                    <!-- 입주 상세정보 -->
                    <section class="build detail">
                        <div class="detail_wrap">
                            <dl>
                                <dt>
                                    <div class="tit_wrap">
                                        <div class="tit_sub_wrap">
                                            <div class="flag"><span class="fs-16 c2">${detail.housing_name}</span></div>
                                            <div class="tit">${detail.pjt_nm}</div>
                                            <c:choose>
                                            <c:when test="${detail.progress=='RV02206'}">
                                            <c:set var="ctype" value="type1"/>
                                            </c:when>
                                            <c:when test="${detail.progress=='RV02207'}">
                                            <c:set var="ctype" value="type2"/>
                                            </c:when>
                                            <c:when test="${detail.progress=='RV02208'}">
                                            <c:set var="ctype" value="type3"/>
                                            </c:when>
                                            </c:choose>
                                            <div class="tag ${ctype}">${detail.progress_name}</div>
                                        </div>
                                        <div class="tel"><span class="c3">${detail.sllt_info_addr_tel}</span></div>
                                    </div>
                                    <div class="sns_wrap">
                                        <button class="sns_btn"><span class="a11y_hide">sns공유</span></button>
                                        <div class="sns_on hide">
                                            <div class="snsHead">
                                                <p>공유하기</p>
                                                <button class="sns_close"><img src="/resources/web/images/ico-close.png" alt="닫기" class="last"></button>
                                            </div>
                                            <div class="snsCont">
                                                <a href="javascript:shareKakao();"><img src="/resources/mobile/images/ico_shareKakao.png" alt="카카오톡 공유하기"><p>카카오톡</p></a>
                                                <a href="javascript:shareStory();"><img src="/resources/mobile/images/ico_shareStory.png" alt="카카오스토리 공유하기"><p class="over">카카오스토리</p></a>
                                                <a href="javascript:shareLine();"><img src="/resources/mobile/images/ico_shareLine.png" alt="네이버 라인 공유하기"><p>라인</p></a>
                                                <a href="#" onclick="javascript:window.open('https://band.us/plugin/share?url='+encodeURIComponent(document.URL)+'&title='+encodeURIComponent(document.title),'naversharedialog', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;"><img src="/resources/mobile/images/ico_shareBand.png" alt="네이버 밴드 공유하기"><p>밴드</p></a>
                                                <!-- <a href="javascript:shareBand();"><img src="/resources/mobile/images/ico_shareBand.png" alt="네이버 밴드 공유하기"><p>밴드</p></a> -->
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
                                        </div>
                                    </div>
                                </dt>
                                <dd>
                                    <div class="image_area">
                                        <c:if test="${!empty detail.occupancyFileList}">
                                            <c:forEach items="${detail.occupancyFileList }" var="img_row">
                                                <div><img src="${img_row.path_name}${img_row.stored_file_name}" alt="${detail.pjt_nm}"></div>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <div class="movein_detail">
                                        <table>
                                            <colgroup>
                                                <col width="20%">
                                                <col width="50%">
                                                <col width="30%">
                                            </colgroup>
                                            <tr class="row">
                                                <td class="tit">단지 정보</td>
                                                <td>
                                                    <table class="sub_table">
                                                        <tr>
                                                            <td>위치</td>
                                                            <td>${detail.sllt_info_loc}</td>
                                                        </tr>
                                                        <tr>
                                                            <td>전용면적</td>
                                                            <td>${detail.area}㎡</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table class="sub_table">
                                                        <tr>
                                                            <td>세대수</td>
                                                            <td>총 <fmt:formatNumber value="${detail.households }" pattern="#,###" />세대</td>
                                                        </tr>
                                                        <tr>
                                                            <td>규모</td>
                                                            <td>${detail.const_scope}</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                <c:if test="${(!empty detail.mv_pre_start_date&&!empty detail.mv_pre_end_date)||(!empty detail.mv_start_date&&!empty detail.mv_end_date)}">
                                            <tr class="row">
                                                <td class="tit">입주정보</td>
                                                <td>
                                                    <table class="sub_table">
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
                                                    </table>
                                                </td>
                                                <td>
                                                    <c:if test="${!empty detail.mv_pre_file_name}">
                                                        <!-- <button data-href="${detail.mv_pre_file_path}${detail.mv_pre_file_name}" target="_blank" class="box_style">사전점검 안내문 </button> -->
                                                        <a href="${detail.mv_pre_file_path}${detail.mv_pre_file_name}" download="ELIF_사전점검_안내문" target="_blank" class="box_style btn_file">사전점검 안내문 </a>
                                                    </c:if>
                                                    <c:if test="${!empty detail.mv_file_doc_name}">
                                                        <!-- <button data-href="${detail.mv_file_doc_path}${detail.mv_file_doc_name}" target="_blank" class="box_style">입주 안내문 </button> -->
                                                        <a href="${detail.mv_file_doc_path}${detail.mv_file_doc_name}" download="ELIF_입주_예약문" target="_blank" class="box_style btn_file">입주 안내문 </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            </c:if>
                                        </table>
                                    </div>
                                </dd>
                            </dl>
                            <div class="btn_wrap">
                            <c:if test="${detail.reservationDiff_date==true}">
                            <a href="/mypage/visit-reservation-01?pjt_cd=${detail.pjt_cd}" class="btn_common_style c2">사전점검 방문 예약 신청</a>
                            </c:if>
                            <c:if test="${detail.diff_date==true}">
                            <a href="/mypage/movein-reservation-01?pjt_cd=${detail.pjt_cd}" class="btn_common_style c2">입주 예약 신청</a>
                            </c:if>
                            <a href="javascript:history.back();" class="btn_common_style c1">목록</a>
                            </div>
                        </div>
                    </section>
                    <!-- //입주 상세정보 -->
                </div>
            </div>

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- //wrap -->
    <%@ include file="../include/javascript.jsp" %>
    <script src="/resources/mobile/js/slick.min.js"></script>
    <script>
        elif.slide();
        elif.snsShare();
        $('.box_style').click(function(){
            //var win = window.open($(this).data('href'));
        })
    </script>
</body>

</html>