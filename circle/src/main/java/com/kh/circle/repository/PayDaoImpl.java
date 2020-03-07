package com.kh.circle.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.PayCountDto;
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
		Object complete = sqlSession.selectOne("pay.planQty1", partner_user_id);
		Object cancel = sqlSession.selectOne("pay.cancelQty1", partner_user_id);
		
		if(complete==null & cancel==null) {
			int total=0;
	
			return total;
		}else if(complete!=null & cancel!=null){
			int total=(int)complete-(int)cancel;
	
			return total;
		}else if(complete!=null & cancel==null){
			int total=(int)complete;
			return total;
		}else {
			int total=0;
			return total;
		}
	}

	@Override
	public Object getQty6(String partner_user_id) {
		Object complete = sqlSession.selectOne("pay.planQty6", partner_user_id);
		Object cancel = sqlSession.selectOne("pay.cancelQty6", partner_user_id);
		if(complete==null & cancel==null) {
			int total=0;
	
			return total;
		}else if(complete!=null & cancel!=null){
			int total=(int)complete-(int)cancel;
			
			return total;
		}else if(complete!=null & cancel==null){
			int total=(int)complete;
			return total;
		}else {
			int total=0;
			return total;
		}
	}


	@Override
	public Object getQty12(String partner_user_id) {
		Object complete = sqlSession.selectOne("pay.planQty12", partner_user_id);
		Object cancel = sqlSession.selectOne("pay.cancelQty12", partner_user_id);
		if(complete==null & cancel==null) {
			int total=0;
	
			return total;
		}else if(complete!=null & cancel!=null){
			int total=(int)complete-(int)cancel;
	
			return total;
		}else if(complete!=null & cancel==null){
			int total=(int)complete;
			return total;
		}else {
			int total=0;
			return total;
		}
	}

	@Override
	public void changeAuth(String partner_user_id, String item_name) {
		PayDto payDto = PayDto.builder()
				.partner_user_id(partner_user_id)
				.item_name(item_name)
				.build();

		sqlSession.update("pay.changeAuth", payDto);
	}

	
}
