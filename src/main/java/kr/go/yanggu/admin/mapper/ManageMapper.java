package kr.go.yanggu.admin.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

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
	
}
