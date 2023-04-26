package kr.go.yanggu.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("forestMapper")
public interface ForestMapper {

	List<Map<String, Object>> selectForestList(Map<String, Object> map) throws SQLException;
	
	int selectForestListTotal(Map<String, Object> map) throws SQLException;
	
	int admin_forest_update(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectForestOne(Map<String, Object> map) throws SQLException;
	
	int iDateForestInsert(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> getCloseDateList(Map<String, Object> map) throws SQLException;
	
	int iDateDelete(Map<String, Object> map) throws SQLException;
	
	int getCloseDateCount(Map<String, Object> map) throws SQLException;
	
	int settingForestInsert(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> getOpenDate(Map<String, Object> map) throws SQLException;
}
