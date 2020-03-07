package com.kh.circle.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.circle.entity.PayDto;

public interface PayDao {
	void insertReady(PayDto payDto);
	void insertSuccess(PayDto payDto);
	List<PayDto> getList();
	PayDto get(int no);
	void insertRevoke(PayDto payDto);
	int getQty1(String partner_user_id);
	Object getQty6(String partner_user_id);
	Object getQty12(String partner_user_id);
	void changeAuth(String partner_user_id, String item_name);
}
