package kr.go.yanggu.admin.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.yanggu.admin.service.SettingService;
import kr.go.yanggu.util.Pager;
import kr.go.yanggu.util.Utils;

@Controller
@RequestMapping(value = "/admin")
public class SettingController {
	
private static final Logger logger = LoggerFactory.getLogger(SettingController.class);
	
	@Autowired
	SettingService settingService;
	
	@RequestMapping(value = "/setting/member/excel", method = RequestMethod.POST)
	public String admin_member_excel(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map,HttpServletResponse response) {
		
    	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
    	
    	try {
			list = settingService.admin_member_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/excel:",e.getMessage());
		}
    	model.addAttribute("list", list);
    	response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8"); 
		return "/admin/setting/accountExcel";
	}
	
	@RequestMapping(value = "/setting/member/accountlist", method = RequestMethod.GET)
	public String admin_member_list(Model model,HttpSession session,@RequestParam Map<String,Object> map,
			@RequestParam(defaultValue="1") int page,@RequestParam(defaultValue="") String adminName,@RequestParam(defaultValue="") String adminId) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			int totalCount = settingService.admin_member_list_total(map);     
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
			list = settingService.admin_member_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/accountlist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("adminName", adminName);	
		model.addAttribute("adminId", adminId);
		return "admin/setting/accountList";
	}
	
	
	@RequestMapping(value = "/setting/member/addAccount", method = RequestMethod.GET)
	public String admin_member_addAccount(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		Map<String,Object> one = new HashMap<String, Object>();
		
		if(map.get("seq") != null) {
			try {
				one = settingService.admin_member_one(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin setting/member/addAccount:",e.getMessage());
			}
		}
		model.addAttribute("one", one);
		return "admin/setting/addAccount";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/insert", method = RequestMethod.POST)
	public String admin_member_insert(Model model,@RequestParam Map<String,Object> map,@RequestParam(required=false) int[] auth) {
		int affect = 0;
		
		try {
			int number=0;
			for(int n:auth) number+=n;
			map.put("auth", number);
			affect = settingService.admin_member_insert(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/insert:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/update", method = RequestMethod.POST)
	public String admin_member_update(Model model,@RequestParam Map<String,Object> map,@RequestParam(required=false) int[] auth) {
		int affect = 0;
		
		try {
			int number=0;
			for(int n:auth) number+=n;
			map.put("auth", number);
			affect = settingService.admin_member_update(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/update:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/setting/member/popuplist", method = RequestMethod.GET)
	public String admin_member_popuplist(Model model,HttpSession session,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="") String stat,@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String searchName,@RequestParam(defaultValue="") String startDate,@RequestParam(defaultValue="") String endDate) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			int totalCount = settingService.admin_member_pupoplist_total(map);     
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
			list = settingService.admin_member_pupoplist(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/popuplist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);	
		model.addAttribute("endDate", endDate);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchName", searchName);
		model.addAttribute("stat", stat);
		return "admin/setting/popupList";
	}
	
	@RequestMapping(value = "/setting/member/popupwrite", method = RequestMethod.GET)
	public String admin_member_popupWrite(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		Map<String,Object> one = new HashMap<String, Object>();
		
		if(map.get("seq") != null) {
			try {
				one = settingService.admin_member_pupopone(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin setting/member/popupWrite:",e.getMessage());
			}
		}
		model.addAttribute("one", one);
		model.addAttribute("writer", session.getAttribute("loginSeq"));
		return "admin/setting/popupWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/popupinsert", method = RequestMethod.POST)
	public String admin_member_popupinsert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = settingService.admin_member_pupopinsert(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/popupinsert:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/popupupdate", method = RequestMethod.POST)
	public String admin_member_popupupdate(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = settingService.admin_member_pupopupdate(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/popupupdate:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/setting/member/productlist", method = RequestMethod.GET)
	public String admin_member_productlist(Model model,HttpSession session,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page) {
		
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
		return "admin/setting/productList";
	}
	
	@RequestMapping(value = "/setting/member/productwrite", method = RequestMethod.GET)
	public String admin_member_productWrite(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
		
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
		return "admin/setting/productWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/productinsert", method = RequestMethod.POST)
	public String admin_member_productinsert(Model model,@RequestParam Map<String,Object> map) {
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
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/setting/member/productupdate", method = RequestMethod.POST)
	public String admin_member_productupdate(Model model,@RequestParam Map<String,Object> map) {
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
		
		return affect+"";
	}

	@ResponseBody
	@RequestMapping(value = "/setting/aCntUpdate", method = RequestMethod.POST)
	public String admin_member_aCntUpdate(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return "-3";
    	}
		
		int affect = 0;
		
		try {
			affect = settingService.aCntUpdate(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/setting/rentalSetting", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentalSetting(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
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
    	
		return "admin/setting/rentalSetting";
	}

	@ResponseBody
	@RequestMapping(value = "/setting/getCloseDateList", method = RequestMethod.POST)
	public List<Map<String,Object>> admin_member_getCloseDateList(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return null;
    	}
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		try {
			list = settingService.getCloseDateList();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/setting/idleDateInsert", method = RequestMethod.POST)
	public String admin_member_idleDateInsert(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return "-3";
    	}
		
		int affect = 0;
		long diff = 0;
    	String sDate = paramMap.get("sdate")==null?"":String.valueOf(paramMap.get("sdate"));
    	String eDate = paramMap.get("edate")==null?"":String.valueOf(paramMap.get("edate"));
    	String iDate = "";
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<String> list= new ArrayList<String>();
    	
    	try {
    		diff = Utils.diffOfDate(sDate, eDate);
    		logger.info(" sDate : "+sDate);
    		logger.info(" eDate : "+eDate);
    		logger.info(" diff : "+diff);
    		for (int i = 0; i <= diff; i++) {
    			iDate = Utils.dateAdd(sDate, i, "yyyy-MM-dd");
    			list.add(iDate);
			}
    		map.put("list", list);
			affect = settingService.idleDateInsert(map);
		} catch (Exception e) {
			affect = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		return affect+"";
	}

	@ResponseBody
	@RequestMapping(value = "/setting/idleDateDelete", method = RequestMethod.POST)
	public String admin_member_idleDateDelete(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return "-3";
    	}
		
		int affect = 0;
    	String iDate = paramMap.get("iDate")==null?"":String.valueOf(paramMap.get("iDate"));
    	
    	try {
			affect = settingService.idleDateDelete(iDate);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin setting/idleDateDelete:",e.getMessage());
		}
		
		return affect+"";
	}

	@ResponseBody
	@RequestMapping(value = "/setting/fSettingInsert", method = RequestMethod.POST)
	public String admin_member_fSettingInsert(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return "-3";
    	}
    	
    	Map<String, Object> map = new HashMap<String, Object>();

    	String deadline = paramMap.get("deadline")==null?"20":String.valueOf(paramMap.get("deadline"));
    	map.put("deadline", deadline);
    	String month01 = paramMap.get("month01")==null?"N":String.valueOf(paramMap.get("month01"));
    	map.put("month01", month01);
    	String month02 = paramMap.get("month02")==null?"N":String.valueOf(paramMap.get("month02"));
    	map.put("month02", month02);
    	String month03 = paramMap.get("month03")==null?"N":String.valueOf(paramMap.get("month03"));
    	map.put("month03", month03);
    	String month04 = paramMap.get("month04")==null?"N":String.valueOf(paramMap.get("month04"));
    	map.put("month04", month04);
    	String month05 = paramMap.get("month05")==null?"N":String.valueOf(paramMap.get("month05"));
    	map.put("month05", month05);
    	String month06 = paramMap.get("month06")==null?"N":String.valueOf(paramMap.get("month06"));
    	map.put("month06", month06);
    	String month07 = paramMap.get("month07")==null?"N":String.valueOf(paramMap.get("month07"));
    	map.put("month07", month07);
    	String month08 = paramMap.get("month08")==null?"N":String.valueOf(paramMap.get("month08"));
    	map.put("month08", month08);
    	String month09 = paramMap.get("month09")==null?"N":String.valueOf(paramMap.get("month09"));
    	map.put("month09", month09);
    	String month10 = paramMap.get("month10")==null?"N":String.valueOf(paramMap.get("month10"));
    	map.put("month10", month10);
    	String month11 = paramMap.get("month11")==null?"N":String.valueOf(paramMap.get("month11"));
    	map.put("month11", month11);
    	String month12 = paramMap.get("month12")==null?"N":String.valueOf(paramMap.get("month12"));
    	map.put("month12", month12);
    	
		int affect = 0;
    	
    	try {
			affect = settingService.fSettingInsert(map);
		} catch (Exception e) {
			affect = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		return affect+"";
	}
}
