<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="principal" property="principal" />
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top ">
	<div class="container-fluid">
		<div class="navbar-wrapper">
			<div class="navbar-minimize">
				<button id="minimizeSidebar" class="btn btn-just-icon btn-white btn-fab btn-round">
					<i class="material-icons text_align-center visible-on-sidebar-regular">more_vert</i> <i class="material-icons design_bullet-list-67 visible-on-sidebar-mini">view_list</i>
				</button>
			</div>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
			<span class="sr-only">Toggle navigation</span> <span class="navbar-toggler-icon icon-bar"></span> <span class="navbar-toggler-icon icon-bar"></span> <span class="navbar-toggler-icon icon-bar"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end">
			<c:choose>
			<c:when test="${!empty param.searchHtml}">
			<jsp:include page="search/${param.searchHtml}.jsp">
			<jsp:param name="searchHtml" value="${param.searchHtml}" />
			</jsp:include>
			</c:when>
			</c:choose>

			<ul class="navbar-nav">
				<li class="nav-item dropdown"><a class="nav-link" href="#pablo" id="navbarDropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">person</i><p class="d-lg-none d-md-block">Account</p></a>
					<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownProfile">
						<fmt:formatDate var="login_dtm" pattern="yyyy-MM-dd HH:mm" value="${principal.login_dtm }"/>
						<div class="dropdown-item">최근 로그인 시간 : ${login_dtm}</div>
						<div class="dropdown-item">최근 로그인 IP : ${principal.login_ip}</div>
						<div class="dropdown-divider"></div>
						
						<sec:authorize access="isAnonymous()">
							<a href="/mgmt/login" class="dropdown-item">로그인</a>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<a href="/mgmt/logout" class="dropdown-item">로그아웃</a>
						</sec:authorize>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>