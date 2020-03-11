package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardVo {
	private String type;
	private String value;
	private int startIndex;
	private int countPerPage;
	private int team_no;
	private int member_no;
	@Builder.Default//빌더가 있을 때 기본값을 다른 값으로 대체하기 위한 주석
	private String drive_name = "";
}
