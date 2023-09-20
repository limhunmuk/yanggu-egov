package kr.go.yanggu.admin.service;

import kr.go.yanggu.admin.mapper.ManageMapper;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service("manageService")
public class ManageServiceImpl implements ManageService {
	
    private final ManageMapper manageMapper;

	public ManageServiceImpl(ManageMapper manageMapper) {
		this.manageMapper = manageMapper;
	}

	@Override
	public List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_list(map);
	}

	@Override
	public int admin_member_list_total(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_list_total(map);
	}

	@Override
	public Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_one(map);
	}

	@Override
	public int admin_member_insert(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_insert(map);
	}

	@Override
	public int admin_member_update(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_update(map);
	}
	

}
