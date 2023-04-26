package kr.go.yanggu.home.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homeMainMapper")
public interface HomeMainMapper {
	
	Map<String, Object> login(Map<String, Object> map) throws SQLException;

	int loginFaild(Map<String, Object> map) throws SQLException;

	int loginSuccess(Map<String, Object> map) throws SQLException;

	Map<String, Object> selectReservation(Map<String, Object> map);

	int cancelDragonReserve(Map<String, Object> map) throws SQLException;
	
	int cancelForestReserve(Map<String, Object> map) throws SQLException;

	List<Map<String,Object>> selectMainNotice();

	List<Map<String,Object>> selectMainGallery();

	List<Map<String,Object>> selectPopupList();
	
	Map<String, Object> selectReservationForest(Map<String, Object> map) throws SQLException;
}
