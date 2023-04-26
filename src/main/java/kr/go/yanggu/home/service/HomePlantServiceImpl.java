/**FILEDESC
공통:게시판 Service Implements
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.home.mapper.HomePlantMapper;


@Service("homePlantService")
public class HomePlantServiceImpl implements HomePlantService {
    
    @Autowired HomePlantMapper homePlantMapper;

	@Override
	public List<Map<String, Object>> selectBotanicalList(Map<String, Object> map) throws SQLException {
		return homePlantMapper.selectBotanicalList(map);
	}

	@Override
	public int selectecologyTotal(Map<String, Object> map) throws SQLException {
		return homePlantMapper.selectecologyTotal(map);
	}

	@Override
	public List<Map<String, Object>> selectecologyList(Map<String, Object> map) throws SQLException {
		return homePlantMapper.selectecologyList(map);
	}

	@Override
	public Map<String, Object> selectecologyOne(Map<String, Object> map) throws SQLException {
		return homePlantMapper.selectecologyOne(map);
	}

	@Override
	public int updatecologyReadCnt(Map<String, Object> map) throws SQLException {
		return homePlantMapper.updatecologyReadCnt(map);
	}
	
}
