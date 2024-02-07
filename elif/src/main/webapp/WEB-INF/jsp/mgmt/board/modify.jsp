<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="../include/head.jsp"%>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link href="/resources/manager/custom/summernote/summernote.css" rel="stylesheet">
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/board/${pid}">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
			<jsp:param name="searchHtml" value="board" />
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
									<h4 class="card-title ">${category.description }게시판 수정</h4>
								</div>
								<div class="card-body">
									<form id="write" name="frmSubmit" action="/mgmt/board/${pid}/modifyProc" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								        <input type="hidden" id="idx" name="idx" value="${map.idx }">
										<input type="hidden" name="pid" value="${pid}">
										<input type="hidden" name="currentPageNo" value="${param.currentPageNo }">
										<input type="hidden" name="target" value="${param.target }">
										<input type="hidden" name="keyword" value="${param.keyword }">
										<input type="hidden" name="lang" value="KO">
										<c:if test="${not empty returnUrl }">
										<input type="hidden" name="returnUrl" value="${returnUrl }">
										</c:if>
										
										<c:if test="${category.slug=='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="section">제품</label>
												<div class="col-sm-10 checkbox-radios">
													<input type="hidden" name="section" value="${map.section}">
													<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="checkbox" name="section_arr" value="알룰로스" ${fn:contains(map.section, '알룰로스')?'checked':''}> 알룰로스
															<span class="form-check-sign">
																<span class="check"></span>
															</span>
														</label>
													</div>
													<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="checkbox" name="section_arr" value="난소화성말토덱스트린" ${fn:contains(map.section, '난소화성말토덱스트린')?'checked':''}> 난소화성말토덱스트린
															<span class="form-check-sign">
																<span class="check"></span>
															</span>
														</label>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${fn:length(project_list) > 0}">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="gubun">프로젝트 <span></span></label>
											<div class="col-sm-10">
														<select name="pjt_cd" class="selectpicker" data-style="select-with-transition">
													<c:choose>
														<c:when test="${fn:length(project_list) > 0}">
															<c:forEach items="${project_list }" var="row">
															<option value="${row.pjt_cd}" ${map.pjt_cd==row.pjt_cd?'selected':''}>${row.pjt_mrkg_nm}</option>
															</c:forEach>
														</c:when>
													</c:choose>
													</select>
											</div>
										</div>
										</c:if>
										<c:if test="${fn:length(category.types) > 0}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="gubun">카테고리</label> 
												<div class="col-sm-10">
													<select name="gubun" class="selectpicker" data-style="select-with-transition">
														<c:forTokens items="${category.types}" delims="," var="item">
															<option value="${item}" ${item==map.gubun?' selected="selected"':'' }>${ct:getBoardType(item)}</option>
														</c:forTokens>
													</select>
												</div>
											</div>
										</c:if>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="title">제목 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" id="title" name="title" value="${map.title }" class="form-control" required minlength="2" maxlength="100" title="제목" data-title="제목을">
												</div>
											</div>
										</div>
										<c:if test="${category.slug=='sustainability'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="title_sub">서브 제목</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<input type="text" id="title_sub" name="title_sub" value="${fn:escapeXml(map.title_SUB) }" class="form-control" maxlength="1000" title="제목" data-title="제목을">
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug!='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="CONTENTS">내용</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<textarea id="contents" name="contents" class="form-control texteditor" style="resize: none; height: 300px;">${map.contents}</textarea>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='sustainability'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="tags">썸네일 노출 내용</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<textarea id=tags " name="tags" class="form-control" style="resize: none; height: 60px;">${map.tags}</textarea>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='community'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="video">URL</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<input type="text" name="video" class="form-control" value="${map.video }" maxlength="100" title="URL" data-title="URL을" placeholder="http:// 또는 https:// 부터 주소 입력">
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='media'||category.slug=='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="contents_mobile">검색 데이터</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<textarea id="contents_mobile" name="contents_mobile" class="form-control" style="resize: none; height: 200px!important;">${map.contents_mobile}</textarea>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${fn:length(category.images) > 0}">
										<c:set var='required' value='' />
										<c:set var='requiredGroup' value='' />
										<c:set var='description' value='' />
										<div class="row">
											<label class="col-sm-2 col-form-label">파일 업로드 <span></span></label>
											<div class="col-sm-10">
												<c:choose>
													<c:when test="${category.slug=='news'}">
														<div class="lead text-small mt-3">
														※ 썸네일 권장 사이즈: 가로 651px * 세로 370px<br>
														<span class="invisible">※ </span>파일 형식: JPG, JEPG, PNG / 용량: 30MB 이하
														</div>
													</c:when>
													<c:when test="${category.slug=='community'}">
														<div class="lead text-small mt-3">
														※ 썸네일 권장 사이즈: 가로 376px * 세로 131px<br>
														<span class="invisible">※ </span>파일 형식: JPG, JEPG, PNG / 용량: 30MB 이하  <br>
														</div>
													</c:when>
												</c:choose>
												<div class="row fileupload-wrap" ${requiredGroup}>
													<div class="col-md-12 col-xs-12">
														<c:forTokens items="${category.images}" delims="," var="item">
															<div class="card">
																<c:set var="itemName" value="${item }" />
																<c:choose>
																	<c:when test="${item == 'thumb'}">
																		<c:set var="itemTitle" value="썸네일" />
																		<c:set var="itemAccept" value=".gif,.jpg,.png" />
																	</c:when>
																	<c:when test="${item == 'file'}">
																		<c:set var="itemTitle" value="파일" />
																		<c:set var="itemAccept" value=".gif,.jpg,.png,.pdf,.doc,.docx,.hwp,.xls,.xlsx,.ppt,.pptx" />
																	</c:when>
																	<c:when test="${item == 'gallery'}">
																		<c:set var="itemTitle" value="이미지" />
																		<c:set var="itemAccept" value=".gif,.jpg,.png" />
																	</c:when>
																	<c:when test="${item == 'pdfkr'}">
																		<c:set var="itemTitle" value="한국어" />
																		<c:set var="itemAccept" value=".pdf" />
																	</c:when>
																	<c:when test="${item == 'pdfen'}">
																		<c:set var="itemTitle" value="영어" />
																		<c:set var="itemAccept" value=".pdf" />
																	</c:when>
																	<c:when test="${item == 'pdfcn'}">
																		<c:set var="itemTitle" value="중국어" />
																		<c:set var="itemAccept" value=".pdf" />
																	</c:when>
																	<c:otherwise>
																		<c:set var="itemTitle" value="${item}" />
																		<c:set var="itemAccept" value=".gif,.jpg,.png,.pdf,.doc,.docx,.hwp,.xls,.xlsx,.ppt,.pptx" />
																	</c:otherwise>
																</c:choose>
																<div class="card-header">
																	<h4>
																		${itemTitle }
																	</h4>
																	<div class="clearfix"></div>
																</div>
																<div class="card-body add_img_area">
																	<ul class="file_area" data-group="${itemName}" data-type="file">
																		<c:choose>
																			<c:when test="${fn:length(files[itemName])>0}">
																				<c:forEach var="row" items="${files[itemName] }" varStatus="var">
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
																							<input type="hidden" id="${itemName}idx" name="${itemName}idx_${var.index }" class="hididx" value="${row.idx }">
																								<input type="file" name="${itemName}_${var.index }" id="${itemName}_${var.index }" class="upload-hidden" accept="${itemAccept }"> 
																								<input type="text" class="form-control upload-name" value="${row.original_file_name }" placeholder="업로드" readonly="readonly" ${required}> 
																								<span class="input-group-btn"> 
																								<label for="${itemName}_${var.index }" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																								<a href="/downloadFile?IDX=${row.idx}&BOARD_NAME=BOARD" class="btn btn-light btn-fab"><i class="fa fa-download"></i></a>
																								<button type="button" data-seq="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																								
																							</span>
																						</div>
																					</li>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<li class="item-file">
																					<div class="input-group">
																						<input type="file" name="${itemName}_0" id="${itemName}_0" class="upload-hidden" accept="${itemAccept }" <%-- ${itemName=="thumb"?'required':''} --%> title="${itemTitle }" data-title="${itemTitle }를(을)">
																						<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly"> 
																						<span class="input-group-btn"> 
																						<label for="${itemName}_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																						
																						</span>
																					</div>
																				</li>
																			</c:otherwise>
																		</c:choose>
																	</ul>
																	<c:if test="${item != 'thumb'}">
																		<div class="ln_solid"></div>
																		<div class="form-group bmd-form-group">
																			<button type="button" id="btnAddFile2" class="btn btn-success btn-sm">파일 추가</button>
																		</div>
																	</c:if>
																</div>
															</div>
														</c:forTokens>
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<c:if test="${category.slug=='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="recom">고객정보 수집여부</label>
												<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="Y" ${map.recom=='Y'?'checked="checked"':''}> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="N" ${map.recom=='N'?'checked="checked"':''}> N <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='media'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="recom">상단 노출</label>
												<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="Y" ${map.recom=='Y'?'checked="checked"':''}> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="N" ${map.recom=='N'?'checked="checked"':''}> N <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.code=='event'||category.slug=='popup'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="mainstatus">시작일 종료일 사용여부</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<div id="btnset">
															<div id="mainstatus" class="btn-group" data-toggle="buttons">
																<label class="btn btn-default"> <input type="radio" name="mainstatus" value="Y" ${map.mainstatus=='Y' ?'checked="checked"':''}> 사용
																</label> <label class="btn btn-default active"> <input type="radio" name="mainstatus" value="N" ${map.mainstatus=='N'?'checked="checked"':''}> 사용안함
																</label>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<label class="col-sm-2 col-form-label" for="start_dtm">시작일</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<div class="xdisplay_inputx form-group has-feedback">
                                                        	<fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm" value="${map.start_dtm }"/>
															<input type="text" name="start_dtm" class="form-control datetimepicker" value="${start_dtm }" required title="게시일" data-title="게시일을" />
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<label class="col-sm-2 col-form-label" for="end_dtm">종료일</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<div class="xdisplay_inputx form-group has-feedback">
															<fmt:formatDate var="end_dtm" pattern="yyyy-MM-dd HH:mm" value="${map.end_dtm }"/>
															<input type="text" name="end_dtm" class="form-control datetimepicker" value="${end_dtm }" />
														</div>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='notice'}">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="status">공지 사용여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="Y" ${map.mainstatus=='Y'?'checked="checked"':''}> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="N" ${map.mainstatus=='N'?'checked="checked"':''}> N <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="status">노출여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="status" value="Y" ${map.status=='Y'?'checked="checked"':''}> 공개 <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="status" value="N" ${map.status=='N'?'checked="checked"':''}> 비공개 <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="start_dtm">게시일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
                                                        <fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.start_dtm }"/>
														<input type="text" name="start_dtm" class="form-control datetimepicker" value="${start_dtm }" required title="게시일" data-title="게시일을" />
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="crea_name">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.crea_name }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="crea_dtm">등록일시 <span></span></label>
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
											<label class="col-sm-2 col-form-label" for="upda_dtm">수정일시 <span></span></label>
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
											<div class="col-2"></div>
											<div class="col-10">
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												<a href="javascript:;" class="btn btn-danger" id="delete">삭제</a>
												<a href="list" id="list" class="btn btn-info">목록</a>
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
		$('.texteditor').summernote(snOptions);
		(function ($) {
			var main_count = 0;
			main_count = '${MAIN_COUNT }';
			if ($.isNumeric(main_count)) {
				main_count = parseInt(main_count);
			}
			<c:if test="${category.slug!='popup'}">
				$('[name=mainstatus]').change(function(){
				if(main_count>0){
					if($(this).val()=='Y'){
						if(!confirm('이미 메인에 공지된 게시글이 있습니다. 변경하시겠습니까?')){
					$(this).val('N');
						}
					}
				}
			});
			</c:if>

			$('[name=gubun]').on('change',function(){
				if($(this).val()=='youtube'||$(this).val()=='sns'){
					$('[name=video]').attr('required',true);
				}else{
					$('[name=video]').attr('required',false);
				}
			});

			$("#list").on("click", function (e) { //목록 버튼
				e.preventDefault();
				fn_openBoardList();
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
				if (confirm("파일을 삭제하시겠습니까?\n삭제후에는 복구할 수 없습니다.")) {
					$.post("/mgmt/board/fileDelete", { idx: $(this).data('seq') }).done(function (data) {
						if (data.result == 'ok') {
							if($('#btnAddFile2').length>0){
								if (deleteFile.parents('.add_img_area').find('.file_area').children('li').length < 1) {
									deleteFile.parents('.add_img_area').find('#btnAddFile2').click();
								}
								deleteFile.parents('.item-file').remove();
							}else{
								deleteFile.parents('.item-file').find('.upload-name').val('');
								deleteFile.parents('.item-file').find('.upload-display').remove();
								deleteFile.parents('.item-file').find('.hididx').remove();
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

			$("#delete").on("click", function (e) { //삭제 버튼
				if (confirm("삭제하시겠습니까?")) {
					e.preventDefault();
					fn_deleteBoard();
				}
			});
			<c:if test="${not empty param.ALERT }">
				alert('${param.ALERT}')
			</c:if>
		})(jQuery);
		function doSubmit(frm) {
			if($('[name=frmSubmit] [name=lang]').attr('type')=='hidden'){
				if($('[name=frmSubmit] [name=lang_arr]').length>0){
					if($("[name=frmSubmit] [name=lang_arr]:checked").length == 0){
						alert("선택된 언어가 없습니다.");
						return false;
					}
					var arr = $("[name=frmSubmit] [name=lang_arr]:checked").map( function () {
						return $(this).val();
					}).get().join();
					console.log(arr);
					$('[name=frmSubmit] [name=lang]').val(arr);
					console.log($('[name=frmSubmit] [name=lang]').val());
				}
			}
			if($('[name=frmSubmit] [name=section]').attr('type')=='hidden'){
				if($('[name=frmSubmit] [name=section_arr]').length>0){
					// if($("[name=frmSubmit] [name=section_arr]:checked").length == 0){
					// 	alert("선택된 제품이 없습니다.");
					// 	return false;
					// }
					var arr = $("[name=frmSubmit] [name=section_arr]:checked").map( function () {
						return $(this).val();
					}).get().join();
					$('[name=frmSubmit] [name=section]').val(arr);
				}
			}
			if (checkValidation(frm)) {
				var isOk = true;
				var arrAccept = new Array();
				if('catalog' == "${category.slug}"){
					arrAccept = ['pdf']; 
					$('[data-filegroup] .upload-name').each(function(){
						if($(this).val().length>0){
							var ext = $(this).val().split('.').pop().toLowerCase();
							if($.inArray(ext, arrAccept) == -1) {
							 	alert($(this).val() + '는  PDF파일이 아닙니다.');
							 	isOk = false;
							 	return false;
						    }
						}
					});
				}else{
					$('.upload-hidden').each(function(){
						if($(this).val().length>0){
							var strAccept = $(this).attr('accept');
							strAccept = strAccept.replace(/\./gi, ""); 
							arrAccept = strAccept.split(",");
							var arrFile = $(this).next('.upload-name');
							console.log(arrAccept,arrFile);
							$.each(arrFile, function(index, item){
								var ext = $(item).val().split('.').pop().toLowerCase();
								if($.inArray(ext, arrAccept) == -1) {
									alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
									isOk = false;
									return false;
								}
							});
						}
					});
				}
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
				}
			}
		}

		function fn_openBoardList() {
			if(confirm('목록으로 이동하시겠습니까?')){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("/mgmt/board/${pid}");
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
				if("${!empty LANG}"=="true"){
					comSubmit.addParam("LANG", "${LANG}");
				}
				comSubmit.submit();
			}
		}
		function fn_deleteBoard() {
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/board/${pid}/deleteProc");
			if ("${!empty target}" == "true") {
				comSubmit.addParam("target", "${target}");
			}
			if ("${!empty keyword}" == "true") {
				comSubmit.addParam("keyword", "${keyword}");
			}
			if ("${!empty param.gubun}" == "true") {
				comSubmit.addParam("gubun", "${param.gubun}");
			}
			if("${!empty LANG}"=="true"){
				comSubmit.addParam("LANG", "${LANG}");
			}
			comSubmit.addParam("idx", idx);
			comSubmit.submit();

		}
		function fn_downloadFile(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/common/downloadFile");
			comSubmit.addParam("idx", obj.data("idx"));
			comSubmit.addParam("board_name", "BOARD");
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