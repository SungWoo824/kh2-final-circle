package com.kh.circle.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.PayDto;

public class PayDaoImpl implements PayDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertReady(PayDto payDto) {
		sqlSession.insert("pay.ready", payDto);
	}

	@Override
	public void insertSuccess(PayDto payDto) {
		sqlSession.insert("pay.success", payDto);
		
	}

	@Override
	public List<PayDto> getList() {
		return sqlSession.selectList("pay.list");
	}

	@Override
	public PayDto get(int no) {
		
		return sqlSession.selectOne("pay.get", no);
	}

	@Override
	public void insertRevoke(PayDto payDto) {
		sqlSession.insert("pay.revoke", payDto);
	}

	@Override
	public int getQty1(String partner_user_id) {
		int complete = sqlSession.selectOne("pay.planQty1", partner_user_id);
		int cancel = sqlSession.selectOne("pay.cancelQty1", partner_user_id);
		
		int total = complete-cancel;
		return total;
	}

	@Override
	public int getQty6(String partner_user_id) {
		int complete = sqlSession.selectOne("pay.planQty6", partner_user_id);
		int cancel = sqlSession.selectOne("pay.cancelQty6", partner_user_id);
		
		int total = complete-cancel;
		return total;
	}

	@Override
	public int getQty12(String partner_user_id) {
		int complete = sqlSession.selectOne("pay.planQty12", partner_user_id);
		int cancel = sqlSession.selectOne("pay.cancelQty12", partner_user_id);
		
		int total = complete-cancel;
		return total;
	}
}
