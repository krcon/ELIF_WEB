<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/customer/manager">
        <%@ include file="../../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="sub" value="admin" />
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
                                    <h4 class="card-title ">수정</h4>
                                </div>
                                <div class="card-body">
                                    <form class="form-horizontal" id="modify" name="modify" action="/mgmt/customer/manager/modifyProc" role="form" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="idx" value="${map.idx}" />
                                        <input type="hidden" name="lang" value="KO">
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">아이디 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="userid" maxlength="50" value="${map.userid}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이름 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="name" value="${map.name}" required minlength="2" maxlength="50" title="이름" data-title="이름을">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이메일 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input type="email" class="form-control" name="email" value="${map.email}" required minlength="2" maxlength="50" title="이메일" data-title="이메일을">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">소속 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="department" maxlength="100" value="${map.department}">
                                                </div>
                                            </div>
                                        </div>
										<c:if test="${map.crea_name!=null }">
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
										</c:if>
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
                                            	<a href="javascript:fn_delete('${map.idx}');" class="btn btn-danger">삭제</a>
				                                <a href="javascript:doSubmit('modify');" class="btn btn-primary">수정</a>
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
            <%@ include file="../../include/footer.jsp"%>
        </div>
    </div>
    <%@ include file="../../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
    var product_interest = false;
	(function($){
	    $("#list").on("click", function(e){ //목록 버튼
	        e.preventDefault();
	        fn_adminList();
        });
	    
	    $("[name='inquiry_interest_arr']").prop('disabled', true);
        $("[name=inquiry_type_arr]").each(function(){
            if($("[name=inquiry_type_arr]:checked").val() == "PRODUCT"){
                $("[name='inquiry_interest_arr']").prop('disabled', false);
            }
        });
	    $("[name=inquiry_type_arr]").click(function(){
            $("[name=inquiry_type_arr]").each(function(){
                if($("[name=inquiry_type_arr]:checked").val() == "PRODUCT"){
                    $("[name='inquiry_interest_arr']").prop('disabled', false);
                    product_interest = true;
                }else{
                    $("[name='inquiry_interest_arr']").prop('disabled', true).prop("checked", false);
                    product_interest = false;
                    
                }
            });
	    });
        
	})(jQuery);
	
	
	function fn_adminList(){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/customer/manager");
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		if("${!empty inquiry_type}"=="true"){
			comSubmit.addParam("inquiry_type", "${inquiry_type}");
		}
	    comSubmit.submit();
	}
	
	function fn_delete(idx){
		if (confirm("삭제하시겠습니까?")) {
			var comSubmit = new ComSubmit();
		    comSubmit.setUrl("/mgmt/customer/manager/delete");
		    comSubmit.addParam("idx",idx);
		   
		    comSubmit.submit();
		}
	}
	
	function doSubmit(frm){ 
		if(confirm('수정하시겠습니까?')){
            if($('[name='+frm+'] [name=lang]').attr('type')=='hidden'){
                if($('[name='+frm+'] [name=lang_arr]').length>0){
                    if($('[name='+frm+'] [name=lang_arr]:checked').length == 0){
                        alert("선택된 언어가 없습니다.");
                        return false;
                    }
                    var arr = $('[name='+frm+'] [name=lang_arr]:checked').map( function () {
                        return $(this).val();
                    }).get().join();
                    $('[name='+frm+'] [name=lang]').val(arr);
                }
            }
            if($('[name='+frm+'] [name=inquiry_type]').attr('type')=='hidden'){
                if($('[name='+frm+'] [name=inquiry_type_arr]').length>0){
                    product_interest = true;
                    if($('[name='+frm+'] [name=inquiry_type_arr]:checked').length == 0){
                        alert("선택된 문의 유형이 없습니다.");
                        return false;
                    }
                    var arr = $('[name='+frm+'] [name=inquiry_type_arr]:checked').map( function () {
                        return $(this).val();
                    }).get().join();
                    $('[name='+frm+'] [name=inquiry_type]').val(arr);
                }
            }
            if($('[name='+frm+'] [name=inquiry_interest]').attr('type')=='hidden'&&product_interest){
                if($('[name='+frm+'] [name=inquiry_interest_arr]').length>0){
                    if($('[name='+frm+'] [name=inquiry_interest_arr]:checked').length == 0){
                        alert("선택된 관심분야가 없습니다.");
                        return false;
                    }
                    var arr = $('[name='+frm+'] [name=inquiry_interest_arr]:checked').map( function () {
                        console.log($(this).val());
                        return $(this).val();
                    }).get().join();
                    console.log(arr);
                    $('[name='+frm+'] [name=inquiry_interest]').val(arr);
                }
            }
			if(checkValidation(frm)){
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