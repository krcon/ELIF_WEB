<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>

<c:choose>
    <c:when test="${fn:length(list) > 0}">
        <c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
        <c:forEach items="${list }" var="row">
        <li class="block_item_commu" data-idx="${row.idx}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
            <c:choose>
                <c:when test="${!empty row.video}">
                <a href="${row.video}" target="_blank">
                </c:when>
                <c:otherwise>
                <a href="./community-view?idx=${row.idx}">
                </c:otherwise>
            </c:choose>
                <div class="img_area">
                    <c:choose>
                    <c:when test="${!empty row.img_name}">
                    <img src="${row.img_name}" alt="${row.title}">
                    </c:when>
                    <c:otherwise>
                    <span><img src="/resources/web/images/construction_temp_default.png" alt=""></span>
                    </c:otherwise>
                    </c:choose>
                </div>
                <div class="info">
                    <fmt:formatDate var="start_dtm" pattern="yyyy.MM.dd" value="${row.start_dtm }"/>
                    <p class="date">${start_dtm}</p>
                    <p class="title">${row.title}</p>
                </div>
            </a>
        </li>
        </c:forEach>
    </c:when>
    <c:otherwise>
    <c:if test="${paginationInfo.getTotalRecordCount()<1}">
    <!-- [D] 검색결과 없을 경우 -->
    <li class="no_data_wrap " data-page-current="0" data-page-last="0">
        <div class="nodata">
            <p class="no_data_txt no_contents_ico">등록된 컨텐츠가 없습니다.</p>
        </div>
    </li>
    <!-- // [D] 검색결과 없을 경우 -->
    </c:if>
    </c:otherwise>
</c:choose>