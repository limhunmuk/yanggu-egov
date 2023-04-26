package kr.go.yanggu.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("siteMapper")
public interface SiteMapper {
	List<Map<String, Object>> selectList(Map<String, Object> map) throws SQLException;
	
	int selectTotalCount(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectOne(Map<String, Object> map) throws SQLException;
	
	int insert(Map<String, Object> map) throws SQLException;
	
	int update(Map<String, Object> map) throws SQLException;
	
	int delete(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selectQnaList(Map<String, Object> map) throws SQLException;
	
	int selectQnaTotalCount(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectQnaOne(Map<String, Object> map) throws SQLException;
	
	int insertQna(Map<String, Object> map) throws SQLException;
	
	int updateQna(Map<String, Object> map) throws SQLException;
	
	int deleteQna(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selecEcologytList(Map<String, Object> map) throws SQLException;
	
	int selectEcologyTotalCount(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectEcologyOne(Map<String, Object> map) throws SQLException;
	
	int insertEcology(Map<String, Object> map) throws SQLException;
	
	int updateEcology(Map<String, Object> map) throws SQLException;
	
	int deleteEcology(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selecwoodworkingList(Map<String, Object> map) throws SQLException;
	
	int selectwoodworkingTotalCount(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectwoodworkingOne(Map<String, Object> map) throws SQLException;
	
	int insertwoodworking(Map<String, Object> map) throws SQLException;
	
	int updatewoodworking(Map<String, Object> map) throws SQLException;
	
	int deletewoodworking(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> selectFaqList(Map<String, Object> map) throws SQLException;
	
	int selectFaqTotalCount(Map<String, Object> map) throws SQLException;
	
	Map<String, Object> selectFaq(Map<String, Object> map) throws SQLException;
	
	int inserFaq(Map<String, Object> map) throws SQLException;
	
	int updateFaq(Map<String, Object> map) throws SQLException;
	
	int deleteFaq(Map<String, Object> map) throws SQLException;
}
