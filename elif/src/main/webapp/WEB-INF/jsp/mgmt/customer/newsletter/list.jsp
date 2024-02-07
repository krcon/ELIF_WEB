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
    <div class="wrapper " data-menu="/mgmt/customer/newsletter">
        <%@ include file="../../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="sub" value="newsletter" />
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
                                    <h4 class="card-title ">관심고객등록 목록</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
												<th width="5%" class="column-title text-center">NO</th>
												<th class="column-title text-center">이메일 </th>
												<th width="7%" class="column-title text-center">이름 </th>
												<th width="15%" class="column-title text-center">연락처 </th>
												<th width="7%" class="column-title text-center">국가 </th>
												<th width="10%" class="column-title text-center">회사 </th>
												<th width="8%" class="column-title text-center">직무 </th>
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
														<td class="text-center">${ct:getMaskedEmail(row.email)}</td>
														<td class="text-center">
															<a href="javascript:fn_newsletterView(${row.idx });">${ct:getMaskedName(row.name)}</a>
														</td>
														<td class="text-center">${ct:getMaskedPhoneNum(row.tel)}</td>
														<td class="text-center">${row.nation }</td>
														<td class="text-center">${row.company }</td>
														<td class="text-center">${row.department }</td>
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
                                                <!-- <a href="/mgmt/customer/newsletter/exceldown" class="btn btn-success">엑셀 다운로드</a> -->
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalExcelDownForm"> 엑셀 다운로드</button>
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
    
	<!-- 엑셀 다운로드 팝업 -->
	<div id="ModalExcelDownForm" class="modal fade">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h3 class="modal-title">엑셀 다운로드</h3>
	            </div>
	            <div class="modal-body">
	                <form role="form" method="POST" id="frmExcelDown" action="/mgmt/customer/newsletter/exceldown" >
	                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                    <div class="form-group">
	                        <label class="control-label">사유 (최대 50자)</label>
	                        <div>
	                            <textarea class="form-control" id="reason" name="reason" style="height:150px;" maxlength="50" rows="5"  required></textarea>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div>
	                            <button type="button" id="btnExcelDown" class="btn btn-success">다운로드</button>
	                            <button type="button" data-dismiss="modal" class="btn btn-info">취소</button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    
    <%@ include file="../../include/script.jsp"%>
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

        $('[name=frmSearch]').submit(function() {
        	location.href = "/mgmt/customer/newsletter";
        })
    });
	function fn_newsletterView(idx){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/newsletter/view");
	    comSubmit.addParam("idx",idx);
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
	    comSubmit.submit();
	}
	
	$('#btnExcelDown').click(function(e){
		if($("#reason").val()=="") {
			alert("사유를 입력해 주세요.");
			return;
		}
		if($("#reason").val().length>50) {
			alert("사유를 50자이내로 작성해주세요.");
			return;
		}
		$("#frmExcelDown").submit();
		$('#ModalExcelDownForm').modal('hide');
		
	});
	
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/newsletter");
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