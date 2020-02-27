package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberListVO {

	private String member_name; 
	private String member_position;
	private String member_auth;
	private String member_email;
	private String member_grade;
	private String member_no;

	private String topic_member_position;
	private int topic_no, team_no;

}
