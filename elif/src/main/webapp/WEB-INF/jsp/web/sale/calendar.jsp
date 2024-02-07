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
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <title>분양캘린더 | 엘리프</title>
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
                <section class="visual sale">
                    <h2>분양 캘린더</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><a href="/sale/complex"><span>분양 정보</span></a></li>
                        <li><span>분양 캘린더</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <!-- LNB -->
                    <nav class="lnb">
                        <ul>
                            <li><a href="../sale/complex">분양 단지</a></li>
                            <li><a href="../sale/calendar" class="on">분양 캘린더</a></li>
                        </ul>
                    </nav>
                    <!-- //LNB-->

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
                    <!-- 연도, 버튼 -->
                    <section class="calendar_header">
                        <!-- <h3 class="a11y_hide">분양 캘린더 연도</h3> -->
                        <div class="year">
                            <c:choose>
                                <c:when test="${prevYear==true}">
                                <a href="?year=${nowYear-1}" class="btn_arrow prev"><span class="a11y_hide">이전</span></a> <!-- [D] 0930 : 등록한 분양사이트 없을시 button에 no-data추가 -->
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="btn_arrow prev no-data"><span class="a11y_hide">이전</span></a>
                                </c:otherwise>
                            </c:choose>
                            <strong>${nowYear}</strong>
                            <c:choose>
                                <c:when test="${nextYear==true}">
                                <a href="?year=${nowYear+1}" class="btn_arrow next"><span class="a11y_hide">다음</span></a>
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="btn_arrow next no-data"><span class="a11y_hide">다음</span></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="right">
                            <button type="button" class="btn_toggle list">리스트로 보기</button>
                        </div>
                    </section>
                    <!-- //연도, 버튼-->
                    </c:when>
                    </c:choose>
                    <!-- 분양 캘린더 -->
                    <section class="calendar_body">
                        <c:choose>
                        <c:when test="${complexBool == '1'}">
                        <!-- <h3 class="a11y_hide">분양 캘린더 월별 목록</h3> -->
                        <div class="type_calendar">
                            <ul class="calendar">
                                <c:forEach items="${monthList }" var="month">
                                    <li>
                                        <div class="c1">
                                            <p><strong> <fmt:formatNumber type = "number" minIntegerDigits="2" value="${month.key}" /></strong></p>
                                            <c:choose>
                                            <c:when test="${month.key==1}"><p><em>January</em></p></c:when>
                                            <c:when test="${month.key==2}"><p><em>February</em></p></c:when>
                                            <c:when test="${month.key==3}"><p><em>March</em></p></c:when>
                                            <c:when test="${month.key==4}"><p><em>April</em></p></c:when>
                                            <c:when test="${month.key==5}"><p><em>May</em></p></c:when>
                                            <c:when test="${month.key==6}"><p><em>June</em></p></c:when>
                                            <c:when test="${month.key==7}"><p><em>July</em></p></c:when>
                                            <c:when test="${month.key==8}"><p><em>August</em></p></c:when>
                                            <c:when test="${month.key==9}"><p><em>September</em></p></c:when>
                                            <c:when test="${month.key==10}"><p><em>October</em></p></c:when>
                                            <c:when test="${month.key==11}"><p><em>November</em></p></c:when>
                                            <c:when test="${month.key==12}"><p><em>December</em></p></c:when>
                                            </c:choose>
                                            
                                        </div>
                                        <div class="c2">

                                            <c:choose>
                                                <c:when test="${fn:length(month.value) > 0}">
                                                    <c:forEach items="${month.value }" var="row"><c:choose>
                                                    <c:when test="${row.progress=='RV02201'}">
                                                    <c:set var="ctype" value="type1"/>
                                                    </c:when>
                                                    <c:when test="${row.progress=='RV02202'}">
                                                    <c:set var="ctype" value="type2"/>
                                                    </c:when>
                                                    <c:when test="${row.progress=='RV02203'||row.progress=='RV02204'||row.progress=='RV02205'}">
                                                    <c:set var="ctype" value="type3"/>
                                                    </c:when>
                                                    </c:choose>
                                                        <p>
                                                        <i class="${ctype}">
                                                        <c:choose>
                                                        <c:when test="${row.progress=='RV02204'||row.progress=='RV02205'}">
                                                        분양완료
                                                        </c:when>
                                                        <c:otherwise>
                                                        ${row.progress_name}
                                                        </c:otherwise>
                                                        </c:choose>
                                                        </i>
                                                        <b class="${empty row.subhome_url?'no-data':''}">  <!-- [D] 0930 : 데이터 없을시 클래스 no-data 추가 -->
                                                            <c:choose>
                                                            <c:when test="${!empty row.subhome_url}">
                                                            <a href="${row.subhome_url}" target="_blank" class="btn_detail">
                                                            </c:when>
                                                            <c:otherwise>
                                                            <a href="javascript:;" class="btn_detail">
                                                            </c:otherwise>
                                                            </c:choose>
                                                                ${row.pjt_nm}
                                                            </a>
                                                        </b>
                                                        </p>
                                                    </c:forEach>
                                                </c:when>
                                            </c:choose>
                                            
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>    
                        </div>
                        
                        <div class="type_list">
                            <table>
                                <tbody>
                                <c:forEach items="${monthList }" var="month">
                                    <c:set var="monthCount" value="1"/>
                                    <c:choose>
                                        <c:when test="${fn:length(month.value) > 0}">
                                            <c:forEach items="${month.value }" var="row"><c:choose>
                                            <c:when test="${row.progress=='RV02201'}">
                                            <c:set var="ctype" value="type1"/>
                                            </c:when>
                                            <c:when test="${row.progress=='RV02202'}">
                                            <c:set var="ctype" value="type2"/>
                                            </c:when>
                                            <c:when test="${row.progress=='RV02203' || row.progress=='RV02204'||row.progress=='RV02205'}">
                                            <c:set var="ctype" value="type3"/>
                                            </c:when>
                                            </c:choose>

                                            <tr>
                                                <td class="c1 ${monthCount>1?'hide':''}" rowspan="${fn:length(month.value)}">
                                                    <p><strong> <fmt:formatNumber type = "number" minIntegerDigits="2" value="${month.key}" /></strong></p>
                                                    <c:choose>
                                                    <c:when test="${month.key==1}"><p><em>January</em></p></c:when>
                                                    <c:when test="${month.key==2}"><p><em>February</em></p></c:when>
                                                    <c:when test="${month.key==3}"><p><em>March</em></p></c:when>
                                                    <c:when test="${month.key==4}"><p><em>April</em></p></c:when>
                                                    <c:when test="${month.key==5}"><p><em>May</em></p></c:when>
                                                    <c:when test="${month.key==6}"><p><em>June</em></p></c:when>
                                                    <c:when test="${month.key==7}"><p><em>July</em></p></c:when>
                                                    <c:when test="${month.key==8}"><p><em>August</em></p></c:when>
                                                    <c:when test="${month.key==9}"><p><em>September</em></p></c:when>
                                                    <c:when test="${month.key==10}"><p><em>October</em></p></c:when>
                                                    <c:when test="${month.key==11}"><p><em>November</em></p></c:when>
                                                    <c:when test="${month.key==12}"><p><em>December</em></p></c:when>
                                                    </c:choose>
                                                </td>
                                                <td class="tit ${empty row.subhome_url?'no-data':''}"> <!-- [D] 0929 : 등록한 사이트 없을 경우 no-data클래스 추가 -->
                                                    <c:choose>
                                                    <c:when test="${!empty row.subhome_url}">
                                                    <a href="${row.subhome_url}" target="_blank" class="btn_detail">
                                                    </c:when>
                                                    <c:otherwise>
                                                    <a href="javascript:;" class="btn_detail">
                                                    </c:otherwise>
                                                    </c:choose>
                                                        <em>${row.pjt_nm}</em>
                                                    </a>
                                                </td>
                                                <td>${row.sllt_info_loc}</td>
                                                <td><fmt:formatNumber value="${row.households }" pattern="#,###" />세대</td>
                                                <td>
                                                    <i class="${ctype}">
                                                    <c:choose>
                                                    <c:when test="${row.progress=='RV02204'||row.progress=='RV02205'}">
                                                    분양완료
                                                    </c:when>
                                                    <c:otherwise>
                                                    ${row.progress_name}
                                                    </c:otherwise>
                                                    </c:choose>
                                                    </i>
                                                </td>
                                            </tr>
                                            <c:set var="monthCount" value="${monthCount+1}"/>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                        <%-- <div class="no_data_wrap">
                                            <p class="no_data type04">등록된 단지가 없습니다.</p>
                                        </div> --%>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        </c:when>
                        <c:otherwise>
                        <div class="no_data_wrap">
                            <p class="no_data_txt no_data_ico">등록된 단지가 없습니다.</p>
                        </div>
                        </c:otherwise>
                        </c:choose>
                    </section>
                    <!-- //분양 캘린더 -->
                </div>
            </div>

        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <!-- //wrap -->
    <%@ include file="../include/javascript.jsp" %>
    <script>
        elif.saleCalendar();
    </script>
</body>

</html>