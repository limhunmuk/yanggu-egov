package kr.go.yanggu.home.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homeProgramMapper")
public interface HomeProgramMapper {

	int selectWoodworkingTotal(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selectWoodworkingList(Map<String, Object> map) throws SQLException;

	Map<String, Object> checkDayClose(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> checkDayCloseForest(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selectProductList(Map<String, Object> map) throws SQLException;
	
	int insertProduct(Map<String, Object> map) throws SQLException;
	
	int insertDragonReserve(Map<String, Object> map) throws SQLException;

	Map<String, Object> selectDragonReserve(Map<String, Object> map) throws SQLException;
	
	Map<Object, Object> selectCD() throws SQLException;
	
	Map<Object, Object> selectFacilitySetting() throws SQLException;
	
	int insertForestExperience(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectForestExperience(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectForestSetting(Map<String, Object> paramMap) throws SQLException;
	
	int getProgramEntryCount(Map<String, String> map);
}
