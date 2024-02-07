package com.krcon.elif.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.krcon.elif.common.CommandMap;
import com.krcon.elif.common.service.CommonService;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.FileUtils;
import com.krcon.elif.pagination.PaginationInfo;
import com.krcon.elif.service.CodeService;
import com.krcon.elif.service.ComplexService;
import com.krcon.elif.service.ProjectService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.Code;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.ComplexConstChild;
import com.krcon.elif.vo.ComplexConstFile;
// import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexGuide;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.Project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Configuration
@PropertySource("classpath:system.properties")

@RequestMapping(value = "mgmt")
@Controller
public class ComplexController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.domainName}")
	private String domainName;

	@Value("${db.cocd}")
	private String co_cd;

	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name = "complexService")
	private ComplexService complexService;

	@Resource(name = "codeService")
	private CodeService codeService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;


	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;

	/*************************************************
	 * ! 단지 관리
	 ***************************************************/
	
	@RequestMapping(value = { "/complex/{code_type}/management_list" })
	public ModelAndView management_list(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/management_list");
		complexVO.setCode_type(code_type);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexPjtCount(complexVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexVO.setStart(start);
        complexVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Complex> list = complexService.selectComplexPjtList(complexVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	@RequestMapping(value = { "/complex/{code_type}/management_write" })
	public ModelAndView management_write(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/management_write");
		complexVO.setCode_type(code_type);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		// ComplexCode complexCodeVO = new ComplexCode();
		// complexCodeVO.setCode_type(code_type);
		// List<ComplexCode> code_list = complexService.selectComplexCodeList(complexCodeVO);
		// mv.addObject("code_list", code_list);

		Project projectVO = new Project();
		projectVO.setCode_type(code_type);
		List<Project> project_list = projectService.selectProjectList(projectVO);
		mv.addObject("project_list", project_list);
		
		Code codeQuery = new Code();
		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV020");
		List<Code> complex_type = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_type", complex_type);

		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV021");
		List<Code> complex_region = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_region", complex_region);

		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV022");
		List<Code> complex_progress = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_progress", complex_progress);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		mv.addObject("code_type", code_type);

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mv.addObject("toDay", df.format(cal.getTime()));
        cal.add(Calendar.MONTH, 1);
		mv.addObject("fromDay", df.format(cal.getTime()));

		return mv;
	}

	@RequestMapping(value = "/complex/{code_type}/management_writeProc")
	public ModelAndView management_writeProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/complex/"+code_type+"/management_list");
		complexVO.setCode_type(code_type);
		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}


		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		complexVO.setRegpsn_id(principal.getUsername());
		Complex complexCount = new Complex();
		complexCount.setCo_cd(co_cd);
		complexCount.setPjt_cd(complexVO.getPjt_cd());
		if(complexService.selectComplexPjtCount(complexCount)>0){
			mv.addObject("ALERT", "이미 사용중인 단지입니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		}else{
			complexService.insertComplexPjt(complexVO);
		}
		
		return mv;
	}
	@RequestMapping(value = { "/complex/{code_type}/management_modify" })
	public ModelAndView management_modify(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/management_modify");
		complexVO.setCode_type(code_type);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }
		Project projectVO = new Project();
		projectVO.setCode_type(code_type);
		List<Project> project_list = projectService.selectProjectList(projectVO);
		mv.addObject("project_list", project_list);
		
		
		Code codeQuery = new Code();
		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV020");
		List<Code> complex_type = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_type", complex_type);

		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV021");
		List<Code> complex_region = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_region", complex_region);

		codeQuery.setCode_group_flag("N");
		codeQuery.setCode_group("RV022");
		List<Code> complex_progress = codeService.selectCodeList(codeQuery);
		mv.addObject("complex_progress", complex_progress);


		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		return mv;
	}

	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/complex/{code_type}/management_modifyProc")
	public ModelAndView management_modifyProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/management_list");
		complexVO.setCode_type(code_type);

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		complexVO.setUpdpsn_id(principal.getUsername());
		
		complexService.updateComplexPjt(complexVO);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}

		return mv;
	}
	
	@RequestMapping(value = "/complex/{code_type}/management_status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> management_status(Complex complexVO, HttpServletRequest request) throws Exception {
		int status = complexService.updateComplexPjtStatus(complexVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}
	

	@RequestMapping(value = "/complex/{code_type}/management_deleteProc")
	public ModelAndView management_deleteProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/management_list");
		complexVO.setCode_type(code_type);
		complexService.deleteComplexPjt(complexVO);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		return mv;
	}



	@RequestMapping(value = { "/complex/{code_type}/management_sort" }, method = RequestMethod.GET)
	public ModelAndView management_sort(@PathVariable String code_type,CommandMap commandMap, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mgmt/complex/management_sort");
		Complex complexVO = new Complex();
		complexVO.setCode_type(code_type);
		if(commandMap.get("section").toString().equals("sales")){
			complexVO.setProgress_array("RV02201,RV02202,RV02203".split(","));

		}else if(commandMap.get("section").toString().equals("occupancy")){
			complexVO.setProgress_array("RV02206,RV02207,RV02208".split(","));
			
		}else if(commandMap.get("section").toString().equals("const")){
			complexVO.setProgress_array("RV02204,RV02205".split(","));
			
		}
		
        int total = complexService.selectComplexPjtCount(complexVO);
        List<Complex> list = complexService.selectComplexPjtList(complexVO);
         
        mv.addObject("total", total);
        mv.addObject("list", list);
		
		
		mv.addObject("code_type", code_type);
		return mv;
	}


	@RequestMapping(value = "/complex/{code_type}/management_sort_proc", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> management_sort_proc(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Complex complexVO = new Complex();
		complexVO.setPjt_cd(commandMap.get("pjt_cd").toString());
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date to = transFormat.parse(commandMap.get("main_sort_dtm").toString());
		complexVO.setMain_sort_dtm(to);
		int status = complexService.updateComplexPjtSortDtm(complexVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}

	
	/*************************************************
	 * ! 분양 단지 관리
	 ***************************************************/
	
	@RequestMapping(value = { "/complex/{code_type}/sales_list" })
	public ModelAndView sales_list(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/sales_list");
		complexVO.setCode_type(code_type);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }
		
		complexVO.setProgress_array("RV02201,RV02202,RV02203".split(","));
		
		
		Code codeQuery = new Code();
		codeQuery.setCode_array(complexVO.getProgress_array());
		List<Code> progress_array = codeService.selectCodeList(codeQuery);
		mv.addObject("progress_array", progress_array);

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexPjtCount(complexVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexVO.setStart(start);
        complexVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Complex> list = complexService.selectComplexPjtList(complexVO);
         
        mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("code_type", code_type);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	
	@RequestMapping(value = { "/complex/{code_type}/sales_modify" })
	public ModelAndView sales_modify(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/sales_modify");
		complexVO.setCode_type(code_type);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		if(!CommonUtils.isEmpty(detail.getSllt_info_sch())){
			if(detail.getSllt_info_sch().length()==6){
				detail.setSales_year(detail.getSllt_info_sch().substring(0, 4));
				detail.setSales_month(detail.getSllt_info_sch().substring(4, 6));
			}
		}else{
			if(detail.getSales_date().length()>5){
				detail.setSales_year(detail.getSales_date().substring(0, 4));
				detail.setSales_month(detail.getSales_date().substring(4, 6));
			}
		}
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/complex/{code_type}/sales_proc")
	public ModelAndView sales_proc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/sales_list");
		complexVO.setCode_type(code_type);

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		String filepath = "complex";
		String uploadPath = boardPath+""+filepath+"/";


		List<String> fileDelete = new ArrayList<String>();
		Complex detail = complexService.selectComplexPjtDetail(complexVO);

		complexVO.setSales_thumb_path(uploadPath);
		if(!CommonUtils.isEmpty(complexVO.getSales_thumb_name())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "sales_thumb");
			if(thumb.size()>0){
				complexVO.setSales_thumb_name(thumb.get("STORED_FILE_NAME").toString());
				// complexVO.setSales_thumb_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
			}
		}

		if(!CommonUtils.isEmpty(complexVO.getSales_thumb_old())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "sales_thumb");
			if(thumb.size()>0){
				complexVO.setSales_thumb_path(uploadPath);
				complexVO.setSales_thumb_name(thumb.get("STORED_FILE_NAME").toString());
				complexVO.setSales_thumb_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getSales_thumb_name())){
					fileDelete.add(detail.getSales_thumb_path()+""+detail.getSales_thumb_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getSales_thumb_name())){
				fileDelete.add(detail.getSales_thumb_path()+""+detail.getSales_thumb_name());
			}
			complexVO.setSales_thumb_path("");
			complexVO.setSales_thumb_name("");
			complexVO.setSales_thumb_origin("");
		}

		complexVO.setSales_main_path(uploadPath);
		if(!CommonUtils.isEmpty(complexVO.getSales_main_name())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "sales_main");
			if(thumb.size()>0){
				complexVO.setSales_main_name(thumb.get("STORED_FILE_NAME").toString());
				// complexVO.setSales_main_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
			}
		}
		if(!CommonUtils.isEmpty(complexVO.getSales_main_old())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "sales_main");
			if(thumb.size()>0){
				complexVO.setSales_main_path(uploadPath);
				complexVO.setSales_main_name(thumb.get("STORED_FILE_NAME").toString());
				complexVO.setSales_main_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getSales_main_name())){
					fileDelete.add(detail.getSales_main_path()+""+detail.getSales_main_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getSales_main_name())){
				fileDelete.add(detail.getSales_main_path()+""+detail.getSales_main_name());
			}
			complexVO.setSales_main_path("");
			complexVO.setSales_main_name("");
			complexVO.setSales_main_origin("");
		}
		complexVO.setSales_status("Y");
		complexVO.setSales_reg_id(principal.getUsername());
		complexService.updateComplexPjtSales(complexVO);
		if(fileDelete.size()>0){
			for(int i=0, size=fileDelete.size(); i<size; i++){
				fileUtils.deleteRealFile(request, fileDelete.get(i));
			}
		}

		

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}

		return mv;
	}
	@RequestMapping(value = "/complex/{code_type}/sales_status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> sales_statusProc(Complex complexVO, HttpServletRequest request) throws Exception {
		int status = complexService.updateComplexPjtSalesStatus(complexVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}

	@RequestMapping(value = "/complex/{code_type}/sales_deleteProc")
	public ModelAndView sales_deleteProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/sales_list");
		complexVO.setCode_type(code_type);


		complexService.deleteComplexPjtSales(complexVO);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	/*************************************************
	 * ! 공사 단지 관리
	 ***************************************************/
	
	@RequestMapping(value = { "/complex/{code_type}/const_list" })
	public ModelAndView const_list(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/const_list");
		complexVO.setCode_type(code_type);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }
		complexVO.setProgress_array("RV02204,RV02205".split(","));

		complexVO.setProgress_const("Y");
		complexVO.setProgress_code("RV02202");
		Code codeQuery = new Code();
		codeQuery.setCode_array(complexVO.getProgress_array());
		List<Code> progress_array = codeService.selectCodeList(codeQuery);
		mv.addObject("progress_array", progress_array);

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexPjtCount(complexVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexVO.setStart(start);
        complexVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Complex> list = complexService.selectComplexPjtList(complexVO);
         
        mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("code_type", code_type);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	
	@RequestMapping(value = { "/complex/{code_type}/const_modify" })
	public ModelAndView const_modify(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/const_modify");
		complexVO.setCode_type(code_type);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		if(!CommonUtils.isEmpty(detail.getSllt_info_mibl_ym())){
			if(detail.getSllt_info_mibl_ym().length()==6){
				detail.setConst_year(detail.getSllt_info_mibl_ym().substring(0, 4));
				detail.setConst_month(detail.getSllt_info_mibl_ym().substring(4, 6));
			}
		}
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/complex/{code_type}/const_proc")
	public ModelAndView const_proc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/const_list");
		complexVO.setCode_type(code_type);

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		String filepath = "complex";
		String uploadPath = boardPath+""+filepath+"/";


		List<String> fileDelete = new ArrayList<String>();
		Complex detail = complexService.selectComplexPjtDetail(complexVO);

		complexVO.setConst_thumb_path(uploadPath);
		if(!CommonUtils.isEmpty(complexVO.getConst_thumb_old())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "const_thumb");
			if(thumb.size()>0){
				complexVO.setConst_thumb_name(thumb.get("STORED_FILE_NAME").toString());
				complexVO.setConst_thumb_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getConst_thumb_name())){
					fileDelete.add(detail.getConst_thumb_path()+""+detail.getConst_thumb_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getConst_thumb_name())){
				fileDelete.add(detail.getConst_thumb_path()+""+detail.getConst_thumb_name());
			}
			complexVO.setConst_thumb_name("");
			complexVO.setConst_thumb_origin("");
		}
		complexVO.setConst_status("Y");
		complexVO.setConst_reg_id(principal.getUsername());
		complexService.updateComplexPjtConst(complexVO);
		if(fileDelete.size()>0){
			for(int i=0, size=fileDelete.size(); i<size; i++){
				fileUtils.deleteRealFile(request, fileDelete.get(i));
			}
		}
		
		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}

		return mv;
	}
	@RequestMapping(value = "/complex/{code_type}/const_status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> const_statusProc(Complex complexVO, HttpServletRequest request) throws Exception {
		int status = complexService.updateComplexPjtConstStatus(complexVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}

	@RequestMapping(value = "/complex/{code_type}/const_deleteProc")
	public ModelAndView const_deleteProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/const_list");
		complexVO.setCode_type(code_type);


		complexService.deleteComplexPjtConst(complexVO);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	/*************************************************
	 * ! 공사 단지 상세 관리
	 ***************************************************/
	
	@RequestMapping(value = { "/complex/{code_type}/const_sub_list/{pjt_cd}" })
	public ModelAndView const_sub_list(@PathVariable String code_type,@PathVariable String pjt_cd,ComplexConstChild complexConstChildVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/const_sub_list");
		complexConstChildVO.setCode_type(code_type);
		complexConstChildVO.setPjt_cd(pjt_cd);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }
		// complexConstChildVO.setProgress_array("RV02206,RV02207,RV02208".split(","));

		Code codeQuery = new Code();
		codeQuery.setCode_array(complexConstChildVO.getProgress_array());
		List<Code> progress_array = codeService.selectCodeList(codeQuery);
		mv.addObject("progress_array", progress_array);

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexConstChildVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexConstChildVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexConstChildVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexPjtConstChildCount(complexConstChildVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexConstChildVO.setStart(start);
        complexConstChildVO.setEnd(paginationInfo.getLastRecordIndex());

        List<ComplexConstChild> list = complexService.selectComplexPjtConstChildList(complexConstChildVO);
        for(ComplexConstChild item : list){
			if(!CommonUtils.isEmpty(item.getConst_proc_dt())){
				if(item.getConst_proc_dt().length()==8){
					item.setRegist_year(item.getConst_proc_dt().substring(0, 4));
					item.setRegist_month(item.getConst_proc_dt().substring(4, 6));
				}
			}
		}
        mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("code_type", code_type);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexConstChildVO.getCurrentPageNo());
		if (complexConstChildVO.getTarget() != null) {
			mv.addObject("target", complexConstChildVO.getTarget());
		}
		if (complexConstChildVO.getKeyword() != null) {
			mv.addObject("keyword", complexConstChildVO.getKeyword());
		}
		if (complexConstChildVO.getSdate() != null) {
			mv.addObject("sdate", complexConstChildVO.getSdate());
		}

		if (complexConstChildVO.getEdate() != null) {
			mv.addObject("edate", complexConstChildVO.getEdate());
		}
		return mv;
	}

	
	@RequestMapping(value = { "/complex/{code_type}/const_sub_modify/{pjt_cd}" })
	public ModelAndView const_sub_modify(@PathVariable String code_type,@PathVariable String pjt_cd,ComplexConstChild complexConstChildVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/const_sub_modify");
		complexConstChildVO.setCode_type(code_type);
		complexConstChildVO.setPjt_cd(pjt_cd);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		ComplexConstChild detail = new ComplexConstChild();
		ComplexConstFile complexFileVO = new ComplexConstFile();
		if(!CommonUtils.isEmpty(complexConstChildVO.getConst_proc_dt())){
			detail = complexService.selectComplexPjtConstChildDetail(complexConstChildVO);
			if(!CommonUtils.isEmpty(detail.getConst_proc_dt())){
				if(detail.getConst_proc_dt().length()==8){
					detail.setRegist_year(detail.getConst_proc_dt().substring(0, 4));
					detail.setRegist_month(detail.getConst_proc_dt().substring(4, 6));
				}
				
				complexConstChildVO.setConst_proc_dt(complexConstChildVO.getConst_proc_dt());

				complexFileVO.setPjt_cd(detail.getPjt_cd());
				complexFileVO.setConst_proc_dt(detail.getConst_proc_dt());
				complexFileVO.setFile_gubun("complex_const_sub");
				List<ComplexConstFile> const_sub_file = complexService.selectComplexPjtConstFileList(complexFileVO);
				
				if (const_sub_file.size()>0) {
					mv.addObject("const_sub_file", const_sub_file);
				}
			}
		}
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexConstChildVO.getCurrentPageNo());
		if (complexConstChildVO.getTarget() != null) {
			mv.addObject("target", complexConstChildVO.getTarget());
		}
		if (complexConstChildVO.getKeyword() != null) {
			mv.addObject("keyword", complexConstChildVO.getKeyword());
		}
		if (complexConstChildVO.getSdate() != null) {
			mv.addObject("sdate", complexConstChildVO.getSdate());
		}

		if (complexConstChildVO.getEdate() != null) {
			mv.addObject("edate", complexConstChildVO.getEdate());
		}
		return mv;
	}
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/complex/{code_type}/const_sub_proc/{pjt_cd}",method=RequestMethod.POST)
	public ModelAndView const_sub_proc(@PathVariable String code_type,@PathVariable String pjt_cd,ComplexConstChild complexConstChildVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/complex/"+code_type+"/const_sub_list/"+pjt_cd);
		complexConstChildVO.setCode_type(code_type);
		complexConstChildVO.setPjt_cd(pjt_cd);
		complexConstChildVO.setConst_proc_dt(complexConstChildVO.getConst_proc_dt().replaceAll("-", ""));
		log.info("const_sub_proc");

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		ComplexConstChild detail = new ComplexConstChild();
		if(complexConstChildVO.getProctype().equals("modify")){
			detail.setPjt_cd(complexConstChildVO.getPjt_cd());
			detail = complexService.selectComplexPjtConstChildDetail(complexConstChildVO);
		}

		String filepath = "complex";
		String uploadPath = boardPath+""+filepath+"/";
		List<String> fileDelete = new ArrayList<String>();

		if(complexConstChildVO.getProctype().equals("write")){
			complexConstChildVO.setRegpsn_id(principal.getUsername());
			complexService.insertComplexPjtConstChild(complexConstChildVO);
		}else{
			complexConstChildVO.setUpdpsn_id(principal.getUsername());
			complexService.updateComplexPjtConstChild(complexConstChildVO);
		}
	    List<Map<String,Object>> list = fileUtils.parseInsertFile(request,uploadPath,"const_sub_file");
	    for(int i=0, size=list.size(); i<size; i++){
			ComplexConstFile complexConstFileForm = new ComplexConstFile();
			complexConstFileForm.setPjt_cd(complexConstChildVO.getPjt_cd());
			complexConstFileForm.setConst_proc_dt(complexConstChildVO.getConst_proc_dt());
			complexConstFileForm.setOriginal_file_name(list.get(i).get("ORIGINAL_FILE_NAME").toString());
			complexConstFileForm.setStored_file_name(list.get(i).get("STORED_FILE_NAME").toString());
			complexConstFileForm.setFile_gubun("complex_const_sub");
			complexConstFileForm.setFile_size( Integer.parseInt(list.get(i).get("FILE_SIZE").toString()) );
			complexConstFileForm.setFile_sort(i+1);
			complexConstFileForm.setPath_name(uploadPath);
			
        	complexService.insertComplexPjtConstFile(complexConstFileForm);
	    }

		if(fileDelete.size()>0){
			for(int i=0, size=fileDelete.size(); i<size; i++){
				fileUtils.deleteRealFile(request, fileDelete.get(i));
			}
		}

		mv.addObject("currentPageNo", complexConstChildVO.getCurrentPageNo());
		if (complexConstChildVO.getTarget() != null) {
			mv.addObject("target", complexConstChildVO.getTarget());
		}
		if (complexConstChildVO.getKeyword() != null) {
			mv.addObject("keyword", complexConstChildVO.getKeyword());
		}
		if (complexConstChildVO.getSdate() != null) {
			mv.addObject("sdate", complexConstChildVO.getSdate());
		}

		if (complexConstChildVO.getEdate() != null) {
			mv.addObject("edate", complexConstChildVO.getEdate());
		}

		return mv;
	}

	@RequestMapping(value = "/complex/const_sub_status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> const_sub_status(ComplexConstChild complexConstChildVO, HttpServletRequest request) throws Exception {
		int status = complexService.updateComplexPjtConstChildStatus(complexConstChildVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}
	@RequestMapping(value = "/complex/{code_type}/const_sub_deleteProc")
	public ModelAndView const_sub_deleteProc(@PathVariable String code_type,ComplexConstChild complexConstChildVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/const_sub_list/"+complexConstChildVO.getPjt_cd());
		complexConstChildVO.setCode_type(code_type);


		complexService.deleteComplexPjtConstChild(complexConstChildVO);

		mv.addObject("currentPageNo", complexConstChildVO.getCurrentPageNo());
		if (complexConstChildVO.getTarget() != null) {
			mv.addObject("target", complexConstChildVO.getTarget());
		}
		if (complexConstChildVO.getKeyword() != null) {
			mv.addObject("keyword", complexConstChildVO.getKeyword());
		}
		if (complexConstChildVO.getSdate() != null) {
			mv.addObject("sdate", complexConstChildVO.getSdate());
		}

		if (complexConstChildVO.getEdate() != null) {
			mv.addObject("edate", complexConstChildVO.getEdate());
		}
		return mv;
	}

	/*************************************************
	 * ! 입주 단지 관리
	 ***************************************************/
	
	@RequestMapping(value = { "/complex/{code_type}/occupancy_list" })
	public ModelAndView occupancy_list(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/occupancy_list");
		complexVO.setCode_type(code_type);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }
		complexVO.setProgress_array("RV02206,RV02207,RV02208".split(","));

		Code codeQuery = new Code();
		codeQuery.setCode_array(complexVO.getProgress_array());
		List<Code> progress_array = codeService.selectCodeList(codeQuery);
		mv.addObject("progress_array", progress_array);

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexPjtCount(complexVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexVO.setStart(start);
        complexVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Complex> list = complexService.selectComplexPjtList(complexVO);
         
        mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("code_type", code_type);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}

	
	@RequestMapping(value = { "/complex/{code_type}/occupancy_modify" })
	public ModelAndView occupancy_modify(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/occupancy_modify");
		complexVO.setCode_type(code_type);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		if(!CommonUtils.isEmpty(detail.getMv_date())){
			if(detail.getMv_date().length()==6){
				detail.setMv_date_year(detail.getMv_date().substring(0, 4));
				detail.setMv_date_month(detail.getMv_date().substring(4, 6));
			}
		}
		if(!CommonUtils.isEmpty(detail.getSllt_info_sch())){
			if(detail.getSllt_info_sch().length()==6){
				detail.setSales_year(detail.getSllt_info_sch().substring(0, 4));
				detail.setSales_month(detail.getSllt_info_sch().substring(4, 6));
			}
		}
		ComplexFile complexFileVO = new ComplexFile();
		if(detail.getOccupancy_status().equals("Y")){

			complexFileVO.setPjt_cd(detail.getPjt_cd());
			complexFileVO.setFile_gubun("complex_occupancy");
			List<ComplexFile> occupancy_file = complexService.selectComplexPjtFileList(complexFileVO);
			
			if (occupancy_file.size()>0) {
				mv.addObject("occupancy_file", occupancy_file);
			}
		}
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/complex/{code_type}/occupancy_proc")
	public ModelAndView occupancy_proc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/complex/"+code_type+"/occupancy_list");
		complexVO.setCode_type(code_type);
		log.info("occupancy_proc");

		if(!CommonUtils.checkFileExtension(request)) {
			mv.addObject("ALERT", "잘못된 파일 확장자를 사용했습니다.");
			mv.setViewName("redirect:" + request.getHeader("Referer"));
		    return mv;
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		String filepath = "complex";
		String uploadPath = boardPath+""+filepath+"/";
		List<String> fileDelete = new ArrayList<String>();

		if(!CommonUtils.isEmpty(complexVO.getMv_thumb_old())){
			Map<String,Object> thumb = fileUtils.parseUploadFile(request, filepath, "mv_thumb");
			if(thumb.size()>0){
				complexVO.setMv_thumb_path(uploadPath);
				complexVO.setMv_thumb_name(thumb.get("STORED_FILE_NAME").toString());
				complexVO.setMv_thumb_origin(thumb.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getMv_thumb_name())){
					fileDelete.add(detail.getMv_thumb_path()+""+detail.getMv_thumb_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getMv_thumb_name())){
				fileDelete.add(detail.getMv_thumb_path()+""+detail.getMv_thumb_name());
			}
			complexVO.setMv_thumb_path("");
			complexVO.setMv_thumb_name("");
			complexVO.setMv_thumb_origin("");
		}

		if(!CommonUtils.isEmpty(complexVO.getMv_pre_file_old())){
			Map<String,Object> occupancyfile = fileUtils.parseUploadFile(request, filepath, "mv_pre_file");
			if(occupancyfile.size()>0){
				complexVO.setMv_pre_file_path(uploadPath);
				complexVO.setMv_pre_file_name(occupancyfile.get("STORED_FILE_NAME").toString());
				complexVO.setMv_pre_file_origin(occupancyfile.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getMv_pre_file_name())){
					fileDelete.add(detail.getMv_pre_file_path()+""+detail.getMv_pre_file_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getMv_pre_file_name())){
				fileDelete.add(detail.getMv_pre_file_path()+""+detail.getMv_pre_file_name());
			}
			complexVO.setMv_pre_file_path("");
			complexVO.setMv_pre_file_name("");
			complexVO.setMv_pre_file_origin("");
		}
		if(!CommonUtils.isEmpty(complexVO.getMv_file_doc_old())){
			Map<String,Object> reservationfile = fileUtils.parseUploadFile(request, filepath, "mv_file_doc");
			if(reservationfile.size()>0){
				complexVO.setMv_file_doc_path(uploadPath);
				complexVO.setMv_file_doc_name(reservationfile.get("STORED_FILE_NAME").toString());
				complexVO.setMv_file_doc_origin(reservationfile.get("ORIGINAL_FILE_NAME").toString());
				if(!CommonUtils.isEmpty(detail.getMv_file_doc_name())){
					fileDelete.add(detail.getMv_file_doc_path()+""+detail.getMv_file_doc_name());
				}
			}
		}else{
			if(!CommonUtils.isEmpty(detail.getMv_file_doc_name())){
				fileDelete.add(detail.getMv_file_doc_path()+""+detail.getMv_file_doc_name());
			}
			complexVO.setMv_file_doc_path("");
			complexVO.setMv_file_doc_name("");
			complexVO.setMv_file_doc_origin("");
		}
		complexVO.setOccupancy_status("Y");
		complexVO.setMv_reg_id(principal.getUsername());
		log.info("complexVO:::{}",complexVO);
		complexService.updateComplexPjtOccupancy(complexVO);
	    List<Map<String,Object>> list = fileUtils.parseInsertFile(request,uploadPath,"occupancy_file");
	    for(int i=0, size=list.size(); i<size; i++){
			ComplexFile complexFileForm = new ComplexFile();
			complexFileForm.setPjt_cd(complexVO.getPjt_cd());
			complexFileForm.setOriginal_file_name(list.get(i).get("ORIGINAL_FILE_NAME").toString());
			complexFileForm.setStored_file_name(list.get(i).get("STORED_FILE_NAME").toString());
			complexFileForm.setFile_gubun("complex_occupancy");
			complexFileForm.setFile_size( Integer.parseInt(list.get(i).get("FILE_SIZE").toString()) );
			complexFileForm.setFile_sort(i+1);
			complexFileForm.setPath_name(uploadPath);
			
        	complexService.insertComplexPjtFile(complexFileForm);
	    }

		if(fileDelete.size()>0){
			for(int i=0, size=fileDelete.size(); i<size; i++){
				fileUtils.deleteRealFile(request, fileDelete.get(i));
			}
		}

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}

		return mv;
	}

	@RequestMapping(value = "/complex/{code_type}/occupancy_status", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> occupancy_statusProc(Complex complexVO, HttpServletRequest request) throws Exception {
		int status = complexService.updateComplexPjtOccupancyStatus(complexVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(status==1){
			map.put("result", true);
		}
		return map;
	}
	@RequestMapping(value = "/complex/{code_type}/occupancy_deleteProc")
	public ModelAndView occupancy_deleteProc(@PathVariable String code_type,Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/complex/"+code_type+"/occupancy_list");
		complexVO.setCode_type(code_type);


		complexService.deleteComplexPjtOccupancy(complexVO);

		mv.addObject("currentPageNo", complexVO.getCurrentPageNo());
		if (complexVO.getTarget() != null) {
			mv.addObject("target", complexVO.getTarget());
		}
		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		if (complexVO.getSdate() != null) {
			mv.addObject("sdate", complexVO.getSdate());
		}

		if (complexVO.getEdate() != null) {
			mv.addObject("edate", complexVO.getEdate());
		}
		return mv;
	}



	/*************************************************
	 * ! 분양가이드
	 ***************************************************/
	
	@RequestMapping(value = { "/salesguide_list" })
	public ModelAndView sales_list(ComplexGuide complexGuideVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/salesguide_list");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(complexGuideVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(complexGuideVO.getRecordCountPerPage());
        paginationInfo.setPageSize(complexGuideVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = complexService.selectComplexGuideCount(complexGuideVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
        complexGuideVO.setStart(start);
        complexGuideVO.setEnd(paginationInfo.getLastRecordIndex());

		if(total==0){
			ComplexGuide insertGuide = new ComplexGuide();
			insertGuide.setComments("");
			insertGuide.setStatus("Y");
			insertGuide.setCrea_id("");
			insertGuide.setCrea_name("");
			insertGuide.setType("payment");
			insertGuide.setType_name("분양금 납부");
			complexService.insertComplexGuide(insertGuide);
			insertGuide.setType("tag");
			insertGuide.setType_name("취득세");
			complexService.insertComplexGuide(insertGuide);
			mv.setViewName("/mgmt/salesguide_list");
			return mv;
		}
        List<ComplexGuide> list = complexService.selectComplexGuideList(complexGuideVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
		
		
		mv.addObject("currentPageNo", complexGuideVO.getCurrentPageNo());
		if (complexGuideVO.getTarget() != null) {
			mv.addObject("target", complexGuideVO.getTarget());
		}
		if (complexGuideVO.getKeyword() != null) {
			mv.addObject("keyword", complexGuideVO.getKeyword());
		}
		if (complexGuideVO.getSdate() != null) {
			mv.addObject("sdate", complexGuideVO.getSdate());
		}

		if (complexGuideVO.getEdate() != null) {
			mv.addObject("edate", complexGuideVO.getEdate());
		}
		return mv;
	}

	
	@RequestMapping(value = { "/salesguide_modify" })
	public ModelAndView sales_modify(ComplexGuide complexGuideVO, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("/mgmt/complex/salesguide_modify");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		// if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
		// 	mv.setViewName("/error");
		// 	return mv;
		// }

		ComplexGuide detail = complexService.selectComplexGuideDetail(complexGuideVO);
		mv.addObject("map",detail);

		mv.addObject("currentPageNo", complexGuideVO.getCurrentPageNo());
		if (complexGuideVO.getTarget() != null) {
			mv.addObject("target", complexGuideVO.getTarget());
		}
		if (complexGuideVO.getKeyword() != null) {
			mv.addObject("keyword", complexGuideVO.getKeyword());
		}
		if (complexGuideVO.getSdate() != null) {
			mv.addObject("sdate", complexGuideVO.getSdate());
		}

		if (complexGuideVO.getEdate() != null) {
			mv.addObject("edate", complexGuideVO.getEdate());
		}
		return mv;
	}

	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/salesguide_proc")
	public ModelAndView sales_proc(ComplexGuide complexGuideVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/salesguide_list");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		

		if(complexGuideVO.getIdx()==0){
			complexGuideVO.setCrea_id(principal.getUsername());
			complexGuideVO.setCrea_name(principal.getName());
			complexService.insertComplexGuide(complexGuideVO);
		}else{

			ComplexGuide detail = complexService.selectComplexGuideDetail(complexGuideVO);
			complexGuideVO.setType(detail.getType());
			complexGuideVO.setType_name(detail.getType_name());
			complexGuideVO.setStatus(detail.getStatus());
			if(CommonUtils.isEmpty(detail.getCrea_name())){
				complexGuideVO.setCrea_id(principal.getUsername());
				complexGuideVO.setCrea_name(principal.getName());
			}else{
				complexGuideVO.setUpda_id(principal.getUsername());
				complexGuideVO.setUpda_name(principal.getName());
			}
			complexService.updateComplexGuide(complexGuideVO);
		}

		

		mv.addObject("currentPageNo", complexGuideVO.getCurrentPageNo());
		if (complexGuideVO.getTarget() != null) {
			mv.addObject("target", complexGuideVO.getTarget());
		}
		if (complexGuideVO.getKeyword() != null) {
			mv.addObject("keyword", complexGuideVO.getKeyword());
		}
		if (complexGuideVO.getSdate() != null) {
			mv.addObject("sdate", complexGuideVO.getSdate());
		}

		if (complexGuideVO.getEdate() != null) {
			mv.addObject("edate", complexGuideVO.getEdate());
		}

		return mv;
	}

	@RequestMapping(value = "/salesguide_deleteProc")
	public ModelAndView sales_deleteProc(@PathVariable String code_type,ComplexGuide complexGuideVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/salesguide");


		complexService.deleteComplexGuide(complexGuideVO);

		mv.addObject("currentPageNo", complexGuideVO.getCurrentPageNo());
		if (complexGuideVO.getTarget() != null) {
			mv.addObject("target", complexGuideVO.getTarget());
		}
		if (complexGuideVO.getKeyword() != null) {
			mv.addObject("keyword", complexGuideVO.getKeyword());
		}
		if (complexGuideVO.getSdate() != null) {
			mv.addObject("sdate", complexGuideVO.getSdate());
		}

		if (complexGuideVO.getEdate() != null) {
			mv.addObject("edate", complexGuideVO.getEdate());
		}
		return mv;
	}



	@RequestMapping(value = "/complex/projectAjax")
	@ResponseBody
	public Map<String,Object> projectAjax(Project projectVO, HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		if(CommonUtils.isEmpty(projectVO.getPjt_cd())){
			map.put("result", "error");
		}else{
			Project detail = projectService.selectProjectDetail(projectVO);
			if(!CommonUtils.isEmpty(detail)){
				map.put("project", detail);
				map.put("result", "ok");
			}else{
				map.put("result", "empty");
			}
			
		}
		return map;
	}
	


	@RequestMapping(value = "/complex/fileDelete")
	@ResponseBody
	public Map<String,Object> deletFileProc(ComplexFile complexFileVO, HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		ComplexFile detail = complexService.selectComplexPjtFileDetail(complexFileVO);
		fileUtils.deleteRealFile(request, detail.getPath_name()+""+detail.getStored_file_name());
		complexService.deleteComplexPjtFile(complexFileVO);
		map.put("result", "ok");
		return map;
	}
	

	@RequestMapping(value = "/complex/fileSubDelete")
	@ResponseBody
	public Map<String,Object> deletFileConstProc(ComplexConstFile complexConstFileVO, HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		ComplexConstFile detail = complexService.selectComplexPjtConstFileDetail(complexConstFileVO);
		fileUtils.deleteRealFile(request, detail.getPath_name()+""+detail.getStored_file_name());
		complexService.deleteComplexPjtConstFile(complexConstFileVO);
		map.put("result", "ok");
		return map;
	}
}