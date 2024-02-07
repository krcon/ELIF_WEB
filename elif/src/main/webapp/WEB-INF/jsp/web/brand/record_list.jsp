<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!-- [D] 호출 시, li 기본 노출 6개 -->
<c:choose>
    <c:when test="${fn:length(list) > 0}">
        <c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
        <c:forEach items="${list }" var="row">
        <li class="block_item" data-pjt_cd="${row.pjt_cd}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
            <dl>
                <dt>
                    <span class="cate">${row.housing_name}</span>
                    <div class="tit">
                        <em>${row.pjt_nm}</em>
                    </div>
                </dt>
                <dd>
                    <div class="info">
                        <p class="locate">${row.sllt_info_loc}</p>
                        <p class="area">${row.area}㎡</p>
                        <p class="people">총 <fmt:formatNumber value="${row.households }" pattern="#,###" />세대</p>
                        
                        <p class="scale">${row.const_scope}</p>
                    </div>
                </dd>
            </dl>
        </li>
        </c:forEach>
    </c:when>
    <c:otherwise>
    <c:if test="${paginationInfo.getTotalRecordCount()<1}">
    <!-- [D] 검색결과 없을 경우 -->
    <li data-page-current="0" data-page-last="0">
    </li>
    <!-- // [D] 검색결과 없을 경우 -->
    </c:if>
    </c:otherwise>
</c:choose>