package com.krcon.elif.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.krcon.elif.service.PopupService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.Popup;
import com.krcon.elif.vo.PopupFile;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.pagination.PaginationInfo;

@Configuration
@PropertySource("classpath:system.properties")

@Controller
public class PopupController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.domainName}")
	private String domainName;

	@Resource(name = "popupService")
	private PopupService popupService;

	private final String adminUrl = "mgmt";
	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/" + adminUrl + "/popup" })
	public ModelAndView list(Popup popupVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/popup/list");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(popupVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(popupVO.getRecordCountPerPage());
        paginationInfo.setPageSize(popupVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = popupService.selectBoardCount(popupVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		popupVO.setStart(start);
		popupVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Popup> list = popupService.selectBoardList(popupVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", popupVO.getCurrentPageNo());
		if (popupVO.getTarget() != null) {
			mv.addObject("target", popupVO.getTarget());
		}
		if (popupVO.getKeyword() != null) {
			mv.addObject("keyword", popupVO.getKeyword());
		}

		mv.addObject("pid", popupVO.getPid());

		if (popupVO.getTypes() != null) {
			mv.addObject("types", popupVO.getTypes());
		}
		return mv;
	}

	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/" + adminUrl + "/popup/write" })
	public ModelAndView write(Popup popupVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/popup/write");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		mv.addObject("currentPageNo", popupVO.getCurrentPageNo());
		if (popupVO.getTarget() != null) {
			mv.addObject("target", popupVO.getTarget());
		}
		if (popupVO.getKeyword() != null) {
			mv.addObject("keyword", popupVO.getKeyword());
		}

		mv.addObject("pid", popupVO.getPid());
		if (popupVO.getPid() != 0) {
			mv.addObject("pid", popupVO.getPid());
		}
		if (popupVO.getTypes() != null) {
			mv.addObject("types", popupVO.getTypes());
		}

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mv.addObject("toDay", df.format(cal.getTime()));
        cal.add(Calendar.MONTH, 1);
		mv.addObject("fromDay", df.format(cal.getTime()));

		return mv;
	}

	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/popup/writeProc")
	public ModelAndView writeProc(Popup popupVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/popup");
		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}


		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		popupVO.setCrea_id(principal.getUsername());
		popupVO.setCrea_name(principal.getName());
		popupService.insertBoard(popupVO, request);
		
		return mv;
	}
	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/" + adminUrl + "/popup/modify" })
	public ModelAndView modify(Popup popupVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/popup/modify");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		Popup detail = popupService.selectBoardDetail(popupVO);
		mv.addObject("map",detail);
		
	    List<String> imagesList = Arrays.asList("gallery".split(","));
	    
	    PopupFile boardFileVO = new PopupFile();
	    boardFileVO.setBoard_idx(detail.getIdx());

	    Map<String, Object> inputFiles = new LinkedHashMap<String, Object>();
	    Map<String, Object> inputMobFiles = new LinkedHashMap<String, Object>();
	    for(String item : imagesList){
    		boardFileVO.setFile_gubun(item);
    		List<PopupFile> fileList = popupService.selectFileList(boardFileVO);
    		inputFiles.put(item, fileList);
    		
    		boardFileVO.setFile_gubun("mob"+item);
    		List<PopupFile> fileMobList = popupService.selectFileList(boardFileVO);
    		inputMobFiles.put("mob"+item, fileMobList);
	    }
	    
		if (inputFiles.size()>0) {
			mv.addObject("files", inputFiles);
		}
		if (inputMobFiles.size()>0) {
			mv.addObject("mobfiles", inputMobFiles);
		}
		mv.addObject("currentPageNo", popupVO.getCurrentPageNo());
		if (popupVO.getTarget() != null) {
			mv.addObject("target", popupVO.getTarget());
		}
		if (popupVO.getKeyword() != null) {
			mv.addObject("keyword", popupVO.getKeyword());
		}

		mv.addObject("pid", popupVO.getPid());
		if (popupVO.getPid() != 0) {
			mv.addObject("pid", popupVO.getPid());
		}
		if (popupVO.getTypes() != null) {
			mv.addObject("types", popupVO.getTypes());
		}
		// int main_count=popupService.selectBoardCount(popupVO);
		// mv.addObject("MAIN_COUNT",main_count);
		return mv;
	}

	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/popup/modifyProc")
	public ModelAndView modifyProc(Popup popupVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/" + adminUrl + "/popup");

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		popupVO.setUpda_id(principal.getUsername());
		popupVO.setUpda_name(principal.getName());
		
		popupService.updateBoard(popupVO, request);

		mv.addObject("currentPageNo", popupVO.getCurrentPageNo());
		if (popupVO.getTarget() != null) {
			mv.addObject("target", popupVO.getTarget());
		}
		if (popupVO.getKeyword() != null) {
			mv.addObject("keyword", popupVO.getKeyword());
		}

		mv.addObject("pid", popupVO.getPid());
		if (popupVO.getPid() != 0) {
			mv.addObject("pid", popupVO.getPid());
		}
		if (popupVO.getTypes() != null) {
			mv.addObject("types", popupVO.getTypes());
		}
		return mv;
	}

	
	/** 
	 * @param popupVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/popup/deleteProc")
	public ModelAndView deleteProc(Popup popupVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/popup");


		popupService.deleteBoard(popupVO,request);

		mv.addObject("currentPageNo", popupVO.getCurrentPageNo());
		if (popupVO.getTarget() != null) {
			mv.addObject("target", popupVO.getTarget());
		}
		if (popupVO.getKeyword() != null) {
			mv.addObject("keyword", popupVO.getKeyword());
		}

		mv.addObject("pid", popupVO.getPid());
		if (popupVO.getPid() != 0) {
			mv.addObject("pid", popupVO.getPid());
		}
		if (popupVO.getTypes() != null) {
			mv.addObject("types", popupVO.getTypes());
		}
		return mv;
	}

	
	/** 
	 * @param popupFileVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/popup/fileDelete")
	public ModelAndView deletFileProc(PopupFile popupFileVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		popupService.deleteFile(popupFileVO);
		mv.addObject("result", "ok");
		mv.setViewName("jsonView");

		return mv;
	}

}