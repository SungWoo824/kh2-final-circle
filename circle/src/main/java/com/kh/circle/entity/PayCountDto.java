package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class PayCountDto {
	int one_month, six_month, one_year;
	String user_id;
}
