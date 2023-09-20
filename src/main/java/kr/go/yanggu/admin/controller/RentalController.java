package kr.go.yanggu.admin.controller;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.go.yanggu.admin.service.ForestService;
import kr.go.yanggu.admin.service.SettingService;
import kr.go.yanggu.admin.service.SiteService;
import kr.go.yanggu.home.service.HomeProgramService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.go.yanggu.admin.service.RentalService;
import kr.go.yanggu.util.Pager;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RentalController {
	private static final Logger logger = LoggerFactory.getLogger(RentalController.class);
	private final HomeProgramService homeProgramService;
	private final ForestService forestService;
	private final SiteService siteService;
	private final RentalService rentalService;
	private final SettingService settingService;

	public RentalController(HomeProgramService homeProgramService, ForestService forestService, SiteService siteService, RentalService rentalService, SettingService settingService) {
		this.homeProgramService = homeProgramService;
		this.forestService = forestService;
		this.siteService = siteService;
		this.rentalService = rentalService;
		this.settingService = settingService;
	}

	/**
	 * 예약·신청 > 신청관리 > 유아숲체험/숲해설 - 엑셀 리스트
	 * @param model
	 * @param request
	 * @param paramMap
	 * @param response
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/forestRentalList/excel", method = RequestMethod.POST)
	public String admin_rentallist_excel(Model model, HttpServletRequest request, @RequestParam Map<String,Object> paramMap, HttpServletResponse response,@RequestParam(required=false) String[] stat) {

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(stat != null) {
			paramMap.put("stat", stat);
		}else {
			paramMap.put("stat", "");
		}
		logger.info("stat : "+stat);
		if (paramMap.get("excelUseDate") != null || paramMap.get("excelUseDate") != "") {
			paramMap.put("useDate", paramMap.get("excelUseDate"));
		}
		try {
			list = forestService.selectForestList(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/rentallist/excel:",e.getMessage());
		}
		model.addAttribute("list", list);
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		return "/admin/forest/forest_list_excel";
	}

	/**
	 * 예약·신청 > 신청관리 > 유아숲체험/숲해설 - 리스트
	 * @param model
	 * @param map
	 * @param session
	 * @param page
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/forestRentalList", method = {RequestMethod.GET,RequestMethod.POST})
	public String forest_rental(Model model, HttpSession session,
								@RequestParam Map<String,Object> map,
								@RequestParam(defaultValue="1") int page,
								@RequestParam(required=false) String[] stat) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		Map<Object, Object> checkDMap = new HashMap<Object, Object>();
		Map<String, Object> openMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		if ((!map.containsKey("useDate") || map.get("useDate") == "") && (!map.containsKey("startDate") || map.get("startDate") == "")) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String curDate = simpleDateFormat.format(new Date());
			map.put("useDate", curDate);
		}

		String statQuery="";
		String statString ="";

		if(stat != null) {
			for(int i=0;i<stat.length;i++) {
				if(i==0) {
					statString=stat[i];
				}else {
					statString+=","+stat[i];
				}
				statQuery+="&stat="+stat[i];
			}
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}
		try {

			int totalCount = forestService.selectForestListTotal(map);

			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;

			Pager pager = new Pager(totalCount, page, rows, blocks);
			map.put("limitStart", limitStart);
			map.put("rows", rows);

			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("statQuery",statQuery);
			model.addAttribute("statString",statString);

			list = forestService.selectForestList(map);

			openMap = homeProgramService.selectForestSetting(map);
			checkDMap = homeProgramService.selectCD();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (openMap != null) {
			model.addAttribute("openDate",openMap.get("startDate"));
			model.addAttribute("closeDate",openMap.get("endDate"));
		}

		model.addAttribute("list", list);
		model.addAttribute("cy", checkDMap.get("year"));
		model.addAttribute("cny", checkDMap.get("nyear"));
		model.addAttribute("cm", checkDMap.get("month"));
		model.addAttribute("cnm", checkDMap.get("nmonth"));
		model.addAttribute("cd", checkDMap.get("day"));
		model.addAttribute("ch", checkDMap.get("hour"));
		model.addAttribute("gubun", map.get("gubun"));
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("oldUseDate", map.get("useDate"));
		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/forest_rental_list";
	}

	/**
	 * 예약·신청 > 신청관리 > 유아숲체험/숲해설 - 등록
	 * @param model
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/forestRentalWrite", method = RequestMethod.GET)
	public String forest_rental_write(Model model,@RequestParam Map<String,Object> map) {

		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = forestService.selectForestOne(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("program forest_reservation3:",e.getMessage());
		}

		model.addAttribute("result", result);
		return "/admin/rental/forest_rental_write";
	}

	/**
	 * 예약·신청 > 신청관리 > 유아숲체험/숲해설 - 상태변경
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/rental/forestStatUpdate", method = RequestMethod.POST)
	public ModelAndView forest_stat_update(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int result = 0;

		try {
			result = forestService.admin_forest_update(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin rental/admin_rental_update:",e.getMessage());
		}

		//return String.valueOf(result);
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 예약·신청 > 신청관리 > 유아숲체험/숲해설 - 예약신청
	 * @param paramMap
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/insertForestExperienceAdmin", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView insertForestExperienceAdmin(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {

		Map<String,Object> resultMap = new HashMap<String,Object>();
		Map<String,Object> checkMap = new HashMap<String,Object>();
		logger.info(" insertForestExperience : "+paramMap);

		ModelAndView mv = new ModelAndView();
		int result=0;

		if (paramMap.get("adminUseDate") != null || paramMap.get("adminUseDate") != "") {
			paramMap.put("useDate", paramMap.get("adminUseDate"));
			paramMap.put("gubun", paramMap.get("insertGubun"));
		}

		try {
			checkMap = homeProgramService.checkDayCloseForest(paramMap);
			int rCnt = Integer.parseInt(paramMap.get("cnt").toString());
			int po_aCnt = Integer.parseInt(checkMap.get("po_aCnt").toString());
			int po_bCnt = Integer.parseInt(checkMap.get("po_bCnt").toString());
			int po_cCnt = 0;
			if (checkMap.containsKey("po_cCnt")) {
				po_cCnt = Integer.parseInt(checkMap.get("po_cCnt").toString());
			}
			String po_closeYn = checkMap.get("po_closeYn").toString();
			String po_ret = checkMap.get("po_ret").toString();
			if("210".equals(po_ret) && po_aCnt>=rCnt && "N".equals(po_closeYn) && "1".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			}else if("210".equals(po_ret) && po_bCnt>=rCnt && "N".equals(po_closeYn) && "2".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			}else if("210".equals(po_ret) && po_cCnt>=rCnt && "N".equals(po_closeYn) && "3".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			}else if("429".equals(po_ret) || "430".equals(po_ret) || "431".equals(po_ret) || "432".equals(po_ret)){
				result = -3;
			}else if("441".equals(po_ret)){
				result = -4;
			}else if("Y".equals(po_closeYn)){
				result = -2;
			}else {
				result = -1;
			}
			resultMap.put("dSeq", paramMap.get("dSeq"));
			logger.info(" insertDragonReserve : "+result);
		}catch(Exception e) {
			e.printStackTrace();
			logger.info("insertDragonReserve:",e.getMessage());
		}
		resultMap.put("result", result);

		//return resultMap;
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 엑셀 리스트
	 * @param model
	 * @param request
	 * @param response
	 * @param map
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/rentalList/excel", method = RequestMethod.POST)
	public String admin_rentallist_excel(Model model, HttpServletRequest request, HttpServletResponse response,
										 @RequestParam Map<String,Object> map,
										 @RequestParam(required=false) String[] stat) {

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(stat != null) {
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}
		logger.info("stat : "+stat);
		try {
			list = rentalService.admin_rental_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/rentallist/excel:",e.getMessage());
		}
		model.addAttribute("list", list);
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		return "/admin/rental/rental_list_excel";
	}

	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/rentalList", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentallist(Model model, HttpSession session,
										  @RequestParam Map<String,Object> map,
										  @RequestParam(defaultValue="1") int page,
										  @RequestParam(required=false) String[] stat) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<>();
		String statQuery="";
		String statString ="";
		if(stat != null) {
			for(int i=0;i<stat.length;i++) {
				if(i==0) {
					statString=stat[i];
				}else {
					statString+=","+stat[i];
				}
				statQuery+="&stat="+stat[i];
			}
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}

		try {

			Map<String, Object> countMap = rentalService.admin_rental_list_total(map);
			int totalCount = Integer.parseInt(countMap.get("tCnt").toString());
			int sCount = Integer.parseInt(countMap.get("sCnt").toString());
			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;

			Pager pager = new Pager(totalCount, page, rows, blocks);
			map.put("limitStart", limitStart);
			map.put("rows", rows);

			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("sumCount", sCount);

			list = rentalService.admin_rental_list(map);

		} catch (SQLException e) {

			e.printStackTrace();
			logger.info("admin site/rental/rentallist:",e.getMessage());
		}

		model.addAttribute("list", list);
		model.addAttribute("search_type", map.get("search_type"));
		model.addAttribute("startDate", map.get("startDate") == null ? LocalDate.now() : map.get("startDate"));
		model.addAttribute("endDate", map.get("endDate") == null ? LocalDate.now().plusDays(1) : map.get("endDate"));
		model.addAttribute("statQuery", statQuery);
		model.addAttribute("statString", statString);
		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/rental_list";
	}


	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 등록화면
	 * @param model
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/rentalWrite", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentalWrite(Model model,HttpSession session,@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}
		Map<Object, Object> checkDMap = new HashMap<>();
		Map<Object, Object> settingMap = new HashMap<>();
		try {
			checkDMap = rentalService.selectCD();
			settingMap = rentalService.selectFacilitySetting();

			logger.info(" checkDMap : "+checkDMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		model.addAttribute("cy", checkDMap.get("year"));
		model.addAttribute("cny", checkDMap.get("nyear"));
		model.addAttribute("cm", checkDMap.get("month"));
		model.addAttribute("cnm", checkDMap.get("nmonth"));
		model.addAttribute("cd", checkDMap.get("day"));
		model.addAttribute("ch", checkDMap.get("hour"));
		model.addAttribute("settingMap", settingMap);

		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/rental_write";
	}

	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 상태변경
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/rental/adminRentalUpdate", method = RequestMethod.POST)
	public ModelAndView admin_rental_update(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = rentalService.admin_rental_update(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin rental/admin_rental_update:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 예약신청- 인원체크
	 * @param map
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/checkDayClose", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView checkDayClose(@RequestParam Map<String,Object> map, HttpServletRequest request) {

		logger.info("admin checkDayClose ");
		ModelAndView mv = new ModelAndView();

		try {
			map = rentalService.checkDayClose(map);
			logger.info("admin checkDayClose : "+map);
			map.put("ret", 0);
		}catch(Exception e) {
			map.put("ret", -2);
			e.printStackTrace();
			logger.info("admin checkDayClose:",e.getMessage());
		}
		//return map;
		mv.setViewName("jsonView");
		mv.addObject("result", map);
		return mv;
	}

	/**
	 * 예약·신청 > 신청관리 > 용늪 출입신청 - 예약신청
	 * @param map
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/insertDragonReserve", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView insertDragonReserve(@RequestParam Map<String,Object> map, HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		Map<String,Object> resultMap = new HashMap<String,Object>();
		logger.info(" insertDragonReserve : "+map);
		int result=0;

		try {
			map.put("mobile", map.get("mobile1").toString() + map.get("mobile2")+ map.get("mobile3"));
			result = rentalService.insertDragonReserve(map);
			resultMap.put("dSeq", map.get("dSeq"));
			logger.info("admin insertDragonReserve result: "+result);
		}catch(Exception e) {
			e.printStackTrace();
			logger.info("admin insertDragonReserve err:",e.getMessage());
		}
		//resultMap.put("result", result);
		//return resultMap;
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}


	/**
	 * 예약·신청 > 신청관리 > 체험프로그램 - 엑셀리스트
	 * @param model
	 * @param request
	 * @param map
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/experienceList/excel", method = RequestMethod.POST)
	public String admin_experiencelist_excel(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map,HttpServletResponse response) {

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		try {
			list = rentalService.admin_experience_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/experiencelist/excel:",e.getMessage());
		}
		model.addAttribute("list", list);
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		return "/admin/rental/experience_list_excel";
	}

	/**
	 * 예약·신청 > 신청관리 > 체험프로그램 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/experienceList", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_experience_rentallist(Model model,HttpSession session,
											  @RequestParam Map<String,Object> map,
											  @RequestParam(defaultValue="1") int page,
											  @RequestParam(required=false) String[] stat) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> productList = new ArrayList<Map<String, Object>>();

		try {

			int totalCount = rentalService.admin_experience_list_total(map);
			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;

			Pager pager = new Pager(totalCount, page, rows, blocks);

			map.put("limitStart", limitStart);
			map.put("rows", rows);

			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);

			list = rentalService.admin_experience_list(map);
			productList = rentalService.admin_experience_product_list(map);

		} catch (SQLException e) {

			e.printStackTrace();
			logger.info("admin rental/experiencelist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("productList", productList);
		model.addAttribute("startDate", map.get("startDate"));
		model.addAttribute("endDate", map.get("endDate"));
		model.addAttribute("seq", map.get("seq"));
		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/experience_list";
	}

	@RequestMapping(value = "/admin/rental/WoodworkingList", method = {RequestMethod.GET,RequestMethod.POST})
	public String WoodworkingList(Model model,HttpSession session,HttpServletRequest request,
								  @RequestParam(defaultValue="1") int page,@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectwoodworkingTotalCount(map);
			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;
			Pager pager = new Pager(totalCount, page, rows, blocks);
			map.put("limitStart", limitStart);
			map.put("rows", rows);
			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);
			list = siteService.selecwoodworkingList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/Woodworkinglist:",e.getMessage());
		}

		model.addAttribute("list",list);
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		return "/admin/site/wood_working_list";
	}

	@RequestMapping(value = "/admin/site/WoodworkingWrite", method = RequestMethod.GET)
	public String WoodworkingWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {
		model.addAttribute("writer",session.getAttribute("loginSeq"));
		Map<String, Object> one = new HashMap<String, Object>();

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		if(map.get("seq") != null) {
			try {
				one = siteService.selectwoodworkingOne(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin site/Woodworkingwrite:",e.getMessage());
			}
		}
		model.addAttribute("one",one);
		return "/admin/site/wood_working_rite";
	}

	@ResponseBody
	@RequestMapping(value = "/admin/site/insertWoodworking", method = RequestMethod.POST)
	public String admin_Woodworking_insert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			affect = siteService.insertwoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/insertWoodworking:",e.getMessage());
		}

		return affect+"";
	}

	@ResponseBody
	@RequestMapping(value = "/admin/site/updateWoodworking", method = RequestMethod.POST)
	public String admin_Woodworking_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}

			affect = siteService.updatewoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/updateWoodworking:",e.getMessage());
		}

		return affect+"";
	}

	@ResponseBody
	@RequestMapping(value = "/admin/site/deleteWoodworking", method = RequestMethod.POST)
	public String admin_Woodworking_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			affect = siteService.deletewoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/deleteWoodworking:",e.getMessage());
		}

		return affect+"";
	}

	/**
	 * 예약·신청 > 신청관리 > 체험프로그램 - SMS 발송
	 * @param model
	 * @param session
	 * @param rphoneArr
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/goSms", method = {RequestMethod.GET,RequestMethod.POST})
	public String goSms(Model model,HttpSession session,@RequestParam(value="rphoneArr", required=false) String[] rphoneArr) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		if (rphoneArr == null || rphoneArr.length==0) {
			model.addAttribute("url", "/admin/rental/rentalList");
			model.addAttribute("msg", "sms를 전송할 신청자를 선택해주십시오.");
			return "/admin/alert/alert";
		}

		String rphone = "";
		String dseq = "";

		for(int i=0;i<rphoneArr.length;i++) {
			String[] arr = rphoneArr[i].split("@");
			if(i==0) {
				rphone = arr[0];
				dseq = arr[1];
			}else {
				rphone += ","+arr[0];
				dseq += ","+arr[1];
			}
		}

		logger.info(" goSms rphone : "+rphone);
		logger.info(" goSms dseq : "+dseq);

		model.addAttribute("rphone", rphone);
		model.addAttribute("dseq", dseq);
		return "admin/rental/go_sms";
	}

	/**
	 * 예약·신청 > 신청관리 > 체험프로그램 - SMS 발송
	 * @param model
	 * @param session
	 * @param msg
	 * @param title
	 * @param rphone
	 * @param dseq
	 * @param smsType
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/sendSms", method = RequestMethod.POST)
	public String sendSms(Model model,HttpSession session,String msg, String title, String rphone,String dseq,String smsType) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		try {
			byte[] euckrStrBuffer = msg.getBytes("euc-kr");

			logger.info(" bytes.length : "+euckrStrBuffer.length);

			if(euckrStrBuffer.length>2000) {
				model.addAttribute("url", "/admin/rental/rentalList");
				model.addAttribute("msg", "문자 길이는 2000 byte를 넘을 수 없습니다.");
				return "/admin/alert/alert";
			}else if(euckrStrBuffer.length<91) {
				smsType = "S";
			}else {
				smsType = "L";
			}

			logger.info(" smsType : "+smsType);
			logger.info(" msg : "+msg);
			logger.info(" rphone : "+rphone);
			logger.info(" title : "+title);
			String url = "https://sslsms.cafe24.com/sms_sender.php";
			String secret_key = "1d55fc68f5adccc8170fff91fa8641d7";
			RestTemplate restTemplate = new RestTemplate();
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
			LinkedMultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
			map.add("user_id", "yanggupark1");
			map.add("secure", secret_key); //시크릿키
			map.add("msg", msg); //SMS내용
			map.add("sphone1", "033"); // 인증된 발신번호
			map.add("sphone2", "488");
			map.add("sphone3", "7000");
			map.add("smsType", smsType);//"L" - 장문
			map.add("rphone", rphone); //수신 휴대번호
			map.add("title", title); //타이틀 ..
			map.add("rdate", ""); //예약일자
			map.add("rtime", ""); //예약시간
			map.add("mode", "1");
			//map.add("testflag", "Y"); //테스트시..
			int result = 0;
			Map<String,Object> smsMap = new HashMap<String,Object>();
			List<Map<String,Object>> smsList = new ArrayList<Map<String,Object>>();
			String[] rp =  rphone.split(",");
			String[] ds =  dseq.split(",");
			for(int d=0;d<ds.length;d++) {
				Map<String,Object> rdMap = new HashMap<String,Object>();
				rdMap.put("phoneNum", rp[d]);
				rdMap.put("dseq", ds[d]);
				rdMap.put("sandPhoneNum", "033-488-7000");
				rdMap.put("smsType", smsType);
				rdMap.put("title", title);
				rdMap.put("msg", msg);
				rdMap.put("experienceName", "용늪 출입신청");
				smsList.add(rdMap);
			}

			HttpEntity<LinkedMultiValueMap<String, String>> request2 = new HttpEntity<LinkedMultiValueMap<String, String>>(map, headers);
			String response2 = restTemplate.postForObject( url, request2, String.class );
			String sandResult="S";
			logger.info(" response2 : "+response2);
			response2 = response2.substring(0, 1);
			if(!"s".equals(response2)) {
				sandResult="F";
			}
			for(int d=0;d<ds.length;d++) {
				smsList.get(d).put("sandSYn", sandResult);
			}

			logger.info(" smsList : "+smsList);
			smsMap.put("list", smsList);
			result = rentalService.insertSmsList(smsMap);


			model.addAttribute("response2", response2);
		} catch (UnsupportedEncodingException | SQLException e) {
			e.printStackTrace();
		}
		return "redirect:/admin/rental/rental_list";
	}

	/**
	 * 예약·신청 > 신청관리 > 체험프로그램 - SMS 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param stat
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/smsList", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_smslist(Model model,HttpSession session,
									   @RequestParam Map<String,Object> map,
									   @RequestParam(defaultValue="1") int page,
									   @RequestParam(required=false) String[] stat) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String statQuery="";
		String statString ="";
		if(stat != null) {
			for(int i=0;i<stat.length;i++) {
				if(i==0) {
					statString=stat[i];
				}else {
					statString+=","+stat[i];
				}
				statQuery+="&stat="+stat[i];
			}
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}

		try {
			Map<String, Object> countMap = rentalService.admin_sms_list_total(map);
			int totalCount = Integer.parseInt(countMap.get("tCnt").toString());
			int sCount = Integer.parseInt(countMap.get("sCnt").toString());
			int fCount = Integer.parseInt(countMap.get("fCnt").toString());
			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;
			Pager pager = new Pager(totalCount, page, rows, blocks);
			map.put("limitStart", limitStart);
			map.put("rows", rows);
			model.addAttribute("sCount", sCount);
			model.addAttribute("fCount", fCount);
			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);
			list = rentalService.admin_sms_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/rental/rentallist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("search_type", map.get("search_type"));
		model.addAttribute("startDate", map.get("startDate"));
		model.addAttribute("endDate", map.get("endDate"));
		model.addAttribute("statQuery", statQuery);
		model.addAttribute("statString", statString);
		return "/admin/rental/sms_list";
	}


	/**
	 * 예약·신청 > 설정 > 유아숲체험/숲해설
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/forestProgram", method = RequestMethod.GET)
	public String program_children(Model model, HttpSession session, @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		model.addAttribute("subMenuNo", map.get("subMenuNo") == null ? 0 : map.get("subMenuNo"));
		return "/admin/rental/forest_program";
	}

	/**
	 * 예약·신청 > 설정 > 용늪신청관리
	 * @param model
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/rentalSetting", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentalSetting(Model model, HttpSession session, @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}
		Map<Object, Object> checkDMap = new HashMap<Object, Object>();
		Map<Object, Object> settingMap = new HashMap<Object, Object>();
		try {
			checkDMap = settingService.selectCD();
			settingMap = settingService.selectFacilitySetting();

			logger.info(" checkDMap : "+checkDMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		model.addAttribute("cy", checkDMap.get("year"));
		model.addAttribute("cny", checkDMap.get("nyear"));
		model.addAttribute("cm", checkDMap.get("month"));
		model.addAttribute("cnm", checkDMap.get("nmonth"));
		model.addAttribute("cd", checkDMap.get("day"));
		model.addAttribute("ch", checkDMap.get("hour"));
		model.addAttribute("settingMap", settingMap);

		return "/admin/rental/rental_setting";
	}

	/**
	 * 예약·신청 > 설정 > 체험프로그램 설정 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/productList", method = RequestMethod.GET)
	public String admin_member_productlist(Model model, HttpSession session,
										   @RequestParam Map<String,Object> map,
										   @RequestParam(defaultValue="1") int page) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			int totalCount = settingService.admin_member_productlist_total(map);
			int rows = 10;
			int blocks = 5;
			int limitStart = (page - 1) * rows;
			Pager pager = new Pager(totalCount, page, rows, blocks);
			map.put("limitStart", limitStart);
			map.put("rows", rows);
			model.addAttribute("page", page);
			model.addAttribute("prevLink", pager.getPrevLink());
			model.addAttribute("pageLinks", pager.getPageLinks());
			model.addAttribute("nextLink", pager.getNextLink());
			model.addAttribute("totalPage", pager.getTotalPage());
			model.addAttribute("totalCount", totalCount);
			list = settingService.admin_member_productlist(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/productlist:",e.getMessage());
		}
		model.addAttribute("list", list);
		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/product_list";
	}

	/**
	 * 예약·신청 > 설정 > 체험프로그램 설정 - 등록
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/rental/productWrite", method = RequestMethod.GET)
	public String admin_member_productWrite(Model model, @RequestParam Map<String,Object> map, HttpSession session) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		Map<String,Object> one = new HashMap<String, Object>();

		if(map.get("seq") != null) {
			try {
				one = settingService.admin_member_productone(map);

				if(one != null) {
					//인원수 설정
					List<Map<String, String>> numberList = new ArrayList<Map<String,String>>();

					String numberStr = String.valueOf(one.get("number"));

					//json 파싱
					JSONArray numberArr = new JSONArray(numberStr);

					if(numberArr.length() > 0) {
						for(int i = 0; i < numberArr.length(); i++) {
							Map<String, String> numberData = new HashMap<String, String>();
							JSONObject jsonObj = numberArr.getJSONObject(i);

							numberData.put("date", jsonObj.getString("date"));
							numberData.put("number", jsonObj.getString("number"));
							numberData.put("type", jsonObj.getString("type"));

							numberList.add(numberData);
						}
					}

					if(numberList.size() > 0) {
						one.put("numberList", numberList);
					}
				}
			} catch (SQLException e) {
//				e.printStackTrace();
				logger.info("admin setting/member/popupWrite:",e.getMessage());
			}
		} else {
			String content = "- 우천시나 기상 재해 시 취소될 수 있습니다.&#10;"
					+ "- 진행하는 프로그램에 따라 체험비가 변동될 수 있습니다.&#10;"
					+ "- 체험비 입금 확인 후 예약 확정 되며, 체험비 환불은 불가합니다.&#10;"
					+ "(개인사정으로 참여 못할 시, 타인에게 양도 가능)";
			one.put("content", content);
		}
		model.addAttribute("one", one);
		model.addAttribute("writer", session.getAttribute("loginSeq"));
		// 23.09.07 lhm 추가
		model.addAttribute("subMenuNo", map.get("subMenuNo"));

		return "/admin/rental/product_write";
	}

	/**
	 * 예약·신청 > 설정 > 체험프로그램 설정 - 등록
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/rental/productInsert", method = RequestMethod.POST)
	public ModelAndView admin_member_productinsert(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			//줄바꿈 변환
			String content = String.valueOf(map.get("content")).replaceAll("\r\n", "&#10;").replaceAll("<", "&gt;");
			map.put("content", content);

			affect = settingService.admin_member_productinsert(map);

			if(affect > 0) {
				if(map.get("attachment") != null && !"".equals(map.get("attachment"))) { //파일 첨부했으면 팝업 자동 등록
					map.put("link", "https://www.yg-eco.kr/program/program_write");
					map.put("kind", "a");
					settingService.admin_member_pupopinsert(map);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/productinsert:",e.getMessage());
		}
		// 23.09.07 lhm 추가
		mv.addObject("subMenuNo", map.get("subMenuNo"));
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 예약·신청 > 설정 > 체험프로그램 설정 - 수정
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/rental/productUpdate", method = RequestMethod.POST)
	public ModelAndView admin_member_productupdate(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			//줄바꿈 변환
			String content = String.valueOf(map.get("content")).replaceAll("\r\n", "&#10;");
			map.put("content", content);

			affect = settingService.admin_member_productupdate(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/productpupdate:",e.getMessage());
		}
		// 23.09.07 lhm 추가
		mv.addObject("subMenuNo", map.get("subMenuNo"));

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}



}