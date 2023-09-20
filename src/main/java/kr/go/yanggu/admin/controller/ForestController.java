package kr.go.yanggu.admin.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import kr.go.yanggu.admin.service.ForestService;
import kr.go.yanggu.admin.service.RentalService;
import kr.go.yanggu.home.controller.HomeProgramController;
import kr.go.yanggu.home.service.HomeProgramService;
import kr.go.yanggu.util.Pager;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ForestController {

	@Autowired
	HomeProgramService homeProgramService;

	@Autowired
	ForestService forestService;
	
	@Autowired
	RentalService rentalService;

	
	private static final Logger logger = LoggerFactory.getLogger(HomeProgramController.class);
	
	@RequestMapping(value = "/admin/forest/forest_program", method = RequestMethod.GET)
	public String program_children(Model model,HttpSession session) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		return "/admin/forest/forest_program";
	}
	
	@RequestMapping(value = "/admin/forest/forest_rental", method = {RequestMethod.GET,RequestMethod.POST})
	public String forest_rental(Model model,@RequestParam Map<String,Object> paramMap,HttpSession session,@RequestParam(defaultValue="1") int page,@RequestParam(required=false) String[] stat) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		Map<Object, Object> checkDMap = new HashMap<Object, Object>();
		Map<String, Object> openMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		if ((!paramMap.containsKey("useDate") || paramMap.get("useDate") == "") && (!paramMap.containsKey("startDate") || paramMap.get("startDate") == "")) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String curDate = simpleDateFormat.format(new Date());
		paramMap.put("useDate", curDate);
		}
		
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
			paramMap.put("stat", stat);
		}else {
			paramMap.put("stat", "");
		}
    	try {
    		int totalCount = forestService.selectForestListTotal(paramMap);
    		int rows = 10;
	        int blocks = 5;
	        int limitStart = (page - 1) * rows;        
	        Pager pager = new Pager(totalCount, page, rows, blocks);
	        paramMap.put("limitStart", limitStart);
	        paramMap.put("rows", rows);
	        model.addAttribute("page", page);
	        model.addAttribute("prevLink", pager.getPrevLink());
	        model.addAttribute("pageLinks", pager.getPageLinks());
	        model.addAttribute("nextLink", pager.getNextLink());
	        model.addAttribute("totalPage", pager.getTotalPage());
	        model.addAttribute("totalCount", totalCount);
	        model.addAttribute("statQuery",statQuery);
	        model.addAttribute("statString",statString);
	        list = forestService.selectForestList(paramMap);
	        
	        openMap = homeProgramService.selectForestSetting(paramMap);
    		checkDMap = homeProgramService.selectCD();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	if (openMap != null) {
			model.addAttribute("openDate",openMap.get("startDate"));
			model.addAttribute("closeDate",openMap.get("endDate"));
		}
    	
    	model.addAttribute("list", list);
    	model.addAttribute("cy", checkDMap.get("year"));
    	model.addAttribute("cny", checkDMap.get("nyear"));
    	model.addAttribute("cm", checkDMap.get("month"));
    	model.addAttribute("cnm", checkDMap.get("nmonth"));
    	model.addAttribute("cd", checkDMap.get("day"));
    	model.addAttribute("ch", checkDMap.get("hour"));
    	model.addAttribute("gubun", paramMap.get("gubun"));
    	model.addAttribute("stat",paramMap.get("stat"));
    	model.addAttribute("startDate",paramMap.get("startDate"));
    	model.addAttribute("endDate",paramMap.get("endDate"));
    	model.addAttribute("oldUseDate", paramMap.get("useDate"));
    	
		return "/admin/forest/forest_rental";
	}
	
	@RequestMapping(value = "/admin/forest/forest_rental_write", method = RequestMethod.GET)
	public String forest_rental_write(Model model,@RequestParam Map<String,Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = forestService.selectForestOne(map);
		} catch (SQLException e) {
			e.printStackTrace();
        	logger.info("program forest_reservation3:",e.getMessage());
		}
		
		model.addAttribute("result", result);
		return "/admin/forest/forest_rental_write";
	}
	
	
	@RequestMapping(value = "/admin/forest/changeList", method = RequestMethod.POST)
	public String changeList(@RequestParam Map<String,Object> paramMap,@RequestParam(defaultValue="1") int page,@RequestParam(required=false) String[] stat, Model model) {

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		try {
    		int totalCount = forestService.selectForestListTotal(paramMap);
    		int rows = 10;
	        int blocks = 5;
	        int limitStart = (page - 1) * rows;        
	        Pager pager = new Pager(totalCount, page, rows, blocks);
	        paramMap.put("limitStart", limitStart);
	        paramMap.put("rows", rows);
	        model.addAttribute("page", page);
	        model.addAttribute("prevLink", pager.getPrevLink());
	        model.addAttribute("pageLinks", pager.getPageLinks());
	        model.addAttribute("nextLink", pager.getNextLink());
	        model.addAttribute("totalPage", pager.getTotalPage());
	        model.addAttribute("totalCount", totalCount);
	        list = forestService.selectForestList(paramMap);
    		model.addAttribute("list",list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/admin/forest/forest_list_ajax";
		
	}
	
	@RequestMapping(value = "/admin/forest/insertForestExperienceAdmin", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView insertForestExperienceAdmin(@RequestParam Map<String,Object> paramMap, HttpServletRequest request) {

		Map<String,Object> resultMap = new HashMap<String,Object>();
		Map<String,Object> checkMap = new HashMap<String,Object>();
		logger.info(" insertForestExperience : "+paramMap);

		ModelAndView mv = new ModelAndView();
        int result=0;
		
        if (paramMap.get("adminUseDate") != null || paramMap.get("adminUseDate") != "") {
			paramMap.put("useDate", paramMap.get("adminUseDate"));
			paramMap.put("gubun", paramMap.get("insertGubun"));
		}
        
        try {
        	checkMap = homeProgramService.checkDayCloseForest(paramMap);
        	int rCnt = Integer.parseInt(paramMap.get("cnt").toString());
        	int po_aCnt = Integer.parseInt(checkMap.get("po_aCnt").toString());
        	int po_bCnt = Integer.parseInt(checkMap.get("po_bCnt").toString());
        	int po_cCnt = 0;
        	if (checkMap.containsKey("po_cCnt")) {
        		 po_cCnt = Integer.parseInt(checkMap.get("po_cCnt").toString());
			}
        	String po_closeYn = checkMap.get("po_closeYn").toString();
        	String po_ret = checkMap.get("po_ret").toString();
        	if("210".equals(po_ret) && po_aCnt>=rCnt && "N".equals(po_closeYn) && "1".equals(paramMap.get("entryTime"))) {
	        	paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
	        	result = homeProgramService.insertForestExperience(paramMap);
        	}else if("210".equals(po_ret) && po_bCnt>=rCnt && "N".equals(po_closeYn) && "2".equals(paramMap.get("entryTime"))) {
	        	paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
	        	result = homeProgramService.insertForestExperience(paramMap);
        	}else if("210".equals(po_ret) && po_cCnt>=rCnt && "N".equals(po_closeYn) && "3".equals(paramMap.get("entryTime"))) {
	        	paramMap.put("mobile", paramMap.get("mobile1").toString() + paramMap.get("mobile2")+ paramMap.get("mobile3"));
	        	result = homeProgramService.insertForestExperience(paramMap);
        	}else if("429".equals(po_ret) || "430".equals(po_ret) || "431".equals(po_ret) || "432".equals(po_ret)){
        		result = -3;
        	}else if("441".equals(po_ret)){
        		result = -4;
        	}else if("Y".equals(po_closeYn)){
        		result = -2;
        	}else {
        		result = -1;
        	}
        	resultMap.put("dSeq", paramMap.get("dSeq"));
    		logger.info(" insertDragonReserve : "+result);
        }catch(Exception e) {
        	e.printStackTrace();
        	logger.info("insertDragonReserve:",e.getMessage());
        }
        resultMap.put("result", result);
        
        //return resultMap;
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
    }
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/forest_stat_update", method = RequestMethod.POST)
	public ModelAndView forest_stat_update(Model model,@RequestParam Map<String,Object> map) {

		int result = 0;
		ModelAndView mv = new ModelAndView();

		try {
			result = forestService.admin_forest_update(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin rental/admin_rental_update:",e.getMessage());
		}
		
		//return String.valueOf(result);
		mv.addObject("result", result+"");
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "/admin/forest/forest_rental/excel", method = RequestMethod.POST)
	public String admin_rentallist_excel(Model model,HttpServletRequest request,@RequestParam Map<String,Object> paramMap,HttpServletResponse response,@RequestParam(required=false) String[] stat) {
		
    	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
    	if(stat != null) {
    		paramMap.put("stat", stat);
		}else {
			paramMap.put("stat", "");
		}
    	logger.info("stat : "+stat);
    	if (paramMap.get("excelUseDate") != null || paramMap.get("excelUseDate") != "") {
			paramMap.put("useDate", paramMap.get("excelUseDate"));
		}
    	try {
    		list = forestService.selectForestList(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin rental/rentallist/excel:",e.getMessage()); 
		}
    	model.addAttribute("list", list);
    	response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8"); 
		return "/admin/forest/forestlistExcel";
	}
	
	
	@RequestMapping(value = "/admin/forest/sendSms", method = RequestMethod.POST)
	public String sendSms(Model model,HttpSession session, HttpServletRequest request,String msg, String title, String mobile,String dseq,String smsType,String gubun) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
		
		int result = 0;
		try {
			byte[] euckrStrBuffer = msg.getBytes("euc-kr");

			logger.info(" bytes.length : "+euckrStrBuffer.length);
			
			if(euckrStrBuffer.length>2000) {
	    		model.addAttribute("url", "/admin/forest/forest_rental");
	    		model.addAttribute("msg", "문자 길이는 2000 byte를 넘을 수 없습니다.");
	    		return "/admin/alert/alert";
			}else if(euckrStrBuffer.length<91) {
				smsType = "S";
			}else {
				smsType = "L";
			}

			logger.info(" smsType : "+smsType);
			logger.info(" msg : "+msg);
			logger.info(" rphone : "+mobile);
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
			map.add("rphone", mobile); //수신 휴대번호 
			map.add("title", title); //타이틀 .. 
			map.add("rdate", ""); //예약일자 
			map.add("rtime", ""); //예약시간
			map.add("mode", "1"); 
//			map.add("testflag", "Y"); //테스트시.. 
        	
			Map<String,Object> smsMap = new HashMap<String,Object>();
			List<Map<String,Object>> smsList = new ArrayList<Map<String,Object>>();
			/*
			 * String[] rp = mobile.split(","); String[] ds = dseq.split(",");
			 */
			
				Map<String,Object> rdMap = new HashMap<String,Object>();
				rdMap.put("phoneNum", mobile);
				rdMap.put("dseq", dseq);
				rdMap.put("sandPhoneNum", "033-488-7000");
				rdMap.put("smsType", smsType);
				rdMap.put("title", title);
				rdMap.put("msg", msg);
				rdMap.put("experienceName", "유아숲/해설 출입신청");
				smsList.add(rdMap);
			
			
			HttpEntity<LinkedMultiValueMap<String, String>> request2 = new HttpEntity<LinkedMultiValueMap<String, String>>(map, headers);
			String response2 = restTemplate.postForObject( url, request2, String.class );
			String sandResult="S";
			logger.info(" response2 : "+response2);
			response2 = response2.substring(0, 1);
			if(!"s".equals(response2)) {
				sandResult="F";
			}
			/*
			 * for(int d=0;d<ds.length;d++) { smsList.get(0).put("sandSYn", sandResult); }
			 */
			
			smsList.get(0).put("sandSYn", sandResult);
			
			logger.info(" smsList : "+smsList);
			smsMap.put("list", smsList);
			result = rentalService.insertSmsList(smsMap);
			
		} catch (UnsupportedEncodingException | SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("url", "/admin/forest/forest_rental?gubun=" + gubun);
		model.addAttribute("msg", "승인문자를 전송했습니다.");
		return "/admin/alert/alert"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/iDateInsert", method = RequestMethod.POST)
	public ModelAndView admin_member_idleDateInsert(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			return null;
    	}
		ModelAndView mv = new ModelAndView();

		int result = 0;
		int checkDate = 0;
			try {
				checkDate = forestService.getCloseDateCount(paramMap);
				if (checkDate > 0) {
					result = -1;
				}else {
					result = forestService.iDateForestInsert(paramMap);
				}
		} catch (Exception e) {
			result = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		//return result+"";
		mv.addObject("result", result+"");
		mv.setViewName("jsonView");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/getCloseDateList", method = RequestMethod.POST)
	public ModelAndView admin_member_getCloseDateList(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return null;
    	}

		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		ModelAndView mv = new ModelAndView();

		try {
			list = forestService.getCloseDateList(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin forest/aCntUpdate:",e.getMessage());
		}
		
		//return list;
		mv.addObject("result", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/getOpenDate", method = RequestMethod.POST)
	public ModelAndView admin_forest_getOpenDate(Model model,HttpSession session,@RequestParam Map<String,Object> map) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return null;
    	}

		ModelAndView mv = new ModelAndView();
		Map<String,Object> data = new HashMap<String,Object>();
		
		try {
			data = forestService.getOpenDate(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin forest/aCntUpdate:",e.getMessage());
		}

		//return data;
		mv.addObject("result", data);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/iDateDelete", method = RequestMethod.POST)
	public ModelAndView admin_member_iDateDelete(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		
		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			//return "-3";
			return null;
    	}
		ModelAndView mv = new ModelAndView();
		
		int result = 0;
    	try {
    		result = forestService.iDateDelete(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("admin setting/idleDateDelete:",e.getMessage());
		}
		
		//return result+"";
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/forest/openDate", method = RequestMethod.POST)
	public ModelAndView admin_member_openDate(Model model, HttpSession session, @RequestParam Map<String,Object> paramMap) {


		if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
			return null;
		}
		
    	if (paramMap.get("startDate") != null || paramMap.get("startDate") != "") {
			String startDate = String.valueOf(paramMap.get("startDate"))+" "+ String.valueOf(paramMap.get("sTime"));
			paramMap.put("startDate", startDate);
			
			String endDate = String.valueOf(paramMap.get("endDate"))+" "+ String.valueOf(paramMap.get("eTime"));
			paramMap.put("endDate", endDate);
		}
		
		int result = 0;
		ModelAndView mv = new ModelAndView();
    	
    	try {
    		result = forestService.settingForestInsert(paramMap);
		} catch (Exception e) {
			result = -1;
			e.printStackTrace();
			logger.info("admin setting/aCntUpdate:",e.getMessage());
		}
		
		//return result+"";
		mv.addObject("result", result+"");
		mv.setViewName("jsonView");
		return mv;
	}
}
