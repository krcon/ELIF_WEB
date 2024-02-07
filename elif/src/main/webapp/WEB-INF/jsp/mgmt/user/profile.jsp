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
    <div class="wrapper " data-menu="/mgmt/user">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../include/top.jsp">
                <jsp:param name="searchHtml" value="member" />
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
                                    <h4 class="card-title ">개인정보 수정</h4>
                                </div>
                                <div class="card-body">
								<form class="form-horizontal" id="user_submit" action="/mgmt/user/modifyProc" role="form" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="userid" value="${map.userid }" />
									<input type="hidden" name="idx" value="${map.idx }">
									<input type="hidden" name="profile" value="${profile }">
									<div class="row">
										<label class="col-sm-2 col-form-label">아이디</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">
													${map.userid }
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">
													${map.name }
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-10">
											<div class="form-group">
												<input type="email" name="email" class="form-control" value="${map.email }">
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">소속</label>
										<div class="col-sm-10">
											<div class="form-group">
												<input type="text" class="form-control" name="department" value="${map.department }">
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">사번</label>
										<div class="col-sm-10">
											<div class="form-group">
												<input type="text" class="form-control" name="enumber" value="${map.enumber }">
											</div>
										</div>
									</div>
                                </div>
                                <div class="card-footer">
									<div class="w-100 pb-3">
                                        <div class="row">
                                            <div class="col-2">

                                            </div>
                                            <div class="col-10">
				                                <a href="javascript:doSubmit('user_submit');" class="btn btn-primary">수정</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
							</form>
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
	function doSubmit(frm){
		if(confirm('수정하시겠습니까?')){
			if(checkValidation(frm)){
				$('form#'+frm).submit();
			}
		}else{
			return false;
		}
	}
	</script>
</body>

</html>