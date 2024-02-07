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
    <div class="wrapper " data-menu="/mgmt/board/${pid}">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../include/top.jsp">
			<jsp:param name="searchHtml" value="board" />
			<jsp:param name="sub" value="${category.slug}" />
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
                                    <h4 class="card-title ">${category.description } 게시판 리스트</h4>
                                </div>
                                <div class="card-body">
					            <c:choose>
					                <c:when test="${category.code=='list'||category.code=='social'}">
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<c:if test="${not empty category.types }">
													<th width="10%" class="column-title text-center">카테고리</th>
													</c:if>
													<th class="column-title text-center">제목 </th>
													<th width="10%" class="column-title text-center">작성자</th>
													<th width="8%" class="column-title text-center">조회수</th>
													<th width="8%" class="column-title text-center">노출여부</th>
													<c:if test="${category.slug=='notice'}">
													<th width="8%" class="column-title text-center">공지여부</th>
													</c:if>
													<th width="10%" class="column-title text-center">게시일</th>
													<th width="10%" class="column-title text-center">등록일</th>
												</tr>
											</thead>
											<tbody>
											
								            <c:choose>
								                <c:when test="${fn:length(list) > 0}">
								                	<c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
								                    <c:forEach items="${list }" var="row">
													<tr>
														<td class="text-center">
															${num }
															<c:set var="num" value="${num-1}"/>
														</td>
														<c:if test="${not empty category.types }">
														<td class="text-center">${ct:getBoardType(row.gubun)}</td>
														</c:if>
														<td>
															<a href="javascript:void(0);" data-modidx="${row.idx }">${row.title }</a>
															<c:if test="${row.file_count>0}">
															&nbsp;&nbsp;<span class="fa fa-floppy-o" data-toggle="tooltip" data-placement="bottom" title="" data-html="true"></span>
															</c:if>
														</td>
														<td class="text-center">${ct:getMaskedName(row.crea_name)}</td>
														<td class="text-center">${row.hit_cnt }</td>
														<td class="text-center">
															<button type="button" class="btn-flag-status btn-normal" data-idx="${row.idx}">${row.status }</button>
														</td>
														<c:if test="${category.slug=='notice'}">
														<td class="text-center">${row.mainstatus }</td>
														</c:if>
                                                        <fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.start_dtm }"/>
														<td class="text-center">${start_dtm}</td>
                                                        <fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
														<td class="text-center">${crea_dtm}</td>
													</tr>
								                    </c:forEach>
								                </c:when>
								                <c:otherwise>
								                    <tr>
								                        <td colspan="13">등록된 글이 없습니다.</td>
								                    </tr>
								                </c:otherwise>
								            </c:choose>
											</tbody>
										</table>
						            </div>
					            
					                </c:when>
									<c:otherwise>
									<!-- 갤러리 타입 -->
						            <div class="pt-5">
					                    <div class="row">											
								            <c:choose>
								                <c:when test="${fn:length(list) > 0}">
								                    <c:forEach items="${list }" var="row" varStatus="status">
													<div class="col-md-4">
														<div class="card card-product">
															<div class="card-header card-header-image" data-header-animation="false">
																<a href="javascript:;" data-modidx="${row.idx }">
																	<c:choose>
																		<c:when test="${category.code=='social'}">
																		<img src="https://img.youtube.com/vi/${row.video}/0.jpg" alt="image" />
																		</c:when>
																		<c:otherwise>
																		<img src="${domainName}${row.img_name }" alt="image" />
																		</c:otherwise>
																	</c:choose>
																</a>
															</div>
															<div class="card-body">
																<h5 class="card-title">
																	<a href="javascript:;" data-modidx="${row.idx }">
																		<c:if test="${fn:length(category.types) > 0}">
																		[${row.gubun }]
																		</c:if>
																		<c:if test="${category.slug=='popup' }">
																		[${row.SECTION }]
																		</c:if>
																		${row.title }
																		<c:if test="${category.slug=='mainslide'}">
																		(${row.SECTION==null?'없음':row.SECTION})
																		</c:if>
																	</a>
																</h5>
																<div class="card-description"><c:out value='${fn:substring(row.contents.replaceAll("\\\<.*?\\\>"," ").replaceAll("&nbsp;"," "),0, 70)}' escapeXml="false" /></div>
															</div>
															<div class="card-footer">
																<div class="stats">
																	<div class="date">${fn:substring(row.start_dtm,0,10)}</div>
																</div>
																<div class="stats">
																	<p class="card-category">${row.crea_name }</p>
																</div>
															</div>
														</div>
													</div>
													<c:set var="totalCount" value="${paginationInfo.totalRecordCount }"/>
								                    </c:forEach>
								                </c:when>
								                <c:otherwise>
								                    <div class="col-md-12 dataTables_empty">등록된 글이 없습니다.</div>
								                </c:otherwise>
								            </c:choose>
										</div>
										<div class="ln_solid"></div>
						            </div>
						            
					                </c:otherwise>
					            </c:choose>
                                </div>
                                <div class="card-footer">
									<div class="w-100 pb-3">
                                        <div class="row">
                                            <div class="col-6">
                                                <a href="javascript:;" onclick="fn_openBoardWrite(this)" class="btn btn-primary">등록</a>
                                            </div>
                                            <div class="col-6 text-right">
												<div class="pull-right">
													<ul class="pagination">
														<c:if test="${not empty paginationInfo}">
															<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
														</c:if>
													</ul>
													<input type="hidden" id="currentPageNo" name="currentPageNo" />
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
	(function($){
	    $("a[data-idx]").on("click", function(e){ //제목 
	        e.preventDefault();
	        fn_openBoardDetail($(this));
	    });
	    $("a[data-modidx]").on("click", function(e){ //제목 
	        e.preventDefault();
	        fn_openBoardUpdate($(this));
	    });
		$('tr[data-href]').on("dblclick", function() {
		    document.location = $(this).data('href');
		}).css({'cursor':'pointer'});
		
		$('tr[data-href]').on("doubletap", function() {
		    document.location = $(this).data('href');
		});
	    $("#btnSearch").click(function(){
	    	$("form[name=search]").submit();
	    });
		$(document).on('click','.btn-flag-status',function(){
			if(confirm('수정하시겠습니까?')){
				var thisEle = $(this);
				var status =thisEle.text();
				if(status=='Y'){
					status = 'N';
				}else{
					status = 'Y';
				}
				var jsonData = {'idx':thisEle.data('idx'),'status':status}
				$.ajax({
					type: 'POST',
					url: 'status',
					data: jsonData,
					dataType: 'json',
					async: true,
					cache: false,
					success: function (data) {
						console.log(data);
						if(data.result==true){
							thisEle.html(status);
							alert('변경되었습니다.');
						}
					},
					error: function (xhr, status, error) {
						alert('관리자에게 문의하시기 바랍니다.');
					}
				});
			}
		});
	})(jQuery);

	function fn_openBoardWrite(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/board/${pid}/write");
	    comSubmit.submit();
	}
	function fn_openBoardDetail(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/board/${pid}/view");
	    comSubmit.addParam("idx", obj.data("idx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
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

	function fn_openBoardUpdate(obj) {
		var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/board/${pid}/modify");
	    comSubmit.addParam("idx", obj.data("modidx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if ("${!empty target}" == "true") {
			comSubmit.addParam("target", "${target}");
		}
		if ("${!empty keyword}" == "true") {
			comSubmit.addParam("keyword", "${keyword}");
		}
		if ("${!empty param.gubun}" == "true") {
			comSubmit.addParam("gubun", "${param.gubun}");
		}
		comSubmit.submit();
	}

	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/board/${pid}");
	    comSubmit.addParam("currentPageNo", pageNo);
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