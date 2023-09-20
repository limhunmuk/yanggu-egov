package kr.go.yanggu.admin.controller;


import kr.go.yanggu.admin.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 관리자 > 통계관리
 */
@Controller
public class StatisticsController {
	
	private static final Logger logger = LoggerFactory.getLogger(StatisticsController.class);
	
	@Autowired
	AdminService adminService;

	/**
	 * 아카이브 임시
	 * @param model
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/statistics/category1", method = RequestMethod.GET)
	public String category1(Model model, HttpSession session, @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		model.addAttribute("menuOn", "1");
		return "/admin/statistics/category1";
	}

	/**
	 * 아카이브 임시
	 * @param model
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/statistics/category2", method = RequestMethod.GET)
	public String category2(Model model, HttpSession session, @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		model.addAttribute("menuOn", "2");
		return "/admin/statistics/category2";
	}

	/**
	 * 아카이브 임시
	 * @param model
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/statistics/category3", method = RequestMethod.GET)
	public String category3(Model model, HttpSession session, @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		model.addAttribute("menuOn", "3");
		return "/admin/statistics/category3";
	}
	
}
