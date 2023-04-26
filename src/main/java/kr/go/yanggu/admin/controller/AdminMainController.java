package kr.go.yanggu.admin.controller;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.go.yanggu.admin.service.AdminService;
import kr.go.yanggu.util.Utils;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminMainController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminMainController.class);
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String Main(Model model,@RequestParam Map<String,Object> map) {
		return "/admin/login/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(@RequestParam(name = "adminId") String adminId, @RequestParam(name = "pwd") String pwd, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
       
        map.put("adminId", adminId);
        map.put("pwd", pwd);
        map.put("ip", Utils.getIp(request));
        
        
        try {
	        Map<String, Object> login = adminService.login(map);
	        
	        if (login == null) { // 아이디 패스워드 일치하지 않음
	        	map.put("result", "error");
	        	map.put("msg", "입력정보가 일치하지 않습니다.");
	            
	        	adminService.loginFaild(map);
	        } else if(Integer.parseInt(login.get("count").toString()) >= 5){
	        	map.put("result", "error");
	        	map.put("msg", "5회 로그인 실패 접속불가처리되였습니다.");
	        } else { // 로그인 성공
	        	map.put("result", "success");
	        	map.put("adminType", "master");
	            
	            // 로그인 성공 세션 저장
	            HttpSession session = request.getSession();
	            session.setAttribute("loginSeq", login.get("seq"));
	            session.setAttribute("loginId", login.get("adminId"));
	            session.setAttribute("loginName", login.get("adminName"));
	            session.setAttribute("loginEmail", login.get("adminEmail"));
	            session.setAttribute("loginAuth", login.get("auth"));
	            session.setAttribute("adminDept", login.get("adminDept"));
	            session.setAttribute("loginMobile", login.get("adminMobile"));
	            session.setAttribute("lastLoginDate", login.get("adminLastLoginDate"));
	            System.out.println("======");
	            System.out.println(map.get("ip"));
	            System.out.println(login.get("adminLastLoginDate"));
	            adminService.loginSuccess(map);
	        }
        }catch(Exception e) {
        	e.printStackTrace();
        	logger.info("admin login:",e.getMessage());
        }
        return map;
    }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("loginSeq");
        session.removeAttribute("loginId");
        session.removeAttribute("loginName");
        session.removeAttribute("loginEmail");
        session.removeAttribute("loginAuth");
        session.removeAttribute("loginMobile");
        session.removeAttribute("adminLastLoginDate");
        return "redirect:/admin/login";
    }
	
    
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
    	if (session.getAttribute("loginSeq") == null || "".equals(session.getAttribute("loginSeq"))) {
    		model.addAttribute("url", "/admin/login");
    		model.addAttribute("msg", "권한이 없습니다.");
    		return "/admin/alert/alert";
    	}
    	
    	try {
    		map.put("lastLoginDate", session.getAttribute("lastLoginDate"));
			List<Map<String, Object>> noticeList  = adminService.selectTopNoticeList(map);
			Map<String, Object> rentalCnt = adminService.selectRentalOne(map);
			
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("rentalCnt", rentalCnt);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("admin dashboard:",e.getMessage());
		}
    	
    	
		return "admin/dashboard/dashboard";
	}
}
