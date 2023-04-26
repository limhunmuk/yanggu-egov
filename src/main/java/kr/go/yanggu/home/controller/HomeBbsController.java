package kr.go.yanggu.home.controller;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.yanggu.home.service.HomeBbsService;
import kr.go.yanggu.mail.service.MailServiceImpl;
import kr.go.yanggu.util.Pager;
import kr.go.yanggu.util.Utils;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/bbs")
public class HomeBbsController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeBbsController.class);
	
	@Autowired
	HomeBbsService homeBbsService;
	
	@Autowired
	MailServiceImpl homeMailService;
	
	//공지사항 리스트
	@RequestMapping(value = "/notice_list", method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeList(Model model,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = homeBbsService.selectNoticeTotal(map);
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
	        list = homeBbsService.selectNoticeList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/noticeList:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("searchName",map.get("searchName"));
    	model.addAttribute("keyword",map.get("keyword"));
		return "/home/bbs/notice_list";
	}
	
	//공지사항 상세
	@RequestMapping(value = "/notice_view", method = RequestMethod.GET)
	public String noticeView(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> one = new HashMap<String, Object>();
		try {
			one = homeBbsService.selectNoticeOne(map);
			if(one.get("seq") != null) {
				homeBbsService.updateNoticeReadCnt(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/notice_view:",e.getMessage());
		}
		model.addAttribute("one",one);
		 
		return "/home/bbs/notice_view";
	}
	
	//갤러리 리스트
	@RequestMapping(value = "/gallery_list", method = {RequestMethod.GET,RequestMethod.POST})
	public String galleryList(Model model,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = homeBbsService.selectGalleryTotal(map);
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
	        list = homeBbsService.selectGalleryList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/galleryList:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("searchName",map.get("searchName"));
    	model.addAttribute("keyword",map.get("keyword"));
		return "/home/bbs/gallery_list";
	}
	
	//갤러리 상세
	@RequestMapping(value = "/gallery_view", method = RequestMethod.GET)
	public String galleryView(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> one = new HashMap<String, Object>();
		try {
			one = homeBbsService.selectGalleryOne(map);
			if(one.get("seq") != null) {
				homeBbsService.updateGalleryReadCnt(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/gallery_view:",e.getMessage());
		}
		model.addAttribute("one",one);
		return "/home/bbs/gallery_view";
	}
	
	//1:1문의 작성
	@RequestMapping(value = "/qna_write", method = RequestMethod.GET)
	public String qnaWrite(Model model,@RequestParam Map<String,Object> map) {
		model.addAttribute("number", Utils.generateString1(5));
		return "/home/bbs/qna_write";
	}
	
	@ResponseBody
	@RequestMapping(value = "/qna_insert", method = RequestMethod.POST)
	public String qnaInsert(HttpServletRequest request,Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		try {
			affect = homeBbsService.insertQna(map);
			
			Map<String,String> map2 = new HashMap<String,String>();
			map2.put("insertDate", Utils.getToday());
			map2.put("title", map.get("title").toString());
			map2.put("content", map.get("content").toString());
			try {
				homeMailService.sendMail(map2, "qna_confirm", request);
			} catch (IOException | javax.mail.MessagingException e) {
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/qna_insert:",e.getMessage());
		}
		
		return affect+"";
	}
	
	
	//자주하는 질문 (FAQ) 리스트
	@RequestMapping(value = "/faq_list", method = {RequestMethod.GET,RequestMethod.POST})
	public String faqList(Model model,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = homeBbsService.selectFaqTotal(map);
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
	        list = homeBbsService.selectFaqList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/FaqList:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("searchName",map.get("searchName"));
    	model.addAttribute("keyword",map.get("keyword"));
		return "/home/bbs/faqList";
	}
	
	//자주하는 질문 (FAQ) 상세
	@RequestMapping(value = "/faq_view", method = RequestMethod.GET)
	public String faqView(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> one = new HashMap<String, Object>();
		try {
			one = homeBbsService.selectFaqOne(map);
			if(one.get("seq") != null) {
				homeBbsService.updateFaqReadCnt(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/faq_view:",e.getMessage());
		}
		model.addAttribute("one",one);
		 
		return "/home/bbs/faqView";
	}
}
