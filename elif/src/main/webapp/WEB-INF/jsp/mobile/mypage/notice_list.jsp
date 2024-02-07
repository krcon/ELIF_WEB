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
        <tr class="${row.mainstatus=='Y'?'notice':''}" data-idx="${row.idx}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
            <td class="number">
                ${row.mainstatus=='Y'?'공지':num}
                <c:set var="num" value="${num-1}"/>
            </td>
            <td class="notice_tit">
                <a href="javascript:void(0);" onclick="fn_openBoardView(${row.idx},${paginationInfo.getCurrentPageNo()})" class="title">
                    <span class="board_tit">${row.title}</span>
                    <fmt:formatDate var="start_dtm" pattern="yyyy년 MM월 dd일" value="${row.start_dtm }"/>
                    <span class="list_date">${start_dtm}</span>
                </a>
            </td>
        </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <tr data-page-current="0" data-page-last="0">
            <td colspan="3">
                <p class="no_data">등록된 공지사항이 없습니다.</p>
            </td>
        </tr>
    </c:otherwise>
</c:choose>