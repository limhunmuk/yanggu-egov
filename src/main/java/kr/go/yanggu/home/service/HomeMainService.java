/**FILEDESC
공통:게시판 Service
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface HomeMainService {

	Map<String, Object> login(Map<String, Object> map) throws SQLException;

	int loginFaild(Map<String, Object> map) throws SQLException;

	int loginSuccess(Map<String, Object> map) throws SQLException;

	Map<String, Object> selectReservation(Map<String, Object> map) throws SQLException;

	int cancelDragonReserve(Map<String, Object> map) throws SQLException;

	public List<Map<String,Object>> selectMainNotice() throws SQLException;

	public List<Map<String,Object>> selectMainGallery() throws SQLException;
	
	public List<Map<String,Object>> selectPopupList() throws SQLException;

	Map<String, Object> selectReservationForest(Map<String, Object> map) throws SQLException;

	int cancelForestReserve(Map<String, Object> paramMap) throws SQLException;

	
}
