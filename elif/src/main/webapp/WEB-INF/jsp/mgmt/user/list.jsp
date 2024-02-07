<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/user">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../include/top.jsp">
                <jsp:param name="searchHtml" value="member" />
        	</jsp:include>
            <!-- End Navbar -->
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header card-header-icon card-header-rose">
                                    <div class="card-icon">
                                        <i class="material-icons">supervisor_account</i>
                                    </div>
                                    <h4 class="card-title ">관리자 리스트</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
												<th width="5%" class="column-title text-center">NO</th>
												<th width="10%" class="column-title text-center">아이디 </th>
												<th width="10%" class="column-title text-center">이름 </th>
												<th class="column-title text-center">이메일 </th>
												<th width="10%" class="column-title text-center">권한 </th>
												<th width="15%" class="column-title text-center">소속 </th>
												<th width="15%" class="column-title text-center">마지막 로그인 </th>
												<th width="15%" class="column-title text-center">등록일시 </th>
											</tr>
										</thead>
										<tbody>
										 <c:choose>
										    <c:when test="${fn:length(list) > 0}">
												<c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
										        <c:forEach items="${list }" var="row">
													<tr>
														<td class="text-center">
															${num }
															<c:set var="num" value="${num-1}"/>
														</td>
														<td class="text-center">
															<a href="javascript:fn_openBoardUpdate(${row.idx });">${row.userid }</a>
														</td>
														<td class="text-center">
															<a href="javascript:fn_openBoardUpdate(${row.idx });">${ct:getMaskedName(row.name)}</a>
														</td>
														<td class="text-center"><a href="javascript:fn_openBoardUpdate(${row.idx });">${ct:getMaskedEmail(row.email)}</a></td>
														<td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${row.grants=='ROLE_LOCAL'}">
                                                            Local
                                                            </c:when>
                                                            <c:otherwise>
                                                            Master
                                                            </c:otherwise>
                                                        </c:choose>
                                                        </td>
														<td class="text-center">${row.department }</td>
                                                        <fmt:formatDate var="login_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.login_dtm }"/>
														<td class="text-center last">${login_dtm}</td>
                                                        <fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
														<td class="text-center last">${crea_dtm}</td>
													</tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
										        <tr>
										            <td colspan="6">조회된 결과가 없습니다.</td>
										        </tr>
										    </c:otherwise>
										</c:choose>
										
										</tbody>
									</table>
                                    </div>
                                </div>
                                <div class="card-footer">
									<div class="w-100 pb-3">
                                        <div class="row">
                                            <div class="col-6">
                                                <a href="/mgmt/user/write" class="btn btn-success">관리자추가</a>
                                            </div>
                                            <div class="col-6 text-right">
                                                <div class="pull-right">
                                                    <ul class="pagination">
                                                        <c:if test="${not empty paginationInfo}">
                                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
                                                        </c:if>
                                                    </ul>
                                                    <input type="hidden" id="currentPageNo" name="currentPageNo" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp"%>
        </div>
    </div>
    <%@ include file="../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
    $(function() {

        $('tr[data-href]').on("dblclick", function() {
            document.location = $(this).data('href');
        }).css({
            'cursor': 'pointer'
        });

        $('tr[data-href]').on("doubletap", function() {
            document.location = $(this).data('href');
        });

        // $('[name=frmSearch]').submit(function() {
        //     if ($(this).find('#txt').val() == "") {
        //         location.href = "/mgmt/user";
        //         return false;
        //     }
        // })
    });
	function fn_openBoardUpdate(idx){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/user/"+idx+"/modify");
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
	    comSubmit.submit();
	}
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/user");
	    comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		if("${!empty sdate}"=="true"){
			comSubmit.addParam("sdate", "${sdate}");
		}
		if("${!empty edate}"=="true"){
			comSubmit.addParam("edate", "${edate}");
		}
	    comSubmit.submit();
	}
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>