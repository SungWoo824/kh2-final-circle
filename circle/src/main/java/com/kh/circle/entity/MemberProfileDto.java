package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberProfileDto {
	private int member_profile_no;
	private int member_no;
	private String member_profile_uploadname;
	private long member_profile_filesize;
}
