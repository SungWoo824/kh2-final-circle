package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TopicMemberDto {

	private int topic_no, member_no, team_no;
	private String topic_member_position;

}
