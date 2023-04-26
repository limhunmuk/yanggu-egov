package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.go.yanggu.admin.mapper.RentalMapper;

@Service("rentalService")
public class RentalServiceImpl implements RentalService{
	
	@Autowired RentalMapper rentalMapper;

	@Override
	public List<Map<String, Object>> admin_rental_list(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_rental_list(map);
	}

	@Override
	public Map<String, Object> admin_rental_list_total(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_rental_list_total(map);
	}

	@Override
	public int admin_rental_update(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_rental_update(map);
	}

	@Override
	public List<Map<String, Object>> admin_experience_list(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_experience_list(map);
	}

	@Override
	public int admin_experience_list_total(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_experience_list_total(map);
	}

	@Override
	public List<Map<String, Object>> admin_experience_product_list(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_experience_product_list(map);
	}

	@Override
	public int insertDragonReserve(Map<String, Object> map) throws SQLException {
		return rentalMapper.insertDragonReserve(map);
	}

	@Override
	public Map<String, Object> checkDayClose(Map<String, Object> map) throws SQLException {
		return rentalMapper.checkDayClose(map);
	}

	@Override
	public Map<String, Object> selectMemberOne(Map<String, Object> map) throws SQLException {
		return rentalMapper.selectMemberOne(map);
	}

	@Override
	public int insertSmsList(Map<String, Object> map) throws SQLException {
		return rentalMapper.insertSmsList(map);
	}

	@Override
	public List<Map<String, Object>> admin_sms_list(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_sms_list(map);
	}

	@Override
	public Map<String, Object> admin_sms_list_total(Map<String, Object> map) throws SQLException {
		return rentalMapper.admin_sms_list_total(map);
	}

	@Override
	public Map<Object, Object> selectCD() throws SQLException {
		return rentalMapper.selectCD();
	}

	@Override
	public Map<Object, Object> selectFacilitySetting() throws SQLException {
		return rentalMapper.selectFacilitySetting();
	}

}
