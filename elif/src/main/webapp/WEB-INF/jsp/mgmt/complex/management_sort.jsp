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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/${param.section}_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
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
									<c:choose>
									<c:when test="${param.section=='sales'}"><c:set var="thisname" value="분양"/></c:when>
									<c:when test="${param.section=='const'}"><c:set var="thisname" value="공사"/></c:when>
									<c:when test="${param.section=='occupancy'}"><c:set var="thisname" value="입주"/></c:when>
									</c:choose>
									<h4 class="card-title ">${code_type=='krice'?'KR산업 '+=thisname+='단지':'계룡건설 '+=thisname+='단지'} 정렬</h4>
								</div>
								<div class="card-body">
									
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<th width="10%" class="column-title text-center">단지코드</th>
													<th class="column-title text-center">단지명 </th>
													<th width="10%" class="column-title text-center">진행상태</th>
													<th width="20%" class="column-title text-center">작성일</th>
													<th width="10%" class="column-title text-center">등록일</th>
												</tr>
											</thead>
											<tbody>
											<c:choose>
												<c:when test="${fn:length(list) > 0}">
													<c:set var="num" value="${total }"/>
													<c:forEach items="${list }" var="row">
													<tr>
														<td class="text-center">
															${num }
															<c:set var="num" value="${num-1}"/>
														</td>
														<td class="text-center">
															<a href="modify.do?pjt_cd=${row.pjt_cd }" data-modpjt_cd="${row.pjt_cd }">${row.pjt_cd}</a>
														</td>
														<td>
															<a href="modify.do?pjt_cd=${row.pjt_cd }" data-modpjt_cd="${row.pjt_cd }">${row.pjt_nm }</a>
														</td>
														<td class="text-center">${row.progress_name }</td>
														<td class="text-center">
															<div class="input-group">
															<fmt:formatDate var="main_sort_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${row.main_sort_dtm }"/>
															<input type="text" name="main_sort_dtm" data-pjt_cd='${row.pjt_cd }' class="form-control datefulltimepicker" value="${main_sort_dtm }" />
															<div class="input-group-append">
																<a href="javascript:;" class="btn btn-info btn-sm btn-modify" >수정</a>
															</div>
															</div>
															
														</td>
														<td class="text-center">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.fst_reg_dtm }"/>
														${crea_dtm }
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
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
	$(document).on('click','.btn-modify',function(){
		if(confirm('수정하시겠습니까?')){
			var thisEle = $(this).closest('td').find('[name=main_sort_dtm]');
			var jsonData = {'pjt_cd':thisEle.data('pjt_cd'),'main_sort_dtm':thisEle.val()}
			$.ajax({
				type: 'POST',
				url: 'management_sort_proc',
				data: jsonData,
				dataType : "json",
				
				async: true,
				cache: false,
				success: function (data) {
					console.log(data);
					if(data.result==true){
						thisEle.html(status);
						alert('변경되었습니다.');
					}else{
						alert('변경오류입니다.');
					}
				},
				error: function (xhr, status, error) {
					alert('관리자에게 문의하시기 바랍니다.');
				}
			});
		}
	});

	</script>
</body>

</html>