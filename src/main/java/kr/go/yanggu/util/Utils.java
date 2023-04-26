/**FILEDESC
공통:공통 유틸리티
*/
package kr.go.yanggu.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Utils {
	private static Logger logger = LoggerFactory.getLogger(Utils.class);
	
	// null 처리
	public static String nvl(Object obj, String defaultStr) {
		String ret = "";
		if( obj != null ) ret = obj.toString();
		return "".equals(ret) ? defaultStr : ret;
	}
	
    //  String null을 빈 문자열로 바꿔준다
    public static String nullToEmpty(String s) {
        if (s == null) s = "";
        return s;
    }
    // 랜덤문자 1글자 생성 문자
    public static char randomChar() {
        String pattern = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        java.util.Random rand = new java.util.Random();
        return pattern.charAt(rand.nextInt(pattern.length()));
    }
    
    // 랜덤문자 1글자 생성 숫자
    public static char randomChar1() {
        String pattern = "0123456789";
        java.util.Random rand = new java.util.Random();
        return pattern.charAt(rand.nextInt(pattern.length()));
    }
    
    // 랜덤문자 1글자 생성 문자숫자
    public static char randomChar2() {
        String pattern = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        java.util.Random rand = new java.util.Random();
        return pattern.charAt(rand.nextInt(pattern.length()));
    }
    
    // 랜덤문자열 생성 문자
    public static String generateString(int length) {
        String pattern = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        java.util.Random rand = new java.util.Random();
        String s = "";
        for (int i = 0; i < length; i++) {
            s += pattern.charAt(rand.nextInt(pattern.length()));
        }
        return s;
    }
    
    // 랜덤문자열 생성 숫자
    public static String generateString1(int length) {
        String pattern = "0123456789";
        java.util.Random rand = new java.util.Random();
        String s = "";
        for (int i = 0; i < length; i++) {
            s += pattern.charAt(rand.nextInt(pattern.length()));
        }
        return s;
    }
     // 랜덤문자열 생성 문자숫자
    public static String generateString2(int length) {
        String pattern = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        java.util.Random rand = new java.util.Random();
        String s = "";
        for (int i = 0; i < length; i++) {
            s += pattern.charAt(rand.nextInt(pattern.length()));
        }
        return s;
    }
    // 채널코드 생성
   public static String getChannelCode() {
	Random rnd = new Random();
	String pattern = "0123456789";
	java.util.Random rand = new java.util.Random();
	
	String randomNum = "";
	for (int i = 0; i < 8; i++) {
		randomNum += pattern.charAt(rand.nextInt(pattern.length()));
	}

	String randomStr = String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
	randomStr += String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
	
	return randomStr+randomNum;
   }
    
    // 날짜를 문자열로 변환
    public static String dateToString(Date date, String format) {
        SimpleDateFormat f = new SimpleDateFormat(format);
        return f.format(date);
    }
    
    // 숫자에 콤마넣기
    public static String numberWithComma(short number) {
        DecimalFormat f = new DecimalFormat("###,##0");
        return f.format(number);
    }
    
    // 숫자에 콤마넣기
    public static String numberWithComma(int number) {
        DecimalFormat f = new DecimalFormat("###,##0");
        return f.format(number);
    }
    
    // 숫자에 콤마넣기
    public static String numberWithComma(long number) {
        DecimalFormat f = new DecimalFormat("###,##0");
        return f.format(number);
    }
    
    // 숫자에 콤마넣기
    public static String numberWithComma(float number, int pointDigit) {
        String format;
        if (pointDigit > 0) {
            format = "###,##0.";
            for (int i = 0; i < pointDigit; i++) {
                format += "0";
            }
        } else {
            format = "###,##0";
        }
        DecimalFormat f = new DecimalFormat(format);
        return f.format(number);
    }
    
 // 숫자에 콤마넣기
    public static String numberWithComma(double number, int pointDigit) {
        String format;
        if (pointDigit > 0) {
            format = "###,##0.";
            for (int i = 0; i < pointDigit; i++) {
                format += "0";
            }
        } else {
            format = "###,##0";
        }
        DecimalFormat f = new DecimalFormat(format);
        return f.format(number);
    }
    
    // 숫자에 콤마넣기
    public static String numberWithComma(String number, int pointDigit) {
        double n;
        
        try {
            n = Double.parseDouble(number);
        } catch (RuntimeException e) {
            n = 0;
        }
        String format;
        if (pointDigit > 0) {
            format = "###,##0.";
            for (int i = 0; i < pointDigit; i++) {
                format += "0";
            }
        } else {
            format = "###,##0";
        }
        DecimalFormat f = new DecimalFormat(format);
        return f.format(n);
    }
    
    // 전화번호 하이픈(-) 삽입
    public static String phoneNumberWithHypen(String s) {
        if (!s.matches("^[0-9]*$")) {
            return "";
        }
        if (s.startsWith("02")) {
            if (s.length() == 9) {
                s = s.substring(0, 2) + "-" + s.substring(2, 5) + "-" + s.substring(5);
            } else if (s.length() == 10) {
                s = s.substring(0, 2) + "-" + s.substring(2, 6) + "-" + s.substring(6);
            } else {
                return "";
            }
        } else {
            if (s.length() == 10) {
                s = s.substring(0, 3) + "-" + s.substring(3, 6) + "-" + s.substring(6);
            } else if (s.length() == 11) {
                s = s.substring(0, 3) + "-" + s.substring(3, 7) + "-" + s.substring(7);
            } else {
                return "";
            }
        }
        return s;
    }
    
    // 이전페이지 체크
    public static boolean checkReferer(HttpServletRequest request) {
//        String baseURL = getBaseURL(request);
//        List<String> allowedDomain = new ArrayList<String>(Arrays.asList(Constants.ALLOWED_DOMAIN));
//        allowedDomain.add(0, baseURL);
//        String referer = request.getHeader("REFERER") == null ? "" : request.getHeader("REFERER");
//        boolean result = false;
//        
//        if (!referer.isEmpty()) {
//            for (int i = 0; i < allowedDomain.size(); i++) {
//                if (referer.startsWith(allowedDomain.get(i))) {
//                    result = true;
//                    break;
//                }
//            }
//        }
//        return result;
    	return true;
    }
    
    // IE 체크
    public static boolean checkBrowserIE(HttpServletRequest request) {
        boolean isIE = request.getHeader("User-Agent").contains("MSIE") || request.getHeader("User-Agent").contains("Trident");
        return isIE;
    }
    
    // 모바일 체크
    public static boolean checkMobile(HttpServletRequest request) {
        boolean isMobile = request.getHeader("User-Agent").contains("Mobile");
        return isMobile;
    }
    
    // 파일 중복 체크
    public static String getUniqueFileName(String uploadDir, String file) {
        int fileCnt = 0;
        String fileName = file.contains(".") ? file.substring(0, file.lastIndexOf(".")) : file;
        String ext = file.contains(".") ? file.substring(file.lastIndexOf(".") + 1) : "";
        ext = ext.toLowerCase();
        
        while (true) {
            fileCnt++;
            String filePath = ext.isEmpty() ? uploadDir + fileName : uploadDir + fileName + "." + ext;
            File f = new File(filePath);
            if (!f.exists()) {
                break;
            } else {
                fileName = file.substring(0, file.lastIndexOf(".")) + "_" + fileCnt;
            }
        }
        
        String result = ext.isEmpty() ? fileName : fileName + "." + ext;
        
        return result;
    }

    // 물리적으로 저장될 파일명 반환
    public static String getSysFileName(String file) {
    	
        String fileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS")) + "_" + generateString2(6);
        String ext = getFileExtension(file);
                
        String result = ext.isEmpty() ? fileName : fileName + "." + ext;
        
        return result;
    }
    
    // 고유한 String 값 반환
    public static String getUniqueString() {
    	return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS")) + "_" + generateString2(6);
    }

    // 날짜 더하기
    public static String dateAdd(String date, int addDay) {
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    	String result = "";
    	try
    	{
	    	Date mydate = format.parse(date);   		   	
	    	Calendar cal = Calendar.getInstance();
	        cal.setTime(mydate);
	        cal.add(Calendar.DATE, addDay);		//날짜 더하기
	        result = format.format(cal.getTime());
    	}
    	catch (Exception e)
    	{
    		logger.error(e.getMessage());
    	}
    	
        return result;
    }

    // 날짜 더하기
    public static String dateAdd(String date, int addDay, String formatStr) {
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    	SimpleDateFormat informat = new SimpleDateFormat(formatStr);
    	String result = "";
    	try
    	{
	    	Date mydate = format.parse(date);   		   	
	    	Calendar cal = Calendar.getInstance();
	        cal.setTime(mydate);
	        cal.add(Calendar.DATE, addDay);		//날짜 더하기
	        result = informat.format(cal.getTime());
    	}
    	catch (Exception e)
    	{
    		logger.error(e.getMessage());
    	}
        return result;
    }    
    
    // 파일 확장자 가져오기
    public static String getFileExtension(String fileName) {
        String ext = "";
        
        if (fileName.contains(".")) {
            ext = fileName.substring(fileName.lastIndexOf(".") + 1);
            ext = ext.toLowerCase();
        }
        
        return ext;
    }
    
    //파일 내용 읽어오기
    public static String getFileContents(String filePath) {
        BufferedReader br = null;
        FileInputStream fis = null;
        InputStreamReader isr = null;
        String s = "";
        try{
            File file = new File(filePath);
            fis = new FileInputStream(file);
            isr = new InputStreamReader(fis, "UTF-8");
            br = new BufferedReader(isr);
            StringBuilder sb = new StringBuilder();
            int i;
            while ((i = br.read()) != -1) {
                sb.append((char)i);
            }
            s = sb.toString();
        } catch (IOException e) {
            e.getStackTrace();
        } finally {
            if (br != null) { try { br.close(); } catch (IOException e) {} }
            if (isr != null) { try { isr.close(); } catch (IOException e) {} }
            if (fis != null) { try { fis.close(); } catch (IOException e) {} }
        }
        
        return s;
    }
    
    // 현제 도메인 불러오기
    public static String getBaseURL(HttpServletRequest request) {
        return request.getRequestURL().toString().replace(request.getRequestURI(), "");
    }
    
    // 서버 실제 경로 불러오기
    public static String getDocumentRoot(HttpServletRequest request) {
        return request.getSession().getServletContext().getRealPath("");
    }
    
	// Get Session 값
	public static String getSessionValue(HttpServletRequest request, String key)
	{

		return (request == null || request.getSession().getAttribute(key) == null)
						? ""
						: String.valueOf(request.getSession().getAttribute(key));
	}
	
	// Set Session 값
	public static void setSessionValue(HttpServletRequest request, String key, String val)
	{
		if (request == null) {
			return;
		}

		request.getSession(true).setAttribute(key, val);
	}
	
	// Session 무료화
	public static void sessionInvalidate(HttpServletRequest request)
	{
		request.getSession().invalidate();
	}
	
    // Check Login
    public static boolean checkNotLogin(HttpServletRequest request, String check, String state, String key1)
    {

        String login1 = getSessionValue(request,key1);
        String login2 = getSessionValue(request,state);
        logger.info("login1 : "+login1);
        logger.info("login2 : "+login2);
        boolean logined = false;
        
        if (login1=="" || login2=="" || !check.equals(login2)) {
            logined = true;
        }
        
        return logined;
        
    }
    
	
	// Check Login
	public static boolean checkSession(HttpServletRequest request, String key)
	{
		String login = getSessionValue(request,key);
		boolean logined = false;
		if (login=="") {
			logined = true;
		}
		return logined;
	}
	
    /**
     * 두 지점간의 거리 계산
     * 
     * @param lat1 지점 1 위도
     * @param lon1 지점 1 경도 
     * @param lat2 지점 2 위도
     * @param lon2 지점 2 경도
     * @param unit 거리 표출단위 
     * @return
     */
    public static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
         
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
         
        if (unit == "kilometer") {
            dist = dist * 1.609344;
        } else if(unit == "meter"){
            dist = dist * 1609.344;
        } 
 
        return (dist);
    }
    
    // This function converts decimal degrees to radians
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }
     
    // This function converts radians to decimal degrees
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }
    

    //날짜 차이(기간)
    public static long diffOfDate(String begin, String end) throws Exception
    {
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

      Date beginDate = formatter.parse(begin);
      Date endDate = formatter.parse(end);
  
      long diff = endDate.getTime() - beginDate.getTime();
      long diffDays = diff / (24 * 60 * 60 * 1000);

      return diffDays;
    }    
    
    //json 데이타 Post 전송
    public static String jsonDataWithPost(String apiUrl,String data) throws IOException {
    	String ret = "";
    	logger.info("apiUrl="+apiUrl);
    	logger.info("data="+data);
    	    	
        URL obj = new URL(apiUrl);
        HttpURLConnection postConnection = (HttpURLConnection) obj.openConnection();
        postConnection.setRequestMethod("POST");
        postConnection.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        postConnection.setUseCaches(false);
        postConnection.setDoInput(true);        
        postConnection.setDoOutput(true);
        OutputStream os = postConnection.getOutputStream();
        os.write(data.getBytes());
        os.flush();
        os.close();
        int responseCode = postConnection.getResponseCode();
        logger.info("POST Response Code :  " + responseCode);
        logger.info("POST Response Message : " + postConnection.getResponseMessage());
        if (responseCode == HttpURLConnection.HTTP_CREATED || responseCode == HttpURLConnection.HTTP_OK ) { //success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                postConnection.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in .readLine()) != null) {
                response.append(inputLine);
            } in .close();
            
            ret = response.toString();
            //logger.info("ret="+ret);            
        } else {
        	ret = "{\"result\":-1}";
            //logger.info("POST NOT WORKED");
        }
        
    	return ret;
    }
    
    //json 데이타 Post 전송
    public static String jsonDataWithPost(String apiUrl,String data,String authorization) throws IOException {
    	String ret = "";
    	data = "[" + data + "]";
    	logger.info("apiUrl="+apiUrl);
    	logger.info("data="+data);
    	    	
        URL obj = new URL(apiUrl);
        HttpURLConnection postConnection = (HttpURLConnection) obj.openConnection();
        postConnection.setRequestMethod("POST");
        postConnection.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        if (!authorization.equals("")) {
        	postConnection.setRequestProperty("Authorization", authorization);
        	logger.info("authorization=" + authorization);
        }
        postConnection.setDoOutput(true);
        OutputStream os = postConnection.getOutputStream();
        os.write(data.getBytes());
        os.flush();
        os.close();
        int responseCode = postConnection.getResponseCode();
        logger.info("POST Response Code :  " + responseCode);
        logger.info("POST Response Message : " + postConnection.getResponseMessage());
        if (responseCode == HttpURLConnection.HTTP_CREATED || responseCode == HttpURLConnection.HTTP_OK ) { //success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                postConnection.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in .readLine()) != null) {
                response.append(inputLine);
            } in .close();
            
            ret = response.toString();
            //logger.info("ret="+ret);            
        } else {
        	ret = "{\"result\":-1}";
            //logger.info("POST NOT WORKED");
        }
        
    	return ret;
    }

    // 오늘날짜 반환 YYYY-MM-DD
    public static String getToday() {
    	Date date = new Date();
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        return f.format(date);
    }
    
    // 특정 날짜에 대하여 요일을 구함(일 ~ 토)
    public static String getDateDay(String date) {              
        String day = "" ;
         
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd") ;
        Date nDate = null;
		try {
			nDate = dateFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
        Calendar cal = Calendar.getInstance() ;
        cal.setTime(nDate);
         
        int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
         
        switch(dayNum){
            case 1:
                day = "일";
                break ;
            case 2:
                day = "월";
                break ;
            case 3:
                day = "화";
                break ;
            case 4:
                day = "수";
                break ;
            case 5:
                day = "목";
                break ;
            case 6:
                day = "금";
                break ;
            case 7:
                day = "토";
                break ;
        }
        
        return day ;
    }
    
    
    public static String getIp(HttpServletRequest request) {
    	String ip = request.getHeader("X-Forwarded-For");
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
 
        return ip;
    }
    
}
