package kr.go.yanggu.file.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.go.yanggu.util.Utils;


@Controller
@RequestMapping("/file")
public class FileController {
	private static Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@RequestMapping(value = "/uploadForEditor", method = RequestMethod.POST)
    public String fileUpload(HttpServletRequest request, @RequestParam("Filedata") MultipartFile file) {
       
        String callback = request.getParameter("callback");
        String callback_func = request.getParameter("callback_func");
        String params = "";
        try {
            String upDir = Utils.getDocumentRoot(request)+"uploads/se2/";
            File uploadDir = new File(upDir);
            if (!uploadDir.exists())
                uploadDir.mkdir();
            
            String fileOrgName = file.getOriginalFilename();
            String ext = fileOrgName.substring(fileOrgName.lastIndexOf("."));
            String tempName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + ext;
            tempName = Utils.getUniqueFileName(upDir, tempName);
            String filepath = upDir + tempName;
            File f = new File(filepath);
            file.transferTo(f);

            params += "&bNewLine=true";
            params += "&sFileName=" + tempName;
            params += "&sFileURL=" + request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/uploads/se2/" + tempName;
            System.out.println("========");
            System.out.println(filepath);
            System.out.println(request.getRequestURL().toString().replace(request.getRequestURI(), ""));
            System.out.println(callback);
            System.out.println(callback_func);
            System.out.println(params);
        } catch(IOException e) {

            String fileParamName = file.getOriginalFilename();
            
            params = "&errstr="+fileParamName;
        }
        
        return "redirect:" + callback + "?callback_func=" + callback_func + params;
    }
       
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> fileUpload (HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String fileParamName = "";
        
        // 전달 받은 Request값을 MultipartHttpServletRequest로 바인딩 시킨다.
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        
        String src = (String) request.getParameter("file_src");
        Iterator<String> it = multipartRequest.getFileNames();
    	
    	ObjectMapper mapper = new ObjectMapper();
    	Map<String, Object> jsonObject = new HashMap<String, Object>();
    	String json = "";
    	String fileTemp="";
        
    	String ext = it.toString().substring(it.toString().lastIndexOf(".")+1,it.toString().length());
    	boolean chext = badFileExtIsReturnBoolean(ext);
    	if(chext) {
    		jsonObject.put("result", -2); //불량확장자 표시
    	}else {
	        if (it.hasNext()) {
	            fileParamName = (String) it.next();
	        }
	
	        // 전달 받은 Request값을 MultipartHttpServletRequest로 바인딩 시킨다.
	        MultipartFile file = multipartRequest.getFile(fileParamName);
	        String uploadDir="";
	        
	        try {
	            /* 이름만 넘어오는 경우 체크 */
	            if (file.getSize() > 0) {
	                uploadDir =  Utils.getDocumentRoot(request) + "uploads";

	                File dir = new File(uploadDir);
	                if (!dir.exists()) {
	                    dir.mkdir();
	                }
	                
	                if (Utils.getDocumentRoot(request).indexOf("/")>=0) {
	                	uploadDir += "/" + src + "/";
	                } else {
	                	uploadDir += "\\" + src + "\\";
	                }
	                
	                dir = new File(uploadDir);
	                if (!dir.exists()) {
	                    dir.mkdir();
	                }
	                
	                String fileName = file.getOriginalFilename();
	                fileTemp = Utils.getSysFileName(fileName);
	                String filePath = uploadDir + fileTemp;
	
	                
	                java.io.File f = new java.io.File(filePath);
	                file.transferTo(f);
	                
	            }
	
	        } catch (Exception e) {
	            logger.error("insertFile : " + e.getMessage() );
	        }
	        
	    	jsonObject.put("result", 1);
	    	jsonObject.put("fileTemp", fileTemp);
	    	jsonObject.put("uploadDir", uploadDir);
    	}
        
    	response.setContentType("application/json; charset=UTF-8");
        try {
        	json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(jsonObject);
        	System.out.println(json);
			response.getWriter().print(json);
	        response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
        return null;
    }
    
    public boolean badFileExtIsReturnBoolean(String ext) {
        
        final String[] BAD_EXTENSION = { "jsp", "php", "asp", "html", "perl" };
 
        int len = BAD_EXTENSION.length;
        for (int i = 0; i < len; i++) {
            if (ext.equalsIgnoreCase(BAD_EXTENSION[i])) {
                return true; // 불량 확장자가 존재할때
            }
        }
        return false;
    }
    @RequestMapping(value = "/download")
    public void fileDownload(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
        String uploadDir="";

        String src = request.getParameter("src")==null?"":request.getParameter("src");
        String org = request.getParameter("org")==null?"":request.getParameter("org");
        String tmp = request.getParameter("tmp")==null?"":request.getParameter("tmp");
        
        uploadDir =  Utils.getDocumentRoot(request) + "uploads";
        
        if (Utils.getDocumentRoot(request).indexOf("/")>=0) {
        	uploadDir += "/" + src + "/";
        } else {
        	uploadDir += "\\" + src + "\\";
        }
		
		String path = uploadDir;
		
		
        
        String filename = org;		//원래 파일 이름(다운로드 받을 이름)
        String downname = tmp;		//저장된 임시 이름
        String realPath = "";		//경로와 파일이름을 합쳐서 실제 경로 생성
        if (filename == null || "".equals(filename)) {
            filename = downname;
        }
         
        try {
            String browser = request.getHeader("User-Agent"); 
            //파일 인코딩 
            if (browser.contains("MSIE") || browser.contains("Trident")
                    || browser.contains("Chrome")) {
                filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+","%20");
            } else {
                filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
            }
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        realPath = path +downname;
        System.out.println("111111111");
        System.out.println(realPath);
        
        File file1 = new File(realPath);
        if (!file1.exists()) {
        	 response.setCharacterEncoding("UTF-8"); 
	    	 response.setContentType("text/html; charset=UTF-8");
	    	 
	       	 PrintWriter out = response.getWriter();
	         out.println("<script>alert('파일이 존재하지 않습니다.'); history.back(); </script>");
	         out.flush();
	         out.close();
	         
            return ;
        }
         
        // 파일명 지정        
        response.setContentType("application/octer-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        OutputStream os = null;
        FileInputStream fis = null;
        PrintWriter out = null;
        try {
            os = response.getOutputStream();
            fis = new FileInputStream(realPath);
            int ncount = 0;
            byte[] bytes = new byte[512];
 
            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            
        } catch (Exception e) {
          	 response.setCharacterEncoding("UTF-8"); 
   	    	 response.setContentType("text/html; charset=UTF-8");
   	    	 
   	       	 out = response.getWriter();
   	         out.println("<script>alert('파일이 존재하지 않습니다.'); history.back(); </script>");
   	         out.flush();
   	         
        }finally {
        	if(fis != null) {
        		fis.close();
        	}
			if(os != null) {
				os.close();  		
			}
			if(out != null) {
				out.close();
			}
        }
	}
}
