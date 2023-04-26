package kr.go.yanggu.home.controller;


import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/park")
public class HomeParkController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeParkController.class);
	
	@RequestMapping(value = "/park_guidance", method = RequestMethod.GET)
	public String park_guidance(Model model,@RequestParam Map<String,Object> map) {
		return "/home/park/park_guidance";
	}
	
	@RequestMapping(value = "/park_introduce", method = RequestMethod.GET)
	public String park_introduce(Model model,@RequestParam Map<String,Object> map) {
		return "/home/park/park_introduce";
	}
	
	@RequestMapping(value = "/park_map", method = RequestMethod.GET)
	public String park_map(Model model,@RequestParam Map<String,Object> map) {
		return "/home/park/park_map";
	}
	
}
