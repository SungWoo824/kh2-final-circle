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
}
