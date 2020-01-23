package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberDto {
	private int member_no;
	private String member_email;
	private String member_pw;
	private String member_name;
	private String member_grade;
	
}
