package kr.go.yanggu.admin.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.go.yanggu.admin.dao.MenuListDto;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper("manageMapper")
public interface ManageMapper {

	public List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException;

	public int admin_member_list_total(Map<String, Object> map) throws SQLException;

	public Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException;

	public int admin_member_insert(Map<String, Object> map) throws SQLException;

	public int admin_member_update(Map<String, Object> map) throws SQLException;

	public List<Map<String, Object>> admin_menu_top_list(Map<String, Object> map) throws SQLException;

	public List<Map<String, Object>> admin_menu_bottom_list(String parent) throws SQLException;
	public List<Map<String, Object>> admin_menu_list(Map<String, Object> map) throws SQLException;

	public int admin_menu_list_total(Map<String, Object> map) throws SQLException;
	public int admin_menu_first_save(Map<String, Object> map) throws SQLException;
	public int admin_menu_second_save(Map<String, Object> map) throws SQLException;
	public int admin_menu_third_save(Map<String, Object> map) throws SQLException;

	int admin_menu_first_update(Map<String, Object> map) throws SQLException;
}
