package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.SiteMapper;

@Service("siteService")
public class SiteServiceImpl implements SiteService{

	@Autowired SiteMapper siteMapper;
	
	@Override
	public List<Map<String, Object>> selectList(Map<String, Object> map) throws SQLException {
		return siteMapper.selectList(map);
	}

	@Override
	public int selectTotalCount(Map<String, Object> map) throws SQLException {
		return siteMapper.selectTotalCount(map);
	}

	@Override
	public Map<String, Object> selectOne(Map<String, Object> map) throws SQLException {
		return siteMapper.selectOne(map);
	}

	@Override
	public int insert(Map<String, Object> map) throws SQLException {
		return siteMapper.insert(map);
	}

	@Override
	public int update(Map<String, Object> map) throws SQLException {
		return siteMapper.update(map);
	}

	@Override
	public int delete(Map<String, Object> map) throws SQLException {
		return siteMapper.delete(map);
	}

	@Override
	public List<Map<String, Object>> selectQnaList(Map<String, Object> map) throws SQLException {
		return siteMapper.selectQnaList(map);
	}

	@Override
	public int selectQnaTotalCount(Map<String, Object> map) throws SQLException {
		return siteMapper.selectQnaTotalCount(map);
	}

	@Override
	public Map<String, Object> selectQnaOne(Map<String, Object> map) throws SQLException {
		return siteMapper.selectQnaOne(map);
	}

	@Override
	public int insertQna(Map<String, Object> map) throws SQLException {
		return siteMapper.insertQna(map);
	}

	@Override
	public int updateQna(Map<String, Object> map) throws SQLException {
		return siteMapper.updateQna(map);
	}

	@Override
	public int deleteQna(Map<String, Object> map) throws SQLException {
		return siteMapper.deleteQna(map);
	}

	@Override
	public List<Map<String, Object>> selecEcologytList(Map<String, Object> map) throws SQLException {
		return siteMapper.selecEcologytList(map);
	}

	@Override
	public int selectEcologyTotalCount(Map<String, Object> map) throws SQLException {
		return siteMapper.selectEcologyTotalCount(map);
	}

	@Override
	public Map<String, Object> selectEcologyOne(Map<String, Object> map) throws SQLException {
		return siteMapper.selectEcologyOne(map);
	}

	@Override
	public int insertEcology(Map<String, Object> map) throws SQLException {
		return siteMapper.insertEcology(map);
	}

	@Override
	public int updateEcology(Map<String, Object> map) throws SQLException {
		return siteMapper.updateEcology(map);
	}

	@Override
	public int deleteEcology(Map<String, Object> map) throws SQLException {
		return siteMapper.deleteEcology(map);
	}

	@Override
	public List<Map<String, Object>> selecwoodworkingList(Map<String, Object> map) throws SQLException {
		return siteMapper.selecwoodworkingList(map);
	}

	@Override
	public int selectwoodworkingTotalCount(Map<String, Object> map) throws SQLException {
		return siteMapper.selectwoodworkingTotalCount(map);
	}

	@Override
	public Map<String, Object> selectwoodworkingOne(Map<String, Object> map) throws SQLException {
		return siteMapper.selectwoodworkingOne(map);
	}

	@Override
	public int insertwoodworking(Map<String, Object> map) throws SQLException {
		return siteMapper.insertwoodworking(map);
	}

	@Override
	public int updatewoodworking(Map<String, Object> map) throws SQLException {
		return siteMapper.updatewoodworking(map);
	}

	@Override
	public int deletewoodworking(Map<String, Object> map) throws SQLException {
		return siteMapper.deletewoodworking(map);
	}

	@Override
	public List<Map<String, Object>> selectFaqList(Map<String, Object> map) throws SQLException {
		return siteMapper.selectFaqList(map);
	}
	
	@Override
	public int selectFaqTotalCount(Map<String, Object> map) throws SQLException {
		return siteMapper.selectFaqTotalCount(map);
	}

	@Override
	public Map<String, Object> selectFaq(Map<String, Object> map) throws SQLException {
		return siteMapper.selectFaq(map);
	}

	@Override
	public int inserFaq(Map<String, Object> map) throws SQLException {
		return siteMapper.inserFaq(map);
	}

	@Override
	public int updateFaq(Map<String, Object> map) throws SQLException {
		return siteMapper.updateFaq(map);
	}

	@Override
	public int deleteFaq(Map<String, Object> map) throws SQLException {
		return siteMapper.deleteFaq(map);
	}

}
