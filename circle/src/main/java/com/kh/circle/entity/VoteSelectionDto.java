package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder @Data @AllArgsConstructor @NoArgsConstructor
public class VoteSelectionDto {
	String vote_category_content, vote_select_true, member_name;
	int vote_create_no, member_no;
}
