package kr.go.yanggu.admin.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.yanggu.admin.service.GalleryService;
import kr.go.yanggu.util.Pager;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GalleryController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMainController.class);

	GalleryService galleryService;

	public GalleryController(GalleryService galleryService){
		this.galleryService = galleryService;
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 갤러리관리)
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/gallery/galleryList", method = {RequestMethod.GET,RequestMethod.POST})
	public String galleryList(Model model,HttpSession session,HttpServletRequest request,
							  @RequestParam(defaultValue="1") int page,
							  @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = galleryService.selectGalleryTotalCount(map);
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
			list = galleryService.selectGalleryList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/galleryList:",e.getMessage());
		}

		model.addAttribute("kind",map.get("kind"));
		model.addAttribute("list",list);
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));
		model.addAttribute("men",map.get("keyword"));
		return "/admin/gallery/gallery_list";
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 갤러리관리) > 등록/수정
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/gallery/galleryWrite", method = RequestMethod.GET)
	public String galleryWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {
		model.addAttribute("writer",session.getAttribute("loginSeq"));
		model.addAttribute("name",session.getAttribute("loginName"));
		Map<String, Object> one = new HashMap<String, Object>();

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		if(map.get("seq") != null) {
			try {
				one = galleryService.selectGalleryOne(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin gallery/gallerywrite:",e.getMessage());
			}
		}
		model.addAttribute("kind",map.get("kind"));
		model.addAttribute("one",one);
		return "/admin/gallery/gallery_write";
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 갤러리관리) > 등록/수정 > 저장
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/gallery/insertGallery", method = RequestMethod.POST)
	public ModelAndView admin_gallery_insert(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = galleryService.insertGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/insertGallery:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 갤러리관리) > 등록/수정 > 수정
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/gallery/updateGallery", method = RequestMethod.POST)
	public ModelAndView admin_gallery_update(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = galleryService.updateGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/updateGallery:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 갤러리관리) > 등록/수정 > 삭제
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/gallery/deleteGallery", method = RequestMethod.POST)
	public String admin_gallery_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			affect = galleryService.deleteGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/deleteGallery:",e.getMessage());
		}

		return affect+"";
	}

}
