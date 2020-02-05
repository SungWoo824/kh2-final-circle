package com.kh.circle.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamCertDto;

public class TeamCertDaoImpl implements TeamCertDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberDto memberDto;
	
	@Override
	public void regist(TeamCertDto teamCertDto) {
		sqlSession.insert("team.regist",teamCertDto);
		
	}

	@Override
	public boolean check3(String member_email, String cert_no) {
		//select * from team_cert where member_email=? and cert_no=?
		Map<String, Object> param = new HashMap<>();
		param.put("member_email", member_email);
		param.put("cert_no", cert_no);
		TeamCertDto teamCertDto = sqlSession.selectOne("team.check3",param);
		
		return teamCertDto != null;
	}

	@Override
	public void delete(String member_email) {
		sqlSession.delete("team.delete",member_email);
		
	}

	@Override
	public boolean check4(String member_email,String cert_no) {
		Map<String, Object> param = new HashMap<>();
		param.put("member_email", member_email);
		param.put("cert_no", cert_no);
		TeamCertDto teamCertDto = sqlSession.selectOne("team.check4",param);
		return memberDto != null;
	}

}
