package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface ManageService {
	List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException;
	int admin_member_list_total(Map<String, Object> map) throws SQLException;
	Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException;
	int admin_member_insert(Map<String, Object> map) throws SQLException;
	int admin_member_update(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> admin_menu_top_list(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> admin_menu_list(Map<String, Object> map) throws SQLException;
	int admin_menu_list_total(Map<String, Object> map) throws SQLException;

	List<Map<String, Object>> getMenuList(Map<String, Object> map) throws SQLException;
	int admin_menu_insert(Map<String, Object> map) throws SQLException;
	int admin_menu_update(Map<String, Object> map) throws SQLException;
}
