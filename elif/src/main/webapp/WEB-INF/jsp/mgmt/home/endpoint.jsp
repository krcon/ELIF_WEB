<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/menu/list">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
            <%@ include file="../include/top.jsp"%>
            <!-- End Navbar -->
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
<table>
  <thead>
  <tr>
    <th>path</th>
    <th>methods</th>
    <th>consumes</th>
    <th>produces</th>
    <th>params</th>
    <th>headers</th>
    <th>custom</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${endPoints}" var="endPoint">
    <tr>
      <td>${endPoint.patternsCondition}</td>
      <td>${endPoint.methodsCondition}</td>
      <td>${endPoint.consumesCondition}</td>
      <td>${endPoint.producesCondition}</td>
      <td>${endPoint.paramsCondition}</td>
      <td>${endPoint.headersCondition}</td>
      <td>${empty endPoint.customCondition ? "none" : endPoint.customCondition}</td>
    </tr>
  </c:forEach>
  </tbody>
</table>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp"%>
        </div>
    </div>

    <%@ include file="../include/script.jsp"%>
</body>

</html>