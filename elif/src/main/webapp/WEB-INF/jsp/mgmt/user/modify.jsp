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
                                        <i class="material-icons">assignment</i>
                                    </div>
                                    <h4 class="card-title ">관리자 수정</h4>
                                </div>
                                <div class="card-body">
                                    <form class="form-horizontal" id="user_submit" action="/mgmt/user/modifyProc" role="form" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" id="DUP" value="0" />
                                        <input type="hidden" name="userid" value="${map.userid }" />
					                    <input type="hidden" name="idx" value="${map.idx }">
                                        <input type="hidden" name="menus" value='${map.menus}' />
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">아이디 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
													<input type="text" class="form-control" value="${map.userid }" disabled>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이메일 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
													<input type="email" name="email" class="form-control" value="${map.email }" required title="이메일" data-title="이메일을">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">비밀번호</label>

                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <button type="button" class="btn btn-sm btn-info" id="password-reset">비밀번호 재설정 메일</button>
                                                </div>
                                            </div>
                                        </div>
                                        <%--
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">비밀번호</label>

                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="password" class="form-control" id="password" name="password" value="" minlength="6" maxlength="13" title="비밀번호" data-title="비밀번호를" equalTo="password2">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">비밀번호확인</label>

                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="password" class="form-control" id="password2" value="" minlength="6" maxlength="13" title="비밀번호" data-title="비밀번호를">
                                                </div>
                                            </div>
                                        </div> 
                                        --%>
                                        
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이름 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="name" value="${map.name }" required minlength="2" maxlength="10" title="이름" data-title="이름을">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">운영자 권한 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios">
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="grants" value="ROLE_ADMIN" ${map.grants=='ROLE_ADMIN'?'checked="checked"':'' }> Master
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="grants" value="ROLE_LOCAL" ${map.grants=='ROLE_LOCAL'?'checked="checked"':'' }> Local
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">소속 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="department" required title="소속" data-title="소속을" value="${map.department }">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">사번 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="enumber" required title="사번" data-title="사번을" value="${map.enumber }">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">시작일 <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${map.start_dtm }"/>
                                                        <input type="text" name="start_dtm" class="form-control sdate" required title="시작일" data-title="시작일을" placeholder="시작일" value="${start_dtm }" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <fmt:formatDate var="end_dtm" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${map.end_dtm }"/>
                                                        <input type="text" name="end_dtm" class="form-control edate" required title="종료일" data-title="종료일을" placeholder="종료일" value="${end_dtm }" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">관리자 메뉴 권한 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios pt-2">
                                                <div class="row">
                                                <c:choose>
                                                    <c:when test="${fn:length(mapmenus) > 0}">
                                                        <c:forEach items="${mapmenus }" var="row" varStatus="status">
                                                            <div class="col-md-6 col-lg-3" data-check_idx="${row.idx}">
                                                                <div class="form-check">
                                                                <label class="mb-0 form-check-label">
                                                                    <div class="mb-1 text-black text-large font-weight-bold" >
                                                                        <input class="category_check form-check-input" type="checkbox">
                                                                        ${row.name}
	                                                                    <span class="form-check-sign">
	                                                                        <span class="check"></span>
	                                                                    </span>
                                                                    </div>
                                                                </label>
                                                                </div>
	                                                            <c:forEach items="${row.children }" var="item">
	                                                            <div class="form-check mb-3">
	                                                                <label class="form-check-label">
	                                                                    <input class="form-check-input" name="admenus" type="checkbox" value="${item.idx}">
	                                                                    ${item.name} <%-- (${item.url}) --%>
	                                                                    <span class="form-check-sign">
	                                                                        <span class="check"></span>
	                                                                    </span>
	                                                                </label>
	                                                            </div>
	                                                            </c:forEach>
	                                                        </div>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">사용여부 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios">
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="enabled" value="1" ${map.enabled==true?'checked="checked"':'' }> 사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="enabled" value="0" ${map.enabled==false?'checked="checked"':'' }> 미사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
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
                                            <div class="col-2">

                                            </div>
                                            <div class="col-10">
				                                <a href="javascript:doSubmit('user_submit');" class="btn btn-primary">수정</a>
												<a href="javascript:;" id="delete" class="btn btn-danger"> 삭제 </a>
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
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
	(function($){
        $('[data-check_idx] h4').on('click',function(){
            $(this).parent().find('[name=admenus]').each(function(){
                $(this).prop('checked',true);
            });
        });
        if($('[name=grants]:checked').val()=='ROLE_ADMIN'){
            $('[data-check_idx]').each(function(index,item){
                $(this).find('[name=admenus]').addClass('readonly');
                $('.category_check').addClass('readonly');
            });
        }else{
            $('[data-check_idx]').each(function(index,item){
                $(this).find('[name=admenus]').removeClass('readonly');
                $('.category_check').removeClass('readonly');
                
            });
        }
        $('[name=grants]').change(function(){
            if($(this).val()=='ROLE_ADMIN'){
                $('[name=admenus]').prop('checked',true);
                $('.category_check').prop('checked',true);
                $('[data-check_idx]').each(function(index,item){
                    $(this).find('[name=admenus]').addClass('readonly');
                    $('.category_check').addClass('readonly');
                });
            }else{
                $('[name=admenus]').prop('checked',false);
                $('.category_check').prop('checked',false);
                $('[data-check_idx]').each(function(index,item){
                    $('.category_check').removeClass('readonly');
                    $(this).find('[name=admenus]').removeClass('readonly');
                });
            }
        });
		$("#password2").change(function(){
			if($("#password").val() === $(this).val()){
				
			}else{
				$(this).focus();
				alert("입력하신 비밀번호가 일치하지 않습니다.");
			}
		});
	    $("#list").on("click", function(e){ //목록 버튼
	        e.preventDefault();
	        fn_openBoardList();
        });
        if(IsJsonString('${map.menus}')){
            var menuParse = JSON.parse('${map.menus}');
            $.each(menuParse,function(index,data){
                var comma = data.split(',');
                if(comma.length>0){
                    $.each(comma,function(idx,ele){
                        $('[name=admenus][value="'+ele+'"]').prop('checked',true);
                    });
                }
            });

        }
	    $("#delete").on("click", function(e){ //삭제 버튼
	    	if(confirm("삭제하시겠습니까?")){
		        e.preventDefault();
		        fn_deleteBoard();
	    	}
        });
        $('#password-reset').click(function(){
            var params = {};
			if(confirm("${map.name}님의 비밀번호를 재설정 하시겠습니까?")){
	    			params['page'] = 'json';
				$.post('/mgmt/user/${map.idx }/password-reset',
					params,
					function(response){
						if(response.result="ok"){
							alert('${map.name}님의 메일로 비밀번호를 전송했습니다.')
						}else{
							alert("삭제오류입니다.");
						}
					}
				,'json');
			}
        });
	})(jQuery);
    function category_check(){
        $('.category_check').on('change',function(){
            if($(this).is(':checked')){
                $(this).closest('[data-check_idx]').find('[name=admenus]').prop('checked',true);
            }else{
                $(this).closest('[data-check_idx]').find('[name=admenus]').prop('checked',false);
            }
        });
    }
    $('[data-check_idx]').each(function(){
        if($(this).find('[name=admenus]:checked').length==$(this).find('[name=admenus]').length){
            $(this).find('.category_check').prop('checked',true);
        }
    });
    category_check();
    function checkToJson(){
        var checkArr = {};
        $('[data-check_idx]').each(function(index,item){
            var checkArr2 = "";
            var checkArrCnt = 0;
            $(this).find('[name=admenus]').each(function(){
                if($(this).is(':checked')){
                    if(checkArrCnt>0){
                        checkArr2 += ","+$(this).val();
                    }else{
                        checkArr2 += $(this).val();
                    }
                    checkArrCnt++;
                }
                
            });
            if(checkArr2.length>0){
                checkArr[$(this).data('check_idx')]= checkArr2;
            }
        });
        if(Object.keys(checkArr).length>0){
            return JSON.stringify(checkArr);
        }else{
            return "";
        }
        
    }
	function fn_openBoardList(){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/user");
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
	    comSubmit.submit();
	}
	function doSubmit(frm){
        if(confirm("수정하시겠습니까?")){
            var checkJson = checkToJson();
            $('[name=menus]').val(checkJson);
            if(checkJson==""){
                alert("관리자 메뉴 권한을 선택해 주세요.");
                return false;
            }
            if(checkValidation(frm)){
                $('form#'+frm).submit();
            }
        }else{
            return false;
        }
	}
	function fn_deleteBoard(){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/user/deleteProc");
	    comSubmit.addParam("idx", "${map.idx}");
	    /* comSubmit.addParam("userid", "${map.userid}"); */
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