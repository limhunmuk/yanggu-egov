/**FILEDESC
공통:게시판 Service
*/
package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface AdminService {

	Map<String, Object> login(Map<String, Object> map) throws SQLException;

	int loginFaild(Map<String, Object> map) throws SQLException;

	int loginSuccess(Map<String, Object> map) throws SQLException;
	
	
	List<Map<String, Object>> selectTopNoticeList(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectRentalOne(Map<String, Object> map) throws SQLException;
}
