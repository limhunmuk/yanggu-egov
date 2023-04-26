package kr.go.yanggu.home.controller;


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

import kr.go.yanggu.admin.service.ForestService;
import kr.go.yanggu.home.service.HomeMainService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeMainController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeMainController.class);
	
	@Autowired
	HomeMainService homeMainService;
	
	@Autowired
	ForestService forestService;
	
	//메인페이지
	@RequestMapping(value = {"/", "/main"}, method = RequestMethod.GET)
	public String Main(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map) {
		List<Map<String,Object>> noticeList = new ArrayList<Map<String,Object>>(); 
		List<Map<String,Object>> galleryList = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> popupList = new ArrayList<Map<String,Object>>();
		 
		try {
			noticeList = homeMainService.selectMainNotice();
			galleryList = homeMainService.selectMainGallery();
			popupList = homeMainService.selectPopupList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("galleryList", galleryList);
		model.addAttribute("popupList", popupList);
		
		return "/home/main/main";
	}
	
	//예약확인
	@RequestMapping(value = "/main/reservation_write", method = RequestMethod.GET)
	public String reservation_write(Model model,@RequestParam Map<String,Object> map) {
		return "/home/main/reservation_write";
	}
	
	//예약확인
	@RequestMapping(value = "/main/reservation_view", method = RequestMethod.POST)
	public String reservation_view(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> one  = new HashMap<String,Object>();
		try {
			map.put("mobile", map.get("mobile1").toString()+ map.get("mobile2")+ map.get("mobile3"));
			if (map.get("gubun").equals("o")) {
				one = homeMainService.selectReservation(map); 
			}else {
				one = homeMainService.selectReservationForest(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user main/reservation_view:",e.getMessage());
		}     
		model.addAttribute("gubun", map.get("gubun"));
    	model.addAttribute("one",one);
    	if(one == null || one.get("seq") == null) { 
    		String msg ="";
    		if (map.get("gubun").equals("o")) {
				msg = "용늪 예약 내역이 없습니다.";
			}else if(map.get("gubun").equals("e")) {
				msg = "유아숲체험 예약 내역이 없습니다.";
			}else {
				msg = "유아숲해설 예약 내역이 없습니다.";
			}
    		String url="/main/reservation_write";
    		model.addAttribute("msg", msg);
        	model.addAttribute("url", url);
        	return "/home/alert/alert";
    	}
		return "/home/main/reservation_view";
	}
	
	@RequestMapping(value = "/main/cancelReserve", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> cancelReserve(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		logger.info(" cancelDragonReserve : "+paramMap);
        int result=0;
		
        try {
        	if (paramMap.get("gubun").equals("o")) {
        		result = homeMainService.cancelDragonReserve(paramMap);
			}else {
				result = homeMainService.cancelForestReserve(paramMap);
			}
        }catch(Exception e) {
        	e.printStackTrace();
        	logger.info("admin insertDragonReserve:",e.getMessage());
        }
        resultMap.put("result", result);
        
        return resultMap;
    }
	
	//메인페이지
	@RequestMapping(value = "/main/policy", method = RequestMethod.GET)
	public String policy(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map) {
		
		return "/home/main/policy";
	}
	
	
	@RequestMapping(value = "/test4", method = RequestMethod.GET)
    public String test4(Model model) {   
    	
    	return "home/main/test4";
    	
    }
}
