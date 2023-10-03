package kr.go.yanggu.admin.service;

import kr.go.yanggu.admin.dao.MenuListDto;
import kr.go.yanggu.admin.mapper.ManageMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("manageService")
public class ManageServiceImpl implements ManageService {
	
    private final ManageMapper manageMapper;

	public ManageServiceImpl(ManageMapper manageMapper) {
		this.manageMapper = manageMapper;
	}

	@Override
	public List<Map<String, Object>> admin_member_list(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_list(map);
	}

	@Override
	public int admin_member_list_total(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_list_total(map);
	}

	@Override
	public Map<String, Object> admin_member_one(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_one(map);
	}

	@Override
	public int admin_member_insert(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_insert(map);
	}

	@Override
	public int admin_member_update(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_member_update(map);
	}

	@Override
	public List<Map<String, Object>> admin_menu_top_list(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_menu_list(map);
	}

	@Override
	public List<Map<String, Object>> admin_menu_list(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_menu_list(map);
	}

	@Override
	public int admin_menu_list_total(Map<String, Object> map) throws SQLException {
		return 0;
	}

	@Override
	public List<Map<String, Object>> getMenuList(Map<String, Object> map) throws SQLException {


		List<Map<String, Object>> topMenuList = manageMapper.admin_menu_top_list(map);
		topMenuList.forEach(System.out::println);

		System.out.println(" =============================== ");
		for (Map<String, Object> topMenu : topMenuList) {
			String parent = topMenu.get("seq").toString();
			//topMenu.setFirstMenuListDto(manageMapper.admin_menu_bottom_list(parent));

			List<Map<String, Object>> mapList = manageMapper.admin_menu_bottom_list(parent);
			topMenu.put("firstMenu", mapList);
			System.out.println("1depth size >>>>>>>>> maps2List.size() = " + mapList.size());
			for (Map<String, Object> firstMenu : mapList){
				System.out.println("bottomList.getSeq() = " + firstMenu.get("seq"));
				System.out.println("bottomList.getGroupNm() = " + firstMenu.get("groupNm"));
				System.out.println("bottomList.getCodeNm() = " + firstMenu.get("codeNm"));
				System.out.println("bottomList.getParent() = " + firstMenu.get("parent"));
				System.out.println("bottomList.getLevel() = " + firstMenu.get("level"));
				System.out.println("bottomList.getSort() = " + firstMenu.get("sort"));
				String parent2 = firstMenu.get("seq").toString();
				List<Map<String, Object>> maps2List = manageMapper.admin_menu_bottom_list(parent2);
				System.out.println("2depth size >>>>>>>>> maps2List.size() = " + maps2List.size());
				for (Map<String, Object> secondList : maps2List){
					System.out.println("bottomList.getSeq() = " + secondList.get("seq"));
					System.out.println("bottomList.getGroupNm() = " + secondList.get("groupNm"));
					System.out.println("bottomList.getCodeNm() = " + secondList.get("codeNm"));
					System.out.println("bottomList.getParent() = " + secondList.get("parent"));
					System.out.println("bottomList.getLevel() = " + secondList.get("level"));
					System.out.println("bottomList.getSort() = " + secondList.get("sort"));
				}
			}


		}
		return null;
	}

	@Override
	public int admin_menu_save(Map<String, Object> map) throws SQLException {

		String level = "";
		String gbn = "";
		String seq = "";
		String firstSeq = "";
		String secondSeq = "";

		int rtnSeq = 0;
		if(map.get("level") != null) level = map.get("level").toString();
		if(map.get("seq") != null) seq = map.get("seq").toString();
		if(map.get("firstSeq") != null) firstSeq = map.get("firstSeq").toString();
		if(map.get("secondSeq") != null) secondSeq = map.get("secondSeq").toString();
		if(map.get("gbn") != null) gbn = map.get("gbn").toString();

		// seq를 먼저 따질까, level을 먼저 따질까?
		// 대메뉴 등록
		if(!StringUtils.hasText(level) || level.equals("0")){

			if(StringUtils.hasText(gbn) && gbn.equals("ISR")){
				rtnSeq = manageMapper.admin_menu_first_save(map);
			}else {
				rtnSeq = manageMapper.admin_menu_first_update(map);
			}

		}

		// 중메뉴 등록
		if(StringUtils.hasText(level) && level.equals("1")){
			map.put("firstSeq", firstSeq);
			//rtnSeq = manageMapper.admin_menu_second_save(map);

			if(StringUtils.hasText(gbn) && gbn.equals("ISR")){
				rtnSeq = manageMapper.admin_menu_second_save(map);
			}else {
				rtnSeq = manageMapper.admin_menu_second_update(map);
			}
		}

		//소메뉴 등록
		if(StringUtils.hasText(level) && level.equals("2")){
			map.put("firstSeq", firstSeq);
			map.put("secondSeq", secondSeq);
			//rtnSeq = manageMapper.admin_menu_third_save(map);

			if(StringUtils.hasText(gbn) && gbn.equals("ISR")){
				rtnSeq = manageMapper.admin_menu_third_save(map);
			}else {
				rtnSeq = manageMapper.admin_menu_third_update(map);
			}
		}

		return rtnSeq;
	}

	@Override
	public int admin_menu_insert(Map<String, Object> map) throws SQLException {
		return 0;
	}

	@Override
	public int admin_menu_update(Map<String, Object> map) throws SQLException {
		return manageMapper.admin_menu_first_update(map);
	}

	@Override
	public int admin_menu_delete(Long seq) throws SQLException {
		return manageMapper.admin_menu_first_delete(seq);
	}
}
