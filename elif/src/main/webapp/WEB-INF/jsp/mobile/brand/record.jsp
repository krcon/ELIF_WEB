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
    <meta name="title" content="시공실적, 엘리프"/>
    <meta name="keywords" content="시공실적, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 시공 실적을 안내해드립니다."/>
    <meta property="og:title" content="시공실적, 엘리프">
    <meta property="og:description" content="엘리프의 시공 실적을 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>시공실적 | 엘리프 | 모바일</title>
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
                <section class="visual sale brand">
                    <h2>브랜드</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./story">브랜드 스토리</a></li>
                            <li><a href="./bi">BI</a></li>
                            <li><a href="./record" class="on">시공실적</a></li>
                            <li><a href="./community">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="sale_list">
                        <div>
                            <ul>
                            </ul>
                            <div class="btn_more">
                                <button type="button" class="btn_m1 btn-sale_list-more">더 보기</button>
                            </div>
                        </div>
                    </section>
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
            url: "record_list",
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
                        $('.no_data_wrap').addClass('hide');
                    }
                    if($('.sale_list ul li').last().data('page-current')==0){
                        $('.no_data_wrap').removeClass('hide');
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