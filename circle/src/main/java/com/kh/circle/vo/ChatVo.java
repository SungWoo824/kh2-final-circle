package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatVo {
	private int team_no;
	private int topic_no;
	private String chat_content;
	private int status;//0(enter), 1(exit), 2(message)
}
