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
    <meta name="title" content="커뮤니티, 엘리프"/>
    <meta name="keywords" content="커뮤니티, 브랜드, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프 관련 최신 소식을 확인하실 수 있습니다. "/>
    <meta property="og:title" content="커뮤니티, 엘리프">
    <meta property="og:description" content="엘리프 관련 최신 소식을 확인하실 수 있습니다. ">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>커뮤니티 | 엘리프 | 모바일</title>
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
                <section class="visual brand">
                    <h2>브랜드</h2>
                </section>
                <!-- //Visual & Title -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="./story">브랜드 스토리</a></li>
                            <li><a href="./bi">BI</a></li>
                            <li><a href="./record">시공실적</a></li>
                            <li><a href="./community" class="on">커뮤니티</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <c:set var='cateCount' value='0' />
                    <c:forTokens items="${category.types}" delims="," var="item">
                    <c:if test="${fn:contains(gubuns, item)}">
                    <c:set var='cateCount' value='${cateCount+1}' />
                    </c:if>
                    </c:forTokens>
                    <section class="cont_section">
                        <c:if test="${cateCount>1}">
                        <div class="tab_linker_wrap commu">
                             <ul class="tab_linker">
                                <li>
                                    <a href="#">
                                        <input type="checkbox" id="all" name="cKeyidall" value="all"> <!-- 1005 : 체크 추가 -->
                                        <label for="all">전체</label>
                                    ​​​</a>
                                </li>

                                <c:forTokens items="${category.types}" delims="," var="item">
                                <c:if test="${fn:contains(gubuns, item)}">
                                <li>
                                    <a href="#">
                                        <input type="checkbox" id="${item}" name="cKeyid" value="${item}" data-tit="sub">
                                        <label for="${item}">${ct:getBoardType(item)}</label>
                                    ​</a>
                                </li> 
                                </c:if>
                                </c:forTokens>
                            </ul>
                        </div>
                        </c:if>
                        <!-- [D] 검색결과 없을 경우 -->
                        <!-- // [D] 검색결과 없을 경우 -->

                        <!-- [D] 검색결과가 있을 경우 -->
                        <div class="community_list">
                            <ul>
                            </ul>
                             <div class="btn_more no_pt">
                                <button type="button" class="btn_m1 btn-community_list-more">더 보기</button>
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
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
        // elif.communityCheckbox();
        // elif.brandSubText();
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
    $(document).on('click','.btn-community_list-more',function(){
        content['currentPageNo'] = content['currentPageNo'] + 1;
        loadAjax('');
    });
    
    //검색 관련
    var prevKey = '';
    $(document).on('change','[name=cKeyid],[name=cKeyidall]',function(){
        if($(this).val()==prevKey){
            $(this).prop('checked',true);
            return;
        }
        console.log($(this).val());
        if($(this).val()=='all'){
            if($(this).is(':checked')){
                $('[name=cKeyid],[name=cKeyidall]').prop('checked',true);
            }else{
                $('[name=cKeyid],[name=cKeyidall]').prop('checked',false);
            }
            $('.tab_txt').hide();
        }else{
            $('[name=cKeyid],[name=cKeyidall]').prop('checked',false);
            $(this).prop('checked',true);
            elif.brandSubTextFunc($(this));
        }
        prevKey = $(this).val();
        content['typesArray'] = $('[name=cKeyid]:checked').map(function() { return this.value; }).get().join();
        content['currentPageNo'] = 1;
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
            console.log(content['typesArray']);
        }else if(ins=='filter_reset'){
            delete content.typesArray;
        }else if(ins=='reset'){
            content['currentPageNo']=1;
            delete content.target;
            delete content.keyword;
            delete content.typesArray;
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
            url: "community_list",
            cache: false,
            data: content,
            dataType: 'html',
            async: false,
            success: function (data, status) {
                if (status == 'success') {
                    console.log(type);
                    if(type=='init'){
                        $('.community_list ul').html(data);
                    }else{
                        $('.community_list ul').append(data);
                    }
                    
                    if($('.community_list ul li').last().data('page-current')>=$('.community_list ul li').last().data('page-last')){
                        $('.btn-community_list-more').hide();
                    }else{
                        $('.btn-community_list-more').show();
                    }
                    if($('.community_list ul li').last().data('page-current')==0){
                        $('.no_data_wrap_sns').hide();
                        $('.community_list ul').html('').hide();
                        $('.community_list').append(data.replace("<li", "<div").replace("</li>", "</div>"));
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