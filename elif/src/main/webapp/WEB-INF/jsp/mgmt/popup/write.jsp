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
                                    <h4 class="card-title ">${param.type=='G'?'일반 팝업':'상단 고정 배너' } 추가</h4>
                                </div>
                                <div class="card-body">
                                    
									<form method="post" id="write" name="frmSubmit" action="/mgmt/popup/writeProc" enctype="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									    <input type="hidden" name="pid" value="${pid}">
									    <input type="hidden" name="lang" value="KO"> 
										<input type="hidden" name="type" value="${param.type}">
										<c:choose>
										<c:when test="${param.type=='G'}">
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="status">메인 노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="checkbox" name="gubun_web" value="Y" checked> &nbsp; PC &nbsp;
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="checkbox" name="gubun_mobile" value="Y" checked> 모바일
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
									        <label class="col-sm-2 col-form-label" for="title">제목 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<input type="text" name="title" class="form-control" required value="" maxlength="100" title="제목" data-title="제목을">
												</div>
											</div>
									    </div>
										<c:choose>
										<c:when test="${param.type=='G'}">
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
																<li class="item-file">
																	<div class="input-group">
																		<input type="file" name="gallery_0" id="gallery_0" class="upload-hidden" accept="${itemAccept }" <%-- ${itemName=="thumb"?'required':''} --%> title="${itemTitle }" data-title="${itemTitle }를(을)">
																		<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly"  data-detect="pc" required title="PC 이미지" data-title="PC 이미지를">
																		<span class="input-group-btn">
																			<label for="gallery_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																			<button type="button" class="btn btn-primary btn-fab hidden"><i class="fa fa-close"></i></button>
																		</span>
																	</div>
																</li>
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
																<li class="item-file">
																	<div class="input-group">
																		<input type="file" name="mobgallery_0" id="mobgallery_0" class="upload-hidden" accept="${itemAccept }" title="${itemTitle }" data-title="${itemTitle }를(을)">
																		<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly"  required title="모바일 이미지" data-title="모바일 이미지를">
																		<span class="input-group-btn">
																			<label for="mobgallery_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																			<button type="button" class="btn btn-primary btn-fab hidden"><i class="fa fa-close"></i></button>
																		</span>
																	</div>
																</li>
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
									        <label class="col-sm-2 col-form-label" for="desc_web">내용<span></span></label>
											<div class="col-sm-10">
												<c:choose>
												<c:when test="${param.type=='G'}">
												<div class="input-group row my-2">
													<div class="input-group-prepend col-2 justify-content-end">
														<span class="input-group-text px-0">
														모바일
														</span>
													</div>
													<div class="col-10">
														<input type="text" name="desc_mobile" class="form-control" placeholder="" value="" maxlength="14"  data-detect="mb" required title="대체 텍스트" data-title="대체 텍스트를" />
														<div class="comment mt-0">* 14글자 이내로 입력해주시기 바랍니다.</div>
													</div>
												</div>
												</c:when>
												<c:otherwise>
												<div class="input-group row my-2">
													<div class="col-7">
														<input type="text" name="desc_web" class="form-control" placeholder="" value=""   data-detect="mb" title="대체 텍스트" data-title="대체 텍스트를" />
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
												<c:when test="${param.type=='G'}">
												<div class="input-group row my-2">
													<div class="input-group-prepend col-2 justify-content-end">
														<span class="input-group-text px-0">
														PC
														</span>
													</div>
													<div class="col-7">
														<input type="text" name="url_web" class="form-control" placeholder="" value=""   data-detect="pc" required title="PC 링크 URL" data-title="PC 링크 URL을" />
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_web_target" value="Y"> 새창
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
														<input type="text" name="url_mobile" class="form-control" placeholder="" value="" data-detect="mb" required title="MOBILE 링크 URL" data-title="MOBILE 링크 URL을" />
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_mobile_target" value="Y"> 새창
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
														<input type="text" name="url_web" class="form-control" placeholder="" value=""  data-detect="mb" required title="링크 URL" data-title="링크 URL을" />
													</div>
													<div class="col-sm-3 checkbox-radios">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="checkbox" name="url_web_target" value="Y"> 새창
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
                                                        <input type="text" name="start_dtm" class="form-control sdate" placeholder="시작일" value="${toDay}" required title="시작일" data-title="시작일을" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="end_dtm" class="form-control edate" placeholder="종료일" value="${fromDay}" required title="종료일" data-title="종료일을" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										<c:choose>
										<c:when test="${param.type=='G'}">
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">팝업 크기 (PC만 적용) <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="size_w" class="form-control" placeholder="가로 픽셀" value="" title="가로" data-title="가로값을"  />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="size_h" class="form-control" placeholder="세로 픽셀" value="" title="세로" data-title="세로값을"  />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">팝업 위치 <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="pos_y" class="form-control" placeholder="상단에서 Y 픽셀" value="" title="상단에서 Y 픽셀" data-title="상단에서 Y 픽셀을"  />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="pos_x" class="form-control" placeholder="좌측에서 X 픽셀" value="" title="좌측에서 X 픽셀" data-title="좌측에서 X 픽셀을" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="gubun">모바일 팝업테마</label> 
											<div class="col-sm-10">
												<select name="theme" class="selectpicker" data-style="select-with-transition">
													<option value="1">1번테마</option>
													<option value="2">2번테마</option>
													<option value="3">3번테마</option>
													<option value="4">4번테마</option>
												</select>
											</div>
										</div>
										</c:when>
										<c:otherwise>
										<input type="hidden" name="theme" value="0">
										</c:otherwise>
										</c:choose>

                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">노출여부 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios">
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="status" value="Y" checked=""> 사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="status" value="N"> 미사용
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
									        <a href="javascript:;" class="btn btn-primary" onclick="doSubmit('write');">등록</a>
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
	$('.texteditor').summernote(snOptions);
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


		var main_count=0;
		main_count='${MAIN_COUNT }';
		if($.isNumeric(main_count)){
			main_count = parseInt(main_count);
		}
		$("#list").on("click", function(e){ //목록 버튼
			if(confirm('목록으로 이동하시겠습니까?')){
				e.preventDefault();
				fn_openBoardList();
			}
		});
	})(jQuery);
	function fn_openBoardList(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/popup");
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
	function doSubmit(frm){
		if(checkValidation(frm)){
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
			
			if(confirm('추가하시겠습니까?')){
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
	}
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
	</script>
</body>

</html>