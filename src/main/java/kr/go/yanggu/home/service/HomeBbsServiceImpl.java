/**FILEDESC
공통:게시판 Service Implements
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.home.mapper.HomeBbsMapper;



@Service("homeBbsService")
public class HomeBbsServiceImpl implements HomeBbsService {
    
    @Autowired HomeBbsMapper homeBbsMapper;

	@Override
	public int selectNoticeTotal(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectNoticeTotal(map);
	}

	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectNoticeList(map);
	}

	@Override
	public Map<String, Object> selectNoticeOne(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectNoticeOne(map);
	}

	@Override
	public int updateNoticeReadCnt(Map<String, Object> map) {
		return homeBbsMapper.updateNoticeReadCnt(map);
	}

	@Override
	public List<Map<String, Object>> selectGalleryList(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectGalleryList(map);
	}

	@Override
	public int selectGalleryTotal(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectGalleryTotal(map);
	}

	@Override
	public Map<String, Object> selectGalleryOne(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectGalleryOne(map);
	}

	@Override
	public int updateGalleryReadCnt(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.updateGalleryReadCnt(map);
	}

	@Override
	public int insertQna(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.insertQna(map);
	}

	@Override
	public int selectFaqTotal(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectFaqTotal(map);
	}

	@Override
	public List<Map<String, Object>> selectFaqList(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectFaqList(map);
	}

	@Override
	public Map<String, Object> selectFaqOne(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.selectFaqOne(map);
	}

	@Override
	public int updateFaqReadCnt(Map<String, Object> map) throws SQLException {
		return homeBbsMapper.updateFaqReadCnt(map);
	}
	
}
