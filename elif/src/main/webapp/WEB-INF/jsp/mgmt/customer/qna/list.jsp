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
    <div class="wrapper " data-menu="/mgmt/customer/qna">
        <%@ include file="../../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="sub" value="${fn:toLowerCase(inquiry_type)}" />
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
                                    <h4 class="card-title ">고객 문의</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<th width="7%" class="column-title text-center">답변 상태</th>
													<th width="10%" class="column-title text-center">고객아이디</th>
													<th width="8%" class="column-title text-center">고객명</th>
													<th width="12%" class="column-title text-center">등록일시</th>
													<th width="15%" class="column-title text-center">단지명</th>
													<th class="column-title text-center">제목 </th>
													<th width="8%" class="column-title text-center">답변 작성자</th>
													<th width="8%" class="column-title text-center">답변 완료일시</th>
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
														<td class="text-center">${row.reply_status_name }</td>
														<td class="text-center">${row.user_id }</td>
														<td class="text-center">${ct:getMaskedName(row.user_nm)}</td>
														<td class="text-center">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
														${crea_dtm }
														</td>
														<td class="text-center">
															${row.type=='RV02401'?row.complex_name:row.type_name}
														</td>
														<td>
															<a href="javascript:;" data-idx="${row.idx }">${row.title }</a>
														</td>
														<td class="text-center">${row.reply_name}</td>
														<td class="text-center">
														<fmt:formatDate var="reply_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.reply_dtm }"/>
														${reply_dtm }
														</td>
													</tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
										        <tr>
										            <td colspan="8">조회된 결과가 없습니다.</td>
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
												<%-- <a href="javascript:excelDownload();" class="btn btn-info">엑셀 다운로드</a>
                                            	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalDeleteListForm"> 일괄삭제(3년 이전데이터)</button> --%>
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
    
    <!-- 일괄삭제 팝업 -->
	<div id="ModalDeleteListForm" class="modal fade">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title">일괄 삭제(3년 이전 데이터)</h4>
	            </div>
	            <div class="modal-body">
	                <form role="form" method="POST" id="frmExpireDown" action="/mgmt/customer/qna/expire" >
	                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                    <div class="form-group">
	                        <label class="control-label">총 ${fn:length(delist)}건</label>
	                        <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<th width="10%" class="column-title text-center">답변 상태</th>
													<th width="15%" class="column-title text-center">등록일시</th>
													<th width="15%" class="column-title text-center">단지명</th>
													<th class="column-title text-center">제목 </th>
													<th width="13%" class="column-title text-center">답변 작성자</th>
													<th width="13%" class="column-title text-center">답변 완료일시</th>
												</tr>
										</thead>
										<tbody>
										 <c:choose>
										    <c:when test="${fn:length(delist) > 0}">
												<c:set var="num" value="${fn:length(delist)}"/>
										        <c:forEach items="${delist }" var="row">
													<tr>
														<td class="text-center">
															${num }
															<c:set var="num" value="${num-1}"/>
														</td>
														<td class="text-center">${row.reply_status_name }</td>
														<td class="text-center">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
														${crea_dtm }
														</td>
														<td class="text-center">${row.pjt_cd }</td>
														<td>
															<a href="javascript:;" data-idx="${row.idx }">${row.title }</a>
														</td>
														<td class="text-center">${ct:getMaskedName(row.name)}</td>
														<td class="text-center">
														<fmt:formatDate var="reply_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.reply_dtm }"/>
														${reply_dtm }
														</td>
													</tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
										        <tr>
										            <td colspan="6">등록된 데이터가 없습니다.</td>
										        </tr>
										    </c:otherwise>
										</c:choose>
										
										</tbody>
									</table>
                                    </div>
	                    </div>
	                    <div class="form-group">
	                        <div>
	                            <button type="button" id="btnDeleteAll" class="btn btn-success"> 삭제</button>
	                            <button type="button" data-dismiss="modal" class="btn btn-info">취소</button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    
	<div class="modal fade" id="detailExcelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-notice modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myModalLabel">엑셀다운로드</h5>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<i class="material-icons">close</i>
					</button>
				</div>
				<div class="modal-body">
	                <form role="form" method="POST" id="frmExcelDown" action="/mgmt/customer/qna/exceldown" >
	                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="inquiry_type" value="${inquiry_type}">
	                    <div class="form-group">
	                        <label class="control-label">사유 (최대 50자)</label>
	                        <div>
	                            <textarea class="form-control" id="reason" name="reason" style="height:150px;" maxlength="50" rows="5" style="height:100px;" required></textarea>
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
			</div>
		</div>
	</div>
    
    <%@ include file="../../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
    $(function() {
		if(${param.error=='noadmin'}==true){
			alert('고객문의담당자만 등록/수정할 수 있습니다.');
		}
    	$("a[data-idx]").on("click", function(e){
	        e.preventDefault();
	        fn_openCustomerDetail($(this));
	    });

    	$(".modal").on("show.bs.modal", function (e) {
    		var num = '${fn:length(delist)}';
    		if(num == 0){
    			$("#btnDeleteAll").prop("disabled", true);
    		}
    	});
    	
    	$(".modal").on("hidden.bs.modal", function (e) {
    		$("#btnDeleteAll").prop("disabled", false);
    		$(this).find('form')[0].reset();
    	});
    	
		$("#delete").click(function(){
			if( $("input[type=checkbox][name=chkDel]:checked").length == 0 ){
			    alert("삭제할 항목을 선택해 주세요!");
			    return;
			}
			
			var arrIdx = new Array();
	        $("input[name='chkDel']:checked").each(function() {
	        	arrIdx.push($(this).attr('id'));
	        });
	        
	        if (confirm("삭제하시겠습니까?")) {
	 			var comSubmit = new ComSubmit();
	 			comSubmit.setUrl("/mgmt/customer/qna/delete");
	 			comSubmit.addParam("arrIdx", arrIdx);
	 			comSubmit.submit();
	        }
			
		});
		$("#btnDeleteAll").click(function(){
			var num = '${fn:length(delist)}';
		    if (confirm("총 " + num + "건의 문의 내역을 삭제 하시겠습니까?")) {
	 			var comSubmit = new ComSubmit();
	 			comSubmit.setUrl("/mgmt/customer/qna/deleteAll");
	 			comSubmit.submit();
	        }
			
		});
		$("#chkAll").click(function(){ // 전체 선택 버튼 클릭시
			var checked = $(this).prop("checked");
		
			if(checked){
				$(":checkbox[name=chkDel]").prop("checked", true);
			} else {
				$(":checkbox[name=chkDel]").prop("checked", false);
			}
		});

    	
        $('tr[data-href]').on("dblclick", function() {
            document.location = $(this).data('href');
        }).css({
            'cursor': 'pointer'
        });

        $('tr[data-href]').on("doubletap", function() {
            document.location = $(this).data('href');
        });

        $('[name=frmSearch]').submit(function() {
        	location.href = "/mgmt/customer/qna";
        })
		$('#btnExcelDown').click(function(e){
			if($("#reason").val()=="") {
				alert("사유를 입력해 주세요.");
				return;
			}
			$("#frmExcelDown").submit();
			$('#detailExcelModal').modal('hide');
			
		});
    });
    
	function fn_openCustomerDetail(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/qna/view");
	    comSubmit.addParam("idx", obj.data("idx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		
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
	function excelDownload(){
		$('#detailExcelModal').modal('show');
	}
	
	
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/qna");
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
		if("${!empty start_dtm}"=="true"){
			comSubmit.addParam("start_dtm", "${start_dtm}");
		}
		if("${!empty end_dtm}"=="true"){
			comSubmit.addParam("end_dtm", "${end_dtm}");
		}
		if("${!empty lang}"=="true"){
			comSubmit.addParam("lang", "${lang}");
		}
		if("${!empty reply_status}"=="true"){
			comSubmit.addParam("reply_status", "${reply_status}");
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