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
    <meta name="title" content="공사단지, 엘리프"/>
    <meta name="keywords" content="공사단지, 아파트, 상가, 공사중, 공사 예정, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 공사단지를 안내해드립니다."/>
    <meta property="og:type" content="website" /> 
    <meta property="og:title" content="공사단지, 엘리프">
    <meta property="og:description" content="엘리프의 공사단지를 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <link href="/resources/web/css/slick.css" rel="stylesheet">
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
                            <li><a href="/mobile/build/construction" class="on">공사 단지</a></li>
                            <li><a href="/mobile/build/movein">입주 단지</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <!-- 공사단지-view -->
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
                                                <td>면적</td>
                                                <td>
                                                    <ul>
                                                        <li>전용 ${detail.area}㎡</li>
                                                        <li>대지면적 ${detail.const_g_area}㎡</li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>세대 수</td>
                                                <td>총 <fmt:formatNumber value="${detail.households }" pattern="#,###" />세대</td>
                                            </tr>
                                            <tr>
                                                <td>규모</td>
                                                <td>${detail.const_scope}</td>
                                            </tr>
                                            <tr>
                                                <td>입주일정</td>
                                                <td>${detail.const_year}년 ${detail.const_month}월 예정</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="progress_wrap">
                                    <c:if test="${fn:length(constChild) > 0}">
                                    <c:choose>
                                    <c:when test="${detail.progress=='RV02204'}">
                                    <c:set var="ctype" value="c1"/>
                                    </c:when>
                                    <c:when test="${detail.progress=='RV02205'}">
                                    <c:set var="ctype" value="c2"/>
                                    </c:when>
                                    </c:choose>
                                    <p class="subtit">공정률<span class="flag ${ctype}">${detail.progress_name}</span></p>
                                    <div class="progress_bar">
                                        <div class="progress" style="width: ${constChild[0].const_proc_rate}%"><b><span>${constChild[0].const_proc_rate}%</span></b></div>
                                        
                                    </div>
                                    </c:if>
                                </div>
                                <c:set var="imgset" value="false"/>
                                <c:if test="${fn:length(constChild) > 0}">
                                <c:forEach items="${constChild }" var="row" varStatus="status">
                                <c:if test="${row.contConstFileCount > 0}">
                                <c:set var="imgset" value="true"/>
                                </c:if>
                                </c:forEach>
                                </c:if>
                                <c:choose>
                                <c:when test="${fn:length(constChild) > 0 && imgset==true}">
                                <div class="search_wrap no_pt">
                                    <span class="subtit">공사 현장</span>
                                    <div class="search">
                                        <label for="sch"><span class="a11y_hide">선택</span></label>
                                        <select name="month" id="sch">
                                            <c:forEach items="${constChild }" var="row">
                                                <option value="${row.const_proc_dt}" data-rate="${row.const_proc_rate}" data-file_count="${row.fileCount}">${row.regist_year}년 ${row.regist_month}월</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                </c:when>
                                </c:choose>
                                <div id="const_slide">
                                </div>
                                <div class="btn_wrap">
                                    <a class="btn_list" href="./construction">목록</a>
                                </div>
                            </dd>
                        </dl>
                    </section>
                    <!-- //공사단지-view -->
                </div>
            </div>

        </main>
        <!-- //container -->
        <!-- [blockUi] 로딩시 class에 on -->
        <div id="blockUi"></div>
        <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
    <script>
        elif.slide();
        // elif.snsShare();
    </script>
    <script>
    $(document).on('change','[name=month]',function(){
        $('.photo_slider').addClass('hide');
        $('.progress').css('width',$('[name=month] option:selected').data('rate')+'%').find('span').html($('[name=month] option:selected').data('rate')+'%');
        loadSlide($('[name=month]').val());
    });
    loadSlide($('[name=month]').val());
    
    function loadSlide(monthly){
        var content = {};
        content['pjt_cd'] = '${param.pjt_cd}';
        content['const_proc_dt'] = monthly;
        content['rand'] = Math.random().toString(36).substr(2,11);
        $.ajax({
            type: "GET",
            url: "construction_side",
            cache: false,
            data: content,
            dataType: 'html',
            async: false,
            success: function (data, status) {
                $('#const_slide').html(data);
                elif.slide();
            },
            error: function (data, status) {
                
            }
        });
    }
    elif.snsShare();
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>