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

}
