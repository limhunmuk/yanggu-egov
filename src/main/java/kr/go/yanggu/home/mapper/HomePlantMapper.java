package kr.go.yanggu.home.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homePlantMapper")
public interface HomePlantMapper {
	
	List<Map<String, Object>> selectBotanicalList(Map<String, Object> map) throws SQLException ;

	int selectecologyTotal(Map<String, Object> map) throws SQLException ;

	List<Map<String, Object>> selectecologyList(Map<String, Object> map) throws SQLException ;

	Map<String, Object> selectecologyOne(Map<String, Object> map) throws SQLException ;

	int updatecologyReadCnt(Map<String, Object> map) throws SQLException ;
}
