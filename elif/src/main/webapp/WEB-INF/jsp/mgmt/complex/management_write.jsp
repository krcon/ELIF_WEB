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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/management_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="list" />
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
									<h4 class="card-title ">${code_type=='krice'?'KR산업 단지':'계룡건설 단지'}관리 추가</h4>
								</div>
								<div class="card-body">
									<form method="post" id="write" name="frmSubmit" action="/mgmt/complex/${code_type}/management_writeProc" enctype="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<div class="row">
											<label class="col-sm-2 col-form-label" for="lang">단지코드 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<select name="pjt_cd" class="selectpicker" required data-style="select-with-transition">
													<option value="">선택</option>
													<c:choose>
														<c:when test="${fn:length(project_list) > 0}">
															<c:forEach items="${project_list }" var="row">
															<option value="${row.pjt_cd}">${row.pjt_mrkg_nm}</option>
															</c:forEach>
														</c:when>
													</c:choose>
													</select>
												</div>
											</div>
										</div>
										
										<div class="row">
											<label class="col-sm-2 col-form-label" for="name">단지명 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="pjt_nm" class="form-control" required value="" maxlength="100" title="단지명" data-title="단지명을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">유형 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<c:choose>
													<c:when test="${fn:length(complex_type) > 0}">
														<c:forEach items="${complex_type }" var="row" varStatus="status">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="radio" name="housing" value="${row.code_id}" ${status.count==1?'checked':''}> ${row.code_name}
																<span class="circle">
																	<span class="check"></span>
																</span>
															</label>
														</div>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="region">지역 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<select name="region" class="selectpicker" data-style="select-with-transition">
														<c:choose>
															<c:when test="${fn:length(complex_region) > 0}">
																<c:forEach items="${complex_region }" var="row" varStatus="status">
																<option value="${row.code_id}">${row.code_name}</option>
																</c:forEach>
															</c:when>
														</c:choose>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="location">위치 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="sllt_info_loc" class="form-control" required value="" maxlength="100" title="위치" data-title="위치를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="households">세대수 <span></span></label>
											<div class="col-sm-10 col-lg-5">
												<div class="form-group bmd-form-group">
													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">총</span>
														</div>
														<input type="text" name="households" class="form-control numbercommaonly" onkeyup="numberWithCommas(this)" required value="" maxlength="100" title="세대수" data-title="세대수를" placeholder="숫자만 입력">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">세대</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="tel">연락처</label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="sllt_info_addr_tel" class="form-control" value="" maxlength="100" title="연락처" data-title="연락처를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="area">전용면적 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="area" class="form-control" required value="" maxlength="100" title="전용면적" data-title="전용면적을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">규모 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="const_scope" class="form-control" required value="" maxlength="100" title="규모" data-title="규모를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">진행상태 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<c:choose>
													<c:when test="${fn:length(complex_progress) > 0}">
														<c:forEach items="${complex_progress }" var="row" varStatus="status">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="radio" name="progress" value="${row.code_id}" ${status.count==1?'checked':''}> ${row.code_name}
																<span class="circle">
																	<span class="check"></span>
																</span>
															</label>
														</div>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</div>
										<div class="row" style="display:none;">
											<label class="col-sm-2 col-form-label"><b class="text-warning">미분양건 동시 노출</b>  <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="progress_const" value="Y"> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="progress_const" value="N" checked> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">입주 예약 신청 유의사항 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<textarea name="reservation_comment" class="form-control" style="resize: none; height: 100px;"></textarea>
												</div>
												<div class="comment mt-0">* 해당 내용은 마이 엘리프 내 입주 예약 신청 페이지 하단에 노출되는 항목입니다.</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">사전점검 방문예약 신청 유의사항 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<textarea name="visit_comment" class="form-control" style="resize: none; height: 100px;"></textarea>
												</div>
												<div class="comment mt-0">* 해당 내용은 마이 엘리프 내 사전예약 방문 예약 신청 페이지 하단에 노출되는 항목입니다.</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="use_yn" value="Y" checked=""> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="use_yn" value="N"> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>

									</form>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-2">

											</div>
											<div class="col-10">
											<a href="javascript:;" class="btn btn-info" onclick="doSubmit('write');">등록</a>
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
	<c:if test="${not empty param.ALERT }">
		alert('${param.ALERT}')
	</c:if>
	$('.texteditor').summernote(snOptions);
	
	function progress_const(){
		if($('[name=progress]:checked').val()=='RV02202'){
			$('[name=progress_const]').closest('.row').show();
		}else{
			$('[name=progress_const][value="N"]').prop('checked',true).closest('.row').hide();
		}
		
	}
	progress_const();
	$('[name=progress]').on('change',function(){
		progress_const();
	});
	(function($){
		$('[data-detect="mb"]').removeAttr('required');
		$('[name=gubun_web]').change(function(){
			if($(this).is(':checked')){
				$('[data-detect="pc"]').addAttr('required');
			}else{
				$('[data-detect="pc"]').removeAttr('required');
			}
		});
		$('[name=gubun_mobile]').change(function(){
			if($(this).is(':checked')){
				$('[data-detect="mb"]').addAttr('required');
			}else{
				$('[data-detect="mb"]').removeAttr('required');
			}
		});

		$('[name=pjt_cd]').change(function(){
			if($(this).val().length>0){
				
			$.ajax({
				type : "POST",
				url : "/mgmt/complex/projectAjax",
				cache : false,
				data : {'pjt_cd':$('[name=pjt_cd]').val(),'code_type':'${code_type}'},
				success : function(data){
					if(data.result=='ok'){
						$('[name=pjt_nm]').val(slashTO(data.project.pjt_mrkg_nm));
						var zipcode = "";
						if(data.project.pjt_zpcd!=''){
							zipcode = '('+data.project.pjt_zpcd+') ';
						}
						var pjt_ftn_addr = "";
						if(data.project.pjt_ftn_addr!=''&&data.project.pjt_ftn_addr!=null){
							pjt_ftn_addr = data.project.pjt_ftn_addr;
						}
						var pjt_dtl_addr = "";
						if(data.project.pjt_dtl_addr!=''&&data.project.pjt_dtl_addr!=null){
							pjt_dtl_addr = data.project.pjt_dtl_addr;
						}
						$('[name=sllt_info_loc]').val(slashTO(zipcode + pjt_ftn_addr+' '+pjt_dtl_addr));
						$('[name=households]').val(data.project.hhldno);
						$('[name=sllt_info_addr_tel]').val(slashTO(data.project.sit_caddr));
						console.log(data.project.sllt_knd_cd);
						if(data.project.sllt_knd_cd==''){
							$('[name=housing][value=RV02001]').prop('checked',true);
						}else if(data.project.sllt_knd_cd=='HS01501'){
							$('[name=housing][value=RV02001]').prop('checked',true);
						}else if(data.project.sllt_knd_cd=='HS01503'){
							$('[name=housing][value=RV02002]').prop('checked',true);
						}else{
							$('[name=housing][value=RV02003]').prop('checked',true);
						}
						var const_scope = '';
						var const_slash = '';
						if(data.project.blno!=''){
							const_scope = const_scope + const_slash + data.project.blno+'동';
							const_slash = ' / ';
						}
						if(data.project.hhldno!=''){
							const_scope = const_scope + const_slash + data.project.hhldno+'세대';
							const_slash = ' / ';
						}
						if(data.project.ugrn_stycnt!=''){
							const_scope = const_scope + const_slash + '지하 ' + data.project.ugrn_stycnt+'층';
							const_slash = ' ~ ';
						}
						if(data.project.ogrn_stycnt!=''){
							const_scope = const_scope + const_slash + '지상 ' + data.project.ogrn_stycnt+'층';
						}
						

						$('[name=const_scope]').val(const_scope);
					}else if(data.result=='empty'){
						alert('단지코드를 찾을 수 없습니다.');
					}else if(data.result=='error'){
						alert('단지코드를 찾을 수 없습니다.');
					}
				},
				error : function(data,status){
					alert( "관리자에게 문의하시기 바랍니다." );
				}
			});
			}
		});
		function slashTO(str){
			return str.replace(/&#40;/g,'(');
		}

		var main_count=0;
		main_count='${MAIN_COUNT }';
		if($.isNumeric(main_count)){
			main_count = parseInt(main_count);
		}
		$("#list").on("click", function(e){ //목록 버튼
			e.preventDefault();
			fn_openBoardList();
		});
	})(jQuery);
	function fn_openBoardList(){
		if(confirm('목록으로 이동하시겠습니까?')){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/complex/${code_type}/management_list");
			if("${!empty currentPageNo}"=="true"){
				comSubmit.addParam("currentPageNo", "${currentPageNo}");
			}
			if("${!empty target}"=="true"){
				comSubmit.addParam("target", "${target}");
			}
			if("${!empty keyword}"=="true"){
				comSubmit.addParam("keyword", "${keyword}");
			}
			comSubmit.submit();
		}
	}
	function doSubmit(frm){
		if(checkValidation(frm)){
			var isOk = true;
			var arrFile = $(".upload-name");
			$.each(arrFile, function(index, item){
				if($(item).val().length > 0){
					var ext = $(item).val().split('.').pop().toLowerCase();
					if($.inArray(ext, ['jpg', 'png']) == -1) {
					 	alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
					 	isOk = false;
					 	return false;
					}
				}
			});
			if(!isOk) return false;
			$('.numbercommaonly').val($('.numbercommaonly').val().replace(/,/gi, ""));
			var submitHtml = true;
			if(submitHtml){
				var tags = "";
				var tags_index = 0;
				$('.rk-tags').each(function(index){
					if($(this).is(':checked')){
						if(tags_index==0){
							tags += ""+$(this).val();
						}else{
							tags += ","+$(this).val();
						}
						tags_index++;
					}
				});
				$('form#'+frm).submit();
			}
			
		}
	}
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
	</script>
</body>

</html>