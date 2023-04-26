/**FILEDESC
공통:게시판 Service
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface HomePlantService {

	List<Map<String, Object>> selectBotanicalList(Map<String, Object> map) throws SQLException;
	
	int selectecologyTotal(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> selectecologyList(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectecologyOne(Map<String, Object> map) throws SQLException;
	int updatecologyReadCnt(Map<String, Object> map) throws SQLException;
	
}
