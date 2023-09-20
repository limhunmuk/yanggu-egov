package kr.go.yanggu.admin.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.go.yanggu.admin.service.GalleryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.yanggu.admin.service.SiteService;
import kr.go.yanggu.mail.service.MailServiceImpl;
import kr.go.yanggu.util.Pager;
import kr.go.yanggu.util.Utils;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SiteController {
	private static final Logger logger = LoggerFactory.getLogger(SiteController.class);

	private final SiteService siteService;

	private final MailServiceImpl homeMailService;

	private final GalleryService galleryService;

	public SiteController(SiteService siteService, MailServiceImpl homeMailService, GalleryService galleryService){
		this.siteService = siteService;
		this.homeMailService = homeMailService;
		this.galleryService = galleryService;
	}

	/**
	 * 관리자 > 게시판관리 > 공지사항 - 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/noticeList", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeList(Model model,HttpSession session,HttpServletRequest request,
							 @RequestParam(defaultValue="1") int page,@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectTotalCount(map);
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
			list = siteService.selectList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/noticeList:",e.getMessage());
		}

		model.addAttribute("list",list);

		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));
		return "/admin/site/notice_list";
	}

	/**
	 * 관리자 > 게시판관리 > 공지사항 - 등록
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/site/noticeWrite", method = RequestMethod.GET)
	public String noticeWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {

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
				one = siteService.selectOne(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin site/noticewrite:",e.getMessage());
			}
		}
		model.addAttribute("one",one);
		model.addAttribute("now", LocalDate.now());
		return "/admin/site/notice_write";
	}

	/**
	 * 관리자 > 게시판관리 > 등록
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/insert", method = RequestMethod.POST)
	public String admin_notice_insert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			affect = siteService.insert(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/insert:",e.getMessage());
		}

		return affect+"";
	}

	/**
	 * 관리자 > 게시판관리 > ???????
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/update", method = RequestMethod.POST)
	public String admin_notice_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;

		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}

			affect = siteService.update(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/update:",e.getMessage());
		}

		return affect+"";
	}

	/**
	 * 관리자 > 게시판관리 > 공지사항 > 상세 - 삭제
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/delete", method = RequestMethod.POST)
	public ModelAndView admin_notice_delete(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.delete(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/delete:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/exhibitionList", method = {RequestMethod.GET,RequestMethod.POST})
	public String exhibitionList(Model model,HttpSession session,HttpServletRequest request,
							 	 @RequestParam(defaultValue="1") int page,
								 @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectExhibitionTotalCount(map);
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
			list = siteService.selectExhibitionList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/exhibitionList:",e.getMessage());
		}

		model.addAttribute("list",list);

		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));

		return "/admin/site/exhibition_list";
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 등록/수정
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/exhibitionWrite", method = {RequestMethod.GET,RequestMethod.POST})
	public String exhibitionWrite(Model model,HttpSession session,HttpServletRequest request,
								  @RequestParam(defaultValue="1") int page,
								  @RequestParam Map<String,Object> map) {

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
				one = siteService.selectExhibitionOne(map);
				List<Map<String, Object>> fileList = siteService.selectExhibitionFileList(map);

				model.addAttribute("one",one);
				model.addAttribute("fileList",fileList);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin site/exhibitionWrite:",e.getMessage());
			}
		}

		return "/admin/site/exhibition_write";
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 등록/수정 > 파일 등록
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/exhibitionWrite/addFile", method = RequestMethod.POST)
	public ModelAndView exhibitionWriteAddFile(Model model, @RequestParam Map<String,Object> map, HttpSession session) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			map.put("writer", session.getAttribute("loginSeq"));
			affect = siteService.insertExhibitionFile(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/exhibitionWriteAddFile:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/admin/site/exhibitionWrite/deleteFile", method = RequestMethod.POST)
	public ModelAndView exhibitionWriteDeleteFile(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.deleteExhibitionFile(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/exhibitionWriteAddFile:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 등록/수정 > 저장
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/insertExhibition", method = RequestMethod.POST)
	public ModelAndView insertExhibition(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.insertExhibition(map);
			//map.put("exhibitionSeq", map.get("seq"));
			//affect = siteService.insertExhibitionFile(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/insertExhibition:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 등록/수정 > 수정
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/updateExhibition", method = RequestMethod.POST)
	public ModelAndView Exhibition(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.updateExhibition(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin site/updateExhibition:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > 행사 전시 - 등록/수정 > 삭제
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/deleteExhibition", method = RequestMethod.POST)
	public ModelAndView deleteExhibition(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.deleteExhibition(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/deleteExhibition:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > 수목원 사계절 - 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/galleryList", method = {RequestMethod.GET,RequestMethod.POST})
	public String galleryList(Model model,HttpSession session,
							  HttpServletRequest request,
							  @RequestParam(defaultValue="1") int page,
							  @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		// 23.09.20 lhm 추가 - 수목원 사계절 포토갤러리 출력한다고 상정하고 고정으로 설정
		map.put("kind", "D");
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
			logger.info("admin site/galleryList:",e.getMessage());
		}

		model.addAttribute("kind", "D");
		model.addAttribute("list",list);
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));

		return "/admin/site/gallery_list";
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 포토갤러리) > 등록/수정
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/site/galleryWrite", method = RequestMethod.GET)
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
		model.addAttribute("kind", "D");
		model.addAttribute("one",one);

		return "/admin/site/gallery_write";
	}


	/**
	 * 게시판관리 > 수목원 사계절(기존 - 포토갤러리) > 등록/수정 > 저장
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/insertGallery", method = RequestMethod.POST)
	public ModelAndView admin_gallery_insert(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = galleryService.insertGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/insertGallery:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 포토갤러리) > 등록/수정 > 수정
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/updateGallery", method = RequestMethod.POST)
	public ModelAndView admin_gallery_update(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = galleryService.updateGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/updateGallery:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 게시판관리 > 수목원 사계절(기존 - 포토갤러리) > 등록/수정 > 삭제
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/deleteGallery", method = RequestMethod.POST)
	public ModelAndView admin_gallery_delete(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = galleryService.deleteGallery(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin gallery/deleteGallery:",e.getMessage());
		}

		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}


	/**
	 * 관리자 > 게시판관리 > 1:1 문의내역 - 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/qnaList", method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaList(Model model,HttpSession session,HttpServletRequest request,
						  @RequestParam(defaultValue="1") int page,@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectQnaTotalCount(map);
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
			list = siteService.selectQnaList(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/qnalist:",e.getMessage());
		}

		model.addAttribute("list",list);
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));
		return "/admin/site/qna_list";
	}

	/**
	 * 관리자 > 게시판관리 > 1:1 문의내역 - 상세
	 * @param model
	 * @param map
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/site/qnaView", method = RequestMethod.GET)
	public String qnaView(Model model, @RequestParam Map<String, Object> map,HttpServletRequest request,HttpSession session) {
		model.addAttribute("writer",session.getAttribute("loginSeq"));
		Map<String, Object> one = new HashMap<String, Object>();

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		try {
			one = siteService.selectQnaOne(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/qnaview:",e.getMessage());
		}

		model.addAttribute("one",one);
		return "/admin/site/qna_view";
	}

	/**
	 * 관리자 > 게시판관리 > 1:1 문의내역 - 답변
	 * @param model
	 * @param map
	 * @param order
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/admin/site/qnaModify", method = RequestMethod.POST)
	public String qnaModify(Model model, @RequestParam Map<String,Object> map,
							@RequestParam(defaultValue="") String order,HttpSession session,HttpServletRequest request) {

		try {
			siteService.updateQna(map);

			Map<String,String> map2 = new HashMap<String,String>();
			map2.put("insertDate", Utils.getToday());
			map2.put("title", map.get("title").toString());
			map2.put("content", map.get("content").toString());
			map2.put("content2", map.get("re_content").toString());
			map2.put("email", map.get("email").toString());

			try {
				homeMailService.sendMail(map2, "qna_confirm2", request);
			} catch (IOException | javax.mail.MessagingException e) {
				e.printStackTrace();
			}

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/qnamodify:",e.getMessage());
		}
		return "redirect:/admin/site/qna_list";
	}

	/**
	 * 관리자 > 게시판관리 > 1:1 문의내역 - 삭제
	 * @param model
	 * @param map
	 * @param order
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/admin/site/qnaDelete", method = RequestMethod.GET)
	public String qnaDelete(Model model, @RequestParam Map<String,Object> map,
							@RequestParam(defaultValue="") String order,HttpSession session,HttpServletRequest request) {
		try {
			siteService.deleteQna(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/qnadelete:",e.getMessage());
		}

		return "redirect:/admin/site/qna_list";
	}

	/**
	 * 관리자 > 게시판관리 > FAQ - 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/faqList", method = {RequestMethod.GET,RequestMethod.POST})
	public String faqList(Model model,HttpSession session,HttpServletRequest request,
						  @RequestParam(defaultValue="1") int page,@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectFaqTotalCount(map);
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
			list = siteService.selectFaqList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqlist:",e.getMessage());
		}

		model.addAttribute("list",list);
		model.addAttribute("stat",map.get("stat"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));
		model.addAttribute("searchName",map.get("searchName"));
		model.addAttribute("keyword",map.get("keyword"));
		return "/admin/site/faq_list";
	}

	/**
	 * 관리자 > 게시판관리 > FAQ - 등록/수정
	 * @param model
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/admin/site/faqWrite", method = RequestMethod.GET)
	public String faqWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {
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
				one = siteService.selectFaq(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin site/faqwrite:",e.getMessage());
			}
		}
		model.addAttribute("one",one);
		return "/admin/site/faq_write";
	}

	/**
	 * 관리자 > 게시판관리 > FAQ - 등록
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/faqInsert", method = RequestMethod.POST)
	public ModelAndView admin_faq_insert(Model model, @RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.inserFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqinsert:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}


	/**
	 * 관리자 > 게시판관리 > FAQ - 수정
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/faqUpdate", method = RequestMethod.POST)
	public ModelAndView admin_faq_update(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {

			affect = siteService.updateFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqupdate:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판관리 > FAQ - 삭제
	 * @param model
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/site/faqDelete", method = RequestMethod.POST)
	public ModelAndView admin_faq_delete(Model model,@RequestParam Map<String,Object> map) {

		ModelAndView mv = new ModelAndView();
		int affect = 0;

		try {
			affect = siteService.deleteFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqdelete:",e.getMessage());
		}

		//return affect+"";
		mv.addObject("result", affect+"");
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 관리자 > 게시판 관리 > 게시판 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/articleList", method = {RequestMethod.GET,RequestMethod.POST})
	public String articleList(Model model,HttpSession session,HttpServletRequest request,
							  @RequestParam(defaultValue="1") int page,
							  @RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		return "/admin/site/article_list";
	}

	/**
	 * 관리자 > 게시판 관리 > 게시판 리스트
	 * @param model
	 * @param session
	 * @param request
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/admin/site/articleWrite", method = {RequestMethod.GET,RequestMethod.POST})
	public String articleInsert(Model model,HttpSession session,HttpServletRequest request,
								@RequestParam(defaultValue="1") int page,
								@RequestParam Map<String,Object> map) {

		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			model.addAttribute("url", "/admin/login");
			model.addAttribute("msg", "권한이 없습니다.");
			return "/admin/alert/alert";
		}

		return "/admin/site/article_write";
	}
}
