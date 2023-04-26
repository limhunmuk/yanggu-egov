package kr.go.yanggu.admin.controller;

import java.io.IOException;
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

@Controller
@RequestMapping(value = "/admin")
public class SiteController {
	private static final Logger logger = LoggerFactory.getLogger(SiteController.class);
	
	@Resource(name="siteService")
	SiteService siteService;
	
	@Autowired
	MailServiceImpl homeMailService;
	
	
	@RequestMapping(value = "/site/noticelist", method = {RequestMethod.GET,RequestMethod.POST})
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
        return "admin/site/noticeList"; 
    }
	
	@RequestMapping(value = "/site/noticewrite", method = RequestMethod.GET)
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
        return "admin/site/noticeWrite";
    }
	
	@ResponseBody
	@RequestMapping(value = "/site/insert", method = RequestMethod.POST)
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
	
	@ResponseBody
	@RequestMapping(value = "/site/update", method = RequestMethod.POST)
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
	
	@ResponseBody
	@RequestMapping(value = "/site/delete", method = RequestMethod.POST)
	public String admin_notice_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = siteService.delete(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/delete:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/site/qnalist", method = {RequestMethod.GET,RequestMethod.POST})
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
        return "admin/site/qnaList";
    }
	
	@RequestMapping(value = "/site/qnaview", method = RequestMethod.GET)
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
        return "admin/site/qnaView";
    }
	
	@RequestMapping(value = "/site/qnamodify", method = RequestMethod.POST)
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
    	return "redirect:/admin/site/qnalist";
    }
	
	@RequestMapping(value = "/site/qnadelete", method = RequestMethod.GET)
    public String qnaDelete(Model model, @RequestParam Map<String,Object> map,
    		@RequestParam(defaultValue="") String order,HttpSession session,HttpServletRequest request) {
	 	try {
	 		siteService.deleteQna(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/qnadelete:",e.getMessage());
		} 
    	 
        return "redirect:/admin/site/qnalist"; 
    }
	
	
	@RequestMapping(value = "/site/ecologylist", method = {RequestMethod.GET,RequestMethod.POST})
    public String ecologyList(Model model,HttpSession session,HttpServletRequest request,
    		@RequestParam(defaultValue="1") int page,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert"; 
    	}
    	
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = siteService.selectEcologyTotalCount(map);
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
	        list = siteService.selecEcologytList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/ecologylist:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("stat",map.get("stat"));
    	model.addAttribute("startDate",map.get("startDate"));
    	model.addAttribute("endDate",map.get("endDate"));
    	model.addAttribute("searchName",map.get("searchName"));
    	model.addAttribute("keyword",map.get("keyword"));
        return "admin/site/ecologyList"; 
    }
	
	@RequestMapping(value = "/site/ecologywrite", method = RequestMethod.GET)
    public String ecologyWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {
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
				one = siteService.selectEcologyOne(map);
			} catch (SQLException e) {
				e.printStackTrace();
				logger.info("admin site/ecologwrite:",e.getMessage());
			}
		}
    	model.addAttribute("one",one);
        return "admin/site/ecologyWrite";
    }
	
	@ResponseBody
	@RequestMapping(value = "/site/insertecology", method = RequestMethod.POST)
	public String admin_ecology_insert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			affect = siteService.insertEcology(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/insertecology:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/updateecology", method = RequestMethod.POST)
	public String admin_ecology_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			
			affect = siteService.updateEcology(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/updateecology:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/deleteecology", method = RequestMethod.POST)
	public String admin_ecology_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = siteService.deleteEcology(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/deleteecology:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/site/woodworkinglist", method = {RequestMethod.GET,RequestMethod.POST})
    public String woodworkingList(Model model,HttpSession session,HttpServletRequest request,
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
			logger.info("admin site/woodworkinglist:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("stat",map.get("stat"));
    	model.addAttribute("startDate",map.get("startDate"));
    	model.addAttribute("endDate",map.get("endDate"));
    	model.addAttribute("searchName",map.get("searchName"));
        return "admin/site/woodworkingList";
    }
	
	@RequestMapping(value = "/site/woodworkingwrite", method = RequestMethod.GET)
    public String woodworkingWrite(Model model, @RequestParam Map<String,Object> map,HttpSession session) {
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
				logger.info("admin site/woodworkingwrite:",e.getMessage());
			}
		}
    	model.addAttribute("one",one);
        return "admin/site/woodworkingWrite";
    }
	
	@ResponseBody
	@RequestMapping(value = "/site/insertwoodworking", method = RequestMethod.POST)
	public String admin_woodworking_insert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			affect = siteService.insertwoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/insertwoodworking:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/updatewoodworking", method = RequestMethod.POST)
	public String admin_woodworking_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			if(map.get("kind") == null || map.get("kind").equals("")) {
				map.put("kind", "N");
			}
			
			affect = siteService.updatewoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/updatewoodworking:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/deletewoodworking", method = RequestMethod.POST)
	public String admin_woodworking_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = siteService.deletewoodworking(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/deletewoodworking:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/site/faqlist", method = {RequestMethod.GET,RequestMethod.POST})
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
        return "admin/site/faqList"; 
    }
	
	@RequestMapping(value = "/site/faqwrite", method = RequestMethod.GET)
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
        return "admin/site/faqWrite";
    }
	
	@ResponseBody
	@RequestMapping(value = "/site/faqinsert", method = RequestMethod.POST)
	public String admin_faq_insert(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = siteService.inserFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqinsert:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/faqupdate", method = RequestMethod.POST)
	public String admin_faq_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			
			affect = siteService.updateFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqupdate:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/site/faqdelete", method = RequestMethod.POST)
	public String admin_faq_delete(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = siteService.deleteFaq(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/faqdelete:",e.getMessage());
		}
		
		return affect+"";
	}
}
