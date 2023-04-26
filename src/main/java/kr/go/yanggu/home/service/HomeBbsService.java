/**FILEDESC
공통:게시판 Service
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface HomeBbsService {

	int selectNoticeTotal(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectNoticeOne(Map<String, Object> map) throws SQLException;
	int updateNoticeReadCnt(Map<String, Object> map);
	
	List<Map<String, Object>> selectGalleryList(Map<String, Object> map) throws SQLException;
	int selectGalleryTotal(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectGalleryOne(Map<String, Object> map) throws SQLException;
	int updateGalleryReadCnt(Map<String, Object> map) throws SQLException;
	int insertQna(Map<String, Object> map) throws SQLException;
	
	int selectFaqTotal(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> selectFaqList(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectFaqOne(Map<String, Object> map) throws SQLException;
	int updateFaqReadCnt(Map<String, Object> map) throws SQLException;
	
}
