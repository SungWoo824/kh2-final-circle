package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ChatSearchDto {
	String member_name, chat_time, chat_content, topic_name, keyword;
	int member_no, team_no, term;
}
