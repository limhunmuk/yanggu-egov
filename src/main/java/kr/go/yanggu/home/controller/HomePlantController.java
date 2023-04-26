package kr.go.yanggu.home.controller;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.go.yanggu.home.service.HomePlantService;
import kr.go.yanggu.util.Pager;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/plant")
public class HomePlantController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomePlantController.class);
	
	@Autowired
	HomePlantService homePlantService;
	
	//생태관 사진
	@RequestMapping(value = "/animal_gallery", method = RequestMethod.GET)
	public String animalGallery(Model model,@RequestParam Map<String,Object> map) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			map.put("kind", "B");
	        list = homePlantService.selectBotanicalList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/botanicalGallery:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
		return "/home/plant/animal_gallery";
	}
	
	//공지사항 리스트
	@RequestMapping(value = "/animal_record_list", method = {RequestMethod.GET,RequestMethod.POST})
	public String ecologyList(Model model,@RequestParam Map<String,Object> map,@RequestParam(defaultValue="1") int page) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			int totalCount = homePlantService.selectecologyTotal(map);
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
	        list = homePlantService.selectecologyList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user plant/ecologyList:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
    	model.addAttribute("searchName",map.get("searchName"));
    	model.addAttribute("keyword",map.get("keyword"));
		return "/home/plant/animal_record_list";
	}
	
	//공지사항 상세
	@RequestMapping(value = "/animal_record_view", method = RequestMethod.GET)
	public String ecologyView(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> one = new HashMap<String, Object>();
		try {
			one = homePlantService.selectecologyOne(map);
			if(one.get("seq") != null) {
				homePlantService.updatecologyReadCnt(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user plant/ecology_view:",e.getMessage());
		}
		model.addAttribute("one",one);
		 
		return "/home/plant/animal_record_view";
	}
	
	//분재 갤러리
	@RequestMapping(value = "/bonsai_gallery", method = RequestMethod.GET)
	public String bonsaiGallery(Model model,@RequestParam Map<String,Object> map) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			map.put("kind", "C");
	        list = homePlantService.selectBotanicalList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/botanicalGallery:",e.getMessage());
		} 
		model.addAttribute("list",list);
		return "/home/plant/bonsai_gallery";
	}
	
	//생태 식물원 사계
	@RequestMapping(value = "/botanical_gallery", method = RequestMethod.GET)
	public String botanicalGallery(Model model,@RequestParam Map<String,Object> map) {
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		try {
			map.put("kind", "A");
	        list = homePlantService.selectBotanicalList(map); 
	        
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user bbs/botanicalGallery:",e.getMessage());
		}     
        
    	model.addAttribute("list",list);
		return "/home/plant/botanical_gallery";
	}
	
	@RequestMapping(value = "/animal_crisis", method = RequestMethod.GET)
	public String animal_crisis(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/animal_crisis";
	}
	
	@RequestMapping(value = "/animal_introduce", method = RequestMethod.GET)
	public String animal_introduce(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/animal_introduce";
	}
	
	@RequestMapping(value = "/animal_record", method = RequestMethod.GET)
	public String animal_record(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/animal_record";
	}
	
	@RequestMapping(value = "/bonsai_introduce", method = RequestMethod.GET)
	public String bonsai_introduce(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/bonsai_introduce";
	}
	
	@RequestMapping(value = "/bonsai_tips", method = RequestMethod.GET)
	public String bonsai_tips(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/bonsai_tips";
	}
	
	@RequestMapping(value = "/botanical_introduce", method = RequestMethod.GET)
	public String botanical_introduce(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/botanical_introduce";
	}
	
	@RequestMapping(value = "/botanical_list", method = RequestMethod.GET)
	public String botanical_list(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/botanical_list";
	}
	
	@RequestMapping(value = "/botanical_list2", method = RequestMethod.GET)
	public String botanical_list2(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/botanical_list2";
	}
	
	@RequestMapping(value = "/botanical_list3", method = RequestMethod.GET)
	public String botanical_list3(Model model,@RequestParam Map<String,Object> map) {
		return "/home/plant/botanical_list3";
	}
	
}
