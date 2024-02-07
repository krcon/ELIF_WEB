package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.AdminMenu;
public interface AdminMenuService {
	List<AdminMenu> selectMenu(AdminMenu adminMenu) throws Exception;
	List<AdminMenu> selectMenuList(AdminMenu adminMenu) throws Exception;
    AdminMenu selectMenuDetail(AdminMenu adminMenu) throws Exception;
    int insertMenu(AdminMenu adminMenu) throws Exception;
    int updateMenu(AdminMenu adminMenu) throws Exception;
    int updateMenuSort(AdminMenu adminMenu) throws Exception;
    int deleteMenu(AdminMenu adminMenu) throws Exception;
}