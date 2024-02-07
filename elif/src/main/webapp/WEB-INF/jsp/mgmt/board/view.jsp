<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head> <%@ include file="../include/head.jsp"%>
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/board/${pid}">
		<%@ include file="../include/sidebar.jsp"%> 
		<div class="main-panel"> 
			<c:choose>
			<c:when test="${category.slug=='catalog'}">
			<jsp:include page="../include/top.jsp">
			<jsp:param name="searchHtml" value="catalog" />
			</jsp:include>
			</c:when>
			<c:otherwise>
			<jsp:include page="../include/top.jsp">
			<jsp:param name="searchHtml" value="board" />
			</jsp:include>
			</c:otherwise>
			</c:choose>
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
									<h4 class="card-title ">${category.description } 게시판 상세</h4>
								</div>
								<div class="card-body">
									<c:if test="${not empty map.title}">
										<div class="row">
											<label class="col-sm-2 col-form-label">제목 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.title } </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.title_sub}">
										<div class="row">
											<label class="col-sm-2 col-form-label">서브 제목 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.title_sub } </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.lang}">
										<div class="row">
											<label class="col-sm-2 col-form-label">언어 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.lang} </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:choose>
										<c:when test="${category.slug=='popup'}">
											<c:if test="${not empty map.section}">
												<div class="row">
													<label class="col-sm-2 col-form-label">웹 모바일 선택</label>
													<div class="col-sm-10">
														<div class="form-group">
															<div class="form-control-static"> ${map.section} </div>
														</div>
													</div>
												</div>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${not empty map.section}">
												<div class="row">
													<label class="col-sm-2 col-form-label">그룹사</label>
													<div class="col-sm-10">
														<div class="form-group">
															<div class="form-control-static"> ${map.section } </div>
														</div>
													</div>
												</div>
											</c:if>
										</c:otherwise>
									</c:choose>
									<c:if test="${fn:length(category.types) > 0}">
										<div class="row">
											<label class="col-sm-2 col-form-label">구분 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.gubun } </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.contents}">
										<div class="row">
											<label class="col-sm-2 col-form-label">내용 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.contents } </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.contents_mobile}">
										<div class="row">
											<label class="col-sm-2 col-form-label">모바일 내용 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.contents_mobile } </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.tags}">
										<div class="row">
											<label class="col-sm-2 col-form-label">썸네일 노출 내용 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${fn:replace(map.tags,lf,'<br>')} </div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${category.code=='social' }">
										<div class="row">
											<label class="col-sm-2 col-form-label">비디오 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<div class="embed-responsive embed-responsive-16by9">
															<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/${map.video}"></iframe>
														</div> ${map.video}
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${category.slug == 'mainslide'}">
										<div class="row">
											<label class="col-sm-2 col-form-label">URL <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.video} <label class="btn btn-xs btn-warning">${map.RECOM=='Y'?'새창':'현재창'}</label>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${category.slug=='gallery'}">
										<div class="row">
											<label class="col-sm-2 col-form-label">비디오 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<a href="${map.video}" target="_blank">${map.video}</a>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<div class="row">
										<label class="col-sm-2 col-form-label">조회수</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static"> ${map.HIT_CNT} </div>
											</div>
										</div>
									</div>
									<c:if test="${not empty map.status}">
										<div class="row">
											<label class="col-sm-2 col-form-label">공개여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<span class="btn btn-default btn-sm">${map.status=="Y"?"공개":"비공개"}</span>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty map.mainstatus}">
										<div class="row">
											<label class="col-sm-2 col-form-label">메인공개여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<span class="btn btn-default btn-sm">${map.mainstatus=="Y"?"공개":"비공개"}</span>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${category.code=='event'}">
										<div class="row">
											<label class="col-sm-2 col-form-label">추천여부 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.recom=='Y'?'추천':''} </div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">시작일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.start_dtm} </div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">종료일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static"> ${map.end_dtm} </div>
												</div>
											</div>
										</div>
									</c:if>
									<div class="row">
										<label class="col-sm-2 col-form-label">작성일</label>
										<div class="col-sm-10">
											<div class="form-group">
                                                <fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.crea_dtm }"/>
												<div class="form-control-static"> ${crea_dtm} </div>
											</div>
										</div>
									</div>
									<c:if test="${not empty map.upda_dtm}">
										<div class="row">
											<label class="col-sm-2 col-form-label">수정일 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
												<fmt:formatDate var="upda_dtm" pattern="yyyy-MM-dd" value="${map.upda_dtm }"/>
													<div class="form-control-static"> ${upda_dtm} </div>
												</div>
											</div>
										</div>
									</c:if>
									<div class="row">
										<label class="col-sm-2 col-form-label">작성자</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static"> ${map.name} </div>
											</div>
										</div>
									</div>
									<c:if test="${not empty files}">
										<div class="row">
											<label class="col-sm-2 col-form-label">웹 업로드 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<c:forEach var="fileGubun" items="${files}" varStatus="status">
															<c:if test="${fn:length(fileGubun.value) > 0}">
															<c:choose>
																<c:when test="${fileGubun.key == 'thumb'}">
																	<c:set var="itemTitle" value="썸네일" />
																</c:when>
																<c:when test="${fileGubun.key == 'file'}">
																	<c:set var="itemTitle" value="파일" />
																</c:when>
																<c:when test="${fileGubun.key == 'gallery'}">
																	<c:set var="itemTitle" value="이미지" />
																</c:when>
																<c:when test="${fileGubun.key == 'slide'}">
																	<c:set var="itemTitle" value="슬라이드" />
																</c:when>
																<c:when test="${fileGubun.key == 'main'}">
																	<c:set var="itemTitle" value="메인이미지" />
																</c:when>
																<c:otherwise>
																	<c:set var="itemTitle" value="${fileGubun.key}" />
																</c:otherwise>
															</c:choose>
															<h2 class="title page-header">${itemTitle }</h2>
															<div class="attachment">
																<ul>
																	<c:forEach var="row" items="${fileGubun.value }">
																		<li>
																			<a href="${domainName}${row.path_name }${row.stored_file_name }" data-idx="${row.idx }" class="atch-thumb imgpopup">
																				<c:choose>
																					<c:when test="${fileGubun.key == 'file'}">
																						<i class="fa fa-file-o"></i>
																					</c:when>
																					<c:otherwise>
																						<img src="${domainName}${row.path_name }${row.stored_file_name }" alt="img">
																					</c:otherwise>
																				</c:choose>
																			</a>
																			<div class="file-name">${row.ORIGINAL_FILE_NAME }</div><span>
																				<fmt:formatNumber value="${row.FILE_SIZE }" pattern="#,###.#" />KB</span>
																			<div class="links">
																				<a href="${domainName}${row.path_name }${row.stored_file_name }" data-idx="${row.idx }" class="imgpopup">View</a> - <a href="${domainName}${row.path_name }${row.stored_file_name }" data-idx="${row.idx }" name="file">Download</a>
																			</div>
																		</li>
																	</c:forEach>
																</ul>
															</div>
															</c:if>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${not empty mobfiles}">
										<div class="row">
											<label class="col-sm-2 col-form-label">모바일 업로드 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group">
													<div class="form-control-static">
														<c:forEach var="fileGubun" items="${mobfiles}" varStatus="id">
															<c:if test="${fn:length(fileGubun.value) > 0}">
															<c:choose>
																<c:when test="${fileGubun.key == 'mobthumb'}">
																	<c:set var="itemTitle" value="썸네일" />
																</c:when>
																<c:when test="${fileGubun.key == 'mobfile'}">
																	<c:set var="itemTitle" value="파일" />
																</c:when>
																<c:when test="${fileGubun.key == 'mobgallery'}">
																	<c:set var="itemTitle" value="이미지" />
																</c:when>
																<c:when test="${fileGubun.key == 'mobslide'}">
																	<c:set var="itemTitle" value="슬라이드" />
																</c:when>
																<c:when test="${fileGubun.key == 'mobmain'}">
																	<c:set var="itemTitle" value="메인이미지" />
																</c:when>
																<c:otherwise>
																	<c:set var="itemTitle" value="${fileGubun.key}" />
																</c:otherwise>
															</c:choose>
															<h2 class="title page-header">${itemTitle }</h2>
															<div class="attachment">
																<ul>
																	<c:forEach var="row" items="${fileGubun.value }">
																		<li>
																			<a href="${domainName}${row.PATH_NAME }${row.STORED_FILE_NAME }" data-idx="${row.idx }" class="atch-thumb imgpopup">
																				<c:choose>
																					<c:when test="${fileGubun.key == 'mobfile'}">
																						<i class="fa fa-file-o"></i>
																					</c:when>
																					<c:otherwise>
																						<img src="${domainName}${row.PATH_NAME }${row.STORED_FILE_NAME }" alt="img">
																					</c:otherwise>
																				</c:choose>
																			</a>
																			<div class="file-name">${row.ORIGINAL_FILE_NAME }</div><span>
																				<fmt:formatNumber value="${row.FILE_SIZE }" pattern="#,###.#" />KB</span>
																			<div class="links">
																				<a href="${domainName}${row.PATH_NAME }${row.STORED_FILE_NAME }" data-idx="${row.idx }" class="imgpopup">View</a> - <a href="${domainName}${row.PATH_NAME }${row.STORED_FILE_NAME }" data-idx="${row.idx }" name="file">Download</a>
																			</div>
																		</li>
																	</c:forEach>
																</ul>
															</div>
															</c:if>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-2">
											</div>
											<div class="col-10">
												<a href="javascript:;" onclick="" class="btn btn-info" id="modify">수정</a>
												<a href="javascript:;" class="btn btn-danger" id="delete">삭제</a>
												<a href="javascript:;" class="btn btn-info" id="list">목록</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> <%@ include file="../include/footer.jsp"%>
		</div>
	</div> <%@ include file="../include/script.jsp"%> <form id="commonForm" name="commonForm" method="get"></form>
	<script>
		(function ($) {

			$("#list").on("click", function (e) { //목록 버튼
				e.preventDefault();
				fn_openBoardList();
			});

			$("#modify").on("click", function (e) {
				e.preventDefault();
				fn_openBoardUpdate();
			});

			$("#delete").on("click", function (e) { //삭제 버튼
				if (confirm("삭제하시겠습니까?")) {
					e.preventDefault();
					fn_deleteBoard();
				}
			});
			$("a[name='file']").on("click", function (e) { //파일 이름
				e.preventDefault();
				fn_downloadFile($(this));
			});
		})(jQuery);
		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/board/list/${pid}");
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
			if("${!empty LANG}"=="true"){
				comSubmit.addParam("LANG", "${LANG}");
			}
			comSubmit.submit();
		}

		function fn_openBoardUpdate() {
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/board/${pid}/modify");
			comSubmit.addParam("idx", idx);
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
			if("${!empty LANG}"=="true"){
				comSubmit.addParam("LANG", "${LANG}");
			}
			comSubmit.submit();
		}
		function fn_deleteBoard() {
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/board/${pid}/deleteProc");
			if ("${!empty target}" == "true") {
				comSubmit.addParam("target", "${target}");
			}
			if ("${!empty keyword}" == "true") {
				comSubmit.addParam("keyword", "${keyword}");
			}
			if ("${!empty param.gubun}" == "true") {
				comSubmit.addParam("gubun", "${param.gubun}");
			}
			if("${!empty LANG}"=="true"){
				comSubmit.addParam("LANG", "${LANG}");
			}
			comSubmit.addParam("idx", idx);
			comSubmit.submit();

		}
		function fn_downloadFile(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/downloadFile");
			comSubmit.addParam("idx", obj.data("idx"));
			comSubmit.addParam("BOARD_NAME", "BOARD");
			comSubmit.submit();
		}
	</script>
</body>

</html>