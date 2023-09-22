package kr.go.yanggu.admin.dao;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class MenuListDto {
    public Long seq;
    public String groupNm;
    public String codeNm;
    public String parent;
    public String title;
    public String keyword;
    public String targetType;
    public String level;
    public String sort;

    public List<MenuListDto> firstMenuListDto;
}
