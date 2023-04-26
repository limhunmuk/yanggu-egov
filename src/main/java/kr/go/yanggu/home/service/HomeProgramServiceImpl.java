/**FILEDESC
공통:게시판 Service Implements
*/
package kr.go.yanggu.home.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.SettingMapper;
import kr.go.yanggu.home.mapper.HomeProgramMapper;


@Service("homeProgramService")
public class HomeProgramServiceImpl implements HomeProgramService {
    
    @Autowired HomeProgramMapper homeProgramMapper;
    
    @Autowired SettingMapper settingMapper;

	@Override
	public int selectWoodworkingTotal(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.selectWoodworkingTotal(map);
	}

	@Override
	public List<Map<String, Object>> selectWoodworkingList(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.selectWoodworkingList(map);
	}

	@Override
	public Map<String, Object> checkDayClose(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.checkDayClose(map);
	}
	
	@Override
	public Map<String, Object> checkDayCloseForest(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.checkDayCloseForest(map);
	}

	@Override
	public List<Map<String, Object>> selectProductList(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.selectProductList(map);
	}
	
	@Override
	public int getProgramEntryCount(Map<String, String> map) {
		return homeProgramMapper.getProgramEntryCount(map);
	}

	@Override
	public int insertProduct(Map<String, Object> map) throws SQLException {
		//정원 체크
		int number = 0;
		Map<String, Object> product = settingMapper.admin_member_productone(map);
		
		JSONArray numberArr = new JSONArray(String.valueOf(product.get("number")));
		
		if(numberArr.length() > 0) {
			for(int i = 0; i < numberArr.length(); i++) {
				JSONObject jsonObj = numberArr.getJSONObject(i);
				
				String date = jsonObj.getString("date");

				if(String.valueOf(map.get("useDate")).equals(date)) {
					number = Integer.parseInt(jsonObj.getString("number"));
					break;
				}
			}
		}
		
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", String.valueOf(map.get("seq")));
		param.put("useDate", String.valueOf(map.get("useDate")));
		
		int entryCnt = homeProgramMapper.getProgramEntryCount(param);
		
		if(number <= (entryCnt + 1)) {
			return -2;
		}
		
		return homeProgramMapper.insertProduct(map);
	}

	@Override
	public int insertDragonReserve(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.insertDragonReserve(map);
	}

	@Override
	public Map<String, Object> selectDragonReserve(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.selectDragonReserve(map);
	}

	@Override
	public Map<Object, Object> selectCD() throws SQLException {
		return homeProgramMapper.selectCD();
	}

	@Override
	public Map<Object, Object> selectFacilitySetting() throws SQLException {
		return homeProgramMapper.selectFacilitySetting();
	}
	
	@Override
	public int insertForestExperience(Map<String, Object> paramMap) throws SQLException {
		return homeProgramMapper.insertForestExperience(paramMap);
	}
	
	@Override
	public Map<String, Object> selectForestExperience(Map<String, Object> map) throws SQLException {
		return homeProgramMapper.selectForestExperience(map);
	}
	
	@Override
	public Map<String, Object> selectForestSetting(Map<String, Object> paramMap) throws SQLException {
		return homeProgramMapper.selectForestSetting(paramMap);
	}
}
