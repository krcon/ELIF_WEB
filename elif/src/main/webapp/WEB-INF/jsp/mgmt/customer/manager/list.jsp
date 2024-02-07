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
    <%@ include file="../../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/customer/manager">
        <%@ include file="../../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="sub" value="admin" />
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
                                    <h4 class="card-title ">고객문의 담당자 리스트</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
												<th width="5%" class="column-title text-center">NO</th>
												<th width="15%" class="column-title text-center">아이디</th>
												<th width="15%" class="column-title text-center">이름 </th>
												<th class="column-title text-center">이메일 </th>
												<th width="15%" class="column-title text-center">소속 </th>
												<th width="15%" class="column-title text-center">등록일시 </th>
												<th width="10%" class="column-title text-center"></th>
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
														<td class="text-center">${row.userid }</td>
														<td class="text-center">
															<%-- <a href="javascript:fn_adminUpdate(${row.idx });">${ct:getMaskedName(row.name)}</a> --%>
															${ct:getMaskedName(row.name)}
														</td>
														<td class="text-center">${ct:getMaskedEmail(row.email)}</td>
														<td class="text-center">${row.department }</td>
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
														<td class="text-center">${crea_dtm}</td>
														<td class="text-center last">
															<a href="javascript:;" data-delete_id="${row.idx}" class="btn btn-danger btn-sm">삭제</a>
														</td>
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
                                                <a href="/mgmt/customer/manager/write" class="btn btn-primary">등록</a>
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
            <%@ include file="../../include/footer.jsp"%>
        </div>
    </div>
    <%@ include file="../../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
    $(function() {
		
		$(document).on('click','[data-delete_id]',function(){
			if(confirm('삭제하시겠습니까?')){
				window.location.href="/mgmt/customer/manager/delete?idx="+$(this).data('delete_id');
			}
		})
        $('tr[data-href]').on("dblclick", function() {
            document.location = $(this).data('href');
        }).css({
            'cursor': 'pointer'
        });

        $('tr[data-href]').on("doubletap", function() {
            document.location = $(this).data('href');
        });

        $('[name=frmSearch]').submit(function() {
            location.href = "/mgmt/customer/manager";
        });

    });
	function fn_adminUpdate(idx){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/manager/modify");
	    comSubmit.addParam("idx",idx);
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		if("${!empty inquiry_type}"=="true"){
			comSubmit.addParam("inquiry_type", "${inquiry_type}");
		}
	    comSubmit.submit();
	}
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/manager");
	    comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
		if("${!empty inquiry_type}"=="true"){
			comSubmit.addParam("inquiry_type", "${inquiry_type}");
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