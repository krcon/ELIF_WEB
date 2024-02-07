<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:choose>
<%-- 게시판 && 팝업 --%>
<c:when test="${param.searchHtml=='board' || param.searchHtml=='catalog' || param.searchHtml=='popup'}">
    <c:choose>
        <c:when test="${param.searchHtml=='popup'}">
        <form name="frmSearch" action="/mgmt/popup" class="form-inline text-right navbar-form">
        </c:when>
        <c:otherwise>
        <form name="frmSearch" action="/mgmt/board/${pid}" class="form-inline text-right navbar-form">
        </c:otherwise>
    </c:choose>
        <div class="input-group no-border">
        <c:if test="${param.searchHtml=='popup'}">
        <div class="form-group">
        <select name="gubun_detect" class="selectpicker" data-style="select-with-transition">
            <option value="">구분</option>
            <option value="gubun_web" ${"gubun_web"==param.gubun_detect?'selected="selected"':'' ?'selected':'' }>PC</option>
            <option value="gubun_mobile" ${"gubun_mobile"==param.gubun_detect?'selected="selected"':''?'selected':'' }>Mobile</option>
        </select>
        </div>
        </c:if>
        <div class="form-group">
            <select name="target" class="selectpicker" data-style="select-with-transition">
                <option value="all" ${"KO"==param.target?'selected="selected"':'' }>전체</option>
                <option value="title" ${"title"==param.target?'selected="selected"':'' }>제목</option>
                <option value="contents" ${"contents"==param.target?'selected="selected"':'' }>내용</option>
            </select>
        </div>
        <div class="form-group">
            <input type="text" name="keyword" class="form-control" id="txt" value="${param.keyword }" placeholder="검색어 입력" />
        </div>
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
        </div>
    </form>
</c:when>
<%-- //게시판 && 팝업 --%>
</c:choose>