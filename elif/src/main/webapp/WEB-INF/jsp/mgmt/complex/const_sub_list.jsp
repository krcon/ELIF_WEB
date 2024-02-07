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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/const_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="const_sub" />
			</jsp:include>
			<!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-icon card-header-rose">
									<div class="card-icon">
										<i class="material-icons">assignment</i>
									</div>
									<h4 class="card-title ">${code_type=='krice'?'KR산업 공사단지':'계룡건설 공사단지'} 관리 상세정보 리스트</h4>
								</div>
								<div class="card-body">
									
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<th width="15%" class="column-title text-center">등록일자</th>
													<th width="15%" class="column-title text-center">공정률</th>
													<th width="" class="column-title text-center">상세정보 </th>
													<th width="10%" class="column-title text-center">노출여부</th>
													<th width="10%" class="column-title text-center">파일수</th>
													<th width="16%" class="column-title text-center">작성자</th>
													<th width="15%" class="column-title text-center">등록일시</th>
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
														<td class="text-center">${row.const_proc_dt}</td>
														<td class="text-center">${row.const_proc_rate}%</td>
														<td class="text-center">
															<a href="#none" data-modpjt_cd="${row.pjt_cd }" data-const_proc_dt="${row.const_proc_dt }">상세정보</a>
														</td>
														<td class="text-center">
															<button type="button" class="btn-flag-status btn-normal" data-pjt_cd="${row.pjt_cd}" data-const_proc_dt="${row.const_proc_dt }">${row.status }</button>
														</td>
														<td class="text-center">${ct:getMaskedName(row.fileCount)}</td>
														<td class="text-center">${ct:getMaskedName(row.const_regpsn_nm)}</td>
														<td class="text-center">
														<fmt:formatDate var="fst_reg_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.fst_reg_dtm }"/>
														${fst_reg_dtm }
														</td>
													</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="13" class="text-center">등록된 글이 없습니다.</td>
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
												<a href="javascript:;" onclick="fn_openBoardWrite(this)" class="btn btn-success">상세정보 등록</a>
												<a href="javascript:;" onclick="fn_openBoardList(this)" class="btn btn-success">공사 단지 목록</a>
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
	(function($){
		$("a[data-pjt_cd]").on("click", function(e){ //제목 
			e.preventDefault();
			fn_openBoardDetail($(this));
		});
		$("a[data-modpjt_cd]").on("click", function(e){ //제목 
			e.preventDefault();
			fn_openBoardUpdate($(this));
		});
		$("#btnSearch").click(function(){
			$("form[name=search]").submit();
		});
		$(document).on('click','.btn-flag-status',function(){
			if(confirm('수정하시겠습니까?')){
				var thisEle = $(this);
				var status =thisEle.text();
				if(status=='Y'){
					status = 'N';
				}else{
					status = 'Y';
				}
				var jsonData = {'pjt_cd':thisEle.data('pjt_cd'),'const_proc_dt':thisEle.data('const_proc_dt'),'status':status}
				$.ajax({
					type: 'POST',
					url: '/mgmt/complex/const_sub_status',
					data: jsonData,
					dataType: 'json',
					async: true,
					cache: false,
					success: function (data) {
						console.log(data);
						if(data.result==true){
							thisEle.html(status);
							alert('변경되었습니다.');
						}
					},
					error: function (xhr, status, error) {
						alert('관리자에게 문의하시기 바랍니다.');
					}
				});
			}
		});
	})(jQuery);

	function fn_openBoardList() {
		if(confirm('목록으로 이동하시겠습니까?')){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/complex/${code_type}/const_list");
			comSubmit.addParam("currentPageNo", "${currentPageNo}");
			if ("${!empty target}" == "true") {
				comSubmit.addParam("target", "${target}");
			}
			if ("${!empty keyword}" == "true") {
				comSubmit.addParam("keyword", "${keyword}");
			}
			if ("${!empty param.gubun}" == "true") {
				comSubmit.addParam("gubun", "${param.gubun}");
			}
			comSubmit.submit();
		}
	}
	function fn_openBoardWrite(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/const_sub_modify/${pjt_cd}");
		comSubmit.submit();
	}
	function fn_openBoardDetail(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/view");
		comSubmit.addParam("pjt_cd", obj.data("pjt_cd"));
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

	function fn_openBoardUpdate(obj) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/const_sub_modify/${pjt_cd}");
		comSubmit.addParam("const_proc_dt", obj.data("const_proc_dt"));
		comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if ("${!empty target}" == "true") {
			comSubmit.addParam("target", "${target}");
		}
		if ("${!empty keyword}" == "true") {
			comSubmit.addParam("keyword", "${keyword}");
		}
		if ("${!empty param.gubun}" == "true") {
			comSubmit.addParam("gubun", "${param.gubun}");
		}
		comSubmit.submit();
	}

	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/const_sub_list/${pjt_cd}");
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