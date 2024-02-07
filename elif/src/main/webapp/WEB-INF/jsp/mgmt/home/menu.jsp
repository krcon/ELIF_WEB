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
    <div class="wrapper " data-menu="/mgmt/menu/list">
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
										메뉴 관리
									</h4>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 col-lg-6">
                                            <div class="treeview">
                                                <ul class="list-group" style="border:none;border-bottom:1px solid #eee;padding-bottom:10px;">
                                                    <c:choose>
                                                        <c:when test="${fn:length(list) > 0}">
                                                            <c:forEach items="${list }" var="row">
                                                                <li class="list-group-item" data-idx="${row.idx}" data-name="${row.name}" data-sort="${row.sort}" data-url="${row.url}" >
                                                                    <div class="row">
                                                                        <div class="col-sm-8">
                                                                            ${row.idx}. 
                                                                            <a href="javascript:void(0);" class="mod-node" data-toggle="tooltip" title="수정">${row.name} (${row.url})</a>
                                                                        </div>
                                                                        <div class="col-sm-3">
                                                                            <span class="sort-node sort-node-${row.level}"><input type="text" name="sort_${row.idx}" disabled class="form-control text-center" value="${row.sort}"></span>
                                                                        </div>
                                                                        <div class="col-sm-1">
                                                                            <a href="javascript:void(0);" class="add-node float-right"><i class="material-icons" data-toggle="tooltip" title="등록">add</i></a>
                                                                        </div>
                                                                    </div>
                                                                </li>

                                                                    <c:if test="${row.children.size()>0}">
                                                                    <c:forEach items="${row.children }" var="item">
                                                                        
                                                                        <li class="list-group-item" data-idx="${item.idx}" data-name="${item.name}" data-sort="${item.sort}" data-url="${item.url}" >
                                                                            <div class="row">
                                                                                <div class="col-sm-8">
                                                                                    <span class="indent"></span>
                                                                                    ${item.idx}. 
                                                                                    <a href="javascript:void(0);" class="mod-node" data-toggle="tooltip" title="수정">${item.name} (${item.url})</a>
                                                                                </div>
                                                                                <div class="col-sm-3">
                                                                                    <span class="sort-node sort-node-${item.level}"><input type="text" name="sort_${item.idx}" disabled class="form-control text-center" value="${item.sort}"></span>
                                                                                </div>
                                                                                <div class="col-sm-1">
                                                                                    <a href="javascript:void(0);" class="add-node float-right"><i class="material-icons" data-toggle="tooltip" title="등록">add</i></a>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                    </c:forEach>
                                                                    </c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-xl-6 d-none" id="form">
                                            <div class="sticky-top" id="right-fixed">
                                                <div  data-spy="scroll" class="card">
                                                    <h4 class="card-header">
                                                    코드 <span>추가</span>
                                                    </h4>
                                                    <div class="card-body">
                                                        
                                                        <div class="row" id="code-wrap">
                                                            <label class="col-sm-2 col-form-label" for="parent_code">부모 코드</label>
                                                            <div class="col-sm-3">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="text" name="parent_idx" class="form-control" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="text" disabled class="form-control" id="parent_name" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-sm-2 col-form-label" for="name">메뉴명</label>
                                                            <div class="col-sm-10">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="text" name="name" class="form-control" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <label class="col-sm-2 col-form-label" for="url">URL</label>
                                                            <div class="col-sm-10">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="text" name="url" class="form-control" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <label class="col-sm-2 col-form-label" for="icons">아이콘</label>
                                                            <div class="col-sm-10">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="text" name="icons" class="form-control" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-sm-2 col-form-label" for="sort">정렬</label>
                                                            <div class="col-sm-10">
                                                                <div class="form-group bmd-form-group">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="number" name="sort" class="form-control" value=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-2"></div>
                                                            <div class="col-10">
                                                                <a href="javascript:addMenu();" class="btn btn-round btn-info" id="code-btn-add">추가</a>
                                                                <a href="javascript:editMenuProc();" class="btn btn-round btn-info" id="code-btn-mod">수정</a>
                                                                <a href="javascript:delMenuProc();" class="btn btn-round btn-danger" id="code-btn-del">삭제</a>
                                                                
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
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp"%>
        </div>
    </div>

    <%@ include file="../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
	$(function(){
        $('.treeview .list-group-item span').click(function() {
            $('.treeview .list-group-item').removeClass('active');
            if(!$(this).closest('li').hasClass('active')){
                $(this).closest('li').addClass('active');
            }
        });
        $('.treeview .add-node').click(function(){
            $('#form').removeClass('d-none');
            $('#code-wrap').show();
            $('#form').find('h4 span').html('추가');
            $('[name=parent_idx]').val($(this).closest('li').data('idx'));
            $('#parent_name').val($(this).closest('li').data('name'));
            $('[name=user_nm]').val('');
            $('[name=url]').val('/mgmt/');
            $('[name=icons]').val('');
            $('[name=sort]').val(1);
            $('#code-btn-add').show();
            $('#code-btn-del').hide();
            $('#code-btn-mod').hide();
        });
        $('.treeview .mod-node').click(function(){
            $('#form').removeClass('d-none');
            $('#code-wrap').hide();
            $('#form').find('h4 span').html('수정');
            $('[name=parent_idx]').val($(this).closest('li').data('idx'));
            $('#parent_name').val($(this).closest('li').data('name'));
            $('[name=user_nm]').val($(this).closest('li').data('name'));
            $('[name=url]').val($(this).closest('li').data('url'));
            $('[name=icons]').val($(this).closest('li').data('icons'));
            $('[name=sort]').val($(this).closest('li').data('sort'));
            $('#code-btn-add').hide();
            $('#code-btn-del').show();
            $('#code-btn-mod').show();
        });
	});
	function editMenuProc(){
        editMenu($('[name=parent_idx]').val());
    }
	function addMenu(){
		var params = {};
		$('#form input,#form select').each(function() {
			if($(this).attr('name')){
				params[$(this).attr('name')] = $(this).val();
			}
			
		});
		params['page'] = 'json';
		params['retype'] = 'insert';
		$.post('proc',
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
	function editMenu(id){
		var params = {};
		$('#form input,#form select').each(function() {
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
        swal({
            text: "수정하시겠습니까?",
            showCancelButton: true,
            confirmButtonText: '네!',
            cancelButtonText: '아니오!',
            confirmButtonClass: "btn btn-success",
            cancelButtonClass: "btn btn-danger",
            buttonsStyling: true
        }).then(function (result) {
            console.log(result);
            if (result.value==true) {
                $.post('proc',
                    params,
                    function(response){
                        if(response.result="ok"){
                            $('[name=sort_'+id+']').val(params['sort']);
                            custom.showSwal('auto-close','수정되었습니다. 리로드를 해주세요.',500);
                            // window.location.reload();
                        }else{
                            alert(response.result);
                        }
                    }
                ,'json');
            } else {
                console.log("취소");
            } 
        });
	}
	function delMenuProc(){
        delMenu($('[name=parent_idx]').val());
    }
	function delMenu(id){
		var params = {};
		if(confirm("삭제하시겠습니까?")){
				params['idx'] = id;
				params['page'] = 'json';
				params['retype'] = 'delete';
			$.post('proc',
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

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
	</script>
</body>

</html>