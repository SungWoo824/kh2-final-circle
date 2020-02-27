package com.kh.circle.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PayDto {
	private int no, quantity, total_amount, term, price;
	private String tid, cid, approved_time, partner_order_id, partner_user_id, item_name, status, aid;
	private int countAll;
	
}
