package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CirclePaySuccessReturnVO {
	private String 
	aid,	
	tid,
	cid,
	sid,
	partner_order_id,
	partner_user_id,
	payment_method_type,
	item_name,
	item_code,
	created_at,
	approved_at,
	payload;
	private int quantity, total_amount;
	private PayAmountVO amount;
	private PaySuccessCardInfoVO card_info;
}
