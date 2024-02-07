<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<c:if test="${fn:length(contConstFileList) > 0}">

<div class="photo_slider" id="${param.rand}">
    <ul class="slider-for">
        <!-- [D] 0916 : 슬라이드 이미지 비율에 대한 div 생성 -->
        <c:forEach items="${contConstFileList }" var="img_row">
        <li><div><img src="${img_row.path_name}${img_row.stored_file_name}" alt=""></div></li>
        </c:forEach>
    </ul>
    <ul class="slider-nav">
        <!-- [D] 0916 : 슬라이드 이미지 비율에 대한 div 생성 -->
        <c:forEach items="${contConstFileList }" var="img_row">
        <li><div><img src="${img_row.path_name}${img_row.stored_file_name}" alt=""></div></li>
        </c:forEach>
    </ul>
</div>
</c:if>