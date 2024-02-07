<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%-- 고객 관리 검색 --%>


<c:choose>
<c:when test="${param.sub=='admin'}">
<form name="frmSearch" action="${!empty param.searchAction?param.searchAction:''}" class="navbar-form">
	<div class="input-group no-border">
	
	<div class="form-group ">
		<select name="target" class="selectpicker" data-style="select-with-transition">
			<option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
			<option value="name" ${"name"==param.target?'selected="selected"':'' }>이름</option>
			<option value="email" ${"email"==param.target?'selected="selected"':'' }>이메일</option>
		</select>
	</div>
	
	<div class="form-group">
		<input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
	</div>
	<button type="submit" class="btn btn-white btn-round btn-just-icon">
		<i class="material-icons">search</i>
		<div class="ripple-container"></div>
	</button>
	</div>
</form>
</c:when>
<c:otherwise>

<form name="frmSearch" action="${!empty param.searchAction?param.searchAction:''}" class="form-inline text-right navbar-form">
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
		<select name="reply_status" class="selectpicker" data-style="select-with-transition">
			<option value="">상태</option>
			<option value="RV02301" ${"RV02301"==param.reply_status?'selected="selected"':'' }>접수완료</option>
			<option value="RV02303" ${"RV02303"==param.reply_status?'selected="selected"':'' }>답변완료(메일 발송 O)</option>
			<option value="RV02302" ${"RV02302"==param.reply_status?'selected="selected"':'' }>답변완료(메일 발송 X)</option>
		</select>
	</div>
	<div class="form-group ">
		<select name="target" class="selectpicker" data-style="select-with-transition">
			<option value="all" ${"all"==param.target?'selected="selected"':'' }>전체</option>
			<option value="title" ${"title"==param.target?'selected="selected"':'' }>제목</option>
			<option value="inquiry_content" ${"title"==param.target?'selected="selected"':'' }>내용</option>
		</select>
	</div>
	<div class="form-group">
		<input type="text" name="keyword" class="form-control" id="txt" value="${keyword}" placeholder="검색어 입력" />
	</div>
	<button type="submit" class="btn btn-white btn-round btn-just-icon">
		<i class="material-icons">search</i>
		<div class="ripple-container"></div>
	</button>
	</div>
</form>
</c:otherwise>
</c:choose>