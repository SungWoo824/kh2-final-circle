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
	public List<PayDto> list(String member_email) {
		return sqlSession.selectList("pay.list", member_email);
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
			if(total>=0) {
				return total;
			}else {
				return 0;
			}
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
			if(total>=0) {
				return total;
			}else {
				return 0;
			}
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
			if(total>=0) {
				return total;
			}else {
				return 0;
			}
		}else if(complete!=null & cancel==null){
			int total=(int)complete;
			return total;
		}else {
			int total=0;
			return total;
		}
	}

	@Override
	public List<PayCountDto> getCountList(String user_id) {
		return sqlSession.selectList("pay.getCountList", user_id);
	}

	@Override
	public void insertPayCount(int one_month, int six_month, int one_year, String user_id) {
		PayCountDto payCountDto = PayCountDto.builder()
				.one_month(one_month)
				.six_month(six_month)
				.one_year(one_year)
				.user_id(user_id)
				.build();
		
		sqlSession.insert("pay.insertPayCount", payCountDto);
	}

	@Override
	public void updatePayCount(int one_month, int six_month, int one_year, String user_id) {
		PayCountDto payCountDto = PayCountDto.builder()
				.one_month(one_month)
				.six_month(six_month)
				.one_year(one_year)
				.user_id(user_id)
				.build();
		sqlSession.update("pay.updatePayCount", payCountDto);
	}

	@Override
	public void changeAuth1(String user_id) {
		sqlSession.update("pay.changeAuth1", user_id);
	}

	@Override
	public void changeAuth6(String user_id) {
		sqlSession.update("pay.changeAuth6", user_id);
	}

	@Override
	public void changeAuth12(String user_id) {
		sqlSession.update("pay.changeAuth12", user_id);
	}

	@Override
	public int oneMonth(String user_id) {
		if(sqlSession.selectOne("pay.oneMonth", user_id)==null) {
			return 0;
		}else {
			return sqlSession.selectOne("pay.oneMonth", user_id);			
		}
	}

	@Override
	public int sixMonth(String user_id) {
		if(sqlSession.selectOne("pay.sixMonth", user_id)==null) {
			return 0;
		}else {
			return sqlSession.selectOne("pay.sixMonth", user_id);			
		}
	}

	@Override
	public int oneYear(String user_id) {
		if(sqlSession.selectOne("pay.oneYear", user_id)==null) {
			return 0;
		}else {
			return sqlSession.selectOne("pay.oneYear", user_id);			
		}
	}

	@Override
	public void changeStatus(int no) {
		sqlSession.update("pay.changeStatus", no);
	}

	@Override
	public void upadteUsed(String partner_user_id, String item_name) {
		PayDto payDto = PayDto.builder()
				.partner_user_id(partner_user_id)
				.item_name(item_name)
				.build();
		sqlSession.update("pay.updateUsed", payDto);
		
	}

	@Override
	public String checkUsed(String partner_user_id, String item_name) {
		// TODO Auto-generated method stub
		return null;
	}

	


}
