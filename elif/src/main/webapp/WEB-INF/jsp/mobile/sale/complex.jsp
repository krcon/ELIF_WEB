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
    <meta name="title" content="분양단지,엘리프"/> 
    <meta name="keywords" content="분양단지, 아파트, 상가, 분양중, 분양 예정, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/> 
    <meta name="description" content="엘리프의 분양 단지를 안내해드립니다."/>
    <meta property="og:title" content="엘리프">
    <meta property="og:description" content="엘리프 분양, 공사/입주, 브랜드, MY ELIF">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>분양단지 | 엘리프 | 모바일</title>
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
                <section class="visual sale">
                    <h2>분양 정보</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="/mobile/sale/complex" class="on">분양단지</a></li>
                            <li><a href="/mobile/sale/calendar">분양캘린더</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->

                    <!-- 검색 -->
                    <section class="search_wrap">
                        <div class="filter_wrap">
                            <div class="filter">
                                <button type="button" id="btnFilter" class="btn_filter">지역별/유형별/진행 상태별 필터검색</button>
                            </div>
                            <div class="filter_box">
                                <div class="box_in">
                                    <dl>
                                        <dt>지역별</dt>
                                        <dd>
                                            <ul>
                                                <li>
                                                    <input type="checkbox" name="aKeyidall" id="aKeyidall" class="skipNav" >
                                                    <label for="aKeyidall">전체</label>
                                                </li>
                                                <c:choose>
                                                    <c:when test="${fn:length(codeRegion) > 0}">
                                                        <c:forEach items="${codeRegion }" var="row">
                                                        <li>
                                                            <input type="checkbox" name="aKeyid" id="${row.code_id}" value="${row.code_id}" class="skipNav">
                                                            <label for="${row.code_id}">${row.code_name}</label>
                                                        </li>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>유형별</dt>
                                        <dd>
                                            <ul>
                                                <li>
                                                    <input type="checkbox" name="cKeyidall" id="cKeyidall" class="skipNav" >
                                                    <label for="cKeyidall">전체</label>
                                                </li>
                                                <c:choose>
                                                    <c:when test="${fn:length(codeType) > 0}">
                                                        <c:forEach items="${codeType }" var="row">
                                                        <li>
                                                            <input type="checkbox" name="cKeyid" id="${row.code_id}" value="${row.code_id}" class="skipNav">
                                                            <label for="${row.code_id}">${row.code_name}</label>
                                                        </li>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>진행 상태별</dt>
                                        <dd>
                                            <ul>
                                                <li>
                                                    <input type="checkbox" name="sKeyidall" id="sKeyidall" class="skipNav" >
                                                    <label for="sKeyidall">전체</label>
                                                </li>
                                                <c:choose>
                                                    <c:when test="${fn:length(codeProgress) > 0}">
                                                        <c:forEach items="${codeProgress }" var="row">
                                                        <li>
                                                            <input type="checkbox" name="sKeyid" id="${row.code_id}" value="${row.code_id}" class="skipNav">
                                                            <label for="${row.code_id}">${row.code_name}</label>
                                                        </li>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </ul>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="button_wrap">
                                    <button type="button" class="btn_filter_search">해당 조건으로 검색</button>
                                    <button type="button" class="btn_reset">검색조건 초기화</button>
                                </div>
                            </div>
                        </div>
                        <div class="search_top">
                            <div class="find">
                                <label for="sch" class="a11y_hide">단지명 또는 지역명으로 검색</label>
                                <input type="search" name="keyword" placeholder="단지명 또는 지역명으로 검색" id="sch" value="${empty keyword?'':keyword}"> <button type="button" id="btn-search">검색</button>
                            </div>
                        </div>
                    </section>
                    <!-- //검색-->
                    <!-- 분양 리스트 -->
                    <section class="sale_list">
                        <ul>
                        </ul>
                        <button type="button" class="btn_m1 btn-sale_list-more">더 보기</button>
                    </section>
                    <!-- //분양 리스트-->
                </div>
            </div>

        </main>
        <!-- //container -->
        <!-- [blockUi] 로딩시 class에 on -->
        <div id="blockUi"></div>
        <!-- //[blockUi] -->
        <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- //wrap -->
    <%@ include file="../include/javascript.jsp" %>
    <script>
        elif.saleSearch();
    </script>
    <script>
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    
    var content = {};
    content['currentPageNo'] = 1;
    loadAjax('init');
    $(document).on('click','.btn-sale_list-more',function(){
        content['currentPageNo'] = content['currentPageNo'] + 1;
        loadAjax('');
    });
    
    //검색 관련
    $(document).on('change','[name=aKeyid],[name=aKeyidall]',function(){
        content['region'] = $('[name=aKeyid]:checked').map(function() { return this.value; }).get().join();
        search('filter');
    });
    $(document).on('change','[name=cKeyid],[name=cKeyidall]',function(){
        content['housing'] = $('[name=cKeyid]:checked').map(function() { return this.value; }).get().join();
        search('filter');
    });
    $(document).on('change','[name=sKeyid],[name=sKeyidall]',function(){
        content['progress'] = $('[name=sKeyid]:checked').map(function() { return this.value; }).get().join();
        search('filter');
    });
    $(document).on('click','.btn_reset',function(){
        search('filter_reset');
    });
    
    $(document).on('click','#btn-search',function(){
        search('');
    });
    <c:if test="${!empty keyword}">
    search('');
    </c:if>
    function search(ins){
        if(ins=='filter'){
            console.log(content['region']);
            console.log(content['housing']);
            console.log(content['progress']);
        }else if(ins=='filter_reset'){
            delete content.region;
            delete content.housing;
            delete content.progress;
        }else if(ins=='reset'){
            content['currentPageNo']=1;
            delete content.target;
            delete content.keyword;
            delete content.region;
            delete content.housing;
            delete content.progress;
            $('.filter_box [type="checkbox"]').prop('checked',false);
            $('[name=keyword]').val('');
        }else{
            content['target'] = 'all';
            content['keyword'] = $('[name=keyword]').val();
            
        }
        loadAjax('init');
    }
    function loadAjax(type) {
        console.log(content);
        $.ajax({
            type: "POST",
            url: "complex_list",
            cache: false,
            data: content,
            dataType: 'html',
            async: false,
            success: function (data, status) {
                if (status == 'success') {
                    console.log(type);
                    if(type=='init'){
                        $('.sale_list ul').html(data);
                    }else{
                        $('.sale_list ul').append(data);
                    }
                    
                    if($('.sale_list ul li').last().data('page-current')>=$('.sale_list ul li').last().data('page-last')){
                        $('.btn-sale_list-more').hide();
                    }else{
                        $('.btn-sale_list-more').show();
                    }
                
                }
            },
            error: function (data, status) {
                
            }
        });
    }
    </script>
</body>

</html>