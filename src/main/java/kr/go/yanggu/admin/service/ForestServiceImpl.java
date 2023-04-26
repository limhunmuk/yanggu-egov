package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.ForestMapper;

@Service("forestService")
public class ForestServiceImpl implements ForestService {
	
	@Autowired ForestMapper forestMapper;

	@Override
	public int selectForestListTotal(Map<String, Object> map) throws SQLException {
		return forestMapper.selectForestListTotal(map);
	}

	@Override
	public List<Map<String, Object>> selectForestList(Map<String, Object> map) throws SQLException {
		return forestMapper.selectForestList(map);
	}
	
	@Override
	public int admin_forest_update(Map<String, Object> map) throws SQLException {
		return forestMapper.admin_forest_update(map);
	}
	
	@Override
	public Map<String, Object> selectForestOne(Map<String, Object> map) throws SQLException {
		return forestMapper.selectForestOne(map);
	}
	
	@Override
	public int iDateForestInsert(Map<String, Object> map) throws SQLException {
		return forestMapper.iDateForestInsert(map);
	}
	
	@Override
	public List<Map<String, Object>> getCloseDateList(Map<String, Object> map) throws SQLException {
		return forestMapper.getCloseDateList(map);
	}
	
	@Override
	public int iDateDelete(Map<String, Object> map) throws SQLException {
		return forestMapper.iDateDelete(map);
	}
	
	@Override
	public int getCloseDateCount(Map<String, Object> map) throws SQLException {
		return forestMapper.getCloseDateCount(map);
	}
	
	@Override
	public int settingForestInsert(Map<String, Object> map) throws SQLException {
		return forestMapper.settingForestInsert(map);
	}
	
	@Override
	public Map<String, Object> getOpenDate(Map<String, Object> map) throws SQLException {
		return forestMapper.getOpenDate(map);
	}
}
