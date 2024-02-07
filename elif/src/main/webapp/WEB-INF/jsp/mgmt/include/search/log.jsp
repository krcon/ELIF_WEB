<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:choose>
<c:when test="${param.sub=='access'}">
<form name="frmSearch" action="/mgmt/log" class="navbar-form">
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
        <select name="login_type" class="selectpicker" data-style="select-with-transition">
            <option value="" ${"all"==param.login_type?'selected="selected"':'' }>전체</option>
            <option value="login" ${"login"==param.login_type?'selected="selected"':'' }>로그인</option>
            <option value="logout" ${"logout"==param.login_type?'selected="selected"':'' }>로그아웃</option>
        </select>
    </div>
    <div class="form-group bmd-form-group ">
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="userid" ${"userid"==param.target?'selected="selected"':'' }>아이디</option>
            <option value="username" ${"username"==param.target?'selected="selected"':'' }>이름</option>
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
<c:when test="${param.sub=='menu'}">
<form name="frmSearch" action="/mgmt/log/menu" class="navbar-form">
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
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="userid" ${"userid"==param.target?'selected="selected"':'' }>아이디</option>
            <option value="username" ${"username"==param.target?'selected="selected"':'' }>이름</option>
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
<c:when test="${param.sub=='excel'}">
<form name="frmSearch" action="/mgmt/log/excel" class="navbar-form">

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
        <select name="target" class="selectpicker" data-style="select-with-transition">
            <option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
            <option value="user_id" ${"user_id"==param.target?'selected="selected"':'' }>아이디</option>
            <option value="username" ${"username"==param.target?'selected="selected"':'' }>이름</option>
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
</c:choose>