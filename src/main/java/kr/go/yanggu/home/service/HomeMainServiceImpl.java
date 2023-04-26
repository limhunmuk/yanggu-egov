/**FILEDESC
공통:게시판 Service Implements
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.home.mapper.HomeMainMapper;


@Service("homeMainService")
public class HomeMainServiceImpl implements HomeMainService {
    
    @Autowired HomeMainMapper mainMapper;

	@Override
	public Map<String, Object> login(Map<String, Object> map) throws SQLException {
		 return mainMapper.login(map);
	}

	@Override
	public int loginFaild(Map<String, Object> map) throws SQLException {
		 return mainMapper.loginFaild(map);
	}

	@Override
	public int loginSuccess(Map<String, Object> map) throws SQLException {
		 return mainMapper.loginSuccess(map);
	}

	@Override
	public Map<String, Object> selectReservation(Map<String, Object> map) throws SQLException {
		return mainMapper.selectReservation(map);
	}

	@Override
	public int cancelDragonReserve(Map<String, Object> map) throws SQLException {
		 return mainMapper.cancelDragonReserve(map);
	}
	
	@Override
	public int cancelForestReserve(Map<String, Object> map) throws SQLException {
		return mainMapper.cancelForestReserve(map);
	}

	@Override
	public List<Map<String, Object>> selectMainNotice() throws SQLException {
		 return mainMapper.selectMainNotice();
	}

	@Override
	public List<Map<String, Object>> selectMainGallery() throws SQLException {
		 return mainMapper.selectMainGallery();
	}

	@Override
	public List<Map<String, Object>> selectPopupList() throws SQLException {
		 return mainMapper.selectPopupList();
	}
	
	@Override
	public Map<String, Object> selectReservationForest(Map<String, Object> map) throws SQLException {
		return mainMapper.selectReservationForest(map);
	}
}
