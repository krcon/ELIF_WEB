<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:bundle basename="message">
<fmt:message key="company" var="head_company"/>
</fmt:bundle>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<link rel="apple-touch-icon" sizes="76x76" href="/resources/manager/img/apple-icon.png">
	<link rel="icon" type="image/png" href="/resources/manager/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<title>
		<c:out value="${head_company}" /> 관리자
	</title>
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<!--     Fonts and icons     -->
	<link rel="stylesheet" type="text/css" href="/resources/manager/custom/fonts.css" />
	<link rel="stylesheet" href="/resources/manager/custom/font-awesome.min.css">
	<!-- CSS Files -->
	<link href="/resources/manager/css/material-dashboard.min.css?v=2.1.0" rel="stylesheet" />
	<link href="/resources/manager/css/plugins/simplelightbox.min.css" rel="stylesheet" />
	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link href="/resources/manager/custom/custom.css" rel="stylesheet" />
	
	<script src="/resources/manager/js/core/jquery.min.js"></script>
	