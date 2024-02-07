<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="principal" property="principal" />
<div class="sidebar" data-color="rose" data-background-color="black" data-image="/resources/manager/img/sidebar-1.jpg">
	<div class="logo">
		<a href="/mgmt/home" class="simple-text logo-mini"><i class="material-icons">admin_panel_settings</i></a>
		<a href="/mgmt/home" class="simple-text logo-normal"> 
			<c:out value="${head_company}" />
		</a>
	</div>
	<div class="sidebar-wrapper">
		<div class="user">
			<div class="photo">
				<img src="/resources/manager/img/faces/avatar.png" />
			</div>
			<div class="user-info">
				<a data-toggle="collapse" href="#collapseExample" class="username">
				<span> ${principal.name} <b class="caret"></b></span>
				</a>
				<div class="collapse" id="collapseExample">
					<ul class="nav">
						<li class="nav-item">
							<a class="nav-link" data-menu="mgmt|user|profile" href="/mgmt/user/profile">
								<span class="sidebar-mini"> PR </span> 
								<span class="sidebar-normal"> 개인정보 수정 </span>
							</a>
						</a>
						<li class="nav-item">
							<a class="nav-link" data-menu="mgmt|user|password" href="/mgmt/user/password">
								<span class="sidebar-mini"> PW </span> 
								<span class="sidebar-normal"> 비밀번호 변경 </span>
							</a>
						</a>
						<li class="nav-item">
							<a class="nav-link" data-menu="mgmt|user|logout" href="/mgmt/logout">
								<span class="sidebar-mini"> LO </span> 
								<span class="sidebar-normal"> 로그아웃 </span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<ul class="nav">
			<!-- <li class="nav-item ">
				<a class="nav-link" href="/mgmt/home"> <i class="material-icons">dashboard</i><p>Dashboard</p></a>
			</li> -->
			<c:choose>
				<c:when test="${fn:length(principal.adminMenu) > 0}">
					<c:forEach items="${principal.adminMenu }" var="row">
					<li class="nav-item ">
						<c:choose>
						<c:when test="${row.children.size()>0}">
						<a class="nav-link" data-toggle="collapse" href="#menu-list--${row.idx}"> 
						</c:when>
						<c:otherwise>
						<a class="nav-link" href="${row.url}" data-menu="mgmt|user|list">
						</c:otherwise>
						</c:choose>
							<c:choose>
							<c:when test="${fn:startsWith(row.title,'관리자')}">
							<i class="material-icons">manage_accounts</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'단지코드')}">
							<i class="material-icons">format_list_numbered</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'KR')}">
							<i class="material-icons">corporate_fare</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'계룡단지')}">
							<i class="material-icons">apartment</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'브랜드')}">
							<i class="material-icons">business_center</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'MY')}">
							<i class="material-icons">add_business</i>
							</c:when>
							<c:when test="${fn:startsWith(row.title,'기타')}">
							<i class="material-icons">support_agent</i>
							</c:when>
							<c:otherwise>
							<i class="material-icons">list</i>
							</c:otherwise>
							</c:choose>
							<p>
								${row.title}
								
								<c:if test="${row.children.size()>0}">
								<b class="caret"></b>
								</c:if>
							</p>
						</a>
						<c:if test="${row.children.size()>0}">
						<div class="collapse" id="menu-list--${row.idx}">
							<ul class="nav">
								<c:forEach items="${row.children }" var="item">
								<li class="nav-item "><a class="nav-link" href="${item.url }" data-menu="mgmt|board|category"> <span class="sidebar-mini"> ${fn:substring(item.title,0,2) } </span> <span class="sidebar-normal"> ${item.title } </span>
								</a></li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</li>

					</c:forEach>
				</c:when>
				<c:otherwise>
					<li>메뉴가 없습니다.</li>
				</c:otherwise>
			</c:choose>
			<li class="nav-item ">
				<a class="nav-link" href="<spring:eval expression="@environment.getProperty('sys.webdomain')"></spring:eval>" target="_blank">
					<i class="material-icons">home</i>
					엘리프 홈페이지 바로가기
				</a>
			</li>
		</ul>
	</div>
</div>