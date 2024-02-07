<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/product/code">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
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
                                    <h4 class="card-title ">코드 관리</h4>
                                </div>
                                <div class="card-body">
									<div class="row">
										<label class="col-sm-1 col-form-label">코드타입</label>
										<div class="col-sm-2">
											<div class="form-group">
												<div class="input-group">
													<select name="code_type" class="selectpicker" data-style="select-with-transition">
                                                        <option value="krice">KR 산업단지 관리</option>
                                                        <option value="krcon">계룡 건설 단지 관리</option>
                                                    </select>
												</div>
											</div>
										</div>
										<label class="col-sm-1 col-form-label">코드</label>
										<div class="col-sm-2">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="code" class="form-control "  maxlength="250"/>
												</div>
											</div>
										</div>
										<label class="col-sm-1 col-form-label">코드명</label>
										<div class="col-sm-2">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="code_name" class="form-control "  maxlength="250"/>
												</div>
											</div>
										</div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-info" id="btnWrite">등록</button>
										</div>
									</div>
                                    
                                    <div class="ln_solid mt-4"></div>
                                    
                                    <div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
                                                <th width="14%" class="column-title text-center">타입</th>
                                                <th width="14%" class="column-title text-center">코드</th>
                                                <th width="" class="column-title text-center">코드명</th>
                                                <th width="10%" class="column-title text-center">수정</th>
                                                <th width="10%" class="column-title text-center">삭제</th>
                                            </tr>
										</thead>
										<tbody>
										 <c:choose>
										    <c:when test="${fn:length(list) > 0}">
											    <c:forEach items="${list }" var="row">
													<tr data-code="${row.code}">
														<td class="text-center">
                                                            <input type="hidden" name="prev_code" value="${row.code}">
                                                            <select name="code_type" id="code_type" class="selectpicker" data-style="select-with-transition">
                                                                <option value="KRICE" ${row.code_type=='KRICE'?'selected':''}>KR 산업단지 관리</option>
                                                                <option value="KRCON" ${row.code_type=='KRCON'?'selected':''}>계룡단지 관리</option>
                                                            </select>
                                                        </td>
														<td class="text-center"><input type="text" name="code" class="form-control text-center" style = "border:none" readonly value="${row.code }" maxlength="250"/></td>
														<td class="text-center"><input type="text" name="code_name" class="form-control text-center" style = "border:none" readonly value="${row.code_name}" maxlength="250"/></td>
														<td class="text-center"><input type="button" class="btn btn-success btn-sm" name="btnModify" value="수정" /></td>
														<td class="text-center"><input type="button" class="btn btn-danger btn-sm" name="btnDelete" value="삭제" /></td>
													</tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
										        <tr>
										            <td colspan="6">조회된 결과가 없습니다.</td>
										        </tr>
										    </c:otherwise>
										</c:choose>
										
										</tbody>
									</table>
                                    </div>
                                </div>

                                <div class="card-footer">
									<div class="w-100 pb-3">
                                        <div class="row">
                                            <div class="col-6">
                                                <%-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalExcelDownForm"> 엑셀 다운로드</button> --%>
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
    $(function() {
	<c:if test="${not empty SITE_ERROR}">
	alert("${sessionScope["SITE_ERROR"]}");
	<c:remove var="SITE_ERROR" scope="session" />
	</c:if>
		
	

        $('[name=frmSearch]').submit(function() {
            if ($(this).find('#txt').val() == "") {
                location.href = "/mgmt/product/code";
                return false;
            }
        });
		$(document).on('change','.chkcode',function(){
			if($(this).is(':checked')){
				$('#'+$(this).data('target')).attr('disabled',false);
			}else{
				$('#'+$(this).data('target')).attr('disabled',true).val();
			}
		});
        
        $("#btnWrite").click(function() {
			
        	var code = $("#code").val();
        	var code_type = $("#code_type").val();
        	var code_name = $("#code_name").val();
        	if(code == ''){
				alert('코드를 입력해주세요.');
				return;
			}

        	var comSubmit = new ComSubmit();
            comSubmit.setMethod("POST");
            comSubmit.addParam("_csrf", $('meta[name="_csrf"]').attr('content'));
    	    comSubmit.setUrl("/mgmt/complexcode/write");
    	    comSubmit.addParam("code", code);
    	    comSubmit.addParam("code_type", code_type);
    	    comSubmit.addParam("code_name", code_name);
    	   
    	    comSubmit.submit();
        })
        
        $("input[name='btnModify']").click(function() {
       		var tr = $(this).closest('tr');
        	var prev_code = tr.find('[name="prev_code"]');
        	var code = tr.find('[name="code"]');
        	var code_type = tr.find('[name="code_type"]');
            var code_name = tr.find('[name="code_name"]');
          
        	if( $(this).val() == '수정' ) {
        		$(this).toggleClass("btn-primary btn-success");
        		$(this).val("확인");
                code.attr("readonly",false);
                code_type.attr("readonly",false);
                code_name.attr("readonly",false);
       	    }
       	    else {
       	    	$(this).val('수정');
       	    	$(this).toggleClass("btn-success btn-primary");
				code.attr("readonly",true);
	            code_type.attr("readonly",true);
	            code_name.attr("readonly",true);
	            	
                var comSubmit = new ComSubmit();
                comSubmit.setMethod("POST");
                comSubmit.addParam("_csrf", $('meta[name="_csrf"]').attr('content'));
                comSubmit.setUrl("/mgmt/complexcode/modify");
                // comSubmit.setMethod('post');
                comSubmit.addParam("prev_code", prev_code.val());
                comSubmit.addParam("code", code.val());
                comSubmit.addParam("code_type", code_type.val());
                comSubmit.addParam("code_name", code_name.val());
                
                comSubmit.submit();
	        }
        	
        	//$("#txtKR").css("border","");
        	//$("#txtKR").attr("readonly",false);
        })
        
        $("input[name='btnDelete']").click(function() {
        	if(confirm("개별 코드를 삭제하시겠습니까?")){
        		var tr = $(this).closest('tr');
        		var comSubmit = new ComSubmit();
                comSubmit.setMethod("POST");
                comSubmit.addParam("_csrf", $('meta[name="_csrf"]').attr('content'));
		       	comSubmit.setUrl("/mgmt/complexcode/delete");
		       	comSubmit.addParam("code", tr.data('code'));
		       	comSubmit.submit();
        	}
        })
        
    });
    
	
	
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/product/code");
		if("${!empty param.division}"=="true"){
			comSubmit.addParam("division", "${param.division}");
		}
		
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
		
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