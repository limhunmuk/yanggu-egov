/**FILEDESC
공통:메일 Config
*/
package kr.go.yanggu.mail.service;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource(value = "classpath:/egovframework/egovProps/production/environment.properties")
public class MailConfig {

}
