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
	int getQty6(String partner_user_id);
	int getQty12(String partner_user_id);
	void insertCount(Object object, String term, int total_count);
	List<Object> totalCount(String term);
	int countAll(String status, String item_name);
}
