package kr.go.yanggu.home.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.go.yanggu.admin.service.RentalService;
import kr.go.yanggu.admin.service.SettingService;
import kr.go.yanggu.home.service.HomeProgramService;
import kr.go.yanggu.util.Pager;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/program")
public class HomeProgramController {

	private static final Logger logger = LoggerFactory.getLogger(HomeProgramController.class);

	@Autowired
	HomeProgramService homeProgramService;

	@Autowired
	RentalService rentalService;

	@Autowired
	SettingService settingService;

	// 용늪출입신청기간이 아닐시
	@RequestMapping(value = "/reserv_notice", method = RequestMethod.GET)
	public String reserv_notice(Model model, @RequestParam Map<String, Object> map) {
		return "/home/program/reserv_notice";
	}

	// 목공예 체험 프로그램
	@RequestMapping(value = "/wood_introduce", method = RequestMethod.GET)
	public String wood_introduce(Model model, @RequestParam Map<String, Object> map) {
		return "/home/program/wood_introduce";
	}

	// 목공예 체험 프로그램
	@RequestMapping(value = "/wood_list", method = RequestMethod.GET)
	public String woodList(Model model, @RequestParam Map<String, Object> map,
			@RequestParam(defaultValue = "1") int page) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			int totalCount = homeProgramService.selectWoodworkingTotal(map);
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
			list = homeProgramService.selectWoodworkingList(map);

		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user program/wood_list:", e.getMessage());
		}

		model.addAttribute("list", list);
		return "/home/program/wood_list";
	}

	// 체험프로그램 소개
	@RequestMapping(value = "/program_introduce", method = RequestMethod.GET)
	public String programIntroduce(Model model, @RequestParam Map<String, Object> map) {
		return "/home/program/program_introduce";
	}

	// 체험프로그램 신청
	@RequestMapping(value = "/program_write", method = RequestMethod.GET)
	public String programWrite(Model model, @RequestParam Map<String, Object> map) {
		Map<String, Object> openDateE = new HashMap<String, Object>();
		Map<String, Object> openDateF = new HashMap<String, Object>();
		String eClose = "N";
		String fClose = "N";

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH");
		Calendar time = Calendar.getInstance();

		String curDateTime = format.format(time.getTime());
		String curDate = curDateTime.substring(0, 10);
		String curTime = curDateTime.substring(11, 13);

		try {
			map.put("gubun", "e"); // 유아숲 체험 설정
			openDateE = homeProgramService.selectForestSetting(map);
			if (openDateE != null) {

				String startDateTime = String.valueOf(openDateE.get("startDate"));
				String startDate = startDateTime.substring(0, 10);
				String startTime = startDateTime.substring(11, 13);

				String endDateTime = String.valueOf(openDateE.get("endDate"));
				String endDate = endDateTime.substring(0, 10);
				String endTime = endDateTime.substring(11, 13);

				int compareSDate = curDate.compareTo(startDate);
				if (compareSDate == 0) {
					int compareSTime = curTime.compareTo(startTime);
					if (compareSTime < 0) {
						eClose = "Y";
					}
				} else if (compareSDate > 0) {
					int compareEDate = curDate.compareTo(endDate);
					if (compareEDate == 0) {
						int compareETime = curTime.compareTo(endTime);
						if (compareETime >= 0) {
							eClose = "Y";
						}
					} else if (compareEDate > 0) {
						eClose = "Y";
					}
				} else {
					eClose = "Y";
				}
			}
			map.put("gubun", "f"); // 숲 해설 설정
			openDateF = homeProgramService.selectForestSetting(map);
			if (openDateF != null) {
				String startDateTime = String.valueOf(openDateF.get("startDate"));
				String startDate = startDateTime.substring(0, 10);
				String startTime = startDateTime.substring(11, 13);

				String endDateTime = String.valueOf(openDateF.get("endDate"));
				String endDate = endDateTime.substring(0, 10);
				String endTime = endDateTime.substring(11, 13);

				int compareSDate = curDate.compareTo(startDate);
				if (compareSDate == 0) {
					int compareSTime = curTime.compareTo(startTime);
					if (compareSTime < 0) {
						fClose = "Y";
					}
				} else if (compareSDate > 0) {
					int compareEDate = curDate.compareTo(endDate);
					if (compareEDate == 0) {
						int compareETime = curTime.compareTo(endTime);
						if (compareETime >= 0) {
							fClose = "Y";
						}
					} else if (compareEDate > 0) {
						fClose = "Y";
					}
				} else {
					fClose = "Y";
				}
			}

			// 수목원 체험 프로그램
			map.put("gubun", "");
//			map.put("seq", 5);
			Map<String, Object> productData = new HashMap<String, Object>();
			productData = settingService.admin_member_productLastone(map); //가장 최신 등록 데이터 하나만 가져옴
			if (productData != null) {
				Date today = new Date();
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String todayStr = df.format(today);

				String trem = String.valueOf(productData.get("text_date"));
				String startDate = trem.split("~")[0].trim();
				String endDate = trem.split("~")[1].trim();

				String openYn = "N";

				if (endDate.compareTo(todayStr) >= 0) { // 접수 마감 이전일 때
					openYn = "Y";
				}

				productData.put("today", todayStr);
				productData.put("startDate", startDate);
				productData.put("endDate", endDate);
				productData.put("openYn", openYn);
				
				//인원수 설정
				List<Map<String, String>> numberList = new ArrayList<Map<String,String>>();
				
				//json 파싱
				JSONArray numberArr = new JSONArray(String.valueOf(productData.get("number")));
				
				if(numberArr.length() > 0) {
					for(int i = 0; i < numberArr.length(); i++) {
						Map<String, String> numberData = new HashMap<String, String>();
						JSONObject jsonObj = numberArr.getJSONObject(i);
						
						numberData.put("date", jsonObj.getString("date"));
						numberData.put("number", jsonObj.getString("number"));
						numberData.put("type", jsonObj.getString("type"));
						
						numberList.add(numberData);
					}
				}
				
				if(numberList.size() > 0) {
					productData.put("numberList", numberList);
				}
				
				productData.put("content", String.valueOf(productData.get("content")).replaceAll("&#10;", "<br>"));

				model.addAttribute("product", productData);

			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("user program/program_write:", e.getMessage());
		}
		model.addAttribute("fClose", fClose);
		model.addAttribute("eClose", eClose);
		return "/home/program/program_write";
	}

	// 체험 프로그램 매핑 추가
	@RequestMapping(value = "/program_reserv", method = { RequestMethod.GET, RequestMethod.POST })
	public String programReservPage(Model model, @RequestParam Map<String, Object> productData) {
		try {
			productData = settingService.admin_member_productone(productData);
			if (productData != null) {
				Date today = new Date();
				SimpleDateFormat toStr = new SimpleDateFormat("yyyy-MM-dd");
				String todayStr = toStr.format(today);

				String trem = String.valueOf(productData.get("text_date"));
				String startDate = trem.split("~")[0].trim();
				String endDate = trem.split("~")[1].trim();

				String openYn = "N";
				if (endDate.compareTo(todayStr) >= 0) { // 접수 마감 이전일 때
					openYn = "Y";
				}

				if (startDate.compareTo(todayStr) < 0) {// 접수 시작일이 지났으면 선택 가능한 날짜를 오늘부터 가능하게
					startDate = todayStr;
				}

				productData.put("today", todayStr);
				productData.put("startDate", startDate);
				productData.put("endDate", endDate);
				productData.put("openYn", openYn);
				
				//정원 완료된 날짜 제외
				List<String> ableDate = new ArrayList<String>();
				JSONArray numberArr = new JSONArray(String.valueOf(productData.get("number")));
				
				if(numberArr.length() > 0) {
					for(int i = 0; i < numberArr.length(); i++) {
						Map<String, String> map = new HashMap<String, String>();
						JSONObject jsonObj = numberArr.getJSONObject(i);
						
						map.put("date", jsonObj.getString("date"));
						map.put("seq", String.valueOf(productData.get("seq")));
						
						int entryCnt = homeProgramService.getProgramEntryCount(map);
						int number = Integer.parseInt(jsonObj.getString("number"));
						
						if(entryCnt < number) {
							ableDate.add(jsonObj.getString("date"));
						}
					}
				}
				
				ObjectMapper ob = new ObjectMapper();
				productData.put("ableDays", ob.writeValueAsString(ableDate));
				
				model.addAttribute("product", productData);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("user program/program_reserv:", e.getMessage());
		}

		return "/home/program/program_reserv";
	}

	// 체험프로그램 신청 등록
	@RequestMapping(value = "/program_write_action", method = RequestMethod.POST)
	public String programWriteAction(Model model, @RequestParam Map<String, Object> map) {
		int affect = 0;
		try {
			map.put("mobile", map.get("mobile1").toString() + map.get("mobile2") + map.get("mobile3"));
			affect = homeProgramService.insertProduct(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("user program/program_write_action:", e.getMessage());
		}
		String msg = "";
		String url = "";
		if (affect < 0) {
			if (affect == -2) {
				msg = "해당 일자의 접수 정원이 가득 찼습니다.";
			} else {
				msg = "신청 실패하였습니다.";
			}
			url = "/program/program_write";
		} else {
			msg = "신청 성공하였습니다.";
			url = "/";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/home/alert/alert";
	}

	// 용늪 출입 신청1
	@RequestMapping(value = "/reservation1", method = RequestMethod.GET)
	public String reservation1(Model model, @RequestParam Map<String, Object> map) {
		Map<Object, Object> settingMap = new HashMap<Object, Object>();
		String closeYn = "N";
		try {
			settingMap = homeProgramService.selectFacilitySetting();
			String month01 = settingMap.get("month01").toString();
			String month02 = settingMap.get("month02").toString();
			String month03 = settingMap.get("month03").toString();
			String month04 = settingMap.get("month04").toString();
			String month05 = settingMap.get("month05").toString();
			String month06 = settingMap.get("month06").toString();
			String month07 = settingMap.get("month07").toString();
			String month08 = settingMap.get("month08").toString();
			String month09 = settingMap.get("month09").toString();
			String month10 = settingMap.get("month10").toString();
			String month11 = settingMap.get("month11").toString();
			String month12 = settingMap.get("month12").toString();
			String mymonth = settingMap.get("mymonth").toString();

			if ("01".equals(mymonth) && "Y".equals(month01) && "Y".equals(month02)) {
				closeYn = "Y";
			} else if ("02".equals(mymonth) && "Y".equals(month02) && "Y".equals(month03)) {
				closeYn = "Y";
			} else if ("03".equals(mymonth) && "Y".equals(month03) && "Y".equals(month04)) {
				closeYn = "Y";
			} else if ("04".equals(mymonth) && "Y".equals(month04) && "Y".equals(month05)) {
				closeYn = "Y";
			} else if ("05".equals(mymonth) && "Y".equals(month05) && "Y".equals(month06)) {
				closeYn = "Y";
			} else if ("06".equals(mymonth) && "Y".equals(month06) && "Y".equals(month07)) {
				closeYn = "Y";
			} else if ("07".equals(mymonth) && "Y".equals(month07) && "Y".equals(month08)) {
				closeYn = "Y";
			} else if ("08".equals(mymonth) && "Y".equals(month08) && "Y".equals(month09)) {
				closeYn = "Y";
			} else if ("09".equals(mymonth) && "Y".equals(month09) && "Y".equals(month10)) {
				closeYn = "Y";
			} else if ("10".equals(mymonth) && "Y".equals(month10) && "Y".equals(month11)) {
				closeYn = "Y";
			} else if ("11".equals(mymonth) && "Y".equals(month11) && "Y".equals(month12)) {
				closeYn = "Y";
			} else if ("12".equals(mymonth) && "Y".equals(month12) && "Y".equals(month01)) {
				closeYn = "Y";
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if ("Y".equals(closeYn)) {
			return "/home/program/reserv_notice";
		} else {
			return "/home/program/reservation1";
		}
	}

	// 용늪 출입 신청2
	@RequestMapping(value = "/reservation2", method = RequestMethod.GET)
	public String reservation2(Model model, @RequestParam Map<String, Object> map) {
		Map<Object, Object> checkDMap = new HashMap<Object, Object>();
		Map<Object, Object> settingMap = new HashMap<Object, Object>();
		try {
			checkDMap = homeProgramService.selectCD();
			settingMap = homeProgramService.selectFacilitySetting();

			logger.info(" checkDMap : " + checkDMap);
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
		return "/home/program/reservation2";
	}

	// 용늪 출입 신청3
	@RequestMapping(value = "/reservation3", method = RequestMethod.GET)
	public String reservation3(Model model, @RequestParam Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			result = homeProgramService.selectDragonReserve(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("program reservation3:", e.getMessage());
		}

		model.addAttribute("result", result);
		return "/home/program/reservation3";
	}

	@RequestMapping(value = "/checkDayClose", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkDayClose(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		logger.info(" checkDayClose ");

		try {
			map = homeProgramService.checkDayClose(paramMap);
			logger.info(" checkDayClose : " + map);
			map.put("ret", 0);
		} catch (Exception e) {
			map.put("ret", -2);
			e.printStackTrace();
			logger.info("admin login:", e.getMessage());
		}
		return map;
	}

	@RequestMapping(value = "/checkDayCloseForest", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkDayCloseForest(@RequestParam Map<String, Object> paramMap,
			HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		logger.info(" checkDayCloseForest ");

		try {
			map = homeProgramService.checkDayCloseForest(paramMap);
			logger.info(" checkDayClose : " + map);
			map.put("ret", 0);
		} catch (Exception e) {
			map.put("ret", -2);
			e.printStackTrace();
			logger.info("admin login:", e.getMessage());
		}
		return map;
	}

	@RequestMapping(value = "/insertDragonReserve", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertDragonReserve(@RequestParam Map<String, Object> paramMap,
			HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> checkMap = new HashMap<String, Object>();
		logger.info(" insertDragonReserve : " + paramMap);
		int result = 0;

		try {
			checkMap = homeProgramService.checkDayClose(paramMap);
			int rCnt = Integer.parseInt(paramMap.get("cnt").toString());
			int po_aCnt = Integer.parseInt(checkMap.get("po_aCnt").toString());
			String po_closeYn = checkMap.get("po_closeYn").toString();
			String po_ret = checkMap.get("po_ret").toString();
			if ("210".equals(po_ret) && po_aCnt >= rCnt && "N".equals(po_closeYn)) {
				paramMap.put("mobile",
						paramMap.get("mobile1").toString() + paramMap.get("mobile2") + paramMap.get("mobile3"));
				result = homeProgramService.insertDragonReserve(paramMap);
			} else if ("440".equals(po_ret) || "439".equals(po_ret) || "438".equals(po_ret) || "437".equals(po_ret)
					|| "436".equals(po_ret) || "435".equals(po_ret) || "434".equals(po_ret) || "433".equals(po_ret)
					|| "432".equals(po_ret) || "431".equals(po_ret) || "430".equals(po_ret) || "429".equals(po_ret)) {
				result = -3;
			} else if ("441".equals(po_ret)) {
				result = -4;
			} else if ("Y".equals(po_closeYn)) {
				result = -2;
			} else {
				result = -1;
			}
			resultMap.put("dSeq", paramMap.get("dSeq"));
			logger.info(" insertDragonReserve : " + result);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("insertDragonReserve:", e.getMessage());
		}
		resultMap.put("result", result);

		return resultMap;
	}

	@RequestMapping(value = "/insertForestExperience", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertForestExperience(@RequestParam Map<String, Object> paramMap,
			HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> checkMap = new HashMap<String, Object>();
		logger.info(" insertForestExperience : " + paramMap);
		int result = 0;

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
			if ("210".equals(po_ret) && po_aCnt >= rCnt && "N".equals(po_closeYn)
					&& "1".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile",
						paramMap.get("mobile1").toString() + paramMap.get("mobile2") + paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			} else if ("210".equals(po_ret) && po_bCnt >= rCnt && "N".equals(po_closeYn)
					&& "2".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile",
						paramMap.get("mobile1").toString() + paramMap.get("mobile2") + paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			} else if ("210".equals(po_ret) && po_cCnt >= rCnt && "N".equals(po_closeYn)
					&& "3".equals(paramMap.get("entryTime"))) {
				paramMap.put("mobile",
						paramMap.get("mobile1").toString() + paramMap.get("mobile2") + paramMap.get("mobile3"));
				result = homeProgramService.insertForestExperience(paramMap);
			} else if ("429".equals(po_ret) || "430".equals(po_ret) || "431".equals(po_ret)) {
				result = -3;
			} else if ("441".equals(po_ret)) {
				result = -4;
			} else if ("Y".equals(po_closeYn)) {
				result = -2;
			} else {
				result = -1;
			}
			resultMap.put("dSeq", paramMap.get("dSeq"));
			logger.info(" insertDragonReserve : " + result);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("insertDragonReserve:", e.getMessage());
		}
		resultMap.put("result", result);

		return resultMap;
	}

	@RequestMapping(value = "/program_children", method = RequestMethod.GET)
	public String program_children(Model model) {

		return "/home/program/program_children";
	}

	@RequestMapping(value = "/forest_reservation1", method = RequestMethod.GET)
	public String forest_reservation1(Model model, @RequestParam Map<String, Object> paramMap) {
		Map<Object, Object> checkDMap = new HashMap<Object, Object>();
		Map<String, Object> openMap = new HashMap<String, Object>();
		if (!paramMap.containsKey("gubun")) {
			String msg = "잘못된 접근입니다.";
			String url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/home/alert/alert";
		}

		try {
			openMap = homeProgramService.selectForestSetting(paramMap);
			checkDMap = homeProgramService.selectCD();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (openMap != null) {
			model.addAttribute("startDate", openMap.get("startDate"));
			model.addAttribute("endDate", openMap.get("endDate"));
		}
		model.addAttribute("cy", checkDMap.get("year"));
		model.addAttribute("cny", checkDMap.get("nyear"));
		model.addAttribute("cm", checkDMap.get("month"));
		model.addAttribute("cnm", checkDMap.get("nmonth"));
		model.addAttribute("cd", checkDMap.get("day"));
		model.addAttribute("ch", checkDMap.get("hour"));
		model.addAttribute("gubun", paramMap.get("gubun"));
		return "/home/program/forest_reservation1";
	}

	@RequestMapping(value = "/forest_reservation2", method = RequestMethod.GET)
	public String forest_reservation2(Model model, @RequestParam Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = homeProgramService.selectForestExperience(map);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("program forest_reservation3:", e.getMessage());
		}

		model.addAttribute("result", result);
		return "/home/program/forest_reservation2";
	}

	@RequestMapping(value = "/forest_reservation3", method = RequestMethod.GET)
	public String forest_reservation3(Model model, @RequestParam Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = homeProgramService.selectForestExperience(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		return "/home/program/forest_reservation3";
	}

	@RequestMapping(value = "/forest/sendSms", method = RequestMethod.POST)
	public String sendSms(Model model, HttpSession session, HttpServletRequest request, String msg, String title,
			String mobile, String dseq, String smsType, String gubun) {

		int result = 0;
		try {
			byte[] euckrStrBuffer = msg.getBytes("euc-kr");

			logger.info(" bytes.length : " + euckrStrBuffer.length);

			if (euckrStrBuffer.length > 2000) {
				model.addAttribute("url", "/admin/forest/forest_rental");
				model.addAttribute("msg", "문자 길이는 2000 byte를 넘을 수 없습니다.");
				return "/home/alert/alert";
			} else if (euckrStrBuffer.length < 91) {
				smsType = "S";
			} else {
				smsType = "L";
			}

			logger.info(" smsType : " + smsType);
			logger.info(" msg : " + msg);
			logger.info(" rphone : " + mobile);
			logger.info(" title : " + title);

			String url = "https://sslsms.cafe24.com/sms_sender.php";
			String secret_key = "1d55fc68f5adccc8170fff91fa8641d7";

			RestTemplate restTemplate = new RestTemplate();
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
			LinkedMultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();
			map.add("user_id", "yanggupark1");
			map.add("secure", secret_key); // 시크릿키
			map.add("msg", msg); // SMS내용
			map.add("sphone1", "033"); // 인증된 발신번호
			map.add("sphone2", "488");
			map.add("sphone3", "7000");
			map.add("smsType", smsType);// "L" - 장문
			map.add("rphone", mobile); // 수신 휴대번호
			map.add("title", title); // 타이틀 ..
			map.add("rdate", ""); // 예약일자
			map.add("rtime", ""); // 예약시간
			map.add("mode", "1");
//			map.add("testflag", "Y"); //테스트시.. 

			Map<String, Object> smsMap = new HashMap<String, Object>();
			List<Map<String, Object>> smsList = new ArrayList<Map<String, Object>>();
			/*
			 * String[] rp = mobile.split(","); String[] ds = dseq.split(",");
			 */

			Map<String, Object> rdMap = new HashMap<String, Object>();
			rdMap.put("phoneNum", mobile);
			rdMap.put("dseq", dseq);
			rdMap.put("sandPhoneNum", "033-488-7000");
			rdMap.put("smsType", smsType);
			rdMap.put("title", title);
			rdMap.put("msg", msg);
			rdMap.put("experienceName", "유아숲/해설 출입신청");
			smsList.add(rdMap);

			HttpEntity<LinkedMultiValueMap<String, String>> request2 = new HttpEntity<LinkedMultiValueMap<String, String>>(
					map, headers);
			String response2 = restTemplate.postForObject(url, request2, String.class);
			String sandResult = "S";
			logger.info(" response2 : " + response2);
			response2 = response2.substring(0, 1);
			if (!"s".equals(response2)) {
				sandResult = "F";
			}
			/*
			 * for(int d=0;d<ds.length;d++) { smsList.get(0).put("sandSYn", sandResult); }
			 */

			smsList.get(0).put("sandSYn", sandResult);

			logger.info(" smsList : " + smsList);
			smsMap.put("list", smsList);
			result = rentalService.insertSmsList(smsMap);
			result = 1;

			if (result == 2) {
				throw new SQLException();
			}

		} catch (UnsupportedEncodingException | SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("url", "");
		model.addAttribute("msg", "승인문자를 전송했습니다.");
		return "/admin/alert/alert";
	}
}
