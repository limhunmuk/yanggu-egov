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
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SettingController {

	private static final Logger logger = LoggerFactory.getLogger(SettingController.class);

	@Autowired
	SettingService settingService;

	@RequestMapping(value = "/admin/setting/member/excel", method = RequestMethod.POST)
	public String admin_member_excel(Model model, HttpServletRequest request, @RequestParam Map<String, Object> map, HttpServletResponse response) {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		try {
			list = settingService.admin_member_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/member/excel:", e.getMessage());
		}
		model.addAttribute("list", list);
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		return "/admin/setting/manager_excel";
	}

	@RequestMapping(value = "/admin/setting/memberList", method = RequestMethod.GET)
	public String admin_member_list(Model model, HttpSession session,
									@RequestParam Map<String, Object> map,
									@RequestParam(defaultValue = "1") int page,
									@RequestParam(defaultValue = "") String adminName,
									@RequestParam(defaultValue = "") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		return "/admin/setting/member_list";
	}

	@RequestMapping(value = "/admin/setting/member/popupList", method = RequestMethod.GET)
	public String admin_member_popuplist(Model model, HttpSession session, @RequestParam Map<String, Object> map, @RequestParam(defaultValue = "1") int page,
										 @RequestParam(defaultValue = "") String stat, @RequestParam(defaultValue = "") String keyword,
										 @RequestParam(defaultValue = "") String searchName, @RequestParam(defaultValue = "") String startDate, @RequestParam(defaultValue = "") String endDate) {

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
			logger.info("admin setting/member/popuplist:", e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchName", searchName);
		model.addAttribute("stat", stat);
		return "/admin/setting/popup_list";
	}

	@ResponseBody
	@RequestMapping(value = "/admin/setting/aCntUpdate", method = RequestMethod.POST)
	public ModelAndView admin_member_aCntUpdate(Model model, HttpSession session, @RequestParam Map<String, Object> map) {

		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			mv.addObject("result", "-3");
			mv.setViewName("jsonView");
			return mv;
		}

		int affect = 0;

		try {
			affect = settingService.aCntUpdate(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:", e.getMessage());
		}

		// return affect + "";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/admin/setting/getCloseDateList", method = RequestMethod.POST)
	public ModelAndView admin_member_getCloseDateList(Model model, HttpSession session, @RequestParam Map<String, Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return null;
		}

		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		try {
			list = settingService.getCloseDateList();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:", e.getMessage());
		}

		//return list;
		mv.addObject("result", list);
		mv.setViewName("jsonView");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/admin/setting/idleDateInsert", method = RequestMethod.POST)
	public ModelAndView admin_member_idleDateInsert(Model model, HttpSession session, @RequestParam Map<String, Object> paramMap) {

		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			mv.addObject("result", "-3");
			mv.setViewName("jsonView");
			return mv;
		}

		int affect = 0;
		long diff = 0;
		String sDate = paramMap.get("sdate") == null ? "" : String.valueOf(paramMap.get("sdate"));
		String eDate = paramMap.get("edate") == null ? "" : String.valueOf(paramMap.get("edate"));
		String iDate = "";
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> list = new ArrayList<String>();

		try {
			diff = Utils.diffOfDate(sDate, eDate);
			logger.info(" sDate : " + sDate);
			logger.info(" eDate : " + eDate);
			logger.info(" diff : " + diff);
			for (int i = 0; i <= diff; i++) {
				iDate = Utils.dateAdd(sDate, i, "yyyy-MM-dd");
				list.add(iDate);
			}
			map.put("list", list);
			affect = settingService.idleDateInsert(map);
		} catch (Exception e) {
			affect = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:", e.getMessage());
		}

		//return affect + "";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/admin/setting/idleDateDelete", method = RequestMethod.POST)
	public ModelAndView admin_member_idleDateDelete(Model model, HttpSession session, @RequestParam Map<String, Object> paramMap) {

		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			mv.addObject("result", "-3");
			mv.setViewName("jsonView");
			return mv;
		}

		int affect = 0;
		String iDate = paramMap.get("iDate") == null ? "" : String.valueOf(paramMap.get("iDate"));

		try {
			affect = settingService.idleDateDelete(iDate);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin setting/idleDateDelete:", e.getMessage());
		}

		//return affect + "";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/admin/setting/fSettingInsert", method = RequestMethod.POST)
	public ModelAndView admin_member_fSettingInsert(Model model, HttpSession session, @RequestParam Map<String, Object> paramMap) {

		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			mv.addObject("result", "-3");
			mv.setViewName("jsonView");
			return mv;
		}

		Map<String, Object> map = new HashMap<String, Object>();

		String deadline = paramMap.get("deadline") == null ? "20" : String.valueOf(paramMap.get("deadline"));
		map.put("deadline", deadline);
		String month01 = paramMap.get("month01") == null ? "N" : String.valueOf(paramMap.get("month01"));
		map.put("month01", month01);
		String month02 = paramMap.get("month02") == null ? "N" : String.valueOf(paramMap.get("month02"));
		map.put("month02", month02);
		String month03 = paramMap.get("month03") == null ? "N" : String.valueOf(paramMap.get("month03"));
		map.put("month03", month03);
		String month04 = paramMap.get("month04") == null ? "N" : String.valueOf(paramMap.get("month04"));
		map.put("month04", month04);
		String month05 = paramMap.get("month05") == null ? "N" : String.valueOf(paramMap.get("month05"));
		map.put("month05", month05);
		String month06 = paramMap.get("month06") == null ? "N" : String.valueOf(paramMap.get("month06"));
		map.put("month06", month06);
		String month07 = paramMap.get("month07") == null ? "N" : String.valueOf(paramMap.get("month07"));
		map.put("month07", month07);
		String month08 = paramMap.get("month08") == null ? "N" : String.valueOf(paramMap.get("month08"));
		map.put("month08", month08);
		String month09 = paramMap.get("month09") == null ? "N" : String.valueOf(paramMap.get("month09"));
		map.put("month09", month09);
		String month10 = paramMap.get("month10") == null ? "N" : String.valueOf(paramMap.get("month10"));
		map.put("month10", month10);
		String month11 = paramMap.get("month11") == null ? "N" : String.valueOf(paramMap.get("month11"));
		map.put("month11", month11);
		String month12 = paramMap.get("month12") == null ? "N" : String.valueOf(paramMap.get("month12"));
		map.put("month12", month12);

		int affect = 0;

		try {
			affect = settingService.fSettingInsert(map);
		} catch (Exception e) {
			affect = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:", e.getMessage());
		}

		//return affect + "";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}
}