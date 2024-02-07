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
    <meta name="title" content="공지사항, 엘리프"/>
    <meta name="keywords" content="엘리프, 공지사항, MY ELIF, 엘리프"/>
    <meta name="description" content="엘리프 관련 공지사항을 안내해드립니다. "/>
    <meta property="og:title" content="공지사항, 엘리프">
    <meta property="og:description" content="엘리프 관련 공지사항을 안내해드립니다. ">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    
    <title>공지 사항 | 엘리프 | 모바일</title>
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
                            <li><a href="/mobile/mypage/payment-guide">분양대금 조회</a></li>
                            <!-- <li><a href="/mobile/mypage/visit-reservation-01">사전점검 방문 예약</a></li> -->
                            <!-- <li><a href="/mobile/mypage/movein-reservation-01">입주 예약</a></li> -->
                            <li><a href="/mobile/mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="/mobile/mypage/notice" class="on">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <form name="frmSearch" action="notice" class="form-inline text-right navbar-form">
                        <div class="board_search_wrap">
                            <label for="sch" class="a11y_hide">검색 선택</label>
                            <select class="border_select sm" name="target" id="sch">
                                <option value="all" ${"KO"==param.target?'selected="selected"':'' }>전체</option>
                                <option value="title" ${"title"==param.target?'selected="selected"':'' }>제목</option>
                                <option value="contents" ${"contents"==param.target?'selected="selected"':'' }>내용</option>
                            </select>
                            <div class="board_search_input_wrap">
                                <label for="txt" class="a11y_hide">검색어를 입력하세요</label>
                                <input type="text" name="keyword" value="${param.keyword }" class="search_input border_input" title="검색어를 입력하세요" placeholder="검색어를 입력하세요" id="txt" >
                                <button type="button" class="search_btn"><span class="blind">검색하기</span></button>
                            </div>
                            
                        </div>
                        </form>
                        <div class="table_wrap notice_wrap">
                            <table>
                                <caption>공지사항을 확인할 수 있는 테이블입니다.</caption>
                                <colgroup>
                                    <col style="width:20%">
                                    <col style="width:80%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">번호</th>
                                        <th scope="col">제목</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                        <div class="btn_area">
                            <button type="button" class="btn border btn-notice_wrap-more">더보기</button>
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
        // elif.saleSearch();
    </script>
    <script>
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    $(function() {

        $('[name=frmSearch]').submit(function() {
            content['target'] = $('[name=target]').val();
            content['keyword'] = $('[name=keyword]').val();
            content['currentPageNo'] = 1;
            loadAjax('init');
            return false;
        })
    });

    var content = {};
    content['currentPageNo'] = 1;
    loadAjax('init');
    $(document).on('click','.btn-community_list-more',function(){
        content['currentPageNo'] = content['currentPageNo'] + 1;
        loadAjax('');
    });
    
    function loadAjax(type) {
        console.log(content);
        $.ajax({
            type: "POST",
            url: "notice_list",
            cache: false,
            data: content,
            dataType: 'html',
            async: false,
            success: function (data, status) {
                if (status == 'success') {
                    if(type=='init'){
                        $('.notice_wrap tbody').html(data);
                    }else{
                        $('.notice_wrap tbody').append(data);
                    }
                    
                    if($('.notice_wrap tbody tr').last().data('page-current')>=$('.notice_wrap tbody tr').last().data('page-last')){
                        $('.btn-notice_wrap-more').hide();
                    }else{
                        $('.btn-notice_wrap-more').show();
                    }
                
                }
            },
            error: function (data, status) {
                
            }
        });
    }


	function fn_openBoardView(idx,currentPageNo){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("notice-view");
	    comSubmit.addParam("idx", idx);
	    comSubmit.addParam("currentPageNo", currentPageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
	    comSubmit.submit();
	}
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("notice");
	    comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
	    comSubmit.submit();
	}
    </script>
</body>

</html>