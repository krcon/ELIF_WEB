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
    <div class="wrapper " data-menu="/mgmt/popup">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="popup" />
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
                                    <h4 class="card-title ">${map.type=='G'?'일반 팝업':'상단 고정 배너' } 추가</h4>
                                </div>
                                <div class="card-body">
                                    
									<form id="write" action="/mgmt/popup/modifyProc" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								        <input type="hidden" id="idx" name="idx" value="${map.idx }">
										<input type="hidden" name="currentPageNo" value="${param.currentPageNo }">
										<input type="hidden" name="target" value="${param.target }">
										<input type="hidden" name="keyword" value="${param.keyword }">
										<input type="hidden" name="type" value="${map.type }">
									    <input type="hidden" name="lang" value="KO">
										<c:choose>
										<c:when test="${map.type=='G'}">
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="status">메인 노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="checkbox" name="gubun_web" value="Y" ${'Y'==map.gubun_web?'checked':'' }> &nbsp; PC &nbsp;
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="checkbox" name="gubun_mobile" value="Y" ${'Y'==map.gubun_mobile?'checked':'' }> 모바일
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
													</label>
												</div>
											</div>
									    </div>
										</c:when>
										<c:otherwise>
									    <input type="hidden" name="gubun_web" value="Y"> 
										</c:otherwise>
										</c:choose>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="TITLE">제목 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<input type="text" name="title" class="form-control" required value="${fn:escapeXml(map.title) }" maxlength="100" title="제목" data-title="제목을">
												</div>
											</div>
									    </div>
										<c:choose>
										<c:when test="${map.type=='G'}">
										<div class="row">
											<c:set var="itemAccept" value=".jpg,.jpeg,.png" />
											<label class="col-sm-2 col-form-label">팝업이미지 <span></span></label>
											<div class="col-sm-10">
												<div class="row fileupload-wrap">
													<div class="col-md-6 col-xs-12">
														<div class="card">
														<div class="card-header">
															<h4>
																PC 이미지
															</h4>
															<div class="clearfix"></div>
														</div>
														<div class="card-body add_img_area">
															<ul class="file_area" data-group="gallery">
																<c:choose>
																	<c:when test="${fn:length(files['gallery'])>0}">
																		<c:forEach var="row" items="${files['gallery'] }" varStatus="var">
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
																							<a href="${domainName}${row.path_name }${row.stored_file_name }" class="upload-thumb-wrap imgpopup"><img src="${domainName}${row.path_name }${row.stored_file_name }" class="upload-thumb"></a>
																						</div>
																					</c:otherwise>
																				</c:choose>
																				<div class="input-group">
																					<input type="hidden" id="galleryidx" name="galleryidx_${var.index }" value="${row.idx }">
																						<input type="file" name="gallery_${var.index }" id="gallery_${var.index }" class="upload-hidden" accept="${itemAccept }" title="썸네일 이미지" data-title="썸네일 이미지를"> 
																						<input type="text" class="form-control upload-name" value="${row.original_file_name }" placeholder="업로드" readonly="readonly" data-detect="pc" required title="PC 이미지" data-title="PC 이미지를"> 
																						<span class="input-group-btn"> 
																						<label for="gallery_${var.index }" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																						<c:if test="${item=='file' }">
																						<button type="button" data-seq="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																						</c:if>
																					</span>
																				</div>
																			</li>
																		</c:forEach>
																	</c:when>
																	<c:otherwise>
																		<li class="item-file">
																			<div class="input-group">
																				<input type="file" name="gallery_0" id="gallery_0" class="upload-hidden" accept="${itemAccept }" <%-- ${itemName=="thumb"?'required':''} --%> title="${itemTitle }" data-title="${itemTitle }를(을)">
																				<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly" data-detect="pc"  required title="PC 이미지" data-title="PC 이미지를"> 
																				<span class="input-group-btn"> 
																				<label for="gallery_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																				
																				</span>
																			</div>
																		</li>
																	</c:otherwise>
																</c:choose>
															</ul>
															<div class="clearfix">
																<small>PC용 사이즈 : 500 x 360 /  파일형식 : JPG, PNG / 용량 : 30MB 이하</small>
															</div>
														</div>
														</div>
													</div>
													<%-- <div class="col-md-6 col-xs-12">
														<div class="card">
														<div class="card-header">
															<h4>
																모바일 이미지
															</h4>
															<div class="clearfix"></div>
														</div>
														<div class="card-body add_img_area">
															<ul class="file_area" data-group="mobgallery">
																	<c:choose>
																		<c:when test="${fn:length(mobfiles['mobgallery'])>0}">
																			<c:forEach var="row" items="${mobfiles['mobgallery'] }" varStatus="var">
																				<li class="item-file"><c:choose>
																						<c:when test="${item=='file' }">
																							<div class="upload-display">
																								<div class="upload-thumb-wrap">
																									<i class="fa fa-file-o"></i>
																								</div>
																							</div>
																						</c:when>
																						<c:otherwise>
																							<div class="upload-display">
																								<a href="${domainName}${row.path_name }${row.stored_file_name }" class="upload-thumb-wrap imgpopup"><img src="${domainName}${row.path_name }${row.stored_file_name }" class="upload-thumb"></a>
																							</div>
																						</c:otherwise>
																					</c:choose>
																					<div class="input-group">
																						<span class="input-group-btn">
																							<c:if test="${item=='file' }">
																							<button type="button" data-seq="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																							</c:if>
																						</span>
																							<input type="hidden" id="mobgalleryidx" name="mobgalleryidx_${var.index }" value="${row.idx }"> 
																							<input type="file" name="mobgallery_${var.index }" id="mobgallery_${var.index }" class="upload-hidden" accept="${itemAccept }"> 
																							<input type="text" class="form-control upload-name" value="${row.original_file_name }" placeholder="업로드" readonly="readonly" data-detect="mb"  required title="모바일 이미지" data-title="모바일 이미지를"> 
																						<span class="input-group-btn"> 
																							<label for="mobgallery_${var.index }" class="btn btn-primary btn-fab">
																								<i class="fa fa-upload"></i>
																							</label>
																						</span>
																					</div>
																					</li>
																			</c:forEach>
																		</c:when>
																		<c:otherwise>
																			<li class="item-file">
																				<div class="input-group">
																					<span class="input-group-btn hidden">
																						<c:if test="${item=='file' }">
																						<button type="button" data-seq="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																						</c:if>
																					</span> 
																					<input type="file" name="mobgallery_0" id="mobgallery_0" class="upload-hidden" accept="${itemAccept }" title="${itemTitle }" data-title="${itemTitle }를(을)">
																					<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly" data-detect="mb"  required title="모바일 이미지" data-title="모바일 이미지를">
																					<span class="input-group-btn"> 
																					<label for="mobgallery_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																					</span>
																				</div>
																			</li>
																		</c:otherwise>
																	</c:choose>
															</ul>
															<div class="clearfix">
																<small>※ Mobile용 사이즈 : 400 x 300 /  파일형식 : JPG, PNG / 용량 : 30MB 이하</small>
															</div>
														</div>
														</div>
													</div> --%>
												</div>
											</div>
									    </div>
										</c:when>
										<c:otherwise>
										</c:otherwise>
										</c:choose>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="title_sub">내용 <span></span></label>
											<div class="col-sm-10">
												<c:choose>
												<c:when test="${map.type=='G'}">
												<div class="input-group row my-2">
													<div class="input-group-prepend col-2 justify-content-end">
														<span class="input-group-text px-0">
														모바일
														</span>
													</div>
													<div class="col-10">
														<input type="text" name="desc_mobile" class="form-control" placeholder="" value="${map.desc_mobile }" maxlength="14" required title="대체 텍스트" data-detect="mb" data-title="대체 텍스트를" />
														<div class="comment mt-0">* 14글자 이내로 입력해주시기 바랍니다.</div>
													</div>
												</div>
												</c:when>
												<c:otherwise>
												<div class="input-group row my-2">
													<div class="col-7">
														<input type="text" name="desc_web" class="form-control" placeholder="" value="${map.desc_web }"  required title="대체 텍스트" data-detect="pc" data-title="대체 텍스트를"/>
													</div>
												</div>
												</c:otherwise>
												</c:choose>
											</div>
									    </div>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="TITLE_SUB">링크 URL <span></span></label>
											<div class="col-sm-10">
												<c:choose>
												<c:when test="${map.type=='G'}">
												<div class="input-group row my-2">
													<div class="input-group-prepend col-2 justify-content-end">
														<span class="input-group-text px-0">
														PC
														</span>
													</div>
													<div class="col-7">
														<input type="text" name="url_web" class="form-control" placeholder="" value="${map.url_web }" data-detect="pc" title="링크 URL" data-title="링크 URL을"/>
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_web_target" value="Y" ${'Y'==map.url_web_target?'checked':'' }> 새창
																<span class="form-check-sign">
																	<span class="check"></span>
																</span>
															</label>
														</div>
													</div>
												</div>
												<div class="input-group row my-2">
													<div class="input-group-prepend col-2 justify-content-end">
														<span class="input-group-text px-0">
														모바일
														</span>
													</div>
													<div class="col-7">
														<input type="text" name="url_mobile" class="form-control" placeholder="" value="${map.url_mobile }" data-detect="mb" title="링크 URL" data-title="링크 URL을"  />
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_mobile_target" value="Y" ${'Y'==map.url_mobile_target?'checked':'' }> 새창
																<span class="form-check-sign">
																	<span class="check"></span>
																</span>
															</label>
														</div>
													</div>
												</div>
												</c:when>
												<c:otherwise>
												<div class="input-group row my-2">
													<div class="col-7">
														<input type="text" name="url_web" class="form-control" placeholder="" value="${map.url_web }" data-detect="pc" title="링크 URL" data-title="링크 URL을"/>
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_web_target" value="Y" ${'Y'==map.url_web_target?'checked':'' }> 새창
																<span class="form-check-sign">
																	<span class="check"></span>
																</span>
															</label>
														</div>
													</div>
												</div>
												</c:otherwise>
												</c:choose>
											</div>
									    </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">노출기간 <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        	<fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm" value="${map.start_dtm }"/>
															<input type="text" name="start_dtm" class="form-control datetimepicker" value="${start_dtm }" required title="게시일" data-title="게시일을" data-detect="pc" required title="시작일" data-title="시작일을"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
															<fmt:formatDate var="end_dtm" pattern="yyyy-MM-dd HH:mm" value="${map.end_dtm }"/>
															<input type="text" name="end_dtm" class="form-control datetimepicker" value="${end_dtm }" data-detect="mb" required title="종료일" data-title="종료일을"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">노출여부 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios">
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="status" value="Y" ${'Y'==map.status?'checked':'' }> 사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="status" value="N" ${'N'==map.status?'checked':'' }> 미사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
										</div>
										<c:choose>
										<c:when test="${map.type=='G'}">
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">팝업 크기 (PC만 적용) <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="size_w" class="form-control" placeholder="가로 픽셀" value="${map.size_w }" title="가로" data-title="가로값을"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="size_h" class="form-control" placeholder="세로 픽셀" value="${map.size_h }" title="세로" data-title="세로값을"  />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">팝업 위치 <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="pos_y" class="form-control" placeholder="상단에서 Y 픽셀" value="${map.pos_y }" title="상단에서 Y 픽셀" data-title="상단에서 Y 픽셀을"  />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="pos_x" class="form-control" placeholder="좌측에서 X 픽셀" value="${map.pos_x }" title="좌측에서 X 픽셀" data-title="좌측에서 X 픽셀을" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="gubun">모바일 팝업테마</label> 
											<div class="col-sm-10">
												<select name="theme" class="selectpicker" data-style="select-with-transition">
													<option value="1" ${map.theme=='1'?'selected':''}>1번테마</option>
													<option value="2" ${map.theme=='2'?'selected':''}>2번테마</option>
													<option value="3" ${map.theme=='3'?'selected':''}>3번테마</option>
													<option value="4" ${map.theme=='4'?'selected':''}>4번테마</option>
												</select>
											</div>
										</div>
										</c:when>
										<c:otherwise>
										<input type="hidden" name="theme" value="0">
										</c:otherwise>
										</c:choose>
										
										<div class="row">
											<label class="col-sm-2 col-form-label" for="START_DTM">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.crea_name }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">등록일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.crea_dtm }"/>
														<input type="text" class="form-control" disabled value="${crea_dtm }" />
													</div>
												</div>
											</div>
										</div>
										<c:if test="${map.upda_name!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="upda_name">수정자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.upda_name }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">수정일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="upda_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.upda_dtm }"/>
														<input type="text" class="form-control" disabled value="${upda_dtm }" />
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
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												<a href="javascript:;" class="btn btn-danger" id="delete">삭제</a>
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
		// $('.texteditor').summernote(snOptions);
		if(!$('[name=gubun_web]').is(':checked')){
			$('[data-detect="pc"]').removeAttr('required');
		}
		if(!$('[name=gubun_mobile]').is(':checked')){
			$('[data-detect="mb"]').removeAttr('required');
		}
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
		var main_count = 0;
		main_count = '${MAIN_COUNT }';
		if ($.isNumeric(main_count)) {
			main_count = parseInt(main_count);
		}


		$("#list").on("click", function (e) { //목록 버튼
			if(confirm('목록으로 이동하시겠습니까?')){
				e.preventDefault();
				fn_openBoardList();
			}
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
		$("a[name='file']").on("click", function (e) { //파일 이름
			e.preventDefault();
			fn_downloadFile($(this));
		});
		$(".delete-file").click(function () {
			var deleteFile = $(this);
			if (confirm("파일을 삭제하시겠습니까?")) {
				$.post("/mgmt/popup/fileDelete", { file_idx: $(this).data('seq') }).done(function (data) {
					if (data.result == 'ok') {
						if (deleteFile.parents('.add_img_area').find('.file_area').children('li').length < 1) {
							deleteFile.parents('.add_img_area').find('#btnAddFile2').click();
						}
						deleteFile.parents('.item-file').remove();
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
						if($.inArray(ext, extList) == -1) {
						 	alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
						 	isOk = false;
						 	return false;
					    }
					}
				});
				if(!isOk) return false;
				
				if(confirm('수정하시겠습니까?')){
					var submitHtml = true;
					if (submitHtml) {
						var tags = "";
						var tags_index = 0;
						$('.rk-tags').each(function (index) {
							if ($(this).is(':checked')) {
								if (tags_index == 0) {
									tags += "" + $(this).val();
								} else {
									tags += "," + $(this).val();
								}
								tags_index++;
							}
						});
						$('form#' + frm).submit();
					}
				}else{
					return false;
				}
			}
		}

		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/popup");
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
			if("${!empty type}"=="true"){
				comSubmit.addParam("type", "${type}");
			}
			comSubmit.submit();
		}
		function fn_deleteBoard() {
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/popup/deleteProc");
			if ("${!empty target}" == "true") {
				comSubmit.addParam("target", "${target}");
			}
			if ("${!empty keyword}" == "true") {
				comSubmit.addParam("keyword", "${keyword}");
			}
			if ("${!empty param.gubun}" == "true") {
				comSubmit.addParam("gubun", "${param.gubun}");
			}
			comSubmit.addParam("idx", idx);
			comSubmit.submit();

		}
		function fn_downloadFile(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/common/downloadFile");
			comSubmit.addParam("idx", obj.data("idx"));
			comSubmit.addParam("BOARD_NAME", "BOARD");
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