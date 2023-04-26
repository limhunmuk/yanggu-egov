package kr.go.yanggu.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("sttingMapper")
public interface SettingMapper {

	List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException;
	
	int admin_member_list_total(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException;
	
	int admin_member_insert(Map<String, Object> map) throws SQLException;
	
	int admin_member_update(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> admin_member_pupoplist(Map<String, Object> map) throws SQLException;
	
	int admin_member_pupoplist_total(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> admin_member_pupopone(Map<String, Object> map) throws SQLException;
	
	int admin_member_pupopinsert(Map<String, Object> map) throws SQLException;
	
	int admin_member_pupopupdate(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> admin_member_productlist(Map<String, Object> map) throws SQLException;
	
	int admin_member_productlist_total(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> admin_member_productone(Map<String, Object> map) throws SQLException;
	
	int admin_member_productinsert(Map<String, Object> map) throws SQLException;
	
	int admin_member_productupdate(Map<String, Object> map) throws SQLException;
	
	Map<Object, Object> selectCD() throws SQLException;
	
	int aCntUpdate(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> getCloseDateList() throws SQLException;
	
	int idleDateInsert(Map<String, Object> map) throws SQLException;
	
	int idleDateDelete(String iDate) throws SQLException;
	
	Map<Object, Object> selectFacilitySetting() throws SQLException;
	
	int fSettingInsert(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> admin_member_productLastone(Map<String, Object> map);
}
