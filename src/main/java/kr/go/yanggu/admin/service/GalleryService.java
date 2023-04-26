package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface GalleryService {
	
	List<Map<String, Object>> selectGalleryList(Map<String, Object> map) throws SQLException;
	int selectGalleryTotalCount(Map<String, Object> map) throws SQLException;
	Map<String, Object> selectGalleryOne(Map<String, Object> map) throws SQLException;
	int insertGallery(Map<String, Object> map) throws SQLException;
	int updateGallery(Map<String, Object> map) throws SQLException;
	int deleteGallery(Map<String, Object> map) throws SQLException;
}
