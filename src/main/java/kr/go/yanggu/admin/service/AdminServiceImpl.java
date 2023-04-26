/**FILEDESC
공통:게시판 Service Implements
*/
package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.AdminMapper;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Autowired AdminMapper adminMapper;

	@Override
	public Map<String, Object> login(Map<String, Object> map) throws SQLException {
		return adminMapper.login(map);
	}

	@Override
	public int loginFaild(Map<String, Object> map) throws SQLException {
		return adminMapper.loginFaild(map);
	}

	@Override
	public int loginSuccess(Map<String, Object> map) throws SQLException {
		adminMapper.lastLogin(map);
		return adminMapper.loginSuccess(map);
	}

	@Override
	public List<Map<String, Object>> selectTopNoticeList(Map<String, Object> map) throws SQLException {
		return adminMapper.selectTopNoticeList(map);
	}

	@Override
	public Map<String, Object> selectRentalOne(Map<String, Object> map) throws SQLException {
		return adminMapper.selectRentalOne(map);
	}

}
