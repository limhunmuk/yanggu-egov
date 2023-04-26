/**FILEDESC
공통:메일전송 ServiceImpl
*/
package kr.go.yanggu.mail.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl {
	private JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	
	@Autowired Environment mailConfig;
	
    private static Logger logger = LoggerFactory.getLogger(MailServiceImpl.class);
	
	@Async
	public void sendMail(Map<String, String> data, String type,HttpServletRequest request) throws IOException, MessagingException {

		/* ----- 설정 세팅 ----- */
		
        Properties prop = System.getProperties();        
        prop.put("mail.smtp.starttls.enable", mailConfig.getProperty("mail.smtp.starttls.enable"));
        prop.put("mail.smtp.auth", mailConfig.getProperty("mail.smtp.auth"));
        prop.put("mail.smtp.host", mailConfig.getProperty("mail.smtp.host"));
        prop.put("mail.smtp.port", mailConfig.getProperty("mail.smtp.port"));
        //String mailPath = mailConfig.getProperty("mail.path");
        //System.out.println("메일 패스"+mailPath);
        
        mailSender.setJavaMailProperties(prop);		
        mailSender.setUsername(mailConfig.getProperty("admin.email"));
		mailSender.setPassword(mailConfig.getProperty("admin.password"));
		logger.info("메일발송 값 : "+mailConfig.getProperty("admin.email"));
		logger.info("메일발송 값 : "+mailConfig.getProperty("admin.password"));
		
		String url = mailConfig.getProperty("btnUrl");
		
		MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

		/* ----- 설정 세팅 ----- */
		
        SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss.S");
        Date time = new Date();
        
        File input = null;
        Document doc = null;
        String[] iter = null;        
        
        messageHelper.setFrom("admin@yanggu.go.kr");	// 보내는사람 생략하거나 하면 정상작동을 안함
        if(type.equals("qna_confirm")) {
        	// 설정파일에 등록된 담당자의 이메일
	        messageHelper.setTo(mailConfig.getProperty("manager.email"));
	        logger.info(" 관리자 이메일 : "+mailConfig.getProperty("manager.email"));
        } else {
        	messageHelper.setTo(data.get("email"));     // 받는사람 이메일
        	logger.info(" 관리자 이메일2 : "+data.get("email"));
        }
         
        input = new File(request.getSession().getServletContext().getRealPath("/mailForm")+"/"+type+".html"); 
        logger.info(" 폼경로 : "+request.getSession().getServletContext().getRealPath("/mailForm")+"/"+type+".html");
        doc = Jsoup.parse(input, "UTF-8", url);
        
        logger.info("메일발송 시작");
        
        switch(type) {
        // QNA - from user / to manager
        case "qna_confirm" :
            logger.info("메일발송 정상");	        	
        	messageHelper.setSubject("Q&A 글이 등록되었습니다. 확인 부탁드립니다.");        	
        	data.put("date", sf2.format(time.getTime()));        	
	        iter = "#insertDate,#title,#content".split(",");
	        doc.select("#btn").attr("href", url);
        	break;
        	
        case "qna_confirm2" :
            logger.info("메일발송 정상");	        	
        	messageHelper.setSubject("Q&A 답변 등록되었습니다. 확인 부탁드립니다.");        	
        	data.put("date", sf2.format(time.getTime()));        	
	        iter = "#insertDate,#title,#content,#content2".split(",");
	        doc.select("#btn").attr("href", url);
        	break;
        }

        // src 속성이 있는 곳의 컨텍스트 주소 수정
        Elements elems = doc.select("[src]");
        for( Element elem : elems ){
        	if( !elem.attr("src").equals(elem.attr("abs:src")) ){
        		elem.attr("src", elem.attr("abs:src"));
        	}
        }
        
        mailSetting(doc, iter, data);
        messageHelper.setText(doc.html(), true); 
        try {
            mailSender.send(message);
        }catch (Exception e) {
        	logger.info("ERROR : "+e.getMessage());
		}
        logger.info("메일발송 끝 데이터 : "+data);
	}

	/* mailForm의 id와 key값을 맞추고 해당 key data가 없는 경우 display none 처리 */
	public void mailSetting(Document doc, String[] iter, Map<String, String> data) {	
		for (String s : iter) {
	        logger.info("메일발송 중 값 : "+s);
			if(s.split("")[0].equals("#")) {
				String s2 = s.replace("#", "");
				Element ele = doc.getElementById(s2);	
				if(data.get(s2) != null && !"".equals(data.get(s2))) {
					ele.html(data.get(s2));
				} else {			
					ele.parent().html("");
				}				
			} else if(s.split("")[0].equals(".")){
				String s2 = s.replace(".", "");
				Elements eles = doc.select(s);
				if(data.get(s2) != null && !"".equals(data.get(s2))) {
					eles.html(data.get(s2));
				} else {			
					eles.parents().html("");
				}
			}
		}	
	}
	
}
