package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.GalleryMapper;

@Service("galleryService")
public class GalleryServiceImpl implements GalleryService{

	@Autowired GalleryMapper galleryMapper;

	@Override
	public List<Map<String, Object>> selectGalleryList(Map<String, Object> map) throws SQLException {
		return galleryMapper.selectGalleryList(map);
	}

	@Override
	public int selectGalleryTotalCount(Map<String, Object> map) throws SQLException {
		return galleryMapper.selectGalleryTotalCount(map);
	}

	@Override
	public Map<String, Object> selectGalleryOne(Map<String, Object> map) throws SQLException {
		return galleryMapper.selectGalleryOne(map);
	}

	@Override
	public int insertGallery(Map<String, Object> map) throws SQLException {
		return galleryMapper.insertGallery(map);
	}

	@Override
	public int updateGallery(Map<String, Object> map) throws SQLException {
		return galleryMapper.updateGallery(map);
	}

	@Override
	public int deleteGallery(Map<String, Object> map) throws SQLException {
		return galleryMapper.deleteGallery(map);
	}
	
}
