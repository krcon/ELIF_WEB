<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:choose>
<c:when test="${param.sub=='list'}">
<form name="frmSearch" action="./management_list" class="navbar-form">
    <div class="form-group bmd-form-group ">
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="code" ${"code"==param.target?'selected="selected"':'' }>코드</option>
            <option value="name" ${"name"==param.target?'selected="selected"':'' }>단지명</option>
            <option value="progress" ${"progress"==param.target?'selected="selected"':'' }>진행상태</option>
        </select>
    </div>
    <div class="input-group">
        <input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
    </div>
</form>
</c:when>
<c:when test="${param.sub=='sales'}">
<form name="frmSearch" action="./sales_list" class="navbar-form">
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
    <div class="form-group bmd-form-group ">
        <select name="progress" class="selectpicker" data-style="select-with-transition">
            <option value="" ${""==param.target?'selected="selected"':'' }>전체</option>
            <c:choose>
            <c:when test="${fn:length(progress_array) > 0}">
                <c:forEach items="${progress_array }" var="row">
                    <option value="${row.code_id}" ${row.code_id==param.progress?'selected="selected"':'' }>${row.code_name}</option>
                </c:forEach>
            </c:when>
            </c:choose>
        </select>
    </div>
    <div class="form-group bmd-form-group ">
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="code" ${"code"==param.target?'selected="selected"':'' }>단지코드</option>
            <option value="name" ${"name"==param.target?'selected="selected"':'' }>단지명</option>
        </select>
    </div>
    <div class="input-group">
        <input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
    </div>
</form>
</c:when>
<c:when test="${param.sub=='const'}">
<form name="frmSearch" action="./const_list" class="navbar-form">
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
    <div class="form-group bmd-form-group ">
        <select name="progress" class="selectpicker" data-style="select-with-transition">
            <option value="" ${""==param.target?'selected="selected"':'' }>전체</option>
            <c:choose>
            <c:when test="${fn:length(progress_array) > 0}">
                <c:forEach items="${progress_array }" var="row">
                    <option value="${row.code_id}" ${row.code_id==param.progress?'selected="selected"':'' }>${row.code_name}</option>
                </c:forEach>
            </c:when>
            </c:choose>
        </select>
    </div>
    <div class="form-group bmd-form-group ">
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="pjt_cd" ${"pjt_cd"==param.target?'selected="selected"':'' }>단지코드</option>
            <option value="name" ${"name"==param.target?'selected="selected"':'' }>단지명</option>
        </select>
    </div>
    <div class="input-group">
        <input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
    </div>
</form>
</c:when>
<c:when test="${param.sub=='occupancy'}">
<form name="frmSearch" action="./occupancy_list" class="navbar-form">
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
    <div class="form-group bmd-form-group ">
        <select name="progress" class="selectpicker" data-style="select-with-transition">
            <option value="" ${""==param.target?'selected="selected"':'' }>전체</option>
            <c:choose>
            <c:when test="${fn:length(progress_array) > 0}">
                <c:forEach items="${progress_array }" var="row">
                    <option value="${row.code_id}" ${row.code_id==param.progress?'selected="selected"':'' }>${row.code_name}</option>
                </c:forEach>
            </c:when>
            </c:choose>
        </select>
    </div>
    <div class="form-group bmd-form-group ">
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="code" ${"code"==param.target?'selected="selected"':'' }>단지코드</option>
            <option value="name" ${"name"==param.target?'selected="selected"':'' }>단지명</option>
        </select>
    </div>
    <div class="input-group">
        <input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
    </div>
</form>
</c:when>
<c:when test="${param.sub=='const_sub'}">
<form name="frmSearch" action="../const_sub_list/${const_idx}" class="navbar-form">
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
    <div class="input-group">
        <input type="text" name="keyword" class="form-control hidden" id="txt" value="${keyword}" placeholder="검색어 입력" />
        <button type="submit" class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>
        </button>
    </div>
</form>
</c:when>
</c:choose>