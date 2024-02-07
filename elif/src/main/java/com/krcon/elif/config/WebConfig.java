package com.krcon.elif.config;

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.krcon.elif.common.CustomMapArgumentResolver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{

	@Autowired
	AdminInterceptor adminInterceptor;
	
    
    /** 
     * @return CustomMapArgumentResolver
     */
    @Bean
    public CustomMapArgumentResolver customMapArgumentResolver() {
    	CustomMapArgumentResolver bean = new CustomMapArgumentResolver();
    		return bean;
    }
    
	
    /** 
     * @param argumentResolvers
     */
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		argumentResolvers.add(new CustomMapArgumentResolver());
	}
	
	
    /** 
     * @param registry
     */
    @Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns("/mgmt/*")
				.addPathPatterns("/mgmt/*/*")
				.addPathPatterns("/mgmt/*/*/*")
				.addPathPatterns("/mgmt/*/*/*/*")
				.excludePathPatterns("/mgmt/user/authsec")
				.excludePathPatterns("/mgmt/login")
				.excludePathPatterns("/mgmt/home")
				.excludePathPatterns("/mgmt/anon/*");
	}
    
    /** 
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
          .addResourceHandler("/resources/**")
          .addResourceLocations("/resources/");	
        registry
            .addResourceHandler("/upload/**")
            .addResourceLocations("/upload/");	
    }
	

    
    /** 
     * @param converters
     */
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        converters.add(escapingConverter());

    }

    
    /** 
     * @return HttpMessageConverter<?>
     */
    @Bean
    public HttpMessageConverter<?> escapingConverter() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.getFactory().setCharacterEscapes(new HTMLCharacterEscapes());
        
        MappingJackson2HttpMessageConverter escapingConverter =
                new MappingJackson2HttpMessageConverter();
        escapingConverter.setObjectMapper(objectMapper);
        return escapingConverter;
    }
    


/** 
 * @return FilterRegistrationBean<CustomXssEscapeServletFilter>
 */
//	@Bean
//    public FilterRegistrationBean<XssEscapeServletFilter> getFilterRegistraionBean() {
//    	FilterRegistrationBean<XssEscapeServletFilter> registraionBean = new FilterRegistrationBean<XssEscapeServletFilter>();
//    	registraionBean.setFilter(new XssEscapeServletFilter());
//    	registraionBean.setOrder(1);
//    	registraionBean.addUrlPatterns("/*");
//    	
//    	return registraionBean;
//    }
	
	@Bean
    public FilterRegistrationBean<CustomXssEscapeServletFilter> getFilterRegistraionBean() {
    	FilterRegistrationBean<CustomXssEscapeServletFilter> registraionBean = new FilterRegistrationBean<CustomXssEscapeServletFilter>();
    	registraionBean.setFilter(new CustomXssEscapeServletFilter());
    	registraionBean.setOrder(1);
    	registraionBean.addUrlPatterns("/*");
    	
    	return registraionBean;
    }
    
    /** 
     * @param registry
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*");
    }
}