package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.SettingMapper;

@Service("settingService")
public class SettingServiceImpl implements SettingService {
	
	@Autowired SettingMapper settingMapper;

	@Override
	public List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_list(map);
	}

	@Override
	public int admin_member_list_total(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_list_total(map);
	}
	
	@Override
	public Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_one(map);
	}

	@Override
	public int admin_member_insert(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_insert(map);
	}

	@Override
	public int admin_member_update(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_update(map);
	}

	@Override
	public List<Map<String, Object>> admin_member_pupoplist(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_pupoplist(map);
	}

	@Override
	public int admin_member_pupoplist_total(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_pupoplist_total(map);
	}

	@Override
	public Map<String, Object> admin_member_pupopone(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_pupopone(map);
	}

	@Override
	public int admin_member_pupopinsert(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_pupopinsert(map);
	}

	@Override
	public int admin_member_pupopupdate(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_pupopupdate(map);
	}

	@Override
	public List<Map<String, Object>> admin_member_productlist(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_productlist(map);
	}

	@Override
	public int admin_member_productlist_total(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_productlist_total(map);
	}

	@Override
	public Map<String, Object> admin_member_productone(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_productone(map);
	}

	@Override
	public int admin_member_productinsert(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_productinsert(map);
	}

	@Override
	public int admin_member_productupdate(Map<String, Object> map) throws SQLException {
		return settingMapper.admin_member_productupdate(map);
	}

	@Override
	public Map<Object, Object> selectCD() throws SQLException {
		return settingMapper.selectCD();
	}

	@Override
	public int aCntUpdate(Map<String, Object> map) throws SQLException {
		return settingMapper.aCntUpdate(map);
	}

	@Override
	public List<Map<String, Object>> getCloseDateList() throws SQLException {
		return settingMapper.getCloseDateList();
	}

	@Override
	public int idleDateInsert(Map<String, Object> map) throws SQLException {
		return settingMapper.idleDateInsert(map);
	}

	@Override
	public int idleDateDelete(String iDate) throws SQLException {
		return settingMapper.idleDateDelete(iDate);
	}

	@Override
	public Map<Object, Object> selectFacilitySetting() throws SQLException {
		return settingMapper.selectFacilitySetting();
	}

	@Override
	public int fSettingInsert(Map<String, Object> map) throws SQLException {
		return settingMapper.fSettingInsert(map);
	}

	@Override
	public Map<String, Object> admin_member_productLastone(Map<String, Object> map) {
		return settingMapper.admin_member_productLastone(map);
	}

}
