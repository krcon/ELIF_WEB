
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<c:choose>
    <c:when test="${param.sub=='community'}">
    <form name="frmSearch" action="/mgmt/board/${pid}" class="form-inline text-right navbar-form">
        <div class="input-group no-border">

        <div class="form-group bmd-form-group">
            <div class="xdisplay_inputx form-group has-feedback">
                <input type="text" name="sdate" class="form-control sdatepicker"  placeholder="시작일" value="${sdate }" />
            </div>
        </div>
        <div class="form-group bmd-form-group">
            <div class="xdisplay_inputx form-group has-feedback">
                <input type="text" name="edate" class="form-control edatepicker"  placeholder="종료일" value="${edate }" />
            </div>
        </div>
        <div class="form-group">
            <select name="gubun" class="selectpicker" data-style="select-with-transition">
                <option value="" ${""==param.target?'selected="selected"':'' }>전체</option>
                <c:forTokens items="${category.types}" delims="," var="item">
                    <option value="${item}" ${item==param.gubun?' selected="selected"':'' }>${ct:getBoardType(item)}</option>
                </c:forTokens>
            </select>
        </div>
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
    <c:when test="${param.sub=='notice'}">
    <form name="frmSearch" action="/mgmt/board/${pid}" class="form-inline text-right navbar-form">
        <div class="input-group no-border">

        <div class="form-group bmd-form-group">
            <div class="xdisplay_inputx form-group has-feedback">
                <input type="text" name="sdate" class="form-control sdatepicker"  placeholder="시작일" value="${sdate }" />
            </div>
        </div>
        <div class="form-group bmd-form-group">
            <div class="xdisplay_inputx form-group has-feedback">
                <input type="text" name="edate" class="form-control edatepicker"  placeholder="종료일" value="${edate }" />
            </div>
        </div>
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
    <c:otherwise>
    <form name="frmSearch" action="/mgmt/board/${pid}" class="form-inline text-right navbar-form">
        <div class="input-group no-border">
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
    </c:otherwise>
</c:choose>