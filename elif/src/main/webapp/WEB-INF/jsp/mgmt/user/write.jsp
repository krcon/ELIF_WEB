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
                                    <h4 class="card-title ">관리자 추가</h4>
                                </div>
                                <div class="card-body">
                                    <form class="form-horizontal" id="write" action="/mgmt/user/writeProc" role="form" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" id="DUP" value="0" />
                                        <input type="hidden" name="menus" value="" />
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">아이디 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control username" minlength="5" maxlength="16" name="userid" required minlength="2" maxlength="255" title="아이디" data-title="아이디를">
                                                        <span class="input-group-btn">
                                                            <button type="button" id="btnOverlapChk" class="btn btn-sm btn-info">중복체크</button>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="lead text-small">
                                                * 아이디는 최소 5자 이상 최대 16자 이하로 입력해 주세요.<br>
                                                * 아이디는 영소문자와 숫자 조합으로 적용 가능합니다.<br>
                                                * 아이디는 개인 신상정보가 포함되지 않도록 주의해주십시오.<br>
                                                - 개인 신상정보 : 생년월일, 전화번호, 사번 등
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이름 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control nameonly" name="name" value="" required minlength="2" maxlength="255" title="이름" data-title="이름을">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">이메일 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input type="email" class="form-control" name="email" required minlength="2" maxlength="255" title="이메일" data-title="이메일을">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- 
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">비밀번호</label>

                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="password" class="form-control" id="password" name="password" value="" required minlength="6" maxlength="13" title="비밀번호" data-title="비밀번호를" equalTo="password2">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">비밀번호확인</label>

                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="password" class="form-control" id="password2" value="" required minlength="6" maxlength="13" title="비밀번호" data-title="비밀번호를">
                                                </div>
                                            </div>
                                        </div> 
                                        --%>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">운영자 권한 <span></span></label>
                                            <div class="col-sm-10 checkbox-radios">
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="grants" value="ROLE_ADMIN" checked=""> Master
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="grants" value="ROLE_LOCAL" > Local
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
                                                    <input type="text" class="form-control" name="department" required title="소속" data-title="소속을" value="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label">사번 <span></span></label>
                                            <div class="col-sm-10">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" name="enumber" required title="사번" data-title="사번을" value="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 col-form-label" for="start_dtm">사용기간 <span></span></label>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="start_dtm" class="form-control sdate" required title="시작일" data-title="시작일을" placeholder="시작일" value="${toDay}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group bmd-form-group">
                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                        <input type="text" name="end_dtm" class="form-control edate" required title="종료일" data-title="종료일을" placeholder="종료일" value="${fromDay}" />
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
	                                                                    <input class="form-check-input" name="admenus" type="checkbox" value="${item.idx}" checked>
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
                                                        <input class="form-check-input" type="radio" name="enabled" value="1" checked=""> 사용
                                                        <span class="circle">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="radio" name="enabled" value="0"> 미사용
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
                                                <a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-sm btn-primary">등록</a>
                                                <a href="javascript:;" id="list" class="btn btn-sm btn-primary"> 목록 </a>
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
                $(this).find('.category_check').addClass('readonly');
            });
        }else{
            $('[data-check_idx]').each(function(index,item){
                $(this).find('[name=admenus]').removeClass('readonly');
                $(this).find('.category_check').removeClass('readonly');
            });
        }
        $('[name=grants]').change(function(){
            if($(this).val()=='ROLE_ADMIN'){
                $('[name=admenus]').prop('checked',true);
                $('.category_check').prop('checked',true);
                $('[data-check_idx]').each(function(index,item){
                    $(this).find('[name=admenus]').addClass('readonly');
                    $(this).find('.category_check').addClass('readonly');
                });
            }else{
                $('[name=admenus]').prop('checked',false);
                $('.category_check').prop('checked',false);
                $('[data-check_idx]').each(function(index,item){
                    $(this).find('[name=admenus]').removeClass('readonly');
                    $(this).find('.category_check').removeClass('readonly');
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
		$('#btnOverlapChk').click(function(){
            if( $('[name=userid]').val().length < 5 ){
                alert("아이디는 최소 5자 이상 최대 16자 이하로 입력해 주세요. ");
                return;
            }
            var valiID = ["admin", "webadmin", "master", "root"];
            if(jQuery.inArray($('[name=userid]').val(), valiID)>-1){
                alert('사용이 불가능한 아이디입니다. 다른 아이디를 입력해 주세요.');
                return;
            }
            var jsonData = {
                "userid": $('[name=userid]').val()
            }
            $.ajax({
                type: 'POST',
                url:'/mgmt/user/emailSearch',
                data: jsonData,
                dataType: 'json',
                async: true,
                cache :false,
                success: function(data){
                    if(data.result==0){
                        alert("사용할 수 있는 아이디입니다.");
                        $("#DUP").val(1);
                    }else{
                        alert("사용중인 아이디입니다.");
                        $("#DUP").val(0);
                    }
                },
                error:function(xhr,status,error){
                    alert( "관리자에게 문의하시기 바랍니다." );
                }
            });
		});
	    $("#list").on("click", function(e){ //목록 버튼	
	        e.preventDefault();
	        fn_openBoardList();
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

	function fn_openBoardList(){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/user");
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
        if($("#DUP").val()=='0'){
            alert('아이디 중복체크 후 등록해 주세요.');
            return;
        }
		if(checkValidation(frm)){
            var checkJson = checkToJson();
            $('[name=menus]').val(checkJson);
            if(checkJson==""){
                alert("관리자 메뉴 권한을 선택해 주세요.");
                return false;
            }
			$('form#'+frm).submit();
		}
    }
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
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
	</script>
</body>

</html>