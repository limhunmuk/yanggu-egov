package kr.go.yanggu.admin.dao;

import lombok.Data;

@Data
public class SecondMenuListDto {
    public Long seq;
    public String groupNm;
    public String codeNm;
    public String parent;
    public String title;
    public String keyword;
    public String targetType;
    public String level;
    public String sort;
}
