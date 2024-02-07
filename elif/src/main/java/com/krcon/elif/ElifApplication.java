package com.krcon.elif;

import org.apache.catalina.Context;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@SpringBootApplication
@EnableScheduling
public class ElifApplication {
	
	/** 
	 * @param args
	 */
	public static void main(String[] args) {
		SpringApplication.run(ElifApplication.class, args);
	}
	/** 
	 * @return MappingJackson2JsonView
	 */
	@Bean
    MappingJackson2JsonView jsonView(){
        return new MappingJackson2JsonView();
    }

	//세션공유를 위해 web.xml 에 <distributable/> 설정해주는 부분 대체
	private static boolean distributable;
	public static boolean getDistributable() {
		return distributable;
	}
	@Bean
	public ServletWebServerFactory tomcatFactory() {
		return new TomcatServletWebServerFactory() {
			@Override
			protected void postProcessContext(Context context) {
				ElifApplication.distributable = context.getDistributable();
				System.out.println("distributable is :"+distributable);
			}
		};
	}

}
