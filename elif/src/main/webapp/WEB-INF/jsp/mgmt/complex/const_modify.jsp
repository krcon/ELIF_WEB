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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/const_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="const" />
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
									<h4 class="card-title ">${code_type=='krice'?'KR산업 공사단지':'계룡건설 공사단지'} 관리 수정</h4>
								</div>
								<div class="card-body">
									
									<form id="write" action="/mgmt/complex/${code_type}/const_proc" method="post" encType="multipart/form-data">
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
											<div class="col-sm-10 col-lg-5">
												<div class="form-group bmd-form-group">
													<div class="input-group">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">총</span>
														</div>
														<input type="text" disabled class="form-control" value="${map.households}" >
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">세대</span>
														</div>
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
											<label class="col-sm-2 col-form-label" for="sllt_info_mibl_ym">입주예정 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="hidden" name="sllt_info_mibl_ym" class="form-control" value="${map.sllt_info_mibl_ym}">
													<c:set var="now" value="<%=new java.util.Date()%>" />
													<c:set var="syear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
													<c:set var="smonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set> 
													<select name="const_year" class="selectpicker" data-style="select-with-transition">
													<c:forEach var="i" begin="${syear}" end="${syear+10}" step="1" >
													<option value="${i}" ${!empty map.const_year?(map.const_year==i?'selected':''):''}>${i}</option>
													</c:forEach>
													</select>
													<select name="const_month" class="selectpicker" data-style="select-with-transition">
													<c:forEach var="i" begin="1" end="12" step="1" >
													<c:set var="nowmonth"><fmt:formatNumber type="number" minIntegerDigits="2" maxIntegerDigits="2" value="${i}" /></c:set>
													<option value="${nowmonth}" ${!empty map.const_month?(map.const_month==nowmonth?'selected':''):(smonth==nowmonth?'selected':'')}>${nowmonth}</option>
													</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="title_sub">썸네일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<ul class="file_area mb-0" data-filegroup="pdf">
														<li class="item-file">
															<c:if test="${not empty map.const_thumb_name}">
															<div class="upload-display"><div class="upload-thumb-wrap"><img src="${map.const_thumb_path}${map.const_thumb_name}" class="upload-thumb"></div></div>
															</c:if>
															<span class="bmd-form-group">	
																<div class="input-group">
																	<input type="file" name="const_thumb" id="thumb" class="upload-hidden" accept=".jpg,.jpeg,.gif,.png">
																	<input type="text" name="const_thumb_old" value="${map.const_thumb_origin}" class="form-control upload-name" placeholder="업로드" readonly="readonly" title="썸네일" data-title="썸네일을">
																	<span class="input-group-btn">
																		<label for="thumb" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																		<c:choose>
																		<c:when test="${map.const_status=='Y'}">
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
											<label class="col-sm-2 col-form-label" for="url">대지 면적 <span></span></label>
											<div class="col-lg-5 col-sm-10 ">
												<div class="form-group bmd-form-group">
													<div class="input-group">
														<input type="text" name="const_g_area" class="form-control text-right" required value="${map.const_g_area}" maxlength="100" title="대지 면적" data-title="대지 면적을">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">m<sup>2</sup></span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="const_view_status" value="Y" ${!empty map.const_view_status ? ('Y'==map.const_view_status?'checked':''):'checked' }> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="const_view_status" value="N" ${'N'==map.const_view_status?'checked':'' }> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<c:if test="${map.const_reg_nm!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="START_DTM">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.const_reg_nm }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">등록일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="const_reg_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.const_reg_dtm }"/>
														<input type="text" class="form-control" disabled value="${const_reg_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<c:if test="${map.const_upda_nm!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_upda_nm">수정자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.const_upda_nm }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">수정일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="const_upda_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.const_upda_dtm }"/>
														<input type="text" class="form-control" disabled value="${const_upda_dtm }" />
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
												<c:when test="${map.const_status=='Y'}">
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
			if(confirm('${map.const_status=='Y'?'수정':'추가'}하시겠습니까?')){
				if (checkValidation(frm)) {
					var isOk = true;
					var arrFile = $(".upload-name");
			
					$.each(arrFile, function(index, item){
						var extList = $(item).closest('.input-group').find('[type=file]').attr('accept').replace(/\./g,'').split(',');
						if($(item).val().length > 0){
							var ext = $(item).val().split('.').pop().toLowerCase();
							if($.inArray(ext, extList) == -1) {
								alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
								isOk = false;
								return false;
							}
						}
					});
					if(!isOk) return false;
					$('[name=sllt_info_mibl_ym]').val($('[name=const_year]').val()+''+$('[name=const_month]').val());
					var submitHtml = true;
					if (submitHtml) {
						
						$('form#' + frm).submit();
					}
				}
			}
		}

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
		function fn_deleteBoard() {
			var pjt_cd = "${map.pjt_cd}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/complex/${code_type}/const_deleteProc");
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
		$.ajaxSetup({
			headers: {
				'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
			}
		});
	</script>
</body>

</html>