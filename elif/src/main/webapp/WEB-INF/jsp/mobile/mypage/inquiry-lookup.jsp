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
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    
    <title>문의 내역 | 엘리프 | 모바일</title>
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
                            <li><a href="/mobile/mypage/inquiry-apply" class="on">고객 문의</a></li>
                            <li><a href="/mobile/mypage/notice">공지사항</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <div class="tab_linker_wrap">
                        <ul class="tab_linker">
                            <li>
                                <a href="/mobile/mypage/inquiry-apply">고객문의</a>
                            </li>
                            <li class="on">
                                <a href="/mobile/mypage/inquiry-lookup">문의내역</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tab_content_wrap">
                        <div class="tab_content">
                            <section class="cont_section">
                                <div class="table_wrap fixed">
                                    <table class="normal_table inquiry-lookup_wrap">
                                        <caption>문의 내역을 확인할 수 있습니다.</caption>
                                        <colgroup>
                                            <col style="width:calc(100% - 142px)">
                                            <col style="width:142px">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">제목</th>
                                                <th scope="col" class="tl">처리현황</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn_area">
                                    <button type="button" class="btn border btn-inquiry-lookup_wrap-more">더 보기</button>
                                </div>

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
        elif.saleSearch();
    </script>
    <script>
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
	(function($){
	    $(document).on("click",'a[data-idx]', function(e){ //제목 
	        e.preventDefault();
	        fn_openBoardDetail($(this));
	    });
	    $("#btnSearch").click(function(){
	    	$("form[name=search]").submit();
	    });
		$(document).on('click','.btn-flag-status',function(){
			if(confirm('삭제 하시겠습니까?')){
				var thisEle = $(this);
				var jsonData = {'idx':thisEle.data('idx')}
				$.ajax({
					type: 'POST',
					url: 'inquiry-lookup-delete',
					data: jsonData,
					dataType: 'json',
					async: true,
					cache: false,
					success: function (data) {
                        console.log(data);
						if(data.result==true){
							alert('삭제되었습니다.');
                            window.location.reload();
						}else{
                            alert('삭제 오류 입니다. 관리자에게 문의하시기 바랍니다.');
                        }
					},
					error: function (xhr, status, error) {
						alert('관리자에게 문의하시기 바랍니다.');
					}
				});
			}
		});
	})(jQuery);
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
            url: "inquiry-lookup_list",
            cache: false,
            data: content,
            dataType: 'html',
            async: false,
            success: function (data, status) {
                if (status == 'success') {
                    if(type=='init'){
                        $('.inquiry-lookup_wrap tbody').html(data);
                    }else{
                        $('.inquiry-lookup_wrap tbody').append(data);
                    }
                    
                    if($('.inquiry-lookup_wrap tbody tr').last().data('page-current')>=$('.inquiry-lookup_wrap tbody tr').last().data('page-last')){
                        $('.btn-inquiry-lookup_wrap-more').hide();
                    }else{
                        $('.btn-inquiry-lookup_wrap-more').show();
                    }
                
                }
            },
            error: function (data, status) {
                
            }
        });
    }

	function fn_openBoardDetail(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("inquiry-lookup-view");
	    comSubmit.addParam("idx", obj.data("idx"));
	    comSubmit.addParam("currentPageNo", obj.closest('tr').data('page-current'));
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
	    comSubmit.submit();
	}

	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("inquiry-lookup");
	    comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
		
	    comSubmit.submit();
	}
    </script>
</body>

</html>