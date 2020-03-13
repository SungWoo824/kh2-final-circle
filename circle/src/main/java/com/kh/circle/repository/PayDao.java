package com.kh.circle.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.circle.entity.PayCountDto;
import com.kh.circle.entity.PayDto;

public interface PayDao {
	void insertReady(PayDto payDto);
	void insertSuccess(PayDto payDto);
	List<PayDto> list(String member_email);
	PayDto get(int no);
	void insertRevoke(PayDto payDto);
	int getQty1(String partner_user_id);
	Object getQty6(String partner_user_id);
	Object getQty12(String partner_user_id);
	List<PayCountDto> getCountList(String user_id);
	void insertPayCount(int one_month, int six_month, int one_year, String user_id);
	void updatePayCount(int one_month, int six_month, int one_year, String user_id);
	void changeAuth1(String user_id);
	void changeAuth6(String user_id);
	void changeAuth12(String user_id);
	int oneMonth(String user_id);
	int sixMonth(String user_id);
	int oneYear(String user_id);
	void changeStatus(int no);
	void upadteUsed(String partner_user_id, String item_name);
	String checkUsed(String partner_user_id, String item_name);
	
}
