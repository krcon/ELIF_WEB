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
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>공지사항 | 엘리프</title>
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
                        <li><span>공지사항</span></li>
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
                            <li><a href="../mypage/inquiry-apply">고객 문의</a></li>
                            <li><a href="../mypage/notice" class="on">공지사항</a></li>
                            <li><a href="../mypage/elifNews">엘리프 뉴스</a></li>
                            <li><a href="../mypage/FAQ-view">FAQ</a></li>
                            <li><a href="https://cs.kyeryong.net/jsp/as/defc/co/defc_co_confirm.jsp" target="_blank">A/S 신청</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <section class="cont_section">
                        <form name="frmSearch" action="notice" class="form-inline text-right navbar-form">
                        <div class="board_search_wrap">
                            <label for="sch" class="a11y_hide">검색 방식 선택</label> 
                            <select class="border-select sm" id="sch" name="target">
                                <option value="all" ${"KO"==param.target?'selected="selected"':'' }>전체</option>
                                <option value="title" ${"title"==param.target?'selected="selected"':'' }>제목</option>
                                <option value="contents" ${"contents"==param.target?'selected="selected"':'' }>내용</option>
                            </select>
                            <label for="txt" class="a11y_hide">검색어를 입력하세요</label>
                            <input type="text" name="keyword" value="${param.keyword }" class="search_input border_input" title="검색어를 입력하세요" id="txt">
                        </div>
                        </form>
                        <div class="info_table board">
                            <table class="table normal_table">
                                <caption>공지사항을 확인할 수 있는 테이블입니다.</caption>
                                <colgroup>
                                    <col style="width:104px">
                                    <col style="width:946px">
                                    <col style="width:150px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">번호</th>
                                        <th scope="col">제목</th> 
                                        <th scope="col">날짜</th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- <tr class="notice">
                                        <td class="no_pds tc">공지</td>
                                        <td><a href="#" class="title">홈페이지 가입은 어디에서 하면 되나요?</a>​</td>
                                        <td class="tc"><span class="list-date">2021년 7월 3일</span></td>
                                    </tr> --%>
                                <c:choose>
                                <c:when test="${fn:length(list) > 0}">
                                    <c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
                                    <c:forEach items="${list }" var="row">
                                    <tr class="${row.mainstatus=='Y'?'notice':''}">
                                        <td class="no_pds tc">
                                            ${row.mainstatus=='Y'?'공지':num}
                                            <c:set var="num" value="${num-1}"/>
                                        </td>
                                        <td><a href="javascript:void(0);" onclick="fn_openBoardView(${row.idx})" class="title">${row.title}</a>​</td>
                                        <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${row.start_dtm }"/>
                                        <td class="tc"><span class="list-date">${start_dtm}</span></td>
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="3">
                                            <p class="no_data">등록된 공지사항이 없습니다.</p>
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
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
    $(function() {

        $('[name=frmSearch]').submit(function() {
            if ($(this).find('#txt').val() == "") {
                location.href = "notice";
                return false;
            }
        })
    });
	function fn_openBoardView(idx){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("notice-view");
	    comSubmit.addParam("idx", idx);
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
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
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>