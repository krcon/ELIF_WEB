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
        <c:choose>
        <c:when test="${row.progress=='RV02204'}">
        <c:set var="ctype" value="color1"/>
        </c:when>
        <c:when test="${row.progress=='RV02205'}">
        <c:set var="ctype" value="color2"/>
        </c:when>
        </c:choose>
        <li data-pjt_cd="${row.pjt_cd}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
            <c:choose>
            <c:when test="${row.const_count>0 && row.progress=='RV02205'}">
            <a href="construction_view?pjt_cd=${row.pjt_cd}" class="btn_detail">
            </c:when>
            <c:otherwise>
            <a href="javascript:;" class="btn_detail" data-effect="none">
            </c:otherwise>
            </c:choose>
                <div class="img_area">
                    <c:choose>
                    <c:when test="${!empty row.const_thumb_name}">
                    <span><img src="${row.const_thumb_path}${row.const_thumb_name}" alt=""></span>
                    </c:when>
                    <c:otherwise>
                    <span><img src="/resources/web/images/construction_temp_default.png" alt=""></span>
                    </c:otherwise>
                    </c:choose>
                </div>
                <dl>
                    <dt>
                        <div class="exp1"><span class="c2">${row.housing_name}</span>
                        </div>
                        <div class="tit"><em>${row.pjt_nm}</em> <i class="flag_type ${ctype}">${row.progress_name}</i></div>
                        <c:if test="${!empty row.const_year}">
                        <div class="exp2"><span class="c1">${row.const_year}년 ${row.const_month}월 입주 예정</span></div>
                        </c:if>
                    </dt>
                    <dd>
                        <div class="info">
                            <p class="locate">${row.sllt_info_loc}</p>
                            <p class="area">${row.area}㎡</p>
                            <p class="people">총 <fmt:formatNumber value="${row.households }" pattern="#,###" />세대</p>
                        </div>
                        <div class="tel">${row.sllt_info_addr_tel}</div>
                    </dd>
                </dl>
            </a>
        </li>
        </c:forEach>
    </c:when>
    <c:otherwise>
    <c:if test="${paginationInfo.getTotalRecordCount()<1}">
        <li data-page-current="0" data-page-last="0">
        <c:choose>
        <c:when test="${fn:length(param.keyword)>0 || fn:length(param.progress)>0 || fn:length(param.housing)>0 || fn:length(param.region)>0}">
        <div class="no_data_wrap">
            <p class="no_data_txt no_search_data_ico">일치하는 단지가 없습니다.</p>
            <div class="btn_more">
                <a href="javascript:search('reset');" class="btn_m1 list">전체 목록</a>
            </div>
        </div>
        </c:when>
        <c:otherwise>
        <div class="no_data_wrap">
            <p class="no_data_txt no_data_ico">등록된 단지가 없습니다.</p>
        </div>
        </c:otherwise>
        </c:choose>
        </li>
    </c:if>
    </c:otherwise>
</c:choose>