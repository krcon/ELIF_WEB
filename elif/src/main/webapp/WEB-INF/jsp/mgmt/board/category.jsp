<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/board/category">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
            <%@ include file="../include/top.jsp"%>
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
                                    <h4 class="card-title ">
										카테고리관리
									</h4>
									<div class="pull-right btn btn-sm btn-outline-info btn-round" data-toggle="modal" data-target=".category_code">
										상위 카테고리 추가
									</div>
                                </div>
                                <div class="card-body">
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action" id="category">
											<thead>
												<tr class="headings">
													<th width="6%" class="column-title text-center">ID </th>
													<th width="10%" class="column-title text-center">카테고리 타입 </th>
													<th width="10%" class="column-title text-center">
													<span rel="tooltip" data-toggle="tooltip" data-placement="bottom" title="관리자 메뉴의 상위 카테고리 ">상위 카테고리 <i class="material-icons">info</i></span>
													</th>
													<th width="10%" class="column-title text-center">
													<span rel="tooltip" data-toggle="tooltip" data-placement="bottom" title="슬러그(SLUG)는 페이지나 포스트를 설명하는 몇개 단어의 집합입니다. 소문자와 -의 조합으로만 가능합니다. ">SLUG <i class="material-icons">info</i></span>
													</th>
													<th class="column-title text-center">게시판 명 </th>
													<th width="12%" class="column-title text-center">
														<span rel="tooltip" data-toggle="tooltip" data-placement="bottom" title="타입은 콤마(,)로 구분합니다.">타입추가 <i class="material-icons">info</i></span>
													</th>
													<%-- 
													<th width="5%" class="column-title text-center">추천</th>
													--%>
													<th width="7%" class="column-title text-center">
													<span rel="tooltip" data-toggle="tooltip" data-placement="bottom" title="위지윅 에디터의 사용여부">HTML <i class="material-icons">info</i></span>
													</th>
													<th width="8%" class="column-title text-center">페이지수</th>
													<th width="17%" class="column-title text-center">
													<span rel="tooltip" data-toggle="tooltip" data-placement="bottom" title="파일업로드는 썸네일(thumb),메인(main),파일(file),갤러리(gallery)를 사용하기위한 코드이며  콤마(,)로 구분합니다.">파일업로드 <i class="material-icons">info</i></span>
													</th>
													<th width="10%" class="column-title no-link last"><span class="nobr">Action</span></th>
												</tr>
											</thead>
											<tbody>

											<c:choose>
												<c:when test="${fn:length(list) > 0}">
													<c:forEach items="${list }" var="row">
														<tr data-seq="${row.idx }">
															<td class="text-center seq">${row.idx }</td>
															<td class="text-center">
																<input type="hidden" name="main" value="${row.main}">
																<select name="code" class="selectpicker" data-style="select-with-transition">
																	<option value="list" ${row.code=='list'?'selected="selected"':'' }>리스트</option>
																	<option value="social" ${row.code=='social'?'selected="selected"':'' }>소셜</option>
																	<option value="gallery" ${row.code=='gallery'?'selected="selected"':'' }>갤러리</option>
																	<option value="media" ${row.code=='media'?'selected="selected"':'' }>동영상</option>
																	<option value="event" ${row.code=='event'?'selected="selected"':'' }>이벤트</option>
																</select>
															</td>
															<td class="text-center">
																<select name="catecode" class="selectpicker" data-style="select-with-transition">
																	<option value="">없음</option>
																	<c:choose>
																		<c:when test="${fn:length(code) > 0}">
																			<c:forEach items="${code }" var="codeRow">
																			<option value="${codeRow.catecode}" ${row.catecode==codeRow.catecode?'selected="selected"':'' }>${codeRow.description}</option>
																			</c:forEach>
																		</c:when>
																	</c:choose>
																</select>
															</td>
															<td class="text-center">
																<input type="text" name="slug" class="form-control inp-slug" value="${row.slug }" />
															</td>
															<td class="text-center"><input type="text" name="description" class="form-control" value="${row.description }"/></td>
															<td class="text-center">
																<input type="text" name="types" class="form-control" value="${row.types }" />
															</td>
															<%-- 
															<td class="text-center">
																
																<label class="tag-checkbox">
																	<input type="checkbox" name="TAG" class="flat" ${row.TAG=='Y'?'checked="checked"':'' } value="Y">
																</label>
																<i class="fa fa-edit taginput rk-input" data-toggle="tooltip" data-placement="bottom" title="${row.TAG_DEFAULT}"></i>
																<input type="hidden" name="TAG_DEFAULT" class="form-control" value="${row.TAG_DEFAULT}"> 
																
																<label class="tag-checkbox">
																	<input type="checkbox" name="MAIN" class="flat" ${row.MAIN=='Y'?'checked="checked"':'' } value="Y">
																</label>
																
															</td>
															--%>
															<td class="text-center">
																<label class="html-checkbox">
																	<input type="checkbox" name="html" class="flat" ${row.html=='Y'?'checked="checked"':'' } value="Y">
																</label>
															</td>
															<td class="text-center">
																<input type="number" name="count" class="form-control" value="${row.count }" />
															</td>
															<td class="text-center">
																<input type="text" name="images" class="form-control" value="${row.images }" />
															</td>
															<td class=" last">
																<a href="#none" onclick="editCategory(${row.idx });" class="btn btn-info btn-fab btn-sm"><i class="fa fa-save mr-1" data-toggle="tooltip" data-placement="bottom" title="수정"></i></a>
																<a href="#none" onclick="delCategory(${row.idx });" class="btn btn-info btn-fab btn-sm"><i class="fa fa-remove mr-1" data-toggle="tooltip" data-placement="bottom" title="삭제"></i></a>
															</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
												<tr>
													<td colspan="12">컨텐츠가 없습니다.</td>
												</tr>
												</c:otherwise>
											</c:choose>
											</tbody>
											<tfoot>
												<tr>
													<td class="text-center">추가</td>
													<td>
														<input type="hidden" name="main" value="N">
														<select name="code" class="selectpicker" data-style="select-with-transition">
															<option value="list">리스트</option>
															<option value="social">소셜</option>
															<option value="gallery">갤러리</option>
															<option value="media">동영상</option>
															<option value="event">이벤트</option>
														</select>
													</td>
													<td class="text-center">
														<select name="catecode" class="selectpicker" data-style="select-with-transition">
															<option value="">없음</option>
															<c:choose>
																<c:when test="${fn:length(code) > 0}">
																	<c:forEach items="${code }" var="codeRow">
																	<option value="${codeRow.catecode}">${codeRow.description}</option>
																	</c:forEach>
																</c:when>
															</c:choose>
														</select>
													</td>
													<td><input type="text" name="slug" class="form-control inp-slug" value="" /></td>
													<td><input type="text" name="description" class="form-control" value="" required="required" /></td>
													<td><input type="text" name="types" class="form-control" value="" /></td>
													<%-- 
													<td class="text-center">
														<label class="tag-checkbox">
															<input type="checkbox" name="TAG" class="flat" value="Y">
														</label>
														<i class="fa fa-edit taginput rk-input"></i>
														<input type="hidden" name="TAG_DEFAULT" class="form-control" value=""> 
														<label class="tag-checkbox">
															<input type="checkbox" name="MAIN" class="flat" ${row.MAIN=='Y'?'checked="checked"':'' } value="Y">
														</label>
														
													</td>
													--%>
													<td class="text-center">
														<label class="html-checkbox">
															<input type="checkbox" name="html" class="flat" checked="checked"  value="Y">
														</label>
													</td>
													<td class="text-center">
														<input type="number" name="count" class="form-control" value="15" />
													</td>
													<td class="text-center">
														<input type="text" name="images" class="form-control" value="thumb,file,gallery" />
													</td>
													<td><a href="#none" onclick="addCategory();" class="btn btn-info btn-sm"><i class="fa fa-check mr-1"></i><span>등록</span></a></td>
												</tr>
											</tfoot>
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
	<div class="modal fade category_code" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-lg">
	        <div class="modal-content">
	
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
	                <h4 class="modal-title" id="myModalLabel2">카테고리 코드</h4>
	            </div>
	            <div class="modal-body">
					<table class="table table-striped" id="cate-code">
					    <thead>
					        <tr>
					            <th style="width:40%;">카테고리 코드</th>
					            <th style="width:40%;">코드명</th>
					            <th>Action</th>
					        </tr>
					    </thead>
					    <tbody>
					    </tbody>
					    <tfoot>
					        <tr>
					            <td><input type="text" name="catecode" class="form-control" value="" required="required" /></td>
					            <td><input type="text" name="description" class="form-control" value="" required="required" /></td>
					            <td><a href="#none" onclick="addCateCode();" class="btn btn-info btn-sm"><i class="fa fa-check"></i><span>등록</span></a></td>
					        </tr>
					    </tfoot>
					</table>
	            </div>
	        </div>
	    </div>
	</div>
    <%@ include file="../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
	$(function(){
		$('.btn').data('toggle','modal').click(function(){
			if($(this).data('target')==".category_code"){
				loadCategoryCode();
			}
		});
		
	});
	
	function addCategory(){
		var params = {};
		$('#category tfoot tr input,#category tfoot tr select').each(function() {
			if($(this).attr('name')){
				params[$(this).attr('name')] = $(this).val();
			}
			
		});
		params['page'] = 'json';
		params['retype'] = 'insert';
		$.post('/mgmt/board/categoryProc',
			params,
			function(response){
				if(response.result=="ok"){
					window.location.reload();
				}else{
					alert(response.result);
				}
			}
		,'json');
	}
	function editCategory(id){
		var params = {};
		$('#category tbody tr[data-seq='+id+'] input,#category tbody tr[data-seq='+id+'] select').each(function() {
			if($(this).attr('name')){
				if($(this).attr('type')=='checkbox'){
					if($(this).is(':checked')){
						params[$(this).attr('name')] = 'Y';
					}else{
						params[$(this).attr('name')] = 'N';
					}
				}else{
					params[$(this).attr('name')] = $(this).val();
				}
			}
		});
		params['idx'] = id;
		params['page'] = 'json';
		params['retype'] = 'update';
		if(confirm("수정하시겠습니까?")){
			$.post('/mgmt/board/categoryProc',
				params,
				function(response){
					if(response.result="ok"){
						custom.showSwal('auto-close-text','수정되었습니다.','')
					}else{
						alert(response.result);
					}
				}
			,'json');
		}
	}
	function delCategory(id){
		var params = {};
		if(confirm("삭제하시겠습니까?")){
				params['idx'] = id;
				params['page'] = 'json';
				params['retype'] = 'delete';
			$.post('/mgmt/board/categoryProc',
				params,
				function(response){
					if(response.result="ok"){
						window.location.reload();
					}else{
						alert("삭제오류입니다.");
					}
				}
			,'json');
		}
	}




	/*
	 * 카테고리 코드 수정
	*/
	function loadCategoryCode(){
		var params = {};
		params['page'] = 'json';
		params['retype'] = 'list';
		$.post('/mgmt/board/cateCodeProc',params,function(response){
			if(response.result='ok'){
				$inputTr = '';
				$.each(response.list, function(i, item) {
					$inputTr += '<tr data-seq="'+item.CATECODE+'">';
					$inputTr += '    <td><input type="text" name="catecode" readonly="readonly" class="form-control" value="'+item.catecode+'" /></td>';
					$inputTr += '    <td><input type="text" name="description" class="form-control" value="'+item.description+'" /></td>';
					$inputTr += '    <td>';
					$inputTr += '		<a href="#none" onclick="editCateCode(\''+item.catecode+'\');" class="btn btn-info btn-fab btn-sm"><i class="fa fa-save" data-toggle="tooltip" data-placement="bottom" title="수정"></i></a>';
						$inputTr += '    	<a href="#none" onclick="delCateCode(\''+item.catecode+'\');" class="btn btn-info btn-fab btn-sm"><i class="fa fa-remove" data-toggle="tooltip" data-placement="bottom" title="삭제"></i></a>';
						$inputTr += '    </td>';
					$inputTr += '</tr>';
				});
				$('#cate-code tbody').html($inputTr);
				
			}else{
				alert("로딩오류 입니다.");
			}
		},'json');
	}
	function addCateCode(){
		var params = {};
		$('#cate-code tfoot tr input,#category tfoot tr select').each(function() {
			if($(this).attr('name')){
				params[$(this).attr('name')] = $(this).val();
			}
			
		});
		params['page'] = 'json';
		params['retype'] = 'insert';
					
		$.post('/mgmt/board/cateCodeProc',
			params,
			function(response){
				if(response.result='ok'){
					$('#cate-code tfoot [name="catecode"]').val("");
					$('#cate-code tfoot [name="description"]').val("");
					loadCategoryCode();
				}else{
					$errStr = "";
					$.each(response.data, function(i, item) {
						$errStr += response.data[i]+"\n";
					});
					alert($errStr);
				}
			}
		,'json');
	}
	function editCateCode(id){
		var params = {};
		$('#cate-code tbody tr[data-seq='+id+'] input,#cate-code tbody tr[data-seq='+id+'] select').each(function() {
			if($(this).attr('name')){
				params[$(this).attr('name')] = $(this).val();
			}
			
		});
		params['page'] = 'json';
		params['retype'] = 'update';
		params['id'] = id;
		if(confirm("수정하시겠습니까?")){
			$.post('/mgmt/board/cateCodeProc',
				params,
				function(response){
					if(response.result='ok'){
						loadCategoryCode();
					}else{
						$errStr = "";
						$.each(response.data, function(i, item) {
							$errStr += response.data[i]+"\n";
						});
						alert($errStr);
					}
				}
			,'json');
		}
	}
	function delCateCode(id){
		var params = {};
		params['CATECODE'] = id;
		params['page'] = 'json';
		params['retype'] = 'delete';
		if(confirm("삭제하시겠습니까?")){
			$.post('/mgmt/board/cateCodeProc',
				params,
				function(response){
					if(response.result='ok'){
						loadCategoryCode();
					}else{
						alert("삭제오류입니다.");
					}
				}
			,'json');
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