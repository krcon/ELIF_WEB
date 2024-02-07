package com.krcon.elif.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krcon.elif.dao.AdminMenuDAO;
import com.krcon.elif.vo.AdminMenu;

@Configuration
@PropertySource("classpath:system.properties")

@Service("adminService")
public class AdminMenuServiceImpl implements AdminMenuService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.mail.address}")
    private String mailFrom;
	
	@Autowired
    public JavaMailSender mailSender;
	
    @Resource(name="adminDAO")
    private AdminMenuDAO adminDao;

    
	/** 
	 * @param adminMenu
	 * @return List<AdminMenu>
	 * @throws Exception
	 */
	public List<AdminMenu> selectMenu(AdminMenu adminMenu) throws Exception {
        return adminDao.selectMenu(adminMenu);
    }
    
    
	/** 
	 * @param adminMenu
	 * @return List<AdminMenu>
	 * @throws Exception
	 */
	public List<AdminMenu> selectMenuList(AdminMenu adminMenu) throws Exception {
        return adminDao.selectMenuList(adminMenu);
    }
    
	/** 
	 * @param adminMenu
	 * @return AdminMenu
	 * @throws Exception
	 */
	public AdminMenu selectMenuDetail(AdminMenu adminMenu) throws Exception {
        return adminDao.selectMenuDetail(adminMenu);
    }

	
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int insertMenu(AdminMenu adminMenu) throws Exception {
	    return adminDao.insertMenu(adminMenu);
	}

	
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMenu(AdminMenu adminMenu) throws Exception {
	    return adminDao.updateMenu(adminMenu);
	}
	
	
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMenuSort(AdminMenu adminMenu) throws Exception{
	    return adminDao.updateMenuSort(adminMenu);
	}	
	
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int deleteMenu(AdminMenu adminMenu) throws Exception{
	    return adminDao.deleteMenu(adminMenu);
	}
	
}	
