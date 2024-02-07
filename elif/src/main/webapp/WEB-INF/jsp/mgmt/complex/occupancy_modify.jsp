<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="../include/head.jsp"%>
	<link href="/resources/manager/custom/summernote/summernote.css" rel="stylesheet">
</head>

<body class="">
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/occupancy_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="occupancy" />
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
									<h4 class="card-title ">${code_type=='krice'?'KR산업 입주단지':'계룡건설 입주단지'} 관리 수정</h4>
								</div>
								<div class="card-body">
									
									<form id="write" action="/mgmt/complex/${code_type}/occupancy_proc" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" id="pjt_cd" name="pjt_cd" value="${map.pjt_cd }">
										<input type="hidden" name="currentPageNo" value="${param.currentPageNo }">
										<input type="hidden" name="target" value="${param.target }">
										<input type="hidden" name="keyword" value="${param.keyword }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="lang">단지코드 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.pjt_cd}">
												</div>
											</div>
										</div>
										
										<div class="row">
											<label class="col-sm-2 col-form-label" for="name">단지명 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.pjt_nm}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">유형 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.housing_name}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="region">지역 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.region_name}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="location">위치 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.sllt_info_loc}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="households">세대수 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div class="input-group">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">총</span>
														</div>
														<input type="number" disabled class="form-control" value="${map.households}" >
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="tel">연락처 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.sllt_info_addr_tel}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="area">전용면적 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.area}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">규모 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" disabled class="form-control" value="${map.const_scope}">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="mv_date">입주 예정월 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="hidden" name="mv_date" class="form-control" value="${map.mv_date}">
													<c:set var="now" value="<%=new java.util.Date()%>" />
													<c:set var="syear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
													<c:set var="smonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set> 
													<select name="mv_date_year" class="selectpicker" data-style="select-with-transition">
													<option value="">선택</option>
													<c:forEach var="i" begin="${syear}" end="${syear+10}" step="1" >
													<option value="${i}" ${!empty map.mv_date_year?(map.mv_date_year==i?'selected':''):''}>${i}</option>
													</c:forEach>
													</select>
													<span class="input-comment mr-3">년</span> 
													<select name="mv_date_month" class="selectpicker" data-style="select-with-transition">
													<option value="">선택</option>
													<c:forEach var="i" begin="1" end="12" step="1" >
													<c:set var="nowmonth"><fmt:formatNumber type="number" minIntegerDigits="2" maxIntegerDigits="2" value="${i}" /></c:set>
													<option value="${nowmonth}" ${!empty map.mv_date_month?(map.mv_date_month==nowmonth?'selected':''):''}>${nowmonth}</option>
													</c:forEach>
													</select>
													<span class="input-comment">월</span> 
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="url">입주 개시일 <span></span></label>
											<div class="col-sm-10 ">
												<div class="form-group bmd-form-group">
													<input type="text" name="mv_cert_date" value="${map.mv_cert_date}" class="form-control datepicker" title="입주증 발금 게시일" data-title="입주증 발금 게시일을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="title_sub">썸네일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<ul class="file_area mb-0" data-filegroup="pdf">
														<li class="item-file">
															<c:if test="${not empty map.mv_thumb_name}">
															<div class="upload-display"><div class="upload-thumb-wrap"><img src="${map.mv_thumb_path}${map.mv_thumb_name}" class="upload-thumb"></div></div>
															</c:if>
															<span class="bmd-form-group">	
																<div class="input-group">
																	<input type="file" name="mv_thumb" id="thumb" class="upload-hidden" accept=".jpg,.jpeg,.gif,.png">
																	<input type="text" name="mv_thumb_old" value="${map.mv_thumb_origin}" class="form-control upload-name" placeholder="업로드" readonly="readonly" title="썸네일" data-title="썸네일을">
																	<span class="input-group-btn">
																		<label for="thumb" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																		<c:choose>
																		<c:when test="${map.occupancy_status=='Y'}">
																		<button type="button" class="btn btn-primary btn-fab app-file-remove"><i class="fa fa-close"></i></button>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																		</c:choose>
																	</span>
																</div>
															</span>
														</li>
													</ul>
													<div class="comment mt-0">※ 썸네일 권장 사이즈 : 가로 360 * 세로 210px, 파일 형식: JPG,JPEG,PNG / 용량: 1MB 이하</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="url">사전점검 방문 신청 기간 <span></span></label>
											<div class="col-lg-3 col-sm-5 ">
												<div class="form-group bmd-form-group">
													<input type="text" name="mv_pre_start_date" value="${map.mv_pre_start_date}" class="form-control" title="사전점검 방문 신청 기간" data-title="사전점검 방문 신청 기간을">
												</div>
											</div>
											<div class="col-lg-3 col-sm-5 ">
												<div class="form-group bmd-form-group">
													<input type="text" name="mv_pre_end_date" value="${map.mv_pre_end_date}" class="form-control" title="사전점검 방문 신청 기간" data-title="사전점검 방문 신청 기간을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="title_sub">사전점검 안내문 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<ul class="file_area mb-0" data-filegroup="pdf">
														<li class="item-file">
															<c:if test="${not empty map.mv_pre_file_name}">
															<div class="upload-display"><div class="upload-thumb-wrap"><img src="${map.mv_pre_file_path}${map.mv_pre_file_name}" class="upload-thumb"></div></div>
															</c:if>
															<span class="bmd-form-group">	
																<div class="input-group">
																	<input type="file" name="mv_pre_file" id="mv_pre_file" class="upload-hidden" accept=".gif,.jpg,.png,.pdf,.doc,.docx,.hwp,.xls,.xlsx,.ppt,.pptx,.zip">
																	<input type="text" name="mv_pre_file_old" value="${map.mv_pre_file_origin}" class="form-control upload-name" placeholder="업로드" readonly="readonly" title="사전점검 안내문" data-title="사전점검 안내문을">
																	<span class="input-group-btn">
																		<label for="mv_pre_file" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																		<c:choose>
																		<c:when test="${map.occupancy_status=='Y'}">
																		<button type="button" class="btn btn-primary btn-fab app-file-remove"><i class="fa fa-close"></i></button>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																		</c:choose>
																	</span>
																</div>
															</span>
														</li>
													</ul>
													<div class="comment mt-0">※ 파일 형식: 모든파일(이미지,문서,압축) / 용량: 3MB 이하</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="title_sub">입주 안내문 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<ul class="file_area mb-0" data-filegroup="pdf">
														<li class="item-file">
															<c:if test="${not empty map.mv_file_doc_name}">
															<div class="upload-display"><div class="upload-thumb-wrap"><img src="${map.mv_file_doc_path}${map.mv_file_doc_name}" class="upload-thumb"></div></div>
															</c:if>
															<span class="bmd-form-group">	
																<div class="input-group">
																	<input type="file" name="mv_file_doc" id="mv_file_doc" class="upload-hidden" accept=".gif,.jpg,.png,.pdf,.doc,.docx,.hwp,.xls,.xlsx,.ppt,.pptx,.zip">
																	<input type="text" name="mv_file_doc_old" value="${map.mv_file_doc_origin}" class="form-control upload-name" placeholder="업로드" readonly="readonly" title="입주 안내문" data-title="입주 안내문을">
																	<span class="input-group-btn">
																		<label for="mv_file_doc" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																		<c:choose>
																		<c:when test="${map.occupancy_status=='Y'}">
																		<button type="button" class="btn btn-primary btn-fab app-file-remove"><i class="fa fa-close"></i></button>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																		</c:choose>
																	</span>
																</div>
															</span>
														</li>
													</ul>
													<div class="comment mt-0">※ 파일 형식: 모든파일(이미지,문서,압축) / 용량: 3MB 이하</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="url">입주예약 신청기간 <span></span></label>
											<div class="col-lg-3 col-sm-5 ">
												<div class="form-group bmd-form-group">
													<input type="text" name="mv_start_date" value="${map.mv_start_date}" class="form-control" title="입주예약 신청기간" data-title="입주예약 신청기간을">
												</div>
											</div>
											<div class="col-lg-3 col-sm-5 ">
												<div class="form-group bmd-form-group">
													<input type="text" name="mv_end_date" value="${map.mv_end_date}" class="form-control" title="입주예약 신청기간" data-title="입주예약 신청기간을">
												</div>
											</div>
										</div>

										<div class="row">
											<label class="col-sm-2 col-form-label">단지사진 <span></span></label>
											<div class="col-sm-10 col-lg-5">
												<div class="row fileupload-wrap">
													<div class="col-md-12 col-xs-12">
															<div class="card pt-4">
																<div class="card-body add_img_area">
																	<ul class="file_area" data-group="occupancy_file" data-type="file">
																		<c:choose>
																			<c:when test="${fn:length(occupancy_file)>0}">
																				<c:forEach var="row" items="${occupancy_file }" varStatus="var">
																					<li class="item-file">
																						<c:choose>
																							<c:when test="${item=='file' }">
																								<div class="upload-display">
																									<div class="upload-thumb-wrap">
																										<i class="fa fa-file-o"></i>
																									</div>
																								</div>
																							</c:when>
																							<c:otherwise>
																								<div class="upload-display">
																									<a href="${row.path_name }${row.stored_file_name }" class="upload-thumb-wrap imgpopup"><img src="${row.path_name }${row.stored_file_name }" class="upload-thumb"></a>
																								</div>
																							</c:otherwise>
																						</c:choose>
																						
																						<div class="input-group">
																							<input type="hidden" id="occupancy_filepjt_cd" name="occupancy_filepjt_cd_${var.index }" class="hidpjt_cd" value="${row.pjt_cd }">
																								<input type="file" name="occupancy_file_${var.index }" id="occupancy_file_${var.index }" class="upload-hidden" accept=".jpg,.jpeg,.gif,.png"> 
																								<input type="text" class="form-control upload-name" value="${row.original_file_name }" placeholder="업로드" readonly="readonly" ${required}> 
																								<span class="input-group-btn"> 
																								<label for="occupancy_file_${var.index }" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																								<button type="button" data-idx="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																							</span>
																						</div>
																					</li>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<li class="item-file">
																					<div class="input-group">
																						<input type="file" name="occupancy_file_0" id="occupancy_file_0" class="upload-hidden" accept=".jpg,.jpeg,.gif,.png" <%-- ${itemName=="thumb"?'required':''} --%> title="${itemTitle }" data-title="${itemTitle }를(을)">
																						<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly"> 
																						<span class="input-group-btn"> 
																						<label for="occupancy_file" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																						
																						</span>
																					</div>
																				</li>
																			</c:otherwise>
																		</c:choose>
																	</ul>
																	<div class="form-group bmd-form-group">
																		<button type="button" id="btnAddFile2" class="btn btn-success btn-sm">파일 추가</button>
																<div class="comment mt-0">※ 파일 수정은 삭제 후 추가해 주세요.</div>
																	</div>
																</div>
															</div>
																<div class="comment mt-0">※ 이미지 권장 사이즈 : 가로 1200 * 세로 700px, 파일 형식: JPG,JPEG,PNG / 용량: 1MB 이하</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="occupancy_view_status" value="Y" ${!empty map.occupancy_view_status ? ('Y'==map.occupancy_view_status?'checked':''):'checked' }> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="occupancy_view_status" value="N" ${'N'==map.occupancy_view_status?'checked':'' }> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<c:if test="${map.mv_reg_nm!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="START_DTM">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.mv_reg_nm }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">등록일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="mv_reg_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.mv_reg_dtm }"/>
														<input type="text" class="form-control" disabled value="${mv_reg_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<c:if test="${map.mv_upda_nm!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="mv_upda_nm">수정자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.mv_upda_nm }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">수정일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="mv_upda_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.mv_upda_dtm }"/>
														<input type="text" class="form-control" disabled value="${mv_upda_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</form>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-2">

											</div>
											<div class="col-10">
												<c:choose>
												<c:when test="${map.occupancy_status=='Y'}">
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												<a href="javascript:;" class="btn btn-danger" id="delete">삭제</a>
												</c:when>
												<c:otherwise>
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">등록</a> 
												</c:otherwise>
												</c:choose>
												<a href="javascript:;" id="list" class="btn btn-info">목록 </a>
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
	<script src="/resources/manager/custom/uploadfile.js"></script>
	<script src="/resources/manager/custom/summernote/summernote.js"></script>
	<script src="/resources/manager/custom/summernote/lang/summernote-ko-KR.js"></script>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
	//사전점검 방문 신청 기간
	$('[name=mv_pre_start_date]').datetimepicker({
	format: 'YYYY-MM-DD HH:mm:ss',
	icons: {
		time: "fa fa-clock-o",
		date: "fa fa-calendar",
		up: "fa fa-chevron-up",
		down: "fa fa-chevron-down",
		previous: 'fa fa-chevron-left',
		next: 'fa fa-chevron-right',
		today: 'fa fa-screenshot',
		clear: 'fa fa-trash',
		close: 'fa fa-remove'
	}
	});

	$('[name=mv_pre_end_date]').datetimepicker({
	useCurrent: false,
	format: 'YYYY-MM-DD HH:mm:ss',
	icons: {
		time: "fa fa-clock-o",
		date: "fa fa-calendar",
		up: "fa fa-chevron-up",
		down: "fa fa-chevron-down",
		previous: 'fa fa-chevron-left',
		next: 'fa fa-chevron-right',
		today: 'fa fa-screenshot',
		clear: 'fa fa-trash',
		close: 'fa fa-remove'
	}
	});
	$("[name=mv_pre_start_date]").on("dp.change", function (e) {
	$('[name=mv_pre_end_date]').data("DateTimePicker").minDate(e.date);
	});
	$("[name=mv_pre_end_date]").on("dp.change", function (e) {
	$('[name=mv_pre_start_date]').data("DateTimePicker").maxDate(e.date);
	});

	//입주예약 신청기간
	$('[name=mv_start_date]').datetimepicker({
	format: 'YYYY-MM-DD HH:mm:ss',
	icons: {
		time: "fa fa-clock-o",
		date: "fa fa-calendar",
		up: "fa fa-chevron-up",
		down: "fa fa-chevron-down",
		previous: 'fa fa-chevron-left',
		next: 'fa fa-chevron-right',
		today: 'fa fa-screenshot',
		clear: 'fa fa-trash',
		close: 'fa fa-remove'
	}
	});

	$('[name=mv_end_date]').datetimepicker({
	useCurrent: false,
	format: 'YYYY-MM-DD HH:mm:ss',
	icons: {
		time: "fa fa-clock-o",
		date: "fa fa-calendar",
		up: "fa fa-chevron-up",
		down: "fa fa-chevron-down",
		previous: 'fa fa-chevron-left',
		next: 'fa fa-chevron-right',
		today: 'fa fa-screenshot',
		clear: 'fa fa-trash',
		close: 'fa fa-remove'
	}
	});
	$("[name=mv_start_date]").on("dp.change", function (e) {
	$('[name=mv_end_date]').data("DateTimePicker").minDate(e.date);
	});
	$("[name=mv_end_date]").on("dp.change", function (e) {
	$('[name=mv_start_date]').data("DateTimePicker").maxDate(e.date);
	});
	
	var main_count = 0;
	main_count = '${MAIN_COUNT }';
	if ($.isNumeric(main_count)) {
		main_count = parseInt(main_count);
	}


	$("#list").on("click", function (e) { //목록 버튼
		e.preventDefault();
		fn_openBoardList();
	});


	$("#delete").on("click", function (e) { //삭제 버튼
	
		if (confirm("삭제하시겠습니까?")) {
			e.preventDefault();
			fn_deleteBoard();
		}
	});
	$("a[name^='delete']").on("click", function (e) { //파일 삭제 버튼
		e.preventDefault();
		fn_deleteFile($(this));
	});

	<c:if test="${not empty param.ALERT }">
		alert('${param.ALERT}')
	</c:if>

	function doSubmit(frm) {
		if (checkValidation(frm)) {
			var isOk = true;
			var arrFile = $(".upload-name");
			
			$.each(arrFile, function(index, item){
				var extList = $(item).closest('.input-group').find('[type=file]').attr('accept').replace(/\./g,'').split(',');
				if($(item).val().length > 0){
					var ext = $(item).val().split('.').pop().toLowerCase();
					console.log(ext);
					console.log(extList);
					if($.inArray(ext, extList) == -1) {
						alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
						isOk = false;
						return false;
					}
				}
			});
			if(!isOk) return false;
			$('[name=mv_date]').val($('[name=mv_date_year]').val()+''+$('[name=mv_date_month]').val());
			var submitHtml = true;
			if (submitHtml) {
				
				if(confirm('${map.occupancy_status=='Y'?'수정':'추가'}하시겠습니까?')){
					$('form#' + frm).submit();
				}
			}
			
		}
	}

	function fn_openBoardList() {
		if(confirm('목록으로 이동하시겠습니까?')){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/complex/${code_type}/occupancy_list");
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
	function fn_deleteBoard() {
		var pjt_cd = "${map.pjt_cd}";
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/occupancy_deleteProc");
		if ("${!empty target}" == "true") {
			comSubmit.addParam("target", "${target}");
		}
		if ("${!empty keyword}" == "true") {
			comSubmit.addParam("keyword", "${keyword}");
		}
		if ("${!empty param.gubun}" == "true") {
			comSubmit.addParam("gubun", "${param.gubun}");
		}
		comSubmit.addParam("pjt_cd", pjt_cd);
		comSubmit.submit();

	}
	$(".delete-file").click(function () {
		var deleteFile = $(this);
		if (confirm("파일을 삭제하시겠습니까?\n삭제후에는 복구할 수 없습니다.")) {
			$.post("/mgmt/complex/fileDelete", { idx: $(this).data('idx') }).done(function (data) {
				if (data.result == 'ok') {
					if($('#btnAddFile2').length>0){
						if (deleteFile.parents('.add_img_area').find('.file_area').children('li').length < 1) {
							deleteFile.parents('.add_img_area').find('#btnAddFile2').click();
						}
						deleteFile.parents('.item-file').remove();
					}else{
						deleteFile.parents('.item-file').find('.upload-name').val('');
						deleteFile.parents('.item-file').find('.upload-display').remove();
						deleteFile.parents('.item-file').find('.hidpjt_cd').remove();
						deleteFile.parents('.item-file').find('.delete-file').remove();
					}
					alert('삭제 되었습니다.');

					//window.location.href="";
				} else {
					alert("파일이 없거나 삭제된 파일입니다.");
				}
			}).fail(function () {
				alert("관리자에게 문의하시기 바랍니다.");
			});
		}
	});
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
	</script>
</body>

</html>