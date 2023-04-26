package kr.go.yanggu.admin.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.go.yanggu.admin.service.RentalService;
import kr.go.yanggu.util.Pager;

@Controller
@RequestMapping(value = "/admin")
public class RentalController {
	private static final Logger logger = LoggerFactory.getLogger(RentalController.class);
	
	@Autowired
	RentalService rentalService;
	
	@RequestMapping(value = "/rental/rentallist/excel", method = RequestMethod.POST)
	public String admin_rentallist_excel(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map,HttpServletResponse response,@RequestParam(required=false) String[] stat) {
		
    	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
    	if(stat != null) {
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}
    	logger.info("stat : "+stat);
    	try {
			list = rentalService.admin_rental_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/rentallist/excel:",e.getMessage()); 
		}
    	model.addAttribute("list", list);
    	response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8"); 
		return "/admin/rental/rentallistExcel";
	}
	
	@RequestMapping(value = "/rental/rentallist", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentallist(Model model,HttpSession session,@RequestParam Map<String,Object> map,
			@RequestParam(defaultValue="1") int page,@RequestParam(required=false) String[] stat) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String statQuery="";
		String statString ="";
		if(stat != null) {
			for(int i=0;i<stat.length;i++) {
				if(i==0) {
					statString=stat[i];
				}else {
					statString+=","+stat[i];
				}
				statQuery+="&stat="+stat[i];
			}
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}
		
		
		try {
			Map<String, Object> countMap = rentalService.admin_rental_list_total(map);   
			int totalCount = Integer.parseInt(countMap.get("tCnt").toString());   
			int sCount = Integer.parseInt(countMap.get("sCnt").toString());      
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
	        model.addAttribute("sumCount", sCount);
			list = rentalService.admin_rental_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/rental/rentallist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("search_type", map.get("search_type"));	
		model.addAttribute("startDate", map.get("startDate"));	
		model.addAttribute("endDate", map.get("endDate"));
		model.addAttribute("statQuery", statQuery);
		model.addAttribute("statString", statString);
		return "admin/rental/rentalList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/rental/admin_rental_update", method = RequestMethod.POST)
	public String admin_rental_update(Model model,@RequestParam Map<String,Object> map) {
		int affect = 0;
		
		try {
			affect = rentalService.admin_rental_update(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin rental/admin_rental_update:",e.getMessage());
		}
		
		return affect+"";
	}
	
	@RequestMapping(value = "/rental/experiencelist/excel", method = RequestMethod.POST)
	public String admin_experiencelist_excel(Model model,HttpServletRequest request,@RequestParam Map<String,Object> map,HttpServletResponse response) {
		
    	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
    	
    	try {
			list = rentalService.admin_experience_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/experiencelist/excel:",e.getMessage()); 
		}
    	model.addAttribute("list", list);
    	response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8"); 
		return "/admin/rental/experiencelistExcel";
	}
	
	@RequestMapping(value = "/rental/experiencelist", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_experience_rentallist(Model model,HttpSession session,@RequestParam Map<String,Object> map,
			@RequestParam(defaultValue="1") int page,@RequestParam(required=false) String[] stat) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> productList = new ArrayList<Map<String, Object>>();
		
		try {
			int totalCount = rentalService.admin_experience_list_total(map);     
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
			list = rentalService.admin_experience_list(map);
			productList = rentalService.admin_experience_product_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/experiencelist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("productList", productList);
		model.addAttribute("startDate", map.get("startDate"));	
		model.addAttribute("endDate", map.get("endDate"));
		model.addAttribute("seq", map.get("seq"));
		return "admin/rental/experienceList";
	}
	
	@RequestMapping(value = "/rental/rentalWrite", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_rentalWrite(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
    	Map<Object, Object> checkDMap = new HashMap<Object, Object>();
    	Map<Object, Object> settingMap = new HashMap<Object, Object>();
    	try {
    		checkDMap = rentalService.selectCD();
    		settingMap = rentalService.selectFacilitySetting();

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
		
		return "admin/rental/rentalWrite";
	}
	
	@RequestMapping(value = "/rental/checkDayClose", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkDayClose(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {
        
		Map<String,Object> map = new HashMap<String,Object>();
		logger.info("admin checkDayClose ");
		
        try {
    		map = rentalService.checkDayClose(paramMap);
    		logger.info("admin checkDayClose : "+map);
    		map.put("ret", 0);
        }catch(Exception e) {
        	map.put("ret", -2);
        	e.printStackTrace();
        	logger.info("admin checkDayClose:",e.getMessage());
        }
        return map;
    }
	
	@RequestMapping(value = "/rental/insertDragonReserve", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> insertDragonReserve(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		logger.info(" insertDragonReserve : "+paramMap);
        int result=0;
		
        try {
        	paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
        	result = rentalService.insertDragonReserve(paramMap);
        	resultMap.put("dSeq", paramMap.get("dSeq"));
    		logger.info("admin insertDragonReserve : "+result);
        }catch(Exception e) {
        	e.printStackTrace();
        	logger.info("admin insertDragonReserve:",e.getMessage());
        }
        resultMap.put("result", result);
        
        return resultMap;
    }
	
	@RequestMapping(value = "/rental/goSms", method = {RequestMethod.GET,RequestMethod.POST})
	public String goSms(Model model,HttpSession session,@RequestParam(value="rphoneArr", required=false) String[] rphoneArr) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		if (rphoneArr == null || rphoneArr.length==0) {
    		model.addAttribute("url", "/admin/rental/rentallist");
    		model.addAttribute("msg", "sms를 전송할 신청자를 선택해주십시오.");
    		return "/admin/alert/alert";
    	}
		
		String rphone = "";
		String dseq = "";
		
		for(int i=0;i<rphoneArr.length;i++) {
			String[] arr = rphoneArr[i].split("@");
			if(i==0) {
				rphone = arr[0];
				dseq = arr[1];
			}else {
				rphone += ","+arr[0];
				dseq += ","+arr[1];
			}
		}
		
		logger.info(" goSms rphone : "+rphone);
		logger.info(" goSms dseq : "+dseq);
		
		model.addAttribute("rphone", rphone);
		model.addAttribute("dseq", dseq);
		return "admin/rental/goSms";
	}

	@RequestMapping(value = "/rental/sendSms", method = RequestMethod.POST)
	public String sendSms(Model model,HttpSession session,String msg, String title, String rphone,String dseq,String smsType) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		try {
			byte[] euckrStrBuffer = msg.getBytes("euc-kr");

			logger.info(" bytes.length : "+euckrStrBuffer.length);
			
			if(euckrStrBuffer.length>2000) {
	    		model.addAttribute("url", "/admin/rental/rentallist");
	    		model.addAttribute("msg", "문자 길이는 2000 byte를 넘을 수 없습니다.");
	    		return "/admin/alert/alert";
			}else if(euckrStrBuffer.length<91) {
				smsType = "S";
			}else {
				smsType = "L";
			}

			logger.info(" smsType : "+smsType);
			logger.info(" msg : "+msg);
			logger.info(" rphone : "+rphone);
			logger.info(" title : "+title);
			String url = "https://sslsms.cafe24.com/sms_sender.php"; 
			String secret_key = "1d55fc68f5adccc8170fff91fa8641d7"; 
			RestTemplate restTemplate = new RestTemplate(); 
			HttpHeaders headers = new HttpHeaders(); 
			headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); 
			LinkedMultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>(); 
			map.add("user_id", "yanggupark1"); 
			map.add("secure", secret_key); //시크릿키 
			map.add("msg", msg); //SMS내용
			map.add("sphone1", "033"); // 인증된 발신번호
			map.add("sphone2", "488");
			map.add("sphone3", "7000");
			map.add("smsType", smsType);//"L" - 장문 
			map.add("rphone", rphone); //수신 휴대번호 
			map.add("title", title); //타이틀 .. 
			map.add("rdate", ""); //예약일자 
			map.add("rtime", ""); //예약시간
			map.add("mode", "1"); 
			//map.add("testflag", "Y"); //테스트시..
			
        	int result = 0;
			Map<String,Object> smsMap = new HashMap<String,Object>();
			List<Map<String,Object>> smsList = new ArrayList<Map<String,Object>>();
			String[] rp =  rphone.split(",");
			String[] ds =  dseq.split(",");
			for(int d=0;d<ds.length;d++) {
				Map<String,Object> rdMap = new HashMap<String,Object>();
				rdMap.put("phoneNum", rp[d]);
				rdMap.put("dseq", ds[d]);
				rdMap.put("sandPhoneNum", "033-488-7000");
				rdMap.put("smsType", smsType);
				rdMap.put("title", title);
				rdMap.put("msg", msg);
				rdMap.put("experienceName", "용늪 출입신청");
				smsList.add(rdMap);
			}
			
			HttpEntity<LinkedMultiValueMap<String, String>> request2 = new HttpEntity<LinkedMultiValueMap<String, String>>(map, headers);
			String response2 = restTemplate.postForObject( url, request2, String.class );
			String sandResult="S";
			logger.info(" response2 : "+response2);
			response2 = response2.substring(0, 1);
			if(!"s".equals(response2)) {
				sandResult="F";
			}
			for(int d=0;d<ds.length;d++) {
				smsList.get(d).put("sandSYn", sandResult);
			}
			
			logger.info(" smsList : "+smsList);
			smsMap.put("list", smsList);
			result = rentalService.insertSmsList(smsMap);
			
			
			model.addAttribute("response2", response2);
		} catch (UnsupportedEncodingException | SQLException e) {
			e.printStackTrace();
		}
		return "redirect:/admin/rental/rentallist"; 
	}
	
	@RequestMapping(value = "/rental/smslist", method = {RequestMethod.GET,RequestMethod.POST})
	public String admin_rental_smslist(Model model,HttpSession session,@RequestParam Map<String,Object> map,
			@RequestParam(defaultValue="1") int page,@RequestParam(required=false) String[] stat) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String statQuery="";
		String statString ="";
		if(stat != null) {
			for(int i=0;i<stat.length;i++) {
				if(i==0) {
					statString=stat[i];
				}else {
					statString+=","+stat[i];
				}
				statQuery+="&stat="+stat[i];
			}
			map.put("stat", stat);
		}else {
			map.put("stat", "");
		}
		
		
		try {
			Map<String, Object> countMap = rentalService.admin_sms_list_total(map);     
			int totalCount = Integer.parseInt(countMap.get("tCnt").toString());   
			int sCount = Integer.parseInt(countMap.get("sCnt").toString());   
			int fCount = Integer.parseInt(countMap.get("fCnt").toString());
	        int rows = 10;
	        int blocks = 5;
	        int limitStart = (page - 1) * rows;        
	        Pager pager = new Pager(totalCount, page, rows, blocks);
	        map.put("limitStart", limitStart);
	        map.put("rows", rows);
	        model.addAttribute("sCount", sCount);
	        model.addAttribute("fCount", fCount);
	        model.addAttribute("page", page);
	        model.addAttribute("prevLink", pager.getPrevLink());
	        model.addAttribute("pageLinks", pager.getPageLinks());
	        model.addAttribute("nextLink", pager.getNextLink());
	        model.addAttribute("totalPage", pager.getTotalPage());
	        model.addAttribute("totalCount", totalCount);
			list = rentalService.admin_sms_list(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin site/rental/rentallist:",e.getMessage());
		}
		model.addAttribute("list", list);
		model.addAttribute("search_type", map.get("search_type"));	
		model.addAttribute("startDate", map.get("startDate"));	
		model.addAttribute("endDate", map.get("endDate"));
		model.addAttribute("statQuery", statQuery);
		model.addAttribute("statString", statString);
		return "admin/rental/smsList";
	}
	
	
}
