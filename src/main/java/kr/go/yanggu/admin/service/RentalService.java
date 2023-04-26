package kr.go.yanggu.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface RentalService {
	List<Map<String, Object>> admin_rental_list(Map<String, Object> map) throws SQLException;
	Map<String, Object> admin_rental_list_total(Map<String, Object> map) throws SQLException;
	int admin_rental_update(Map<String, Object> map) throws SQLException;
	
	List<Map<String, Object>> admin_experience_list(Map<String, Object> map) throws SQLException;
	int admin_experience_list_total(Map<String, Object> map) throws SQLException;
	List<Map<String, Object>> admin_experience_product_list(Map<String, Object> map) throws SQLException;

	int insertDragonReserve(Map<String, Object> map) throws SQLException;

	Map<String, Object> checkDayClose(Map<String, Object> map) throws SQLException;

	Map<String, Object> selectMemberOne(Map<String, Object> map) throws SQLException;

	int insertSmsList(Map<String, Object> map) throws SQLException;
	

	List<Map<String, Object>> admin_sms_list(Map<String, Object> map) throws SQLException;
	Map<String, Object> admin_sms_list_total(Map<String, Object> map) throws SQLException;

	Map<Object, Object> selectCD() throws SQLException;

	Map<Object, Object> selectFacilitySetting() throws SQLException;
}
