package com.krcon.elif.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.ExcelExportUtil;
import com.krcon.elif.pagination.PaginationInfo;
import com.krcon.elif.service.BoardService;
import com.krcon.elif.service.ProjectService;
import com.krcon.elif.service.LogService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.Board;
import com.krcon.elif.vo.BoardCate;
import com.krcon.elif.vo.BoardCateCode;
import com.krcon.elif.vo.BoardDownload;
import com.krcon.elif.vo.BoardFile;
import com.krcon.elif.vo.Log;
import com.krcon.elif.vo.Project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Configuration
@PropertySource("classpath:system.properties")

@RequestMapping(value = "mgmt")
@Controller
public class BoardController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.domainName}")
	private String domainName;

	@Resource(name = "boardService")
	private BoardService boardService;


	@Value("${sys.upload.boardslash}")
    private String boardSlash;

	@Resource(name = "logService")
	private LogService logService;
	
	private final String adminUrl = "mgmt";

	
	@Resource(name = "projectService")
	private ProjectService projectService;

	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/category" })
	public ModelAndView category(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/board/category");

		BoardCate boardCateVO = new BoardCate();
		boardCateVO.setPage("json");
		List<BoardCate> resultMap = boardService.selectBoardCategory(boardCateVO);
		mv.addObject("list", resultMap);

		BoardCateCode boardCateCodeVO = new BoardCateCode();
		boardCateCodeVO.setPage("json");
		List<BoardCateCode> codeMap = boardService.selectBoardCateCode(boardCateCodeVO);
		mv.addObject("code", codeMap);
		
		return mv;
	}

	
	/** 
	 * @param boardCateVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/category_list" })
	public ModelAndView category_list(BoardCate boardCateVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		boardCateVO.setPage("json");
		BoardCate detail = (BoardCate) boardService.selectBoardShortCategory(boardCateVO);
		mv.addObject("list", detail);
		mv.addObject("result", "ok");
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param boardCateVO
	 * @param boardVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/slugDuplicate", method = RequestMethod.POST)
	public ModelAndView slugDuplicate(BoardCate boardCateVO,Board boardVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (boardCateVO.getRetype().equals("category")) {
			int main_count = boardService.selectBoardCateCntSlug(boardCateVO);
			mv.addObject("COUNT", main_count);
		} else {
			int main_count = boardService.selectBoardSlug(boardVO);
			mv.addObject("COUNT", main_count);
		}
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param boardCateVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/categoryProc")
	public ModelAndView categoryProc(BoardCate boardCateVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		boardCateVO.setCrea_id(principal.getUsername());
		boardCateVO.setCrea_name(principal.getName());

		if (boardCateVO.getPage().equals("json")) {
			if (boardCateVO.getRetype().equals("insert")) {
				int slug_count = boardService.selectBoardCateCntSlug(boardCateVO);
				if (slug_count > 0) {
					mv.addObject("result", "dup");
				} else {
					boardService.insertCategory(boardCateVO, request);
					mv.addObject("result", "ok");
				}

			} else if (boardCateVO.getRetype().equals("update")) {
				boardService.updateCategory(boardCateVO, request);
				mv.addObject("result", "ok");
			} else if (boardCateVO.getRetype().equals("delete")) {
				boardService.deleteCategory(boardCateVO);
				mv.addObject("result", "ok");
			} else {
				mv.addObject("result", "err-type");
			}
		} else {
			mv.addObject("result", "err-page");
		}
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param boardCateCodeVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/cateCodeProc")
	public ModelAndView cateCodeProc(BoardCateCode boardCateCodeVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		boardCateCodeVO.setCrea_id(principal.getUsername());
		boardCateCodeVO.setCrea_name(principal.getName());

		if (boardCateCodeVO.getPage().equals("json")) {
			if (boardCateCodeVO.getRetype().equals("insert")) {
				int slug_count = boardService.selectBoardCateCodeCnt(boardCateCodeVO);
				if (slug_count > 0) {
					mv.addObject("result", "dup");
				} else {
					boardService.insertCateCode(boardCateCodeVO, request);
					mv.addObject("result", "ok");
				}

			} else if (boardCateCodeVO.getRetype().equals("update")) {
				boardService.updateCateCode(boardCateCodeVO, request);
				mv.addObject("result", "ok");
			} else if (boardCateCodeVO.getRetype().equals("delete")) {
				boardService.deleteCateCode(boardCateCodeVO);
				mv.addObject("result", "ok");
			} else if (boardCateCodeVO.getRetype().equals("list")) {
				List<BoardCateCode> detail = boardService.selectBoardCateCode(boardCateCodeVO);
				mv.addObject("list", detail);
				mv.addObject("result", "ok");
			} else {
				mv.addObject("result", "err-type");
			}
		} else {
			mv.addObject("result", "err-page");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/{pid}" })
	public ModelAndView list(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/board/list");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		BoardCate boardCateVO = new BoardCate();
		boardCateVO.setPid(pid);
		BoardCate boardCateDetail = (BoardCate) boardService.selectBoardCategoryDetail(boardCateVO);
		mv.addObject("category", boardCateDetail);
		
		
		if (boardCateDetail != null) {
			boardVO.setColfiletype(boardCateDetail.getSlug());
			if(boardCateDetail.getSlug().equals("catalog")) {
				if(boardVO.getLang()!=null) {
					String[] values = boardVO.getLang().split(",");
					if(values != null){
						boardVO.setLangs(values);
					}
				}
			}
			if(boardCateDetail.getImages()!=null){
				if (boardCateDetail.getImages().indexOf("gallery") > -1) {
					boardVO.setImages("GALLERY");
				} else {
					boardVO.setImages("SLIDE");
				}

			}

		}
		

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
        paginationInfo.setPageSize(boardVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();

		log.info("BOARD {}",boardVO);
        int total = boardService.selectBoardCount(boardVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		boardVO.setStart(start);
		boardVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Board> list = boardService.selectBoardList(boardVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}
		if (boardVO.getSdate() != null) {
			mv.addObject("sdate", boardVO.getSdate());
		}

		if (boardVO.getEdate() != null) {
			mv.addObject("edate", boardVO.getEdate());
		}

		mv.addObject("pid", boardVO.getPid());

		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}

		
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/{pid}/write" })
	public ModelAndView write(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/board/write");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		BoardCate boardCateVO = new BoardCate();
		
		boardCateVO.setPid(pid);
		BoardCate resultCategoryMap = boardService.selectBoardCategoryDetail(boardCateVO);
		mv.addObject("category", resultCategoryMap);
		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		
		
		Project projectVO = new Project();
		
		List<Project> project_list = projectService.selectProjectList(projectVO);
		mv.addObject("project_list", project_list);
		
		
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}
		if (boardVO.getSdate() != null) {
			mv.addObject("sdate", boardVO.getSdate());
		}

		if (boardVO.getEdate() != null) {
			mv.addObject("edate", boardVO.getEdate());
		}

		mv.addObject("pid", boardVO.getPid());
		if (boardVO.getPid() != 0) {
			mv.addObject("pid", boardVO.getPid());
		}
		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mv.addObject("toDay", df.format(cal.getTime()));
        cal.add(Calendar.MONTH, 1);
		mv.addObject("fromDay", df.format(cal.getTime()));
		// int main_count=boardService.selectBoardCount(commandMap.getMap());
		// mv.addObject("MAIN_COUNT",main_count);
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/{pid}/writeProc")
	public ModelAndView writeProc(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		boardVO.setPid(pid);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		boardVO.setCrea_id(principal.getUsername());
		boardVO.setCrea_name(principal.getName());
		
		if (boardVO.getTitle_sub() == null) {
			boardVO.setTitle_sub("");
		}
		if (boardVO.getSlug() == null) {
			boardVO.setSlug("");
		}
		if (boardVO.getContents() == null) {
			boardVO.setContents("");
		}
		if (boardVO.getGubun() == null) {
			boardVO.setGubun("");
		}
		if (boardVO.getStart_dtm() == null) {
			boardVO.setStart_dtm(null);
		}
		if (boardVO.getEnd_dtm() == null) {
			boardVO.setEnd_dtm(null);
		}
		if (boardVO.getSection() == null) {
			boardVO.setSection("");
		}
		if (boardVO.getRecom() == null) {
			boardVO.setRecom("N");
		}
		if (boardVO.getTags() == null) {
			boardVO.setTags("");
		}
		if (boardVO.getStatus() == null) {
			boardVO.setStatus("Y");
		}
		if (boardVO.getMainstatus() == null) {
			boardVO.setMainstatus("N");
		}
		if (boardVO.getVideo() == null) {
			boardVO.setVideo("");
		}
		if (boardVO.getContents_mobile() == null) {
			boardVO.setContents_mobile("");
		}
		boardVO.setCateslug(boardService.selectBoardCategoryIpSlug(boardVO.getPid()));
		boardService.insertBoard(boardVO, request);
		mv.setViewName("redirect:/" + adminUrl + "/board/"+boardVO.getPid());
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/{pid}/view" })
	public ModelAndView view(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/board/view");
		BoardCate boardCateVO = new BoardCate();
		boardCateVO.setPid(pid);
		BoardCate boardCateDetail = boardService.selectBoardCategoryDetail(boardCateVO);
		mv.addObject("category", boardCateDetail);
		
		boardVO.setPid(pid);
		boardVO.setPagetype("ADMIN");
		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map",detail);
		
	    List<String> imagesList = Arrays.asList(boardCateDetail.getImages().split(","));
	    
	    BoardFile boardFileVO = new BoardFile();
	    boardFileVO.setBoard_idx(detail.getIdx());

	    Map<String, Object> inputFiles = new LinkedHashMap<String, Object>();
	    Map<String, Object> inputMobFiles = new LinkedHashMap<String, Object>();
	    for(String item : imagesList){
    		boardFileVO.setFile_gubun(item);
    		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
    		inputFiles.put(item, fileList);
    		
    		boardFileVO.setFile_gubun("mob"+item);
    		List<BoardFile> fileMobList = boardService.selectFileList(boardFileVO);
    		inputMobFiles.put("mob"+item, fileMobList);
	    }
	    
		if (inputFiles.size()>0) {
			mv.addObject("files", inputFiles);
		}
		if (inputMobFiles.size()>0) {
			mv.addObject("mobfiles", inputMobFiles);
		}

		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}
		if (boardVO.getSdate() != null) {
			mv.addObject("sdate", boardVO.getSdate());
		}

		if (boardVO.getEdate() != null) {
			mv.addObject("edate", boardVO.getEdate());
		}

		mv.addObject("pid", boardVO.getPid());

		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/board/{pid}/modify" })
	public ModelAndView modify(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/board/modify");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		BoardCate boardCateVO = new BoardCate();
		boardCateVO.setPid(pid);
		BoardCate boardCateDetail = boardService.selectBoardCategoryDetail(boardCateVO);
		mv.addObject("category", boardCateDetail);
		
		Project projectVO = new Project();
		
		List<Project> project_list = projectService.selectProjectList(projectVO);
		mv.addObject("project_list", project_list);
		System.out.println("$$$$$$$$$$$$$$$$$$$$"+boardVO.getPjt_cd());
		
		boardVO.setPid(pid);
		boardVO.setPagetype("ADMIN");
		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map",detail);
		if(!CommonUtils.isEmpty(boardCateDetail.getImages())){

			List<String> imagesList = Arrays.asList(boardCateDetail.getImages().split(","));
	    
			BoardFile boardFileVO = new BoardFile();
			boardFileVO.setBoard_idx(detail.getIdx());
			
			Map<String, Object> inputFiles = new LinkedHashMap<String, Object>();
			Map<String, Object> inputMobFiles = new LinkedHashMap<String, Object>();
			for(String item : imagesList){
				boardFileVO.setFile_gubun(item);
				List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
				inputFiles.put(item, fileList);
				
				boardFileVO.setFile_gubun("mob"+item);
				List<BoardFile> fileMobList = boardService.selectFileList(boardFileVO);
				inputMobFiles.put("mob"+item, fileMobList);
			}
			
			if (inputFiles.size()>0) {
				mv.addObject("files", inputFiles);
			}
			if (inputMobFiles.size()>0) {
				mv.addObject("mobfiles", inputMobFiles);
			}
		}
		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}
		if (boardVO.getSdate() != null) {
			mv.addObject("sdate", boardVO.getSdate());
		}

		if (boardVO.getEdate() != null) {
			mv.addObject("edate", boardVO.getEdate());
		}

		mv.addObject("pid", boardVO.getPid());

		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/{pid}/modifyProc")
	public ModelAndView modifyProc(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/" + adminUrl + "/board/"+pid+"");
		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		
		boardVO.setUpda_id(principal.getUsername());
		boardVO.setUpda_name(principal.getName());
		
		boardVO.setPid(pid);
		if (boardVO.getTitle_sub() == null) {
			boardVO.setTitle_sub("");
		}
		if (boardVO.getContents() == null) {
			boardVO.setContents("");
		}
		if (boardVO.getSlug() == null) {
			boardVO.setSlug("");
		}
		if (boardVO.getGubun() == null) {
			boardVO.setGubun("");
		}
		if (boardVO.getStart_dtm() == null) {
			boardVO.setStart_dtm(null);
		}
		if (boardVO.getEnd_dtm() == null) {
			boardVO.setEnd_dtm(null);
		}
		if (boardVO.getSection() == null) {
			boardVO.setSection("");
		}
		if (boardVO.getRecom() == null) {
			boardVO.setRecom("N");
		}
		if (boardVO.getTags() == null) {
			boardVO.setTags("");
		}
		if (boardVO.getTags() == null) {
			boardVO.setTags("");
		}
		if (boardVO.getStatus() == null) {
			boardVO.setStatus("Y");
		}
		if (boardVO.getMainstatus() == null) {
			boardVO.setMainstatus("N");
		}
		if (boardVO.getVideo() == null) {
			boardVO.setVideo("");
		}
		if (boardVO.getContents_mobile() == null) {
			boardVO.setContents_mobile("");
		}
		if (boardVO.getPjt_cd() == null) {
			boardVO.setPjt_cd("");
		}
		boardVO.setCateslug(boardService.selectBoardCategoryIpSlug(boardVO.getPid()));
		boardService.updateBoard(boardVO, request);

		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}
		if (boardVO.getSdate() != null) {
			mv.addObject("sdate", boardVO.getSdate());
		}

		if (boardVO.getEdate() != null) {
			mv.addObject("edate", boardVO.getEdate());
		}

		mv.addObject("pid", boardVO.getPid());

		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}
		mv.addObject("IDX", boardVO.getIdx());
		if (boardVO.getReturnUrl() != null) {
			mv.addObject("ALERT", "수정이 완료 되었습니다.");
			mv.setViewName("redirect:" + boardVO.getReturnUrl());
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @param pid
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/{pid}/deleteProc")
	public ModelAndView deleteProc(Board boardVO, HttpServletRequest request, @PathVariable("pid") int pid) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/board/"+pid);
		boardVO.setPid(pid);

		boardService.deleteBoard(boardVO,request);

		
		mv.addObject("currentPageNo", boardVO.getCurrentPageNo());
		if (boardVO.getTarget() != null) {
			mv.addObject("target", boardVO.getTarget());
		}
		if (boardVO.getKeyword() != null) {
			mv.addObject("keyword", boardVO.getKeyword());
		}

		mv.addObject("pid", boardVO.getPid());

		if (boardVO.getTypes() != null) {
			mv.addObject("types", boardVO.getTypes());
		}
		return mv;
	}
	
	/** 
	 * @param boardVO
	 * @param request
	 * @return HashMap<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> openAjaxProfile(Board boardVO, HttpServletRequest request) throws Exception {
		int status = boardService.updateStatus(boardVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}

	
	/** 
	 * @param boardFileVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/board/fileDelete")
	public ModelAndView deletFileProc(BoardFile boardFileVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		boardService.deleteFile(boardFileVO,request);
		mv.addObject("result", "ok");
		mv.setViewName("jsonView");

		return mv;
	}

	
	/** 
	 * @param boardDownloadVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/data" })
	public ModelAndView selectDownloadList(BoardDownload boardDownloadVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/board/download");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(boardDownloadVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(boardDownloadVO.getRecordCountPerPage());
        paginationInfo.setPageSize(boardDownloadVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = boardService.selectDownloadCount(boardDownloadVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		boardDownloadVO.setStart(start);
		boardDownloadVO.setEnd(paginationInfo.getLastRecordIndex());

        List<BoardDownload> list = boardService.selectDownloadList(boardDownloadVO);
         
        List<BoardDownload> delist = boardService.selectDownloadDeleteList(boardDownloadVO);
        mv.addObject("delist", delist);
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);

		mv.addObject("currentPageNo", boardDownloadVO.getCurrentPageNo());
		if (boardDownloadVO.getTarget() != null) {
			mv.addObject("target", boardDownloadVO.getTarget());
		}
		if (boardDownloadVO.getKeyword() != null) {
			mv.addObject("keyword", boardDownloadVO.getKeyword());
		}
		
		return mv;
	}


	
	/** 
	 * @param boardDownloadVO
	 * @param reason
	 * @param request
	 * @return ResponseEntity<byte[]>
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/data/exceldown" })
    public ResponseEntity<byte[]> data_exceldown(BoardDownload boardDownloadVO,@RequestParam(name = "reason") String reason, HttpServletRequest request) throws Exception {
        /*** 1. 운영자로그 - 엑셀다운로그에 로그저장 ***/
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		Log logVO = new Log();
		logVO.setUsername(principal.getName());
		logVO.setUserid(principal.getUserid());
		logVO.setDepartment(principal.getDepartment());
		logVO.setAccess_menu("자료실 엑셀 다운로드");
		logVO.setReason(reason);
		logVO.setLogin_ip(principal.getLogin_ip());
    	logService.insertLogExcel(logVO);
        
        /*** 2. 엑셀파일 생성 ***/
    	Long startTime = System.currentTimeMillis();
        List<BoardDownload> list = boardService.selectDownloadList(boardDownloadVO);
        
        ExcelExportUtil excelUtil = new ExcelExportUtil();
         ResponseEntity<byte[]> result = excelUtil.makeDataDownload(list);

        Long endTime = System.currentTimeMillis();
        log.info("download excel request->" + (endTime - startTime) / 1000 + " seconds");


        return result;
    }
	
	/** 
	 * @param boardDownloadVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/data/delete" })
	public ModelAndView deleteNewsletter(BoardDownload boardDownloadVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/customer/data");
		boardService.deleteDownloadAll(boardDownloadVO);
		return mv;
	}
}