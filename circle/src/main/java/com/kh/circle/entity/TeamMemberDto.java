package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TeamMemberDto {
	private int member_no;
	private int team_no;
	private String member_position;
	private String member_grade;

}
