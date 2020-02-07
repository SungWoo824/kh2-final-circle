package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteCategoryDto {
	String vote_category_content;
	int vote_category_no, vote_create_no;
}
