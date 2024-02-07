package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.AdminMenu;
 
@Repository("adminDAO")
public class AdminMenuDAO extends AbstractDAO{

	
	/** 
	 * @param adminMenu
	 * @return List<AdminMenu>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AdminMenu> selectMenu(AdminMenu adminMenu) throws Exception{
	    return (List<AdminMenu>)selectList("adminMenu.selectMenu", adminMenu);
	}
	
	/** 
	 * @param adminMenu
	 * @return List<AdminMenu>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AdminMenu> selectMenuList(AdminMenu adminMenu) throws Exception{
	    return (List<AdminMenu>)selectList("adminMenu.selectMenu", adminMenu);
	}
	
	/** 
	 * @param adminMenu
	 * @return AdminMenu
	 * @throws Exception
	 */
	public AdminMenu selectMenuDetail(AdminMenu adminMenu) throws Exception{
	    return (AdminMenu) selectOne("adminMenu.selectMenuDetail", adminMenu);
	}
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	public int insertMenu(AdminMenu adminMenu) throws Exception{
	    return (int) insert("adminMenu.insertMenu", adminMenu);
	}
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	public int updateMenuSort(AdminMenu adminMenu) throws Exception{
		return (int) update("adminMenu.updateMenuSort", adminMenu);
	}

	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	public int updateMenu(AdminMenu adminMenu) throws Exception{
		return (int) update("adminMenu.updateMenu", adminMenu);
	}
	
	
	/** 
	 * @param adminMenu
	 * @return int
	 * @throws Exception
	 */
	public int deleteMenu(AdminMenu adminMenu) throws Exception{
		return (int) update("adminMenu.deleteMenu", adminMenu);
	}
	
}