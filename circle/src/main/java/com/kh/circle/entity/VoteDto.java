package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteDto {
	String vote_create_title, vote_create_detail, vote_create_anonymous, vote_create_plural, vote_create_status, vote_create_date;
	int vote_create_no;
}
