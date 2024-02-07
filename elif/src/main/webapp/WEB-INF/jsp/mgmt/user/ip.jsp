<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="req" value="${pageContext.request}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <%@ include file="../include/head.jsp" %>
</head>


<body class="nav-md">

    <div class="container body">


        <div class="main_container">
			
            <div class="col-md-3 left_col">
                <%@ include file="../include/sidebar.jsp" %>
            </div>
            <!-- top navigation -->
            <div class="top_nav">
                <%@ include file="../include/top.jsp" %>
            </div>
            <!-- /top navigation -->

            <!-- page content -->
            <div class="right_col" role="main">
				<div class="page-wrap page-list" data-menu="/mgmt/user/ip">
					<div class="page-title">
					    <div class="title_left">
							<h3>IP 관리</h3>
					    </div>
						<div class="title_right">
							<div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
					        </div>
					    </div>
					</div>
					<div class="clearfix"></div>
					
					<div class="row">
					
					    <div class="col-md-12 col-sm-12 col-xs-12">
					        <div class="x_panel">
					            <div class="x_title">
					                <h2>목록<small>아이피가 0.0.0.0 이 목록에 있으면 어디서나 접속 가능합니다.</small></h2>									
					                <div class="clearfix"></div>
					            </div>
					            <div class="x_content  table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action" id="category">
										<thead>
											<tr class="headings">
												<th width="10%" class="column-title text-center">ID </th>
												<th width="40%" class="column-title text-center">IP </th>
												<th class="column-title text-center">Description </th>
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
															<input type="text" name="IP" class="form-control inp-ip" data-inputmask="'alias': 'ip'" im-insert="true" value="${row.IP }" maxlength="15" />
														</td>
														<td class="text-center"><input type="text" name="DESCRIPTION" class="form-control" value="${row.DESCRIPTION }"/></td>
														<td class=" last">
															<a href="#none" onclick="editIP(${row.idx });" class="btn btn-info btn-tbl-add"><i class="fa fa-save" data-toggle="tooltip" data-placement="bottom" title="수정"></i></a>
															<a href="#none" onclick="delIP(${row.idx });" class="btn btn-info btn-tbl-add"><i class="fa fa-remove" data-toggle="tooltip" data-placement="bottom" title="삭제"></i></a>
														</td>
													</tr>
										        </c:forEach>
										    </c:when>
										    <c:otherwise>
											<tr>
												<td colspan="7">컨텐츠가 없습니다.</td>
											</tr>
										    </c:otherwise>
										</c:choose>
										</tbody>
									    <tfoot>
									        <tr>
									            <td></td>
												<td><input type="text" name="IP" class="form-control inp-ip" value="${clientIP }" maxlength="15" /></td>
									            <td><input type="text" name="DESCRIPTION" class="form-control" value="" required="required" /></td>
									            <td><a href="#none" onclick="addIP();" class="btn btn-info btn-tbl-add"><i class="fa fa-check"></i><span>등록</span></a></td>
									        </tr>
									    </tfoot>
									</table>
					            </div>
					        </div>
					    </div>
					</div>
				</div>
                <!-- footer content -->
                <%@ include file="../include/footer.jsp" %>
                <!-- /footer content -->

            </div>
            <!-- /page content -->
        </div>
    <%@ include file="../include/script.jsp" %>
	<script src="/resource/assets/js/tags/jquery.tagsinput.min.js"></script>
    <script src="https://rawgit.com/RobinHerbots/Inputmask/4.x/dist/jquery.inputmask.bundle.js"></script>
	<script src="/resource/assets/js/forminp.js"></script>
	
	<script>
	try{
		$('.inp-ip').inputmask({
		    alias: "ip",
		    "placeholder": "_"
		});
	}catch(e){}
		function addIP(){
			var params = {};
			$('#category tfoot tr input,#category tfoot tr select').each(function() {
				if($(this).attr('name')){
					params[$(this).attr('name')] = $(this).val();
				}
				
			});
			params['page'] = 'json';
			params['retype'] = 'insert';
			$.post('ipProc',
				params,
				function(response){
					if(response.result=="ok"){
						window.location.reload();
					}else if(response.result=="dup"){
						alert('사용할 수 없는 IP 입니다.');
					}else{
						alert(response.result);
					}
				}
			,'json');
		}
		function editIP(id){
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
				$.post('ipProc',
					params,
					function(response){
						if(response.result="ok"){
							//window.location.reload();
							console.log(response.result);
						}else{
							alert(response.result);
						}
					}
				,'json');
			}
		}
		function delIP(id){
			var params = {};
			if(confirm("삭제하시겠습니까?")){
	    			params['idx'] = id;
	    			params['page'] = 'json';
	    			params['retype'] = 'delete';
				$.post('ipProc',
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
	</script>
</body>

</html>