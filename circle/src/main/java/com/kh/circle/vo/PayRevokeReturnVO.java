package com.kh.circle.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PayRevokeReturnVO {
	private String aid, tid, cid, status;
	private String partner_order_id;
	private String partner_user_id;
	private String payment_method_type;
	//amount 보류
	private PayAmountVO amount;
	private PayAmountVO canceled_amount;
	//cancel_available_amount 보류
	private PayAmountVO cancel_available_amount;
	private String item_name, item_code;
	private int quantity, total_amount, price, term;
	private String created_at, approved_at, canceled_at;
	private String payload;
}
