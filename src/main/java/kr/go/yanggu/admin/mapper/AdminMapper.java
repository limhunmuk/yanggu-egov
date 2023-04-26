package kr.go.yanggu.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminMapper")
public interface AdminMapper {
	
	Map<String, Object> login(Map<String, Object> map) throws SQLException;
	
	int loginFaild(Map<String, Object> map) throws SQLException;
	
	int loginSuccess(Map<String, Object> map) throws SQLException;
	
	int lastLogin(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selectTopNoticeList(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectRentalOne(Map<String, Object> map) throws SQLException;
}
