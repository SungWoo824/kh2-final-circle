package com.kh.circle.vo;

import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;

import lombok.Builder;

import lombok.Data;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class PayReadyVO {
	private String partner_order_id;
	private String partner_user_id;
	private String item_name;
	private int quantity;
	private int total_amount;
	private int vat_amount;
	private int tax_free_amount;
	private int term;
	private int price;
	
}

