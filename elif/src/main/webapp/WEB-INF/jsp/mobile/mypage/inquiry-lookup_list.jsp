<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<c:choose>
    <c:when test="${fn:length(list) > 0}">
        <c:set var="num" value="${fn:length(list)}"/>
        <c:forEach items="${list }" var="row">
        <tr data-idx="${row.idx}" data-page-current="${paginationInfo.getCurrentPageNo()}" data-page-last="${paginationInfo.getLastPageNo()}">
            <td>
                <a href="javascript:;" data-idx="${row.idx }">${row.title }</a>
            </td>
            <td class="tc">
                <span class="badge ${row.reply_status=='RV02301'?'':'gray' }">${row.reply_status=='RV02301'?'접수완료':'답변완료' }</span>
                <button type="button" data-idx="${row.idx}" class="btn del_btn btn-flag-status">삭제</button>
            </td>
        </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
    <tr data-page-current="0" data-page-last="0">
        <td colspan="2">
            <p class="no_data">문의하신 내역이 없습니다.</p>
        </td>
    </tr>
    </c:otherwise>
</c:choose>