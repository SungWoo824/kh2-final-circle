package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TeamMainVO {
	private String team_name, team_domain,member_position,team_payment;
	private int team_no, member_no;
	

}
