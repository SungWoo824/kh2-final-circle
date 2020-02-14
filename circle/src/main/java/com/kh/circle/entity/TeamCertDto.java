package com.kh.circle.entity;

import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class TeamCertDto {
	
	private String cert_email,cert_no,when;


}
