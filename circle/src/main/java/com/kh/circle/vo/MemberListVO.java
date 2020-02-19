package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberListVO {
	private String member_auth, member_grade, member_name;
	private String member_position, topic_member_position, member_email;
	private int topic_no, team_no, member_no;

}
