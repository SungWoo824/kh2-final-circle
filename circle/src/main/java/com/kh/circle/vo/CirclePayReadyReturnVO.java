package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor 
public class CirclePayReadyReturnVO implements PayReadyReturnVO{
	private String tid;
	private String next_redirect_app_url;
	private String next_redirect_mobile_url;
	private String next_redirect_pc_url;
	private String created_at;
	
}
