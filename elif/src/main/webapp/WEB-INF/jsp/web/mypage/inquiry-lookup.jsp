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
                            <li>
                                <a href="../mypage/inquiry-apply">고객문의​​​</a>
                            </li>
                            <li class="on">
                                <a href="../mypage/inquiry-lookup">문의내역​​​</a>
                            </li> 
                        </ul>
                    </div><!-- //tab_linker_wrap -->
                    <div class=tab_content_wrap>
                        <div class="tab_content">
                            <section class="cont_section">
                                <div class="info_table board">
                                    <table class="table normal_table">
                                        <!-- [D] 0830 : '분류' 열 제거 -->
                                        <caption>문의 내역을 확인할 수 있습니다.</caption>
                                        <colgroup>
                                            <col style="width:800px"> <!-- 분류 열 146px 더해짐 -->
                                            <col style="width:120px">
                                            <col style="width:160px">
                                            <col style="width:120px">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">제목</th> 
                                                <th scope="col">처리현황</th> 
                                                <th scope="col">등록일</th> 
                                                <th scope="col"><span class="blind">삭제버튼</span></th> 
                                            </tr>
                                        </thead>
                                        <tbody>
										 <c:choose>
										    <c:when test="${fn:length(list) > 0}">
												<c:set var="num" value="${fn:length(list)}"/>
										        <c:forEach items="${list }" var="row">
                                                <tr>
                                                    <td>
                                                        <a href="javascript:;" data-idx="${row.idx }">${row.title }</a>
                                                    </td>
                                                    <td class="tc"><span class="badge ${row.reply_status=='RV02301'?'':'gray' }">${row.reply_status=='RV02301'?'접수완료':'답변완료' }</span></td>
                                                    <td class="tc date">
														<fmt:formatDate var="crea_dtm" pattern="yyyy년 MM월 dd일" value="${row.crea_dtm }"/>
														${crea_dtm }
                                                    </td>
                                                    <td class="tc"><button type="button" data-idx="${row.idx}" class="btn del_btn btn-flag-status">삭제</button></td>
                                                </tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
                                            <tr>
                                                <td colspan="4">
                                                    <p class="no_data">문의하신 내역이 없습니다.</p>
                                                </td>
                                            </tr>
										    </c:otherwise>
										</c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="pagenation">
                                    <c:if test="${not empty paginationInfo}">
                                        <ui:pagination paginationInfo="${paginationInfo}" type="front" jsFunction="fn_search" />
                                    </c:if>
                                </div>
                            </section>
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
	(function($){
	    $("a[data-idx]").on("click", function(e){ //제목 
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

	function fn_openBoardDetail(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("inquiry-lookup-view");
	    comSubmit.addParam("idx", obj.data("idx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
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
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>