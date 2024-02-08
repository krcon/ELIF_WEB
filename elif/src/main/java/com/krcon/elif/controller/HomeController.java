package com.krcon.elif.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.krcon.elif.common.CommandMap;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.MailHandler;
import com.krcon.elif.pagination.PaginationInfo;
import com.krcon.elif.service.BoardService;
import com.krcon.elif.service.CodeService;
import com.krcon.elif.service.ComplexService;
import com.krcon.elif.service.CustomerService;
import com.krcon.elif.service.MemberService;
import com.krcon.elif.service.PopupService;
import com.krcon.elif.service.ProjectService;
import com.krcon.elif.service.ReservationService;
import com.krcon.elif.vo.Board;
import com.krcon.elif.vo.BoardCate;
import com.krcon.elif.vo.BoardDownload;
import com.krcon.elif.vo.BoardFile;
import com.krcon.elif.vo.Code;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.ComplexConstChild;
import com.krcon.elif.vo.ComplexConstFile;
import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexGuide;
import com.krcon.elif.vo.Customer;
import com.krcon.elif.vo.Member;
import com.krcon.elif.vo.Popup;
import com.krcon.elif.vo.Project;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ComplexService complexService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private PopupService popupService;

	@Autowired
	public JavaMailSender mailSender;

	@Value("${sys.upload.path}")
	private String uploadPath;

	@Value("${sys.upload.boardpath}")
	private String boardPath;

	@Value("${sys.upload.boardslash}")
	private String boardSlash;

	@Value("${sys.adminlink}")
	private String adminlink;

	@Value("${sys.mail.address}")
	private String mailFrom;

	private static final String mb_mp = "/mobile";
	private static final String mb_path = "/mobile";
	private static final String web_path = "/web";
	private String mb_check = mb_mp + "/";
	private String viewname = web_path;
	// ! Redirect PATH
	private String rpath = "";

	/** 
	 * @return String
	 */
	@RequestMapping(value = "/robots.txt")
	@ResponseBody
	public String robots() {
		return "User-agent: *\nAllow: /\n";
	}
	
	/**
	 * @param locale
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String userAgent = request.getHeader("User-Agent").toUpperCase();
		if (userAgent.indexOf("MOBILE") > -1) {
			mv.setViewName("redirect:" + mb_mp + "/index");
		} else {
			mv.setViewName("redirect:index");
		}
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/index", mb_mp + "/index" })
	public ModelAndView index(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		Complex complexVO = new Complex();
		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(complexVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();
		complexVO.setFrom_join("LEFT");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		// complexVO.setSales_status("Y");
		// complexVO.setSales_view_status("Y");
		complexVO.setProgress_array("RV02201,RV02202,RV02203".split(","));
		// complexVO.setProgress_array("RV02201,RV02202,RV02203,RV02204,RV02205".split(","));
		complexVO.setCalendar_view_status("(sales_view_status='Y' or const_view_status='Y')");

		complexVO.setRow_number("tc.idx DESC");
		int total = complexService.selectComplexPjtCount(complexVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		complexVO.setStart(start);
		complexVO.setEnd(paginationInfo.getLastRecordIndex());
		log.info("paginationInfo.getLastRecordIndex():::{}",paginationInfo.getLastRecordIndex());
		List<Complex> list = complexService.selectComplexPjtList(complexVO);

		for (Complex item : list) {
			if (!CommonUtils.isEmpty(item.getSales_date())) {
				if (item.getSales_date().length() > 5) {
					item.setSales_year(item.getSales_date().substring(0, 4));
					item.setSales_month(item.getSales_date().substring(4, 6));
				}
			}
		}
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);



		Popup popupVO = new Popup();
		popupVO.setPid(2);
		popupVO.setLang("KO");
		popupVO.setStatus("Y");
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		popupVO.setSdate(df.format(cal.getTime()));
		popupVO.setEdate(df.format(cal.getTime()));
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			popupVO.setGubun_detect("gubun_mobile");
			popupVO.setType("G");
			List<Popup> popup = popupService.selectBoardList(popupVO);
			mv.addObject("g_popup", popup);
		}else{
			popupVO.setGubun_detect("gubun_web");
			popupVO.setType("G");
			List<Popup> popup = popupService.selectBoardList(popupVO);
			mv.addObject("g_popup", popup);
			popupVO.setType("T");
			popupVO.setStart(0);
			popupVO.setEnd(3);
			popup = popupService.selectBoardList(popupVO);
			mv.addObject("t_popup", popup);
		}




		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/index");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/bi", mb_mp + "/brand/bi" })
	public ModelAndView brand_bi(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/bi");
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/community", mb_mp + "/brand/community" })
	public ModelAndView brand_community(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}

		BoardCate boardCateVO = new BoardCate();
		boardCateVO.setPid(7);
		BoardCate boardCateDetail = (BoardCate) boardService.selectBoardCategoryDetail(boardCateVO);
		mv.addObject("category",boardCateDetail);

		Board boardGubunVO = new Board();
		boardGubunVO.setParent_idx(7);
		boardGubunVO.setStatus("Y");
		List<String> gubun_group = boardService.selectBoardGroupGubun(boardGubunVO);
		String gubuns = gubun_group.toString();
		mv.addObject("gubuns", gubuns);
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/community");
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/community_list", mb_mp + "/brand/community_list" })
	public ModelAndView brand_community_list(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/community_list");
		boardVO.setPid(7);
		boardVO.setStatus("Y");

		if (!CommonUtils.isEmpty(boardVO.getTypesArray())) {
			String[] typesArrayList = boardVO.getTypesArray().split(",");
			if (typesArrayList.length > 0) {
				boardVO.setTypesArrayList(typesArrayList);
			}
		}

		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(6);
		paginationInfo.setPageSize(boardVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = boardService.selectBoardCount(boardVO);
		if (paginationInfo != null) {
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
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/community-view", mb_mp + "/brand/community-view" })
	public ModelAndView brand_community_view(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/community-view");

		boardVO.setPid(7);
		boardVO.setStatus("Y");
		boardVO.setGubun("news");

		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map", detail);
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boardVO.setPrevNextDate(sdFormat.format(detail.getStart_dtm()).toString());

		BoardFile boardFileVO = new BoardFile();
		boardFileVO.setBoard_idx(detail.getIdx());
		boardFileVO.setFile_gubun("files");

		boardService.updateHitCnt(boardVO);

		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
		mv.addObject("files", fileList);

		Board prevVO = boardService.selectBoardDetailPrev(boardVO);
		mv.addObject("prevMap", prevVO);

		Board nextVO = boardService.selectBoardDetailNext(boardVO);
		mv.addObject("nextMap", nextVO);

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
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/record", mb_mp + "/brand/record" })
	public ModelAndView brand_record(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/record");

		Code code = new Code();
		code.setCode_group_flag("N");
		code.setCode_group("RV021");
		List<Code> codeRegion = codeService.selectCodeList(code);
		mv.addObject("codeRegion", codeRegion);
		code.setCode_group_flag("N");
		code.setCode_group("RV020");
		List<Code> codeType = codeService.selectCodeList(code);
		mv.addObject("codeType", codeType);
		code.setCode_group_flag("N");
		code.setCode_group("RV022");
		code.setCode_array("RV02201,RV02202,RV02203".split(","));
		List<Code> codeProgress = codeService.selectCodeList(code);
		mv.addObject("codeProgress", codeProgress);
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/record_list", mb_mp + "/brand/record_list" }, method = RequestMethod.POST)
	public ModelAndView brand_record_proc(Complex complexVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (!CommonUtils.isEmpty(complexVO.getRegion())) {
			complexVO.setRegion_array(complexVO.getRegion().split(","));
		}
		complexVO.setRegion(null);
		if (!CommonUtils.isEmpty(complexVO.getHousing())) {
			complexVO.setHousing_array(complexVO.getHousing().split(","));
		}
		complexVO.setHousing(null);
		if (!CommonUtils.isEmpty(complexVO.getProgress())) {
			complexVO.setProgress_array(complexVO.getProgress().split(","));
		} else {
			complexVO.setProgress_array("RV02207,RV02208".split(","));
		}
		complexVO.setProgress(null);

		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(6);
		paginationInfo.setPageSize(complexVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();
		complexVO.setFrom_join("LEFT");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setRow_number("tc.idx DESC");
		int total = complexService.selectComplexPjtCount(complexVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		complexVO.setStart(start);
		complexVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Complex> list = complexService.selectComplexPjtList(complexVO);

		for (Complex item : list) {
			if (!CommonUtils.isEmpty(item.getMv_date())) {
				if(item.getMv_date().length()==6){
					item.setMv_date_year(item.getMv_date().substring(0, 4));
					item.setMv_date_month(item.getMv_date().substring(4, 6));
				}
			}
		}
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/record_list");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/brand/story", mb_mp + "/brand/story" })
	public ModelAndView brand_story(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/brand/story");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/sale/calendar", mb_mp + "/sale/calendar" })
	public ModelAndView sale_calendar(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/sale/calendar");
		Complex complexYearVO = new Complex();
		complexYearVO.setProgress_array("RV02201,RV02202,RV02203,RV02204,RV02205".split(","));
		complexYearVO.setCalendar_view_status("(sales_view_status='Y' or const_view_status='Y')");
		complexYearVO.setUse_yn("Y");
		List<Integer> years = complexService.selectComplexSalesYear(complexYearVO);

		// log.info("YEAR::::{}",years);
		Year nowYearTem = Year.now();
		String nowYear = nowYearTem.toString();
		if (!CommonUtils.isEmpty(commandMap.get("year"))) {
			nowYear = commandMap.get("year").toString();
		}
		boolean prevYear = false;
		boolean nextYear = false;
		for (int item : years) {
			if (item < Integer.parseInt(nowYear)) {
				prevYear = true;
				break;
			}
		}
		for (int item : years) {
			if (item > Integer.parseInt(nowYear)) {
				nextYear = true;
				break;
			}
		}

		Complex complexVO = new Complex();
		complexVO.setSales_year(nowYear);
		complexVO.setProgress_array("RV02201,RV02202,RV02203,RV02204,RV02205,".split(","));
		// complexVO.setSales_status("Y");
		// complexVO.setSales_view_status("Y");
		complexVO.setCalendar_view_status("(sales_view_status='Y' or const_view_status='Y')");
		complexVO.setRow_number("SALES_DATE ASC");
		complexVO.setOrderby("SALES_DATE ASC");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		List<Complex> list = complexService.selectComplexPjtList(complexVO);
		// log.info("LIST:::::::{}",list);
		Map<Integer, Object> monthList = new HashMap<Integer, Object>();
		for (int month = 1; month <= 12; month++) {
			String digitMonth = "";
			if (month < 10) {
				digitMonth = "0" + String.valueOf(month);
			} else {
				digitMonth = String.valueOf(month);
			}
			String yearMonth = nowYear + "" + digitMonth;
			log.info(yearMonth);
			monthList.put(month,list.stream().filter(item -> item.getSales_date().equals(yearMonth)).collect(Collectors.toList()));
		}

		mv.addObject("prevYear", prevYear);
		mv.addObject("nextYear", nextYear);

		mv.addObject("years", years);
		mv.addObject("nowYear", Integer.parseInt(nowYear));
		mv.addObject("monthList", monthList);
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/sale/complex", mb_mp + "/sale/complex" }, method = RequestMethod.GET)
	public ModelAndView sale_complex(Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/sale/complex");

		Code code = new Code();
		code.setCode_group_flag("N");
		code.setCode_group("RV021");
		List<Code> codeRegion = codeService.selectCodeList(code);
		mv.addObject("codeRegion", codeRegion);
		code.setCode_group_flag("N");
		code.setCode_group("RV020");
		List<Code> codeType = codeService.selectCodeList(code);
		mv.addObject("codeType", codeType);
		code.setCode_group_flag("N");
		code.setCode_group("RV022");
		code.setCode_array("RV02201,RV02202,RV02203".split(","));
		List<Code> codeProgress = codeService.selectCodeList(code);
		mv.addObject("codeProgress", codeProgress);


		if (complexVO.getKeyword() != null) {
			mv.addObject("keyword", complexVO.getKeyword());
		}
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/sale/complex_list", mb_mp + "/sale/complex_list" }, method = RequestMethod.POST)
	public ModelAndView sale_complex_proc(Complex complexVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (!CommonUtils.isEmpty(complexVO.getRegion())) {
			complexVO.setRegion_array(complexVO.getRegion().split(","));
		}
		complexVO.setRegion(null);
		if (!CommonUtils.isEmpty(complexVO.getHousing())) {
			complexVO.setHousing_array(complexVO.getHousing().split(","));
		}
		complexVO.setHousing(null);
		if (!CommonUtils.isEmpty(complexVO.getProgress())) {
			complexVO.setProgress_array(complexVO.getProgress().split(","));
		} else {
			complexVO.setProgress_array("RV02201,RV02202,RV02203".split(","));
		}
		complexVO.setProgress(null);

		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(6);
		paginationInfo.setPageSize(complexVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();
		complexVO.setFrom_join("LEFT");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setSales_status("Y");
		complexVO.setSales_view_status("Y");
		complexVO.setRow_number("tc.idx DESC");
		int total = complexService.selectComplexPjtCount(complexVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		complexVO.setStart(start);
		complexVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Complex> list = complexService.selectComplexPjtList(complexVO);

		for (Complex item : list) {
			if (!CommonUtils.isEmpty(item.getSales_date())) {
				if (item.getSales_date().length() > 5) {
					item.setSales_year(item.getSales_date().substring(0, 4));
					item.setSales_month(item.getSales_date().substring(4, 6));
				}
			}
		}
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/sale/complex_list");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/construction", mb_mp + "/build/construction" })
	public ModelAndView build_construction(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/construction");

		Code code = new Code();
		code.setCode_group_flag("N");
		code.setCode_group("RV021");
		List<Code> codeRegion = codeService.selectCodeList(code);
		mv.addObject("codeRegion", codeRegion);
		code.setCode_group_flag("N");
		code.setCode_group("RV020");
		List<Code> codeType = codeService.selectCodeList(code);
		mv.addObject("codeType", codeType);
		code.setCode_group_flag("N");
		code.setCode_group("RV022");
		code.setCode_array("RV02204,RV02205".split(","));
		List<Code> codeProgress = codeService.selectCodeList(code);
		mv.addObject("codeProgress", codeProgress);
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/construction_list",
			mb_mp + "/build/construction_list" }, method = RequestMethod.POST)
	public ModelAndView build_construction_proc(Complex complexVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (!CommonUtils.isEmpty(complexVO.getRegion())) {
			complexVO.setRegion_array(complexVO.getRegion().split(","));
		}
		complexVO.setRegion(null);
		if (!CommonUtils.isEmpty(complexVO.getHousing())) {
			complexVO.setHousing_array(complexVO.getHousing().split(","));
		}
		complexVO.setHousing(null);
		if (!CommonUtils.isEmpty(complexVO.getProgress())) {
			complexVO.setProgress_array(complexVO.getProgress().split(","));
			if(complexVO.getProgress().equals("RV02205")){
				complexVO.setProgress_const("Y");
				complexVO.setProgress_code("RV02202");

			}
		} else {
			complexVO.setProgress_array("RV02204,RV02205".split(","));
			complexVO.setProgress_const("Y");
			complexVO.setProgress_code("RV02202");
		}
		complexVO.setProgress(null);


		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(6);
		paginationInfo.setPageSize(complexVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();
		complexVO.setFrom_join("LEFT");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setConst_status("Y");
		complexVO.setConst_view_status("Y");
		complexVO.setRow_number("tc.idx DESC");
		int total = complexService.selectComplexPjtCount(complexVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		complexVO.setStart(start);
		complexVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Complex> list = complexService.selectComplexPjtList(complexVO);

		for (Complex item : list) {
			if (!CommonUtils.isEmpty(item.getSllt_info_mibl_ym())) {
				if (item.getSllt_info_mibl_ym().length() > 5) {
					item.setConst_year(item.getSllt_info_mibl_ym().substring(0, 4));
					item.setConst_month(item.getSllt_info_mibl_ym().substring(4, 6));
				}
			}
			if(item.getProgress().equals("RV02202")){
				item.setProgress("RV02205");
				item.setProgress_name("공사중");
			}
		}
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/construction_list");
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/construction_view", mb_mp + "/build/construction_view" })
	public ModelAndView build_construction_view(Complex complexVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setConst_status("Y");
		complexVO.setConst_view_status("Y");
		Complex detail = complexService.selectComplexPjtDetail(complexVO);

		if(!CommonUtils.isEmpty(detail.getSllt_info_mibl_ym())){
			if(detail.getSllt_info_mibl_ym().length()==6){
				detail.setConst_year(detail.getSllt_info_mibl_ym().substring(0, 4));
				detail.setConst_month(detail.getSllt_info_mibl_ym().substring(4, 6));
			}
		}
		if(detail.getProgress().equals("RV02202")){
			detail.setProgress("RV02205");
			detail.setProgress_name("공사중");
		}
		mv.addObject("detail", detail);
		ComplexConstChild complexChildVO = new ComplexConstChild();
		complexChildVO.setPjt_cd(detail.getPjt_cd());
		complexChildVO.setStatus("Y");
		List<ComplexConstChild> constChild = complexService.selectComplexPjtConstChildList(complexChildVO);

		for (ComplexConstChild item : constChild) {
			if(!CommonUtils.isEmpty(item.getConst_proc_dt())){
				if(item.getConst_proc_dt().length()==8){
					item.setRegist_year(item.getConst_proc_dt().substring(0, 4));
					item.setRegist_month(item.getConst_proc_dt().substring(4, 6));
				}
				
				ComplexConstFile complexFileVO = new ComplexConstFile();
				complexFileVO.setPjt_cd(item.getPjt_cd());
				complexFileVO.setConst_proc_dt(item.getConst_proc_dt());
				complexFileVO.setFile_gubun("complex_const_sub");
				int const_sub_file = complexService.selectComplexPjtConstFileCount(complexFileVO);
				item.setContConstFileCount(const_sub_file);
			}
		}
		mv.addObject("constChild", constChild);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/construction-view");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/construction_side", mb_mp + "/build/construction_side" }, method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView build_construction_side(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		ComplexConstFile complexFileVO = new ComplexConstFile();
		complexFileVO.setPjt_cd(commandMap.get("pjt_cd").toString());
		complexFileVO.setConst_proc_dt(commandMap.get("const_proc_dt").toString());
		complexFileVO.setFile_gubun("complex_const_sub");
		List<ComplexConstFile> const_sub_file = complexService.selectComplexPjtConstFileList(complexFileVO);
		
		mv.addObject("contConstFileList", const_sub_file);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/construction-slide");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/movein", mb_mp + "/build/movein" })
	public ModelAndView build_movein(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/movein");

		Code code = new Code();
		code.setCode_group_flag("N");
		code.setCode_group("RV021");
		List<Code> codeRegion = codeService.selectCodeList(code);
		mv.addObject("codeRegion", codeRegion);
		code.setCode_group_flag("N");
		code.setCode_group("RV020");
		List<Code> codeType = codeService.selectCodeList(code);
		mv.addObject("codeType", codeType);
		code.setCode_group_flag("N");
		code.setCode_group("RV022");
		code.setCode_array("RV02206,RV02207".split(","));
		List<Code> codeProgress = codeService.selectCodeList(code);
		mv.addObject("codeProgress", codeProgress);
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/movein_list", mb_mp + "/build/movein_list" }, method = RequestMethod.POST)
	public ModelAndView build_movein_proc(Complex complexVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (!CommonUtils.isEmpty(complexVO.getRegion())) {
			complexVO.setRegion_array(complexVO.getRegion().split(","));
		}
		complexVO.setRegion(null);
		if (!CommonUtils.isEmpty(complexVO.getHousing())) {
			complexVO.setHousing_array(complexVO.getHousing().split(","));
		}
		complexVO.setHousing(null);
		if (!CommonUtils.isEmpty(complexVO.getProgress())) {
			complexVO.setProgress_array(complexVO.getProgress().split(","));
		} else {
			complexVO.setProgress_array("RV02206,RV02207".split(","));
		}
		complexVO.setProgress(null);

		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(complexVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(6);
		paginationInfo.setPageSize(complexVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();
		complexVO.setFrom_join("LEFT");
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setOccupancy_status("Y");
		complexVO.setOccupancy_view_status("Y");
		complexVO.setRow_number("tc.idx DESC");
		int total = complexService.selectComplexPjtCount(complexVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		complexVO.setStart(start);
		complexVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Complex> list = complexService.selectComplexPjtList(complexVO);

		for (Complex item : list) {
			if (!CommonUtils.isEmpty(item.getMv_date())) {
				if (item.getMv_date().length() > 5) {
					item.setMv_date_year(item.getMv_date().substring(0, 4));
					item.setMv_date_month(item.getMv_date().substring(4, 6));
				}
			}
		}
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/movein_list");
		return mv;
	}

	
	/** 
	 * @param complexVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/build/movein_view", mb_mp + "/build/movein_view" })
	public ModelAndView build_movein_view(Complex complexVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();

		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		Complex detail = complexService.selectComplexPjtDetail(complexVO);
		if(!CommonUtils.isEmpty(detail.getMv_date())){
			if (detail.getMv_date().indexOf("-") > -1 && detail.getMv_date().length() > 3) {
				detail.setMv_date_year(detail.getMv_date().substring(0, 4));
				detail.setMv_date_month(detail.getMv_date().substring(4, 6));
			}

		}
		// 입주예약 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_start_date()) && !CommonUtils.isEmpty(detail.getMv_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_start_date());
			Date endDate = format.parse(detail.getMv_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setDiff_date(true);
			}
		}
		// 사전점검 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_pre_start_date())
				&& !CommonUtils.isEmpty(detail.getMv_pre_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_pre_start_date());
			Date endDate = format.parse(detail.getMv_pre_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setReservationDiff_date(true);
			}
		}
		if (detail.getOccupancy_status().equals("Y")) {

			ComplexFile complexFileVO = new ComplexFile();
			complexFileVO.setPjt_cd(detail.getPjt_cd());
			complexFileVO.setFile_gubun("complex_occupancy");
			List<ComplexFile> occupancyFileList = complexService.selectComplexPjtFileList(complexFileVO);
			detail.setOccupancyFileList(occupancyFileList);
		}
		mv.addObject("detail", detail);
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/build/movein-view");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/etc/error", mb_mp + "/etc/error" })
	public ModelAndView etc_error(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/etc/error");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/etc/policies-email", mb_mp + "/etc/policies-email" })
	public ModelAndView etc_policies_email(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/etc/policies-email");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/etc/policies-privacy", mb_mp + "/etc/policies-privacy" })
	public ModelAndView etc_policies_privacy(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/etc/policies-privacy");
		Board boardVO = new Board();
		boardVO.setPid(8);
		boardVO.setStatus("Y");
		List<Board> list = boardService.selectBoardList(boardVO);
		Board detail = new Board();
		int count = 0;
		for (Board item : list) {
			int idx = 0;
			if (CommonUtils.isEmpty(commandMap.get("q"))) {
				if (idx == 0) {
					detail = item;
				}
			} else {
				if (item.getIdx() == Integer.parseInt(commandMap.get("q").toString())) {
					detail = item;
				}
			}

			count++;
		}
		mv.addObject("detail", detail);
		mv.addObject("list", list);

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/etc/policies-terms", mb_mp + "/etc/policies-terms" })
	public ModelAndView etc_policies_terms(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/etc/policies-terms");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/etc/sitemap", mb_mp + "/etc/sitemap" })
	public ModelAndView etc_sitemap(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/etc/sitemap");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/editinfo", mb_mp + "/member/editinfo" }, method = RequestMethod.GET)
	public ModelAndView member_editinfo(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}

		HttpSession session = request.getSession();
		Member sessionMember = (Member) session.getAttribute("memberSession");
		Member detailMember = new Member();
		detailMember.setUser_id(sessionMember.getUser_id());
		Member member = memberService.selectMemberDetail(detailMember);
		mv.addObject("member", member);
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/editinfo");

		return mv;
	}

	
	/** 
	 * @param member
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/editinfo", mb_mp + "/member/editinfo" }, method = RequestMethod.POST)
	public ModelAndView member_editinfo_proc(Member member, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}

		HttpSession session = request.getSession();
		Member sessionMember = (Member) session.getAttribute("memberSession");
		member.setUser_id(sessionMember.getUser_id());
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		if (!CommonUtils.isEmpty(member.getHp())) {
			if (member.getHp().length() > 9) {
				member.setHp1(member.getHp().substring(0, 3));
				member.setHp2(member.getHp().substring(3, 7));
				member.setHp3(member.getHp().substring(7, 11));
			}
		}
		if(CommonUtils.isEmpty(member.getMarry_fg_cd())){
			member.setMarry_fg_cd("");
		}
		if(CommonUtils.isEmpty(member.getDeptsit_yn())){
			member.setDeptsit_yn("");
		}
		member.setDeposit_yymm(member.getDeposit_yymm().replace("-", ""));
		if (memberService.updateMember(member) > 0) {
			Member detailMember = new Member();
			detailMember.setUser_id(sessionMember.getUser_id());
			Member detail = memberService.selectMemberDetail(detailMember);
			session.setAttribute("memberSession", detail);
			session.setAttribute("returnRequest", "ok");

			mv.setViewName("redirect:" + rpath + "/index");
		} else {
			session.setAttribute("returnRequest", "none");
			mv.setViewName("redirect:" + rpath + "/member/editinfo");
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findid-01", mb_mp + "/member/findid-01" }, method = RequestMethod.GET)
	public ModelAndView member_findid_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		Map<String,Object> sms = CommonUtils.niceIdReq(request,"findid");
		mv.addObject("sms", sms);
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/findid-01");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findid-02", mb_mp + "/member/findid-02" }, method = RequestMethod.POST)
	public ModelAndView member_findid_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		Member member = new Member();
		member.setUser_nm(commandMap.get("sName").toString());
		member.setHp(commandMap.get("sMobileNo").toString());
		Member detail = memberService.selectMemberDetail(member);
		
		if (!CommonUtils.isEmpty(detail)) {
			mv.addObject("member", detail);
			mv.setViewName(viewname + "/member/findid-02");
		} else {
			mv.setViewName(viewname + "/member/findid-03");
		}
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findid-03", mb_mp + "/member/findid-03" })
	public ModelAndView member_findid_03(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		
		mv.setViewName(viewname + "/member/findid-03");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findpw-01", mb_mp + "/member/findpw-01" }, method = RequestMethod.GET)
	public ModelAndView member_findpw_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/findpw-01");
		return mv;
	}

	
	/** 
	 * @param member
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findpw-02", mb_mp + "/member/findpw-02" })
	public ModelAndView member_findpw_02(Member member, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/findpw-02");
		HttpSession session = request.getSession();
		String returnType = "";
		Member detail = memberService.selectMemberDetail(member);
		log.info("AAA{}",CommonUtils.isEmpty(detail));
		if (!CommonUtils.isEmpty(detail)) {
			mv.addObject("member", detail);
			Map<String,Object> sms = CommonUtils.niceIdReq(request,"findpw");
			mv.addObject("sms", sms);
			mv.setViewName(viewname + "/member/findpw-02");
		} else {
			session.setAttribute("sessionRequest", member);
			session.setAttribute("returnRequest", "none");
			mv.setViewName("redirect:" + rpath + "/member/findpw-01");
		}
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findpw-03", mb_mp + "/member/findpw-03" }, method = RequestMethod.POST)
	public ModelAndView member_findpw_03(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		HttpSession session = request.getSession();
		Member member = new Member();
		member.setUser_nm(commandMap.get("sName").toString());
		member.setHp(commandMap.get("sMobileNo").toString());
		Member detail = memberService.selectMemberDetail(member);
		if (!CommonUtils.isEmpty(detail)) {
			mv.addObject("member", detail);
			mv.setViewName(viewname + "/member/findpw-03");
		} else {
			session.setAttribute("sessionRequest", commandMap);
			session.setAttribute("returnRequest", "none");
			mv.setViewName("redirect:" + rpath + "/member/findpw-01");
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/findpw-03");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/findpw_03_proc", mb_mp + "/member/findpw_03_proc" }, method = RequestMethod.POST)
	public ModelAndView member_findpw_03_proc(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		HttpSession session = request.getSession();
		if(CommonUtils.isEmpty(commandMap.get("user_id").toString())){
			mv.setViewName("redirect:" + rpath + "/member/findpw-01");
			session.setAttribute("returnRequest", "none");
			return mv;
			
		}
		String returnType = "";
		Member member = new Member();
		member.setUser_id(commandMap.get("user_id").toString());
		Member detail = memberService.selectMemberDetail(member);
		log.info("USER ID :: {},{}",commandMap.get("user_id").toString(),"||"+member.getUser_id()+"||");
		if (!CommonUtils.isEmpty(detail)) {
			member.setUser_id(detail.getUser_id());
			log.info("USER INFO :: {},{}",commandMap.get("user_id").toString(),"||"+commandMap.get("password").toString()+"||");
			member.setPassword(passwordEncoder.encode(commandMap.get("password").toString()));
			if (memberService.updateMemberPwd(member) > 0) {
				session.setAttribute("returnRequest", "pwd_ok");
				mv.setViewName("redirect:" + rpath + "/member/login");
			} else {
				session.setAttribute("sessionRequest", member);
				session.setAttribute("returnRequest", "none");
				mv.setViewName("redirect:" + rpath + "/member/findpw-01");
			}
		} else {
			session.setAttribute("sessionRequest", member);
			session.setAttribute("returnRequest", "none");
			mv.setViewName("redirect:" + rpath + "/member/findpw-01");
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/join-01", mb_mp + "/member/join-01" })
	public ModelAndView member_join_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		log.info("{}", viewname);
		mv.setViewName(viewname + "/member/join-01");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/join-02", mb_mp + "/member/join-02" }, method = RequestMethod.POST)
	public ModelAndView member_join_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/join-02");

		if (commandMap.get("agree01") == null || commandMap.get("agree02") == null) {
			mv.setViewName("redirect:" + rpath + "/member/join-01");
			return mv;
		}

		Map<String,Object> sms = CommonUtils.niceIdReq(request,"join");
		mv.addObject("sms", sms);

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/join-ipinsms", mb_mp + "/member/join-ipinsms" })
	public ModelAndView newmemberipinsms(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView(viewname + "/member/join-ipinsms");
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		Map<String,Object> retMap = CommonUtils.niceIdRes(request,commandMap);
		if(commandMap.get("page").toString().equals("join")){
			@SuppressWarnings("unchecked")
			Map<String,Object> returnObj = (Map<String, Object>) retMap.get("returnObj");
			Member member = new Member();
			member.setUser_nm(returnObj.get("sName").toString());
			member.setHp(returnObj.get("sMobileNo").toString());
			if(memberService.selectMemberCount(member)>0){
				mv.addObject("sMessage", "이미 가입한 회원입니다.");
				mv.addObject("is_bool", false);
				return mv;
			}
		}
		mv.addObject("is_bool", retMap.get("is_bool"));
		mv.addObject("returnObj", retMap.get("returnObj"));
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/join-03", mb_mp + "/member/join-03" })
	public ModelAndView member_join_03(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/join-03");
		if (commandMap.get("agree01") == null || commandMap.get("agree02") == null) {
			mv = new ModelAndView("redirect:" + rpath + "/member/join-01");
		}
		return mv;
	}

	
	/** 
	 * @param member
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/joinProc", mb_mp + "/member/joinProc" })
	public ModelAndView insertAdmin(Member member, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		HttpSession session = request.getSession();
		Map<String, Object> sessionMap = new HashMap<String, Object>();

		if(CommonUtils.isEmpty(member.getMarry_fg_cd())){
			member.setMarry_fg_cd("");
		}
		if(CommonUtils.isEmpty(member.getDeptsit_yn())){
			member.setDeptsit_yn("");
		}
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		if (!CommonUtils.isEmpty(member.getHp())) {
			if (member.getHp().length() > 9) {
				member.setHp1(member.getHp().substring(0, 3));
				member.setHp2(member.getHp().substring(3, 7));
				member.setHp3(member.getHp().substring(7, 11));
			}
		}
		if (!CommonUtils.isEmpty(member.getYymmdd())) {
			if (member.getYymmdd().length() > 7) {
				member.setYymmdd(member.getYymmdd().substring(2));
			}
		}
		member.setDeposit_yymm(member.getDeposit_yymm().replace("-", ""));
		if (memberService.insertMember(member) > 0) {
			sessionMap.put("user_id", member.getUser_id());
			sessionMap.put("user_nm", member.getUser_nm());
			session.setAttribute("join_result", sessionMap);
			mv.setViewName("redirect:" + rpath + "/member/join-04");
		} else {
			String referer = (String) request.getHeader("REFERER");
			session.setAttribute("join_error", member);
			mv.setViewName("redirect:" + referer);
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/idFind", mb_mp + "/member/idFind" })
	@ResponseBody
	public Map<String, Object> idFind(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		Member member = new Member();
		member.setUser_id(commandMap.get("user_id").toString());
		int memCount = memberService.selectMemberCount(member);
		if (memCount > 0) {
			map.put("result", false);
		}
		return map;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/idSearch", mb_mp + "/member/idSearch" })
	@ResponseBody
	public Map<String, Object> idSearch(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		Member member = new Member();
		member.setUser_id(commandMap.get("user_id").toString());
		int memCount = memberService.selectMemberDupCount(member);
		if (memCount > 0) {
			map.put("result", false);
		}
		return map;
	}
	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/pwdSearch", mb_mp + "/member/pwdSearch" })
	@ResponseBody
	public Map<String, Object> pwdSearch(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		Member member = new Member();
		member.setUser_id(commandMap.get("user_id").toString());
		Member memberVO = memberService.selectMemberDetail(member);
		if (passwordEncoder.matches(commandMap.get("pwd").toString(), memberVO.getPassword())) {
			map.put("result", false);
		}
		return map;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/join-04", mb_mp + "/member/join-04" })
	public ModelAndView member_join_04(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/join-04");
		HttpSession session = request.getSession();
		if (!CommonUtils.isEmpty(session.getAttribute("join_result"))) {
			Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("join_result");
			mv.addObject("member", sessionMap);
		} else {
			String referer = (String) request.getHeader("REFERER");
			session.setAttribute("join_error", "join-04");
			mv.setViewName("redirect:" + referer);
		}
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/leave-01", mb_mp + "/member/leave-01" }, method = RequestMethod.GET)
	public ModelAndView member_leave_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		HttpSession session = request.getSession();
		if (!CommonUtils.logincheck(request, "memberSession")) {
			session.setAttribute("returnRequest", "login");
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/leave-01");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/leave-01", mb_mp + "/member/leave-01" }, method = RequestMethod.POST)
	public ModelAndView member_leave_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		HttpSession session = request.getSession();
		String returnType = "";

		Member detail = (Member) session.getAttribute("memberSession");
		if (!CommonUtils.isEmpty(detail)) {
			if (passwordEncoder.matches(commandMap.get("password").toString(), detail.getPassword())) {

				if (memberService.deleteMember(detail) > 0) {
					session.removeAttribute("memberSession");
					mv.addObject("rpath", rpath);
					mv.setViewName(viewname + "/member/leave-02");
				} else {
					session.setAttribute("sessionRequest", commandMap);
					session.setAttribute("returnRequest", "dberr");
					mv.setViewName("redirect:" + rpath + "/member/leave-01");
				}
			} else {
				session.setAttribute("sessionRequest", commandMap);
				session.setAttribute("returnRequest", "none");
				mv.setViewName("redirect:" + rpath + "/member/leave-01");
			}
		} else {
			session.setAttribute("sessionRequest", commandMap);
			session.setAttribute("returnRequest", "error");
			mv.setViewName("redirect:" + rpath + "/member/leave-01");
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/login", mb_mp + "/member/login" }, method = RequestMethod.GET)
	public ModelAndView member_login(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/login");
		return mv;
	}

	
	/** 
	 * @param member
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/login", mb_mp + "/member/login" }, method = RequestMethod.POST)
	public ModelAndView member_login_proc(Member member, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		String returnType = "";
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);

		String referer = (String) request.getHeader("REFERER");
		Member detail = memberService.selectMemberDetail(member);
		if (!CommonUtils.isEmpty(detail)) {
			if (passwordEncoder.matches(member.getPassword(), detail.getPassword())) {
				if(detail.getUser_type().equals("H")){
					mv.addObject("member", detail);
					Map<String,Object> sms = CommonUtils.niceIdReq(request,"findpw");
					mv.addObject("sms", sms);
					mv.setViewName(viewname + "/member/dormancy");
					return mv;
				}
				memberService.updateLogin(member);
				returnType = "ok";
				session.setAttribute("memberSession", detail);
				
			} else {
				returnType = "pwd";
			}
		} else {
			returnType = "none";
		}
		if (returnType.equals("ok")) {
			if(!CommonUtils.isEmpty(detail.getPwd_update_dtm())){
				if(detail.getPwd_update_bool().equals("change")){
					returnType="change";
				}		
			}
		}
		if (returnType.equals("ok")) {
			if (!CommonUtils.isEmpty(member.getReturl())) {
				mv.setViewName("redirect:" + member.getReturl());
			} else {
				mv.setViewName("redirect:" + rpath + "/index");
			}
		} else if (returnType.equals("change")) {
			if (!CommonUtils.isEmpty(member.getReturl())) {
				mv.setViewName("redirect:" + rpath + "/member/pwd_change?returl=" + member.getReturl());
			}else{
				mv.setViewName("redirect:" + rpath + "/member/pwd_change");
			}
		} else {
			session.setAttribute("sessionRequest", member);
			session.setAttribute("returnRequest", returnType);
			mv.setViewName("redirect:" + referer);
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/dormancy_complete", mb_mp + "/member/dormancy_complete" }, method = RequestMethod.POST)
	public ModelAndView dormancy_complete(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		HttpSession session = request.getSession();
		Member member = new Member();
		member.setUser_id(commandMap.get("param_r1").toString());
		member.setHp(commandMap.get("sMobileNo").toString());
		Member detail = memberService.selectMemberDetail(member);
		if (!CommonUtils.isEmpty(detail)) {
			mv.addObject("member", detail);
			mv.setViewName(viewname + "/member/dormancy_complete");
		} else {
			session.setAttribute("sessionRequest", commandMap);
			session.setAttribute("returnRequest", "none");
			mv.setViewName("redirect:" + rpath + "/member/dormancy");
		}
		mv.addObject("rpath", rpath);
		return mv;
	}
	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/dormancy_proc", mb_mp + "/member/dormancy_proc" }, method = RequestMethod.POST)
	public ModelAndView member_dormancy_proc(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		HttpSession session = request.getSession();
		if(CommonUtils.isEmpty(commandMap.get("user_id").toString())){
			mv.setViewName("redirect:" + rpath + "/member/dormancy");
			session.setAttribute("returnRequest", "none");
			return mv;
			
		}
		String returnType = "";
		Member member = new Member();
		member.setUser_id(commandMap.get("user_id").toString());
		Member detail = memberService.selectMemberDetail(member);
		log.info("USER ID :: {},{}",commandMap.get("user_id").toString(),"||"+member.getUser_id()+"||");
		mv.setViewName("redirect:" + rpath + "/member/dormancy");
		if (!CommonUtils.isEmpty(detail)) {
			member.setUser_id(detail.getUser_id());
			log.info("USER INFO :: {},{}",commandMap.get("user_id").toString(),"||"+commandMap.get("password").toString()+"||");
			member.setPassword(passwordEncoder.encode(commandMap.get("password").toString()));
			if (memberService.updateMemberPwdDormancy(member) > 0) {
				session.setAttribute("returnRequest", "pwd_ok");
				mv.setViewName("redirect:" + rpath + "/member/login");
			} else {
				session.setAttribute("sessionRequest", member);
				session.setAttribute("returnRequest", "none");
			}
		} else {
			session.setAttribute("sessionRequest", member);
			session.setAttribute("returnRequest", "none");
		}

		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/pwd_change", mb_mp + "/member/pwd_change" }, method = RequestMethod.GET)
	public ModelAndView member_pwd_change(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/member/pwd_change");
		return mv;
	}

	
	/** 
	 * @param member
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/member/pwd_change", mb_mp + "/member/pwd_change" }, method = RequestMethod.POST)
	public ModelAndView member_pwd_change_proc(Member member, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		String returnType = "";

		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}

		Member sessionMember = (Member) session.getAttribute("memberSession");
		member.setUser_id(sessionMember.getUser_id());
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		if(memberService.updateMemberPwd(member)>0){
			
			session.setAttribute("SITE_ALERT", "비밀번호 변경이 완료 되었습니다.");
			if (!CommonUtils.isEmpty(member.getReturl())) {
				mv.setViewName("redirect:" + member.getReturl());
			} else {
				mv.setViewName("redirect:" + rpath + "/index");
			}
		}else{
			session.setAttribute("sessionRequest", member);
			session.setAttribute("returnRequest", returnType);
			if (!CommonUtils.isEmpty(member.getReturl())) {
				mv.setViewName("redirect:" + rpath + "/member/pwd_change?returl=" + member.getReturl());
			} else {
				mv.setViewName("redirect:" + rpath + "/member/pwd_change");
			}
			
		}
		return mv;
	}


	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/logout", mb_mp + "/logout" })
	public ModelAndView member_logout(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		HttpSession session = request.getSession();
		session.removeAttribute("memberSession");
		mv.setViewName("redirect:" + rpath + "/index");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/as", mb_mp + "/mypage/as" })
	public ModelAndView mypage_as(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/as");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/index", mb_mp + "/mypage/index" })
	public ModelAndView mypage_index(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/index");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		HttpSession session = request.getSession();
		Member detail = (Member) session.getAttribute("memberSession");
		
		if (!CommonUtils.isEmpty(detail)) {
			commandMap.put("user_id",detail.getUser_id());
			List<Map<String,Object>> projectMap = projectService.selectMyElifProjectInfoList(commandMap.getMap());
			for(Map<String,Object> item : projectMap){
				// 입주예약 방문 신청 기간
				if (!CommonUtils.isEmpty(item.get("MV_START_DATE")) && !CommonUtils.isEmpty(item.get("MV_END_DATE"))) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = format.parse(item.get("MV_START_DATE").toString());
					Date endDate = format.parse(item.get("MV_END_DATE").toString());
					Date time = new Date();
					String strnow = format.format(time);
					Date nowDate = format.parse(strnow);
					if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
						item.put("DIFF_DATE",true);
					}
				}
				// 사전점검 방문 신청 기간
				if (!CommonUtils.isEmpty(item.get("MV_PRE_START_DATE")) && !CommonUtils.isEmpty(item.get("MV_PRE_END_DATE"))) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = format.parse(item.get("MV_PRE_START_DATE").toString());
					Date endDate = format.parse(item.get("MV_PRE_END_DATE").toString());
					Date time = new Date();
					String strnow = format.format(time);
					Date nowDate = format.parse(strnow);
					if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
						item.put("RESERVATIONDIFF_DATE",true);
					}
				}
			}
			mv.addObject("projectList", projectMap);
		}

		Board boardVO = new Board();
		boardVO.setPid(6);
		boardVO.setStatus("Y");
		boardVO.setOrderby("mainstatus desc, idx desc");
		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
		paginationInfo.setPageSize(boardVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = boardService.selectBoardCount(boardVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		boardVO.setStart(start);
		boardVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Board> list = boardService.selectBoardList(boardVO);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("noticeList", list);
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/inquiry-apply", mb_mp + "/mypage/inquiry-apply" }, method = RequestMethod.GET)
	public ModelAndView mypage_inquiry_apply(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/inquiry-apply");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		Complex complexVO = new Complex();
		complexVO.setUse_yn("Y");
		complexVO.setProgress_array("RV02201,RV02202,RV02203,RV02204,RV02205,RV02206,RV02207".split(","));
		List<Complex> list = complexService.selectComplexPjtList(complexVO);
		mv.addObject("list", list);

		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/inquiry-apply", mb_mp + "/mypage/inquiry-apply" }, method = RequestMethod.POST)
	public ModelAndView mypage_inquiry_apply_post(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.setViewName(viewname + "/mypage/inquiry-apply");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}

		HttpSession session = request.getSession();
		Map<String, Object> sessionMap = new HashMap<String, Object>();

		Member sessionMember = (Member) session.getAttribute("memberSession");
		customerVO.setUser_id(sessionMember.getUser_id());
		log.info(sessionMember.toString());
		if (customerService.insertCustomer(customerVO) > 0) {
			String domain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
			String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy. MM. dd HH:mm"));
			String nowDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"));

			// 메일 보내기
			HashMap<String, Object> mapMail = new HashMap<String, Object>();
			mapMail.put("title", customerVO.getTitle());
			mapMail.put("date", nowDate);
			mapMail.put("time", nowTime);
			mapMail.put("domain", domain);
			mapMail.put("adminlink", adminlink+"/mgmt/login");
			Complex complexVO = new Complex();
			complexVO.setPjt_cd(customerVO.getPjt_cd());
			Complex complexDetail = complexService.selectComplexPjtDetail(complexVO);
			
			if(customerVO.getType().equals("RV02401")){
				mapMail.put("complex_name", complexDetail.getPjt_nm());
			}else{
				/**
				 * 수정 : 23.05.14
				 * 내용 : 기타문의 단지명 추가 처리
				 * 작업 : 한동호(플레어)
				 */
				//mapMail.put("complex_name", "기타");
				if(complexDetail != null){
					mapMail.put("complex_name", complexDetail.getPjt_nm());
				}
				else {
					mapMail.put("complex_name", "기타");
				}
			}

			String mailFile = "customer_sendmember";
			MailHandler.getMailSend(mailSender, mailFrom, sessionMember.getEmail(), "[계룡 엘리프] 고객 문의 알림 메일", mailFile,mapMail);

			Customer customerAdminVO = new Customer();
			List<Customer> list = customerService.selectAdminInCharge(customerAdminVO);
			if (list.size() > 0) {
				for (Customer customerAdmin : list) {
					mapMail.put("department", customerVO.getDepartment());
					mapMail.put("user_nm", sessionMember.getUser_nm());

					/**
					 * 수정 : 23.05.14
					 * 내용 : 관리자 메일 내용 부분에 사용자 정보 추가(연락처, 이메일)
					 * 작업 : 한동호(플레어)
					 */
					mapMail.put("email2", sessionMember.getEmail());
					mapMail.put("tel2", sessionMember.getHp());

					mapMail.put("title", customerVO.getTitle());
					if(customerVO.getType().equals("RV02401")){
						mapMail.put("complex_name", complexDetail.getPjt_nm());
					}else{
						/**
						 * 수정 : 23.05.14
						 * 내용 : 기타문의 단지명 추가 처리
						 * 작업 : 한동호(플레어)
						 */
						//mapMail.put("complex_name", "기타");
						if(complexDetail != null){
							mapMail.put("complex_name", complexDetail.getPjt_nm());
						}
						else {
							mapMail.put("complex_name", "기타");
						}
					}
					mapMail.put("inquiry_content", customerVO.getInquiry_content());
					mailFile = "customer_sendadmin";
					MailHandler.getMailSend(mailSender, mailFrom, customerAdmin.getEmail(), "[계룡 엘리프] 고객 문의 알림 메일",mailFile, mapMail);
					//break;
				}

			}
			session.setAttribute("SITE_ALERT", "회원님의 문의가 정상적으로 등록되었습니다.");
			mv.setViewName("redirect:" + rpath + "/mypage/inquiry-apply");
		} else {
			String referer = (String) request.getHeader("REFERER");
			session.setAttribute("old_form", customerVO);
			mv.setViewName("redirect:" + referer);
		}

		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/inquiry-lookup", mb_mp + "/mypage/inquiry-lookup" })
	public ModelAndView mypage_inquiry_lookup(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/inquiry-lookup");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		if (request.getRequestURI().indexOf(mb_check) < 0) {
			HttpSession session = request.getSession();
			Member sessionMember = (Member) session.getAttribute("memberSession");

			customerVO.setUser_id(sessionMember.getUser_id());

			PaginationInfo paginationInfo = null;

			paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(customerVO.getCurrentPageNo());
			paginationInfo.setRecordCountPerPage(customerVO.getRecordCountPerPage());
			paginationInfo.setPageSize(customerVO.getPageSize());
			int start = paginationInfo.getFirstRecordIndex();
			int end = paginationInfo.getRecordCountPerPage();

			int total = customerService.selectInquiryCount(customerVO);
			if (paginationInfo != null) {
				paginationInfo.setTotalRecordCount(total);
			}
			customerVO.setStart(start);
			customerVO.setEnd(paginationInfo.getLastRecordIndex());

			List<Customer> list = customerService.selectInquiryList(customerVO);

			mv.addObject("paginationInfo", paginationInfo);
			mv.addObject("list", list);

			mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
			if (customerVO.getTarget() != null) {
				mv.addObject("target", customerVO.getTarget());
			}
			if (customerVO.getKeyword() != null) {
				mv.addObject("keyword", customerVO.getKeyword());
			}

			if (customerVO.getReply_status() != null) {
				mv.addObject("reply_status", customerVO.getReply_status());
			}
			if (customerVO.getSdate() != null) {
				mv.addObject("sdate", customerVO.getSdate());
			}
			if (customerVO.getEdate() != null) {
				mv.addObject("edate", customerVO.getEdate());
			}
		}
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	// ! 모바일에서만 사용
	@RequestMapping(value = { "/mypage/inquiry-lookup_list", mb_mp + "/mypage/inquiry-lookup_list" })
	public ModelAndView mobile_mypage_inquiry_lookup_list(Customer customerVO, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mobile/mypage/inquiry-lookup_list");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:/member/login?returl=" + URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		HttpSession session = request.getSession();
		Member sessionMember = (Member) session.getAttribute("memberSession");

		customerVO.setUser_id(sessionMember.getUser_id());

		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(customerVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(customerVO.getRecordCountPerPage());
		paginationInfo.setPageSize(customerVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = customerService.selectInquiryCount(customerVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		customerVO.setStart(start);
		customerVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Customer> list = customerService.selectInquiryList(customerVO);

		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}

		if (customerVO.getLang() != null) {
			mv.addObject("lang", customerVO.getLang());
		}
		if (customerVO.getReply_status() != null) {
			mv.addObject("reply_status", customerVO.getReply_status());
		}
		if (customerVO.getSdate() != null) {
			mv.addObject("sdate", customerVO.getSdate());
		}
		if (customerVO.getEdate() != null) {
			mv.addObject("edate", customerVO.getEdate());
		}
		if (customerVO.getLang() != null) {
			mv.addObject("lang", customerVO.getLang());
		}
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/inquiry-lookup-view", mb_mp + "/mypage/inquiry-lookup-view" })
	public ModelAndView mypage_inquiry_lookup_view(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/inquiry-lookup-view");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		Customer customerAdminVO = new Customer();
		int countAdmin = customerService.selectAdminCount(customerAdminVO);
		if (countAdmin == 0) {
			mv.setViewName("redirect:" + rpath + "/mgmt/customer/qna?error=noadmin");
			return mv;
		}
		HttpSession session = request.getSession();
		Member sessionMember = (Member) session.getAttribute("memberSession");

		customerVO.setUser_id(sessionMember.getUser_id());

		// 1. IDX로 문의내용 조회
		Customer detail = customerService.selectInquiry(customerVO);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		customerVO.setMerge_dtm(format.format(detail.getCrea_dtm()));
		log.info("::::::::::::::::::{}", detail.getMerge_dtm());

		if (!CommonUtils.isEmpty(detail.getLang())) {
			String[] values = detail.getLang().split(",");
			if (values != null) {
				customerVO.setLangs(values);
			}
		}
		mv.addObject("map", detail);
		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/inquiry-lookup-delete",
			mb_mp + "/mypage/inquiry-lookup-delete" }, method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mypage_inquiry_lookup_delete(Customer customerVO, HttpServletRequest request)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = false;
		if (!CommonUtils.logincheck(request, "memberSession")) {
			result = false;
		}
		HttpSession session = request.getSession();
		Member sessionMember = (Member) session.getAttribute("memberSession");

		customerVO.setUser_id(sessionMember.getUser_id());
		// 1. IDX로 문의내용 조회
		Customer detail = customerService.selectInquiry(customerVO);
		if (detail.getUser_id().equals(sessionMember.getUser_id())) {

			customerService.deleteInquiry(customerVO);
			result = true;
		}
		map.put("result", result);
		return map;
	}
	
	/** 
	 * @return ModelAndView
	 */
	/* 
	@RequestMapping(value = { "/mypage/visit-lookup-01", mb_mp + "/mypage/visit-lookup-01" })
	public ModelAndView mypage_visit_lookup_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-lookup-01");
		return mv;
	}

	@RequestMapping(value = { "/mypage/visit-lookup-02", mb_mp + "/mypage/visit-lookup-02" })
	public ModelAndView mypage_visit_lookup_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-lookup-02");
		return mv;
	}

	@RequestMapping(value = { "/mypage/visit-lookup-03", mb_mp + "/mypage/visit-lookup-03" })
	public ModelAndView mypage_visit_lookup_03(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		List<Map<String,Object>> list = reservationService.retrieveRicheBfchkReserveInfoList(commandMap.getMap());
		mv.addObject("list", list);
		mv.setViewName(viewname + "/mypage/visit-lookup-03");
		return mv;
	}

	@RequestMapping(value = { "/mypage/visit-lookup-04", mb_mp + "/mypage/visit-lookup-04" })
	public ModelAndView mypage_visit_lookup_04(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-lookup-04");
		return mv;
	}

	@RequestMapping(value = { "/mypage/visit-reservation-01", mb_mp + "/mypage/visit-reservation-01" })
	public ModelAndView mypage_visit_reservation_01(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-reservation-01");
		return mv;
	}

	@RequestMapping(value = { "/mypage/visit-reservation-02", mb_mp + "/mypage/visit-reservation-02" })
	public ModelAndView mypage_visit_reservation_02(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-reservation-02");
		return mv;
	} */

	@RequestMapping(value = { "/mypage/visit-reservation-01", mb_mp + "/mypage/visit-reservation-01" })
	public ModelAndView mypage_visit_reservation_n01(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/visit-reservation-n01");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/visit-reservation-n02", mb_mp + "/mypage/visit-reservation-n02" })
	public ModelAndView mypage_visit_reservation_n02(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		Gson gson = new Gson();
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		
		Complex complexVO = new Complex();
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setConst_status("Y");
		complexVO.setConst_view_status("Y");
		complexVO.setPjt_cd(commandMap.get("reqPjtCd").toString());
		Complex detail = complexService.selectComplexPjtDetail(complexVO);

		
		// 입주예약 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_start_date()) && !CommonUtils.isEmpty(detail.getMv_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_start_date());
			Date endDate = format.parse(detail.getMv_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setDiff_date(true);
			}
		}
		// 사전점검 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_pre_start_date())
				&& !CommonUtils.isEmpty(detail.getMv_pre_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_pre_start_date());
			Date endDate = format.parse(detail.getMv_pre_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setReservationDiff_date(true);
			}
		}
		mv.addObject("detail", detail);

		Map<String,Object> map = reservationService.retrieveRicheBfchkReserveInfo(commandMap.getMap());
		mv.addObject("map", map);
		mv.addObject("map2", gson.toJson(map));
		if(map != null && !map.isEmpty()){
			Map<String,Object> timeMap = new HashMap<String,Object>();
			timeMap.put("reqPjtCd",commandMap.get("reqPjtCd"));
			timeMap.put("blCd",commandMap.get("reqBlCd"));
			timeMap.put("rmnoCd",commandMap.get("reqRmnoCd"));
			

			Map<String,Object> timeListMap = new HashMap<String,Object>();
			if(!CommonUtils.isEmpty(map.get("BF_CHK_RES_DT"))){
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Date d1 = df.parse( map.get("BF_CHK_STR_DT").toString() );
				Date d2 = df.parse( map.get("BF_CHK_END_DT").toString() );
				Date nowDate = df.parse( df.format(new Date()) );
				Calendar c1 = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				Calendar nowCal = Calendar.getInstance();
				c1.setTime( d1 );
				c2.setTime( d2 );
				nowCal.setTime(nowDate);
				while( c1.compareTo( c2 ) !=1 ){
					if(c1.compareTo(nowCal)>=0){
						//출력
						timeMap.put("bfChkResDt",c1.getTime());
						String nowDateMap = df.format(c1.getTime());
						
						List<Map<String,Object>> timeNode = reservationService.retrieveRicheBfchkReserveDay(timeMap);
						if(timeNode.size()>0){
							timeListMap.put(nowDateMap, timeNode);
						}
					}
					//시작날짜 + 1 일
					c1.add(Calendar.DATE, 1);
				}
				Map<String, Object> sortedMap = timeListMap.entrySet().stream()
				.sorted(Map.Entry.comparingByKey())
				.collect(Collectors.toMap(
						Map.Entry::getKey,
						Map.Entry::getValue,
						(a, b) -> { throw new AssertionError(); },
						LinkedHashMap::new
				));
				mv.addObject("time", sortedMap);
				mv.addObject("time2", gson.toJson(sortedMap));

			}
		}

		mv.setViewName(viewname + "/mypage/visit-reservation-n02");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/visit-reservation-n03", mb_mp + "/mypage/visit-reservation-n03" })
	public ModelAndView mypage_visit_reservation_n03(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		
		HttpSession session = request.getSession();
		if(commandMap.get("type").equals("delete")){
			if (reservationService.cancelRicheBfchkReserve(commandMap.getMap())>0) {
				session.setAttribute("join_result",  commandMap.getMap());
				session.setAttribute("SITE_ALERT", "신청 취소를 완료 했습니다.");

				//SMS 발송정보
				Map<String, Object> smsInfo = reservationService.retrieveRicheBfchkReserveSmsInfo(commandMap.getMap());

				if(!CommonUtils.isEmpty(smsInfo.get("TO_PHONE_NO")) && !CommonUtils.isEmpty(smsInfo.get("FROM_PHONE_NO"))){
					smsInfo.put("SUBJECT","사전점검예약");
					smsInfo.put("MSG","["+commandMap.get("reqPjtNm")+"] 사전점검 예약이 취소되었습니다.");

					//SMS 발송
					reservationService.sendSms(smsInfo);
				}
				mv.setViewName("redirect:" + rpath + "/mypage/visit-reservation-01");
			} else {
				session.setAttribute("SITE_ALERT", "접수된 신청건이 없습니다.");
				mv.setViewName("redirect:" + rpath + "/mypage/visit-reservation-01");
			}

		}else{
			if (reservationService.saveRicheBfchkReserve(commandMap.getMap())>0) {
				session.setAttribute("join_result",  commandMap.getMap());
				session.setAttribute("SITE_ALERT", "신청을 완료 했습니다.");

				//SMS 발송정보
				Map<String, Object> smsInfo = reservationService.retrieveRicheBfchkReserveSmsInfo(commandMap.getMap());

				//SMS 발송
				if(!CommonUtils.isEmpty(smsInfo.get("TO_PHONE_NO")) && !CommonUtils.isEmpty(smsInfo.get("FROM_PHONE_NO"))){
					Map<String,Object> prjInfo = reservationService.retrieveRicheBfchkReserveInfo(commandMap.getMap());
					smsInfo.put("SUBJECT","사전점검예약");
					smsInfo.put("MSG","["+commandMap.get("reqPjtNm")+"] " + prjInfo.get("VIEW_MSG").toString().replace("예약","사전점검 예약"));
					//SMS 발송
					reservationService.sendSms(smsInfo);
				}

				mv.setViewName("redirect:" + rpath + "/mypage/visit-reservation-01");
			} else {
				session.setAttribute("SITE_ALERT", "해당 예약일시의 예약이 만료되었습니다.");
				mv.setViewName("redirect:" + rpath + "/mypage/visit-reservation-01");
			}

		}

		return mv;
	}
	
	
	/** 
	 * @return ModelAndView
	 */
	/*
	@RequestMapping(value = { "/mypage/movein-lookup-01", mb_mp + "/mypage/movein-lookup-01" })
	public ModelAndView mypage_movein_lookup_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-lookup-01");
		return mv;
	}

	@RequestMapping(value = { "/mypage/movein-lookup-02", mb_mp + "/mypage/movein-lookup-02" })
	public ModelAndView mypage_movein_lookup_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-lookup-02");
		return mv;
	}


	@RequestMapping(value = { "/mypage/movein-lookup-03", mb_mp + "/mypage/movein-lookup-03" })
	public ModelAndView mypage_movein_lookup_03(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		
		List<Map<String,Object>> list = reservationService.retrieveRicheMiblReserveInfoList(commandMap.getMap());
		mv.addObject("list", list);

		mv.setViewName(viewname + "/mypage/movein-lookup-03");
		return mv;
	}

	@RequestMapping(value = { "/mypage/movein-lookup-04", mb_mp + "/mypage/movein-lookup-04" })
	public ModelAndView mypage_movein_lookup_04(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-lookup-04");
		return mv;
	}

	@RequestMapping(value = { "/mypage/movein-reservation-01", mb_mp + "/mypage/movein-reservation-01" })
	public ModelAndView mypage_movein_reservation_01(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-reservation-01");
		return mv;
	}

	@RequestMapping(value = { "/mypage/movein-reservation-02", mb_mp + "/mypage/movein-reservation-02" })
	public ModelAndView mypage_movein_reservation_02(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-reservation-02");
		return mv;
	}
	*/

	@RequestMapping(value = { "/mypage/movein-reservation-01", mb_mp + "/mypage/movein-reservation-01" })
	public ModelAndView mypage_movein_reservation_n01(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/movein-reservation-n01");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/movein-reservation-n02", mb_mp + "/mypage/movein-reservation-n02" })
	public ModelAndView mypage_movein_reservation_n02(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		Gson gson = new Gson();
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		
		Complex complexVO = new Complex();
		complexVO.setFrontbool(true);
		complexVO.setUse_yn("Y");
		complexVO.setConst_status("Y");
		complexVO.setConst_view_status("Y");
		complexVO.setPjt_cd(commandMap.get("reqPjtCd").toString());
		Complex detail = complexService.selectComplexPjtDetail(complexVO);


		// 입주예약 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_start_date()) && !CommonUtils.isEmpty(detail.getMv_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_start_date());
			Date endDate = format.parse(detail.getMv_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setDiff_date(true);
			}
		}
		// 사전점검 방문 신청 기간
		if (!CommonUtils.isEmpty(detail.getMv_pre_start_date())
				&& !CommonUtils.isEmpty(detail.getMv_pre_end_date())) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(detail.getMv_pre_start_date());
			Date endDate = format.parse(detail.getMv_pre_end_date());
			Date time = new Date();
			String strnow = format.format(time);
			Date nowDate = format.parse(strnow);
			if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
				detail.setReservationDiff_date(true);
			}
		}
		mv.addObject("detail", detail);

		Map<String,Object> map = reservationService.retrieveRicheMiblReserveInfo(commandMap.getMap());
		mv.addObject("map", map);
		mv.addObject("map2", gson.toJson(map));

		if(map != null && !map.isEmpty()){
			Map<String,Object> timeMap = new HashMap<String,Object>();
			timeMap.put("reqPjtCd",commandMap.get("reqPjtCd"));
			timeMap.put("blCd",commandMap.get("reqBlCd"));
			timeMap.put("rmnoCd",commandMap.get("reqRmnoCd"));
			if(CommonUtils.isEmpty(map.get("MIBL_LN_NO"))){
				timeMap.put("miblLnNo","");
			}else{
				timeMap.put("miblLnNo",map.get("MIBL_LN_NO"));
			}
			if(CommonUtils.isEmpty(map.get("MIBL_STR_DT"))){
				timeMap.put("miblStrDt","");
			}else{
				timeMap.put("miblStrDt",map.get("MIBL_STR_DT"));
			}
			if(CommonUtils.isEmpty(map.get("MIBL_END_DT"))){
				timeMap.put("miblEndDt","");
			}else{
				timeMap.put("miblEndDt",map.get("MIBL_END_DT"));
			}
			
			List<Map<String,Object>> time = reservationService.retrieveRicheMiblReserveDay(timeMap);
			for(Map<String,Object> item : time){
				timeMap.put("miblResDt",item.get("YYMMDD"));
				List<Map<String,Object>> hhmm = reservationService.retrieveRicheMiblReserveDayDtl(timeMap);
				item.put("hhmm",hhmm);
			}
			//log.info("time::::{}",time);
			mv.addObject("time", time);

			mv.addObject("time2", gson.toJson(time));

		}


		mv.setViewName(viewname + "/mypage/movein-reservation-n02");
		return mv;
	}


	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/movein-reservation-n03", mb_mp + "/mypage/movein-reservation-n03" })
	public ModelAndView mypage_movein_reservation_n03(CommandMap commandMap, HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		
		HttpSession session = request.getSession();
		if(CommonUtils.isEmpty(commandMap.get("reqResTmSeq"))){
			commandMap.put("reqResTmSeq", "");
		}
		if(CommonUtils.isEmpty(commandMap.get("miblResDt"))){
			commandMap.put("miblResDt", "");
		}
		if(CommonUtils.isEmpty(commandMap.get("reqMiblLadderUseYn"))){
			commandMap.put("reqMiblLadderUseYn", "N");
		}
		if(CommonUtils.isEmpty(commandMap.get("reqMiblElvrUseYn"))){
			commandMap.put("reqMiblElvrUseYn", "N");
		}
		if(commandMap.get("type").equals("delete")){
			if (reservationService.cancelRicheMiblReserve(commandMap.getMap())>0) {
				session.setAttribute("join_result",  commandMap.getMap());
				session.setAttribute("SITE_ALERT", "신청 취소를 완료 했습니다.");

				//SMS 발송정보
				Map<String, Object> smsInfo = reservationService.retrieveRicheMiblReserveSmsInfo(commandMap.getMap());

				if(!CommonUtils.isEmpty(smsInfo.get("TO_PHONE_NO")) && !CommonUtils.isEmpty(smsInfo.get("FROM_PHONE_NO"))){
					smsInfo.put("SUBJECT","입주예약");
					smsInfo.put("MSG","["+commandMap.get("reqPjtNm")+"] 입주 예약이 취소되었습니다.");

					//SMS 발송
					reservationService.sendSms(smsInfo);
				}

				mv.setViewName("redirect:" + rpath + "/mypage/movein-reservation-01");
			} else {
				session.setAttribute("SITE_ALERT", "접수된 신청건이 없습니다.");
				mv.setViewName("redirect:" + rpath + "/mypage/movein-reservation-01");
			}

		}else{
			if (reservationService.saveRicheMiblReserve(commandMap.getMap())>0) {
				session.setAttribute("SITE_ALERT", "신청을 완료 했습니다.");

				//SMS 발송정보
				Map<String, Object> smsInfo = reservationService.retrieveRicheMiblReserveSmsInfo(commandMap.getMap());

				//SMS 발송
				if(!CommonUtils.isEmpty(smsInfo.get("TO_PHONE_NO")) && !CommonUtils.isEmpty(smsInfo.get("FROM_PHONE_NO"))){
					Map<String,Object> prjInfo = reservationService.retrieveRicheMiblReserveInfo(commandMap.getMap());
					smsInfo.put("SUBJECT","입주예약");
					smsInfo.put("MSG","["+commandMap.get("reqPjtNm")+"] " + prjInfo.get("VIEW_MSG").toString().replace("신청","입주예약 신청"));
					//SMS 발송
					reservationService.sendSms(smsInfo);
				}

				mv.setViewName("redirect:" + rpath + "/mypage/movein-reservation-01");
			} else {
				String referer = (String) request.getHeader("REFERER");
				session.setAttribute("SITE_ALERT", "해당 예약일시의 예약이 만료되었습니다.");
				mv.setViewName("redirect:" + rpath + "/mypage/movein-reservation-01");
				
			}
		}
		return mv;
	}
	
	/** 
	 * @return ModelAndView
	 */
	/* 	
	@RequestMapping(value = { "/mypage/mycomplex-nodata", mb_mp + "/mypage/mycomplex-nodata" })
	public ModelAndView mypage_mycomplex_nodata(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/mycomplex-nodata");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		return mv;
	} 
	*/

	@RequestMapping(value = { "/mypage/mycomplex", mb_mp + "/mypage/mycomplex" })
	public ModelAndView mypage_mycomplex(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		mv.addObject("rpath", rpath);

		HttpSession session = request.getSession();
		Member detail = (Member) session.getAttribute("memberSession");
		
		if (!CommonUtils.isEmpty(detail)) {
			commandMap.put("user_id",detail.getUser_id());
			List<Map<String,Object>> projectMap = projectService.selectMyElifProjectInfoList(commandMap.getMap());
			for(Map<String,Object> item : projectMap){
				// 입주예약 방문 신청 기간
				if (!CommonUtils.isEmpty(item.get("MV_START_DATE")) && !CommonUtils.isEmpty(item.get("MV_END_DATE"))) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = format.parse(item.get("MV_START_DATE").toString());
					Date endDate = format.parse(item.get("MV_END_DATE").toString());
					Date time = new Date();
					String strnow = format.format(time);
					Date nowDate = format.parse(strnow);
					if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
						item.put("DIFF_DATE",true);
					}
				}
				// 사전점검 방문 신청 기간
				if (!CommonUtils.isEmpty(item.get("MV_PRE_START_DATE")) && !CommonUtils.isEmpty(item.get("MV_PRE_END_DATE"))) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = format.parse(item.get("MV_PRE_START_DATE").toString());
					Date endDate = format.parse(item.get("MV_PRE_END_DATE").toString());
					Date time = new Date();
					String strnow = format.format(time);
					Date nowDate = format.parse(strnow);
					if (nowDate.compareTo(startDate) >= 0 && nowDate.compareTo(endDate) <= 0) {
						item.put("RESERVATIONDIFF_DATE",true);
					}
				}
			}
			mv.addObject("list", projectMap);
		}
		
		mv.setViewName(viewname + "/mypage/mycomplex");
		return mv;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/pjtComplexAjax" }, method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> project_complex_ajax(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String,Object> retMap = new HashMap<String,Object>();
		if(commandMap.get("type").toString().equals("project")){
			List<Map<String,Object>> projectMap = projectService.selectMyElifProject(commandMap.getMap());
			retMap.put("list", projectMap);
		}else if(commandMap.get("type").toString().equals("dong")){
			List<Map<String,Object>> projectMap = projectService.selectMyElifProjectDong(commandMap.getMap());
			retMap.put("list", projectMap);
		}else if(commandMap.get("type").toString().equals("hosu")){
			List<Map<String,Object>> projectMap = projectService.selectMyElifProjectHosu(commandMap.getMap());
			retMap.put("list", projectMap);
		}
		return retMap;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/pjtComplexSubmitAjax" }, method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> project_complexsubmit_ajax(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String,Object> retMap = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Member detail = (Member) session.getAttribute("memberSession");
		
		if (!CommonUtils.isEmpty(detail)) {
			commandMap.put("yymmdd", detail.getYymmdd());
			commandMap.put("user_nm", detail.getUser_nm());
			commandMap.put("user_id", detail.getUser_id());
			if(projectService.selectMyElifProjectInfoCount(commandMap.getMap())==0){
				if(projectService.selectMyElifProjectCount(commandMap.getMap())>0){
					int insInfo = projectService.insertMyElifProjectInfo(commandMap.getMap());
					log.info("insInfo{}",insInfo);
					retMap.put("result", "ok");
				}else{
					retMap.put("result", "not_match");
					retMap.put("resultMsg", "일치하는 분양계약이 없습니다.");
				}
			}else{
				retMap.put("result", "not_dup");
				retMap.put("resultMsg", "이미 추가한 단지 입니다.");
				
			}
		}else{
			retMap.put("result", "not_login");
			retMap.put("resultMsg", "로그인후 이용해 주세요.");

		}
		return retMap;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/notice", mb_mp + "/mypage/notice" })
	public ModelAndView mypage_notice(Board boardVO, CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/notice");
		String pjtCdInfo = "";
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }
		if (request.getRequestURI().indexOf(mb_check) < 0) {
			HttpSession session = request.getSession();
			if(!CommonUtils.isEmpty(	session.getAttribute("memberSession"))) {
			Member detail = (Member) session.getAttribute("memberSession");
			
				commandMap.put("user_id",detail.getUser_id());
				List<Map<String,Object>> list = projectService.selectMyElifProjectInfoList(commandMap.getMap());
				
				for(int i=0, size=list.size(); i<size; i++){
					if(!CommonUtils.isEmpty(list.get(i).get("PJT_CD"))) {
						pjtCdInfo = list.get(i).get("PJT_CD").toString();
					}
				}
			}
			
			
			
			boardVO.setPid(6);
			boardVO.setStatus("Y"); 
			boardVO.setOrderby("mainstatus desc, idx desc");
			PaginationInfo paginationInfo = null;
			
			if(!CommonUtils.isEmpty(pjtCdInfo)) {
				boardVO.setPjt_cd(pjtCdInfo);
				boardVO.setReq_type("U"); // 관리자화면과 사용자 화면 구분
			}else{
				boardVO.setPjt_cd("");
				boardVO.setReq_type(""); // 관리자화면과 사용자 화면 구분
			}
			paginationInfo = new PaginationInfo(); 
			paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
			paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
			paginationInfo.setPageSize(boardVO.getPageSize());
			int start = paginationInfo.getFirstRecordIndex();
			int end = paginationInfo.getRecordCountPerPage();

			int total = boardService.selectBoardCount(boardVO);
			if (paginationInfo != null) {
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
			if (boardVO.getPjt_cd() != null) {
				mv.addObject("pjt_cd", boardVO.getPjt_cd());
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
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	// 모바일 에서만 사용
	@RequestMapping(value = {"/mypage/notice_list", mb_mp + "/mypage/notice_list"})
	public ModelAndView mobile_mypage_notice_list(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mobile/mypage/notice_list");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:/member/login?returl=" + URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(6);
		boardVO.setStatus("Y");
		boardVO.setOrderby("mainstatus desc, idx desc");
		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
		paginationInfo.setPageSize(boardVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = boardService.selectBoardCount(boardVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		boardVO.setStart(start);
		boardVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Board> list = boardService.selectBoardList(boardVO);

		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (CommonUtils.isEmpty(boardVO.getCurrentPageNo())) {
			boardVO.setCurrentPageNo(1);
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
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/notice-view", mb_mp + "/mypage/notice-view" })
	public ModelAndView mypage_notice_view(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/notice-view");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(6);
		boardVO.setStatus("Y");

		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map", detail);
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boardVO.setPrevNextDate(sdFormat.format(detail.getStart_dtm()).toString());

		BoardFile boardFileVO = new BoardFile();
		boardFileVO.setBoard_idx(detail.getIdx());
		boardFileVO.setFile_gubun("file");

		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
		mv.addObject("files", fileList);

		Board prevVO = boardService.selectBoardDetailPrev(boardVO);
		mv.addObject("prevMap", prevVO);

		Board nextVO = boardService.selectBoardDetailNext(boardVO);
		mv.addObject("nextMap", nextVO);

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
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/payment-guide", mb_mp + "/mypage/payment-guide" })
	public ModelAndView mypage_payment_guide(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		ComplexGuide complexGuideVO = new ComplexGuide();
		//취득세
		complexGuideVO.setType("payment");
		complexGuideVO.setRownum(1);
		complexGuideVO.setOrderby("IDX DESC");
        List<ComplexGuide> paymentList = complexService.selectComplexGuideList(complexGuideVO);
		ComplexGuide payment = paymentList.get(0);
		log.info("PAYMENT:::{}",payment);
		complexGuideVO.setType("tag");
		complexGuideVO.setRownum(1);
		complexGuideVO.setOrderby("IDX DESC");
        List<ComplexGuide> tagList = complexService.selectComplexGuideList(complexGuideVO);
		ComplexGuide tag = tagList.get(0);
		mv.addObject("payment", payment);
		mv.addObject("tag", tag);
		mv.setViewName(viewname + "/mypage/payment-guide");
		return mv;
	}
	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/project/list"})
	@ResponseBody
	public Map<String, Object> project_list(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		List<Map<String,Object>> projectMap = projectService.selectMyElifProject(commandMap.getMap());
		if (projectMap.size() > 0) {
			map.put("result", true);
			map.put("list", projectMap);
		}
		return map;
	}

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/payment-lookup", mb_mp + "/mypage/payment-lookup" })
	public ModelAndView mypage_payment_lookup(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/payment-lookup");

		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		return mv;
	}
	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/payment-lookup-01", mb_mp + "/mypage/payment-lookup-01" })
	public ModelAndView mypage_payment_lookup_01(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/payment-lookup-01");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		return mv;
	}
	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/presale"})
	@ResponseBody
	public Map<String, Object> mypage_presale(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", false);
		if(CommonUtils.isEmpty(commandMap.get("user_id"))){
			HttpSession session = request.getSession();
			Member detail = (Member) session.getAttribute("memberSession");
			commandMap.put("user_id", detail.getUser_id());
		}
		List<Map<String,Object>> resultMap = projectService.selectMyElifPresale(commandMap.getMap());
		if (resultMap.size() > 0) {
			map.put("result", true);
			map.put("list", resultMap);
		}
		return map;
	}
	
	/** 
	 * @param commandMap
	 * @return String
	 * @throws IOException
	 * @throws KeyManagementException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping(value="/krcon/api")
	@ResponseBody
    public String callapihttp(CommandMap commandMap) throws IOException, KeyManagementException, NoSuchAlgorithmException{
		String returnStr = "";
		String url = commandMap.get("url").toString();
		commandMap.remove("url");
		String query = CommonUtils.urlEncodeUTF8(commandMap.getMap());
		url = url + "?" + query;
		log.info("URL::::{}",url);
		TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
			public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				return null;
			}
		
			public void checkClientTrusted(X509Certificate[] certs, String authType) {
			}
		
			public void checkServerTrusted(X509Certificate[] certs, String authType) {
			}
		} };
		// Install the all-trusting trust manager
		SSLContext sc = SSLContext.getInstance("SSL");
		sc.init(null, trustAllCerts, new java.security.SecureRandom());
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
		// Create all-trusting host name verifier
		HostnameVerifier allHostsValid = new HostnameVerifier() {
			public boolean verify(String hostname, SSLSession session) {
				return true;
			}
		};
		
		// Install the all-trusting host verifier
		HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
		
		Document doc = Jsoup.connect(url).get();
		log.info(doc.toString());
		returnStr = doc.toString();
		if(returnStr.length()>3){
			returnStr = returnStr.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			returnStr = StringUtils.stripStart(returnStr, null);
		}
        return returnStr;
    }

	
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/payment-lookup-02", mb_mp + "/mypage/payment-lookup-02" })
	public ModelAndView mypage_payment_lookup_02(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/payment-lookup-02");
		if (!CommonUtils.logincheck(request, "memberSession")) {
			mv.setViewName("redirect:" + rpath + "/member/login?returl="
					+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
			return mv;
		}
		return mv;
	}


	/**
	 * ! Start Step
	 */
	// @RequestMapping(value = {"/{step1}"}, method = RequestMethod.GET)
	// public String page_01(HttpServletRequest req, @PathVariable String step1) {
	// log.info("STEP1:::::::{}",step1);
	// return "/web/"+step1;
	// }
	// @RequestMapping(value = {"/{step1}/{step2}"}, method = RequestMethod.GET)
	// public String page_02(HttpServletRequest req, @PathVariable String step1,
	// @PathVariable String step2) {
	// log.info("STEP2:::::::{},{}",step1,step2);
	// return "/web/"+step1+"/"+step2;
	// }
	// @RequestMapping(value = {"/{step1}/{step2}/{step3}"}, method =
	// RequestMethod.GET)
	// public String page_03(HttpServletRequest req, @PathVariable String step1,
	// @PathVariable String step2, @PathVariable String step3) {
	// log.info("STEP3:::::::{},{},{}",step1,step2,step3);
	// return "/web/"+step1+"/"+step2+"/"+step3;
	// }
	/**
	 * ! END Step
	 */

	@RequestMapping(value = { "/support/download", mb_mp + "/support/download" })
	public void data_list(BoardDownload boardDownloadVO, HttpServletResponse response, HttpServletRequest request,
			HttpSession httpsession) throws Exception {

		Board boardVO = new Board();
		int pid = boardService.selectBoardCategorySlug("data");
		boardVO.setIdx(boardDownloadVO.getIdx());
		boardVO.setPid(pid);
		boardVO.setLang("KO");
		boardVO.setStatus("Y");
		Board detail = boardService.selectBoardDetail(boardVO);
		log.info(detail.getRecom());
		if (detail.getRecom().equals("Y")) {
			if (CommonUtils.isEmpty(boardDownloadVO.getEmail()) || CommonUtils.isEmpty(boardDownloadVO.getCompany())) {
				httpsession.setAttribute("SITE_ALERT", "회사명과 이메일을 입력해주세요.");
				log.info("{}", httpsession.getAttribute("SITE_ALERT"));
			} else {
				boardDownloadVO.setBoard_idx(boardDownloadVO.getIdx());
				boardService.insertDownload(boardDownloadVO);
			}
		}

		String uploadPath = "";
		if (request.getServerName().indexOf("krcon-elif") > -1) {
			uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
		} else if (request.getServerName().indexOf("52.79.178.53") > -1) {
			uploadPath = "/data/app/elif";
		} else if (request.getServerName().indexOf("testelif.krcon.co.kr") > -1) {
			uploadPath = "/efs/web";
		}

		BoardFile boardFileVO = new BoardFile();
		boardFileVO.setBoard_idx(detail.getIdx());
		boardFileVO.setFile_gubun("file");
		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
		log.info("FILE:::{}", fileList.size());
		log.info("FILE:::{}", fileList.get(0));
		// -- 4. 다운로드 :: 파일이 1개 이상이면 압축하여 다운로드, 아니면 그 파일만 다운로드
		if (fileList.size() > 1) {
			String zipFile = "/tmp/result.zip";
			String downloadFileName = "result";
			FileOutputStream fout = new FileOutputStream(zipFile);
			ZipOutputStream zout = new ZipOutputStream(fout);

			for (BoardFile file : fileList) {
				String storedFileName = file.getStored_file_name();
				String originalFileName = file.getOriginal_file_name();
				String uploadFolder = file.getPath_name();

				String fileFolder = httpsession.getServletContext().getRealPath(uploadFolder) + boardSlash;
				File f = new File(uploadPath);
				if (f.exists() && f.isDirectory()) {
					fileFolder = uploadPath + uploadFolder + boardSlash;
				}

				ZipEntry zipEntry = new ZipEntry(originalFileName);
				zout.putNextEntry(zipEntry);

				FileInputStream fin = new FileInputStream(new File(fileFolder + storedFileName));
				byte[] buffer = new byte[1024];
				int length;

				// input file을 1024바이트로 읽음, zip stream에 읽은 바이트를 씀
				while ((length = fin.read(buffer)) > 0) {
					zout.write(buffer, 0, length);
				}

				zout.closeEntry();
				fin.close();
			}
			zout.close();

			// 파일이 여러개라도 하나의 파일밖에 전달이 안됨. 압축을 하여 보내는 방법을 강구해야 함
			response.setContentType("application/zip");
			response.addHeader("Content-Disposition", "attachment; filename=" + downloadFileName + ".zip");

			byte fileByte[] = FileUtils.readFileToByteArray(new File(zipFile));

			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();

		} else if (fileList.size() == 1) {
			BoardFile file = fileList.get(0);

			String storedFileName = file.getStored_file_name();
			String originalFileName = file.getOriginal_file_name();
			String uploadFolder = file.getPath_name();

			String fileFolder = httpsession.getServletContext().getRealPath(uploadFolder) + boardSlash;
			File f = new File(uploadPath);
			if (f.exists() && f.isDirectory()) {
				fileFolder = uploadPath + uploadFolder + boardSlash;
			}
			byte fileByte[] = FileUtils.readFileToByteArray(new File(fileFolder + storedFileName));

			// 파일이 여러개라도 하나의 파일밖에 전달이 안됨. 압축을 하여 보내는 방법을 강구해야 함
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);

			String header = request.getHeader("User-Agent");
			String encodedFilename = originalFileName;
			if (header.indexOf("MSIE") > -1) {
				encodedFilename = URLEncoder.encode(originalFileName, "UTF-8").replaceAll("\\+", "%20");
			} else if (header.indexOf("Trident") > -1) {
				encodedFilename = URLEncoder.encode(originalFileName, "UTF-8").replaceAll("\\+", "%20");
			} else if (header.indexOf("Chrome") > -1) {
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < originalFileName.length(); i++) {

					char c = originalFileName.charAt(i);
					if (c > '~') {
						sb.append(URLEncoder.encode("" + c, "UTF-8"));
					} else {
						sb.append(c);
					}
				}
				encodedFilename = sb.toString();
			} else if (header.indexOf("Opera") > -1) {
				encodedFilename = "\"" + new String(originalFileName.getBytes("UTF-8"), "8859_1") + "\"";
			} else if (header.indexOf("Safari") > -1) {
				encodedFilename = "\"" + new String(originalFileName.getBytes("UTF-8"), "8859_1") + "\"";
				encodedFilename = URLDecoder.decode(encodedFilename);
			} else {
				encodedFilename = "\"" + new String(originalFileName.getBytes("UTF-8"), "8859_1") + "\"";
				encodedFilename = URLDecoder.decode(encodedFilename);
			}
			response.setHeader("Content-Disposition", "attachment; filename=" + encodedFilename + ";");

			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);

			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}


	
	/** 
	 * @param commandMap
	 * @param request
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = { "/reservationAjax" }, method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Map<String,Object> reservationAjax(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String,Object> retMap = new HashMap<String,Object>();
		if(commandMap.get("reservation").toString().equals("bfchk")){
			if(commandMap.get("type").toString().equals("project")){
				Complex complexVO = new Complex();
				complexVO.setFrontbool(true);
				complexVO.setUse_yn("Y");
				complexVO.setProgress_array("RV02206,RV02207".split(","));
				complexVO.setFrontcol(commandMap.get("reservation").toString());
				List<Complex> list = complexService.selectComplexPjtList(complexVO);
				
				List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
				for (Complex item : list) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("pjt_cd",item.getPjt_cd());
					map.put("pjt_nm",item.getPjt_nm());
					listMap.add(map);
				}
				retMap.put("list", listMap);
			}else if(commandMap.get("type").toString().equals("dong")){
				List<Map<String,Object>> projectMap = reservationService.retrieveBfChkReserveDong(commandMap.getMap());
				retMap.put("list", projectMap);
			}else if(commandMap.get("type").toString().equals("hosu")){
				List<Map<String,Object>> projectMap = reservationService.retrieveeBfChkReserveHo(commandMap.getMap());
				retMap.put("list", projectMap);
			}
		}else if(commandMap.get("reservation").toString().equals("mibl")){
			if(commandMap.get("type").toString().equals("project")){
				Complex complexVO = new Complex();
				complexVO.setFrontbool(true);
				complexVO.setUse_yn("Y");
				complexVO.setProgress_array("RV02206,RV02207".split(","));
				complexVO.setFrontcol(commandMap.get("reservation").toString());
				List<Complex> list = complexService.selectComplexPjtList(complexVO);
				
				List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
				for (Complex item : list) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("pjt_cd",item.getPjt_cd());
					map.put("pjt_nm",item.getPjt_nm());
					listMap.add(map);
				}
				retMap.put("list", listMap);
				
			}else if(commandMap.get("type").toString().equals("dong")){
				List<Map<String,Object>> projectMap = reservationService.retrieveRicheMiblReserveDong(commandMap.getMap());
				retMap.put("list", projectMap);
			}else if(commandMap.get("type").toString().equals("hosu")){
				List<Map<String,Object>> projectMap = reservationService.retrieveRicheMiblReserveHo(commandMap.getMap());
				retMap.put("list", projectMap);
			}
		}
		return retMap;
	}
	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/elifNews", mb_mp + "/mypage/elifNews" })
	public ModelAndView mypage_elifNews(Board boardVO, CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/elifNews");
		String pjtCdInfo = "";
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }
		if (request.getRequestURI().indexOf(mb_check) < 0) {
			HttpSession session = request.getSession();
			if(!CommonUtils.isEmpty(	session.getAttribute("memberSession"))) {
			Member detail = (Member) session.getAttribute("memberSession");
			
				commandMap.put("user_id",detail.getUser_id());
				List<Map<String,Object>> list = projectService.selectMyElifProjectInfoList(commandMap.getMap());
				
				for(int i=0, size=list.size(); i<size; i++){
					if(!CommonUtils.isEmpty(list.get(i).get("PJT_CD"))) {
						pjtCdInfo = list.get(i).get("PJT_CD").toString();
					}
				}
			}
			
			
			
			boardVO.setPid(9);
			boardVO.setStatus("Y"); 
			boardVO.setOrderby("mainstatus desc, idx desc");
			PaginationInfo paginationInfo = null;
			
			if(!CommonUtils.isEmpty(pjtCdInfo)) {
				boardVO.setPjt_cd(pjtCdInfo);
				boardVO.setReq_type("U"); // 관리자화면과 사용자 화면 구분
			}else{
				boardVO.setPjt_cd("");
				boardVO.setReq_type(""); // 관리자화면과 사용자 화면 구분
			}
			paginationInfo = new PaginationInfo(); 
			paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
			paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
			paginationInfo.setPageSize(boardVO.getPageSize());
			int start = paginationInfo.getFirstRecordIndex();
			int end = paginationInfo.getRecordCountPerPage();

			int total = boardService.selectBoardCount(boardVO);
			if (paginationInfo != null) {
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
			if (boardVO.getPjt_cd() != null) {
				mv.addObject("pjt_cd", boardVO.getPjt_cd());
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
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	// 모바일 에서만 사용
	@RequestMapping(value = {"/mypage/elifNews_list", mb_mp + "/mypage/elifNews_list"})
	public ModelAndView mobile_mypage_elifNews_list(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mobile/mypage/elifNews_list");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:/member/login?returl=" + URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(9);
		boardVO.setStatus("Y");
		boardVO.setOrderby("mainstatus desc, idx desc");
		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
		paginationInfo.setPageSize(boardVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = boardService.selectBoardCount(boardVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		boardVO.setStart(start);
		boardVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Board> list = boardService.selectBoardList(boardVO);

		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (CommonUtils.isEmpty(boardVO.getCurrentPageNo())) {
			boardVO.setCurrentPageNo(1);
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
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/elifNews-view", mb_mp + "/mypage/elifNews-view" })
	public ModelAndView mypage_elifNews_view(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/elifNews-view");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(9);
		boardVO.setStatus("Y");

		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map", detail);
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boardVO.setPrevNextDate(sdFormat.format(detail.getStart_dtm()).toString());

		BoardFile boardFileVO = new BoardFile();
		boardFileVO.setBoard_idx(detail.getIdx());
		boardFileVO.setFile_gubun("file");

		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
		mv.addObject("files", fileList);

		Board prevVO = boardService.selectBoardDetailPrev(boardVO);
		mv.addObject("prevMap", prevVO);

		Board nextVO = boardService.selectBoardDetailNext(boardVO);
		mv.addObject("nextMap", nextVO);

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
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/FAQ", mb_mp + "/mypage/FAQ" })
	public ModelAndView mypage_FAQ(Board boardVO, CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/FAQ");
		String pjtCdInfo = "";
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }
		if (request.getRequestURI().indexOf(mb_check) < 0) {
			HttpSession session = request.getSession();
			if(!CommonUtils.isEmpty(	session.getAttribute("memberSession"))) {
			Member detail = (Member) session.getAttribute("memberSession");
			
				commandMap.put("user_id",detail.getUser_id());
				List<Map<String,Object>> list = projectService.selectMyElifProjectInfoList(commandMap.getMap());
				
				for(int i=0, size=list.size(); i<size; i++){
					if(!CommonUtils.isEmpty(list.get(i).get("PJT_CD"))) {
						pjtCdInfo = list.get(i).get("PJT_CD").toString();
					}
				}
			}
			
			
			
			boardVO.setPid(10);
			boardVO.setStatus("Y"); 
			boardVO.setOrderby("mainstatus desc, idx desc");
			PaginationInfo paginationInfo = null;
			
			if(!CommonUtils.isEmpty(pjtCdInfo)) {
				boardVO.setPjt_cd(pjtCdInfo);
				boardVO.setReq_type("U"); // 관리자화면과 사용자 화면 구분
			}else{
				boardVO.setPjt_cd("");
				boardVO.setReq_type(""); // 관리자화면과 사용자 화면 구분
			}
			paginationInfo = new PaginationInfo(); 
			paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
			paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
			paginationInfo.setPageSize(boardVO.getPageSize());
			int start = paginationInfo.getFirstRecordIndex();
			int end = paginationInfo.getRecordCountPerPage();

			int total = boardService.selectBoardCount(boardVO);
			if (paginationInfo != null) {
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
			if (boardVO.getPjt_cd() != null) {
				mv.addObject("pjt_cd", boardVO.getPjt_cd());
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
		}
		return mv;
	}

	
	/** 
	 * @param boardVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	// 모바일 에서만 사용
	@RequestMapping(value = {"/mypage/FAQ_list", mb_mp + "/mypage/FAQ_list"})
	public ModelAndView mobile_mypage_FAQ_list(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mobile/mypage/FAQ_list");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:/member/login?returl=" + URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(10);
		boardVO.setStatus("Y");
		boardVO.setOrderby("mainstatus desc, idx desc");
		PaginationInfo paginationInfo = null;

		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(boardVO.getRecordCountPerPage());
		paginationInfo.setPageSize(boardVO.getPageSize());
		int start = paginationInfo.getFirstRecordIndex();
		int end = paginationInfo.getRecordCountPerPage();

		int total = boardService.selectBoardCount(boardVO);
		if (paginationInfo != null) {
			paginationInfo.setTotalRecordCount(total);
		}
		boardVO.setStart(start);
		boardVO.setEnd(paginationInfo.getLastRecordIndex());

		List<Board> list = boardService.selectBoardList(boardVO);

		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("list", list);

		if (CommonUtils.isEmpty(boardVO.getCurrentPageNo())) {
			boardVO.setCurrentPageNo(1);
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
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage/FAQ-view", mb_mp + "/mypage/FAQ-view" })
	public ModelAndView mypage_FAQ_view(Board boardVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getRequestURI().indexOf(mb_check) > -1) {
			viewname = mb_path;
			rpath = mb_mp;
		} else {
			viewname = web_path;
			rpath = "";
		}
		mv.addObject("rpath", rpath);
		mv.setViewName(viewname + "/mypage/FAQ-view");
		// if (!CommonUtils.logincheck(request, "memberSession")) {
		// 	mv.setViewName("redirect:" + rpath + "/member/login?returl="
		// 			+ URLEncoder.encode(request.getRequestURI(), "UTF-8"));
		// 	return mv;
		// }

		boardVO.setPid(10);
		boardVO.setStatus("Y");
		boardVO.setBoard_type("FAQ");
		Board detail = boardService.selectBoardDetail(boardVO);
		mv.addObject("map", detail);
		//DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//boardVO.setPrevNextDate(sdFormat.format(detail.getStart_dtm()).toString());

		BoardFile boardFileVO = new BoardFile();
		//boardFileVO.setBoard_idx(detail.getIdx());
		boardFileVO.setFile_gubun("file");

		List<BoardFile> fileList = boardService.selectFileList(boardFileVO);
		mv.addObject("files", fileList);

		//Board prevVO = boardService.selectBoardDetailPrev(boardVO);
		//mv.addObject("prevMap", prevVO);

		//Board nextVO = boardService.selectBoardDetailNext(boardVO);
		//mv.addObject("nextMap", nextVO);

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
}
