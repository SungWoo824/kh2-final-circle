package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatFileVo {
	private int chat_file_no,chat_no,topic_no,member_no,team_no;
	private String chat_file_uploadname,chat_file_type;
	private long chat_file_size;
}
