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
                                    <h4 class="card-title ">${category.description } 게시판 추가</h4>
                                </div>
                                <div class="card-body">
                                    
									<form method="post" id="write" name="frmSubmit" action="/mgmt/board/${pid}/writeProc" enctype="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									    <input type="hidden" name="pid" value="${pid}">
										<input type="hidden" name="lang" value="KO">
										<c:if test="${category.slug=='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="section">제품</label>
												<div class="col-sm-10 checkbox-radios">
													<input type="hidden" name="section" value="">
													<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="checkbox" name="section_arr" value="알룰로스"> 알룰로스
															<span class="form-check-sign">
																<span class="check"></span>
															</span>
														</label>
													</div>
													<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="checkbox" name="section_arr" value="난소화성말토덱스트린"> 난소화성말토덱스트린
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
												    <option value="">전체</option>
													<c:forEach items="${project_list }" var="row">
													
													<option value="${row.pjt_cd}">${row.pjt_mrkg_nm}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										</c:if>
									    <c:if test="${fn:length(category.types) > 0}">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="gubun">카테고리 <span></span></label>
											<div class="col-sm-10">
												<select name="gubun" class="selectpicker" data-style="select-with-transition">
													<c:forTokens items="${category.types}" delims="," var="item">
													<option value="${item}" ${item==map.gubun?'selected="selected"':'' }>${ct:getBoardType(item)}</option>
													</c:forTokens>
												</select>
											</div>
										</div>
										</c:if>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="title">제목 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<input type="text" name="title" class="form-control" required minlength="2" maxlength="100" title="제목" data-title="제목을">
												</div>
											</div>
									    </div>
									    <c:if test="${category.slug=='sustainability'}">
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="title_sub">서브 제목 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<input type="text" id="title_sub" name="title_sub" value="" class="form-control" maxlength="1000" title="제목" data-title="제목을">
												</div>
											</div>
									    </div>
									    </c:if>
										<c:if test="${category.slug!='data'}">
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="contents">내용 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<textarea id="contents" name="contents" class="form-control texteditor" required  title="내용" data-title="내용을" style="resize: none; height: 300px;"></textarea>
												</div>
											</div>
										</div>
									    </c:if>
									    <c:if test="${category.slug=='sustainability'}">
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="tags">썸네일 노출 내용 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
									        		<textarea id=tags" name="tags" class="form-control" style="resize: none; height: 200px!important;"></textarea>
												</div>
											</div>
									    </div>
									    </c:if>
										<c:if test="${category.slug=='community'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="video">URL</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<input type="text" name="video" class="form-control" value="" maxlength="100" title="URL" data-title="URL을" placeholder="http:// 또는 https:// 부터 주소 입력">
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='media'||category.slug=='data'}">
											<div class="row">
												<label class="col-sm-2 col-form-label" for="contents_mobile">검색 데이터</label>
												<div class="col-sm-10">
													<div class="form-group bmd-form-group">
														<textarea id="contents_mobile" name="contents_mobile" class="form-control" style="resize: none; height: 200px!important;"></textarea>
													</div>
												</div>
											</div>
										</c:if>
										<c:if test="${category.slug=='data'}">
									    <div class="row">
											<label class="col-sm-2 col-form-label" for="recom">고객정보 수집여부  <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="radio" name="recom" value="Y" checked="checked"> &nbsp; Y &nbsp;
															<span class="circle">
																<span class="check"></span>
															</span>
														</label>
													</div>
														<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="radio" name="recom" value="N" > N
															<span class="circle">
																<span class="check"></span>
															</span>
														</label>
													</div>
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
													<c:when test="${category.slug=='media'}">
														<div class="lead text-small mt-3">
														※ 썸네일 권장 사이즈: 가로 651px * 세로 370px<br>
														<span class="invisible">※ </span>파일 형식: JPG, JEPG, PNG / 용량: 30MB 이하  <br>
														<span class="invisible">※ </span>썸네일 미등록 시 해당 영상에 등록된 썸네일이 노출됩니다.
														</div>
													</c:when>
													<c:when test="${category.slug=='data'}">
														<%-- <c:set var="requiredGroup" value='data-filegroup="1"' /> --%>
														<div class="lead text-small mt-3">
														※ DOC, DOCX, HWP, XLS, XLSX, ZIP, PDF, PPT, PPTX / 용량: 10MB 이하
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
																<h4>${itemTitle } ${description}</h4>
																<div class="clearfix"></div>
															</div>
															<div class="card-body add_img_area">
																<ul class="file_area" data-group="${itemName}">
																	<li class="item-file">
																		<div class="input-group">
																			<input type="file" name="${itemName}_0" id="${itemName}_0" class="upload-hidden" accept="${itemAccept }">
																			<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly" ${required}>
																			<span class="input-group-btn">
																				<label for="${itemName}_0" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																				<button type="button" class="btn btn-primary btn-fab hidden"><i class="fa fa-close"></i></button>
																			</span>
																		</div>
																	</li>
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

									    <c:if test="${category.code=='event'||category.slug=='popup'}">
									    <div class="row">
									        <label class="col-sm-2 col-form-label" for="MAINSTATUS">시작일 종료일 사용여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="Y"> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="N" checked> N <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
											</div>
									    </div>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="start_dtm">시작일 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" name="start_dtm" class="form-control datetimepicker" value="${toDay}"/>
													</div>
												</div>
											</div>
									    </div>
										<div class="row">
									        <label class="col-sm-2 col-form-label" for="end_dtm">종료일 <span></span></label>
											<div class="col-sm-10">
                                                <div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" name="end_dtm" class="form-control datetimepicker" value="${toDay}"/>
													</div>
												</div>
											</div>
									    </div>
									    </c:if>
									    <c:if test="${category.slug=='notice'}">
									    <div class="row">
									        <label class="col-sm-2 col-form-label" for="MAINSTATUS">공지 사용여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div id="btnset">
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="Y"> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="mainstatus" value="N" checked> N <span class="circle"> <span class="check"></span>
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
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="Y"> Y <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
														<div class="form-check form-check-inline">
															<label class="form-check-label"> <input class="form-check-input" type="radio" name="recom" value="N" checked> N <span class="circle"> <span class="check"></span>
															</span>
															</label>
														</div>
													</div>
												</div>
												</div>
											</div>
										</c:if>
										<c:set var="status" value="${category.slug=='data'?'Y':'N'}" />
										<div class="row">
											<label class="col-sm-2 col-form-label" for="status">노출여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div class="form-check form-check-inline">
														<label class="form-check-label">	
															<input class="form-check-input" type="radio" name="status" value="Y" ${status=='Y'?'checked':''}> &nbsp; 공개 &nbsp;
															<span class="circle">
																<span class="check"></span>
															</span>
														</label>
													</div>
														<div class="form-check form-check-inline">
														<label class="form-check-label">
															<input class="form-check-input" type="radio" name="status" value="N" ${status=='N'?'checked':''}> 비공개
															<span class="circle">
																<span class="check"></span>
															</span>
														</label>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="start_dtm">게시일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="start_dtm" class="form-control datetimepicker" value="${toDay}"/>
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
	$('.texteditor').summernote(snOptions);
	(function($){
		var main_count=0;
		main_count='${MAIN_COUNT }';
		if($.isNumeric(main_count)){
			main_count = parseInt(main_count);
		}

		<c:if test="${category.slug!='popup'}">
		$('[name=MAINSTATUS]').change(function(){
			if(main_count>0){
				if($(this).val()=='Y'){
					if(!confirm('이미 메인에 공지된 게시글이 있습니다. 변경하시겠습니까?')){
						$('[name=mainstatus][value=N]').prop('checked',true);
					}
				}
			}
		});
		</c:if>
		$("#list").on("click", function(e){ //목록 버튼
			e.preventDefault();
			fn_openBoardList();
		});

		$('[name=gubun]').on('change',function(){
			if($(this).val()=='youtube'||$(this).val()=='sns'){
				$('[name=video]').attr('required',true);
			}else{
				$('[name=video]').attr('required',false);
			}
		});
	})(jQuery);
	function fn_openBoardList(){
		if(confirm('목록으로 이동하시겠습니까?')){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/board/${pid}");
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
	function fileValLength(){
		var count = 0;
		$('[data-filegroup] .upload-name').each(function(){
			if($(this).val().length>0){
				count++;
			}
		});
		return count;
	}
	function doSubmit(frm){
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
				console.log(arr);
				$('[name=frmSubmit] [name=section]').val(arr);
				console.log($('[name=frmSubmit] [name=section]').val());
			}
		}
		if(checkValidation(frm)){

			if($('[data-filegroup]').length){
				if(fileValLength()<1){
					alert('파일은 한 개 이상 등록해 주세요.');
					return false;
				}
			}
			
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