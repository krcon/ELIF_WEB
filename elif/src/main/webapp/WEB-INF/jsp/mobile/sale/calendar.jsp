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
    <meta name="title" content="분양캘린더, 엘리프"/>
    <meta name="keywords" content="분양캘린더, 아파트, 상가, 분양중, 분양 예정, 엘리프, 계룡건설 엘리프, ELIF, 분양, 공사, 입주, 프리미엄 주거 공간"/>
    <meta name="description" content="엘리프의 분양단지를 안내해드립니다."/>
    <meta property="og:title" content="분양캘린더, 엘리프">
    <meta property="og:description" content="엘리프의 분양단지를 안내해드립니다.">
    <meta property="og:image" content="/resources/mobile/images/common/og_elif.png" />
    <title>분양캘린더 | 엘리프 | 모바일</title>
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
                            <li><a href="/mobile/sale/complex">분양단지</a></li>
                            <li><a href="/mobile/sale/calendar" class="on">분양캘린더</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->
                    <!-- calendar -->
                    <section class="calendar">
                        <!-- [D] 0914 : 전체 컨텐츠 없을 경우 -->
                        <!-- [D] 0914 : //전체 컨텐츠 없을 경우 -->

                    <c:set var="complexBool" value="0"/>
                    <c:if test="${fn:length(monthList) > 0}">
                    <c:forEach items="${monthList }" var="monthList">
                        <c:if test="${!empty monthList.value}">
                        <c:set var="complexBool" value="1"/>
                        </c:if>
                    </c:forEach>
                    </c:if>
                    <c:choose>
                    <c:when test="${complexBool == '1'}">
                        <div class="calendar_wrap">

                            <!-- 수정 -->
                            <div class="title">
                            <c:choose>
                                <c:when test="${prevYear==true}">
                                <a href="?year=${nowYear-1}" class="arr_btn pre"><span class="a11y_hide">이전</span></a>
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="arr_btn pre disabled"><span class="a11y_hide">이전</span></a>
                                </c:otherwise>
                            </c:choose>
                            <p class="month_tit">${nowYear}</p>
                            <c:choose>
                                <c:when test="${nextYear==true}">
                                <a href="?year=${nowYear+1}" class="arr_btn next"><span class="a11y_hide">다음</span></a>
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="arr_btn next disabled"><span class="a11y_hide">다음</span></a>
                                </c:otherwise>
                            </c:choose>
                            </div>
                            <!-- //수정 -->
                            <div class="calendar_table">
                                <table>
                                <colgroup>
                                    <col width="25%">
                                    <col width="55%">
                                    <col width="20%">
                                </colgroup>
                                <tbody>
                                <c:set var="rowCount" value="0"/>
                                <c:forEach items="${monthList }" var="month">
                                    <c:set var="monthCount" value="1"/>
                                    <c:choose>
                                    
                                        <c:when test="${!empty month.value}">
                                            <c:forEach items="${month.value }" var="row">
                                            <c:choose>
                                            <c:when test="${row.progress=='RV02201'}">
                                            <c:set var="ctype" value="c1"/>
                                            </c:when>
                                            <c:when test="${row.progress=='RV02202'}">
                                            <c:set var="ctype" value="c2"/>
                                            </c:when>
                                            <c:when test="${row.progress=='RV02203'||row.progress=='RV02204'||row.progress=='RV02205'}">
                                            <c:set var="ctype" value="c3"/>
                                            </c:when>
                                            </c:choose>

                                            <c:if test="${fn:length(month.value)==1}">
                                            <c:set var="rowCount" value="0"/>
                                            </c:if>
                                            <tr>
                                                <c:if test="${rowCount==0}">
                                                <td class="month " rowspan="${fn:length(month.value)}">
                                                    <p><fmt:formatNumber type = "number" minIntegerDigits="2" value="${month.key}" /></p>
                                                    <c:choose>
                                                    <c:when test="${month.key==1}"><small>January</small></c:when>
                                                    <c:when test="${month.key==2}"><small>February</small></c:when>
                                                    <c:when test="${month.key==3}"><small>March</small></c:when>
                                                    <c:when test="${month.key==4}"><small>April</small></c:when>
                                                    <c:when test="${month.key==5}"><small>May</small></c:when>
                                                    <c:when test="${month.key==6}"><small>June</small></c:when>
                                                    <c:when test="${month.key==7}"><small>July</small></c:when>
                                                    <c:when test="${month.key==8}"><small>August</small></c:when>
                                                    <c:when test="${month.key==9}"><small>September</small></c:when>
                                                    <c:when test="${month.key==10}"><small>October</small></c:when>
                                                    <c:when test="${month.key==11}"><small>November</small></c:when>
                                                    <c:when test="${month.key==12}"><small>December</small></c:when>
                                                    </c:choose>
                                                </td>
                                                </c:if>
                                                <td>
                                                    <c:choose>
                                                    <c:when test="${!empty row.subhome_url}">
                                                    <a href="${row.subhome_url}" class="external_link" target="_blank">${row.pjt_nm}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <p>${row.pjt_nm}</p>
                                                    </c:otherwise>
                                                    </c:choose>
                                                    
                                                    
                                                </td>
                                                <td>
                                                    <span class="flag ${ctype}">
                                                    <c:choose>
                                                    <c:when test="${row.progress=='RV02204'||row.progress=='RV02205'}">
                                                    분양완료
                                                    </c:when>
                                                    <c:otherwise>
                                                    ${row.progress_name}
                                                    </c:otherwise>
                                                    </c:choose>
                                                    </span>
                                                </td>
                                            </tr>
                                            
                                            <c:if test="${fn:length(month.value)>1}">
                                            <c:set var="rowCount" value="1"/>
                                            </c:if>
                                            <c:set var="monthCount" value="${monthCount+1}"/>


                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>


                                    </c:choose>
                                </c:forEach>
                            </tbody>
                            </table>
                            </div>
                            <p class="comment">* 상기 분양 일정은 허가기관의 인허가 승인 여부에 따라 수시로 변경될 수 있습니다.</p>
                        </div>
                    <!-- //연도, 버튼-->
                    </c:when>
                    <c:otherwise>
                        <div class="no_data_wrap">
                            <p class="no_data type04">등록된 단지가 없습니다.</p>
                        </div>
                    </c:otherwise>
                    </c:choose>
                    </section>
                    <!-- //calendar-->
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
</body>

</html>