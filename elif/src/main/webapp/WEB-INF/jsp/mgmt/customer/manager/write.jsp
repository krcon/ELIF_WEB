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
                                        <i class="material-icons">supervisor_account</i>
                                    </div>
                                    <h4 class="card-title ">고객문의 담당자 등록</h4>
                                </div>
                                <div class="card-body">
                                    <form class="form-horizontal" id="write" name="write" action="/mgmt/customer/manager/writeProc" role="form" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="lang" value="KO">
                                        
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">아이디 <span></span></label>
                                            <div class="col-sm-10 col-lg-3">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control username" minlength="5" maxlength="16" name="userid" required minlength="2" maxlength="255" title="아이디" data-title="아이디를">
                                                        <span class="input-group-btn">
                                                            <button type="button" id="btn-admin" class="btn btn-sm btn-info">조회</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이름 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="name" value="" disabled minlength="2" maxlength="50" title="이름" data-title="이름을">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이메일 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input type="email" class="form-control" name="email" disabled minlength="2" maxlength="50" title="이메일" data-title="이메일을">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">소속 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="department" value="" maxlength="100" disabled title="소속" data-title="소속을">
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
                                                <a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-sm btn-primary">등록</a>
                                                <a href="javascript:;" id="list" class="btn btn-sm btn-info"> 목록 </a>
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
	    
		$(document).on('click','#btn-admin',function(){
			var userid = $('[name="userid"]').val();
			if(userid.length<3){
				alert('아이디를 입력해주세요.');
				return;
			}
			var jsonData = {'userid':userid}
			$.ajax({
				type: 'POST',
				url: '/mgmt/user/ajaxProfile',
				data: jsonData,
				dataType: 'json',
				async: true,
				cache: false,
				success: function (data) {
					if(data.status==true){
                        $('[name=name]').val(data.name);
                        $('[name=email]').val(data.email);
                        $('[name=department]').val(data.department);
                    }else{
                        alert('찾을수 없는 아이디 입니다.');
                        return;
                    }
				},
				error: function (xhr, status, error) {
					alert('관리자에게 문의하시기 바랍니다.');
				}
			});
		});
	    
	})(jQuery);
	
	
	function fn_adminList(){
		if(confirm('목록으로 이동하시겠습니까?')){
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
	}
	function doSubmit(frm){
		if(checkValidation(frm)){
			if(confirm('추가 하시겠습니까?')){
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