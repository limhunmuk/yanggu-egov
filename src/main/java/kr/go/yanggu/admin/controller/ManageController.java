package kr.go.yanggu.admin.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import kr.go.yanggu.admin.service.ManageService;
import kr.go.yanggu.util.Pager;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 > 운영관리
 */
@Controller
public class ManageController {

	private static final Logger logger = LoggerFactory.getLogger(ManageController.class);

	private final ManageService manageService;

	public ManageController(ManageService manageService){
		System.out.println("manageService = " + manageService);
		this.manageService = manageService;
	}

	/**
	 * 관리자 > 운영관리 > 운영자 엑셀 리스트
	 * @param model
	 * @param map
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/managerList/excel", method = RequestMethod.POST)
	public String admin_member_excel(Model model, @RequestParam Map<String,Object> map, HttpServletResponse response) {

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		try {
			list = manageService.admin_member_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin manage/manager_excel:",e.getMessage());
		}
		model.addAttribute("list", list);
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		return "/admin/manage/manager_excel";
	}

	/**
	 * 관리자 > 운영관리 > 운영자 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param adminName
	 * @param adminId
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/managerList" , method = RequestMethod.GET)
	public String admin_member_list(Model model,HttpSession session,
									@RequestParam Map<String,Object> map,
									@RequestParam(defaultValue="1") int page,
									@RequestParam(defaultValue="") String adminName,
									@RequestParam(defaultValue="") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		try {
			int totalCount = manageService.admin_member_list_total(map);
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

			list = manageService.admin_member_list(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin manage/manager_list:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("adminName", adminName);
		model.addAttribute("adminId", adminId);

		return "/admin/manage/manager_list";
	}

	/**
	 * 관리자 > 운영관리 > 운영자관리 - 등록화면
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/addManager", method = RequestMethod.GET)
	public String admin_member_addManager(Model model, @RequestParam Map<String,Object> map, HttpSession session) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		Map<String,Object> one = new HashMap<String, Object>();

		if(map.get("seq") != null) {
			try {
				one = manageService.admin_member_one(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin manage/addAccount",e.getMessage());
			}
		}
		model.addAttribute("one", one);
		return "/admin/manage/add_manager";
	}

	/**
	 * 관리자 > 운영관리 > 운영자관리 - 등록
	 * @param map
	 * @param auth
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/manage/insert", method = RequestMethod.POST)
	public ModelAndView admin_member_insert(@RequestParam Map<String,Object> map, @RequestParam(required=false) int[] auth) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			int number=0;
			for(int n:auth) number+=n;
			map.put("auth", number);
			affect = manageService.admin_member_insert(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin manage/insert:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 운영관리 > 운영자관리 - 수정
	 * @param map
	 * @param auth
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/manage/update", method = RequestMethod.POST)
	public ModelAndView admin_member_update(@RequestParam Map<String,Object> map, @RequestParam(required=false) int[] auth) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			int number=0;
			for(int n:auth) number+=n;
			map.put("auth", number);
			affect = manageService.admin_member_update(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin manage/update:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 운영관리 > 메뉴관리 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param adminName
	 * @param adminId
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/menuList" , method = RequestMethod.GET)
	public String admin_menu_list(Model model,HttpSession session,
								  @RequestParam Map<String,Object> map,
								  @RequestParam(defaultValue="1") int page,
								  @RequestParam(defaultValue="") String adminName,
								  @RequestParam(defaultValue="") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		model.addAttribute("adminName", adminName);
		model.addAttribute("adminId", adminId);
		return "/admin/manage/menu_list";
	}

	/**
	 * 관리자 > 운영관리 > 메뉴관리 - 메뉴등록
	 * @param model
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/menuList/save" , method = RequestMethod.POST)
	public ModelAndView admin_menu_save(Model model,HttpSession session, @RequestParam Map<String,Object> map){

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			mv.setViewName("/admin/alert/alert");
		}

		System.out.println("map.get(\"title\").toString() = " + map.get("title").toString());
		System.out.println("map.get(\"keyword\").toString() = " + map.get("keyword").toString());
		System.out.println("map.get(\"type\").toString() = " + map.get("type").toString());
		System.out.println("map.get(\"url\").toString() = " + map.get("url").toString());
		System.out.println("map.get(\"popupYn\").toString() = " + map.get("popupYn").toString());
		System.out.println("map.get(\"stat\").toString() = " + map.get("stat").toString());
		System.out.println("map.get(\"level\").toString() = " + map.get("level").toString());
		map.put("writer", session.getAttribute("loginSeq").toString());
		String seq = map.get("seq").toString();
		String level = map.get("level").toString();
		System.out.println("level = " + level);

		int result = 0;
		try {
			if(!StringUtils.hasText(level) || !StringUtils.hasText(seq)){
				String strSeq = seq.toString();
				System.out.println("seq >>>>>>>>>>>> strSeq = " + strSeq);
				manageService.admin_menu_save(map);
			}


		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		//return affect+"";
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 *  관리자 > 운영관리 > 메뉴관리 - 메뉴초기화
	 * @param model
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/menuList/init" , method = RequestMethod.GET)
	public ModelAndView admin_menu_init(Model model,HttpSession session, @RequestParam Map<String,Object> map){

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			mv.setViewName("/admin/alert/alert");
		}

		List<Map<String, Object>> list = null;
		try {
			list = manageService.admin_menu_list(map);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		//return affect+"";
		mv.addObject("result", list);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 운영관리 > 메뉴관리 - 메뉴삭제
	 * @param model
	 * @param session
	 * @param seq
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/menuList/delete" , method = RequestMethod.POST)
	public ModelAndView admin_menu_delete(Model model,HttpSession session, @RequestParam String seq) {


		System.out.println("seq =================================== " + seq);
		ModelAndView mv = new ModelAndView();

        if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
            model.addAttribute("url", "/admin/login");
            model.addAttribute("msg", "권한이 없습니다.");
            mv.setViewName("/admin/alert/alert");
        }

        int result;
        try {
            result = manageService.admin_menu_delete(Long.parseLong(seq));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        //return affect+"";
        mv.addObject("result", result);
        mv.setViewName("jsonView");
        return mv;
    }

	/**
	 * 관리자 > 운영관리 > 메인배너 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param adminName
	 * @param adminId
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/mainList" , method = RequestMethod.GET)
	public String admin_main_list(Model model,HttpSession session,
									@RequestParam Map<String,Object> map,
									@RequestParam(defaultValue="1") int page,
									@RequestParam(defaultValue="") String adminName,
									@RequestParam(defaultValue="") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		model.addAttribute("list", list);
		model.addAttribute("adminName", adminName);
		model.addAttribute("adminId", adminId);
		return "admin/manage/main_list";
	}

	/**
	 * 관리자 > 운영관리 > 팝업관리 - 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param adminName
	 * @param adminId
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/popupList" , method = RequestMethod.GET)
	public String admin_popup_list(Model model,HttpSession session,
								  @RequestParam Map<String,Object> map,
								  @RequestParam(defaultValue="1") int page,
								  @RequestParam(defaultValue="") String adminName,
								  @RequestParam(defaultValue="") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		model.addAttribute("list", list);
		model.addAttribute("adminName", adminName);
		model.addAttribute("adminId", adminId);
		return "admin/manage/popup_list";
	}

	/**
	 * 관리자 > 운영관리  > 상단 띠배너 > 리스트
	 * @param model
	 * @param session
	 * @param map
	 * @param page
	 * @param adminName
	 * @param adminId
	 * @return
	 */
	@RequestMapping(value = "/admin/manage/bannerList" , method = RequestMethod.GET)
	public String admin_banner_list(Model model,HttpSession session,
								  @RequestParam Map<String,Object> map,
								  @RequestParam(defaultValue="1") int page,
								  @RequestParam(defaultValue="") String adminName,
								  @RequestParam(defaultValue="") String adminId) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		model.addAttribute("list", list);
		model.addAttribute("adminName", adminName);
		model.addAttribute("adminId", adminId);
		return "/admin/manage/banner_list";
	}

}
