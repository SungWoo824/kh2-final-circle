package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class PayCountDto {
	String member_email, term;
	int total_count;
}
