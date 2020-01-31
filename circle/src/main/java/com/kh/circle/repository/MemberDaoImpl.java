package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Override
	public void signup(MemberDto memberDto,MemberProfileDto memberProfileDto) {
		int no = getSequence();
		memberDto.setMember_no(no);
		memberDto.setMember_pw(encoder.encode(memberDto.getMember_pw())); 
		
		sqlSession.insert("member.signup", memberDto);
		memberProfileDto.setMember_no(no);
		sqlSession.insert("member_profile.insert",memberProfileDto);
	}

	@Override
	public MemberDto signin(String member_email,String pw) {
		MemberDto memberDto = sqlSession.selectOne("member.signin", member_email);
		
		if(encoder.matches(pw, memberDto.getMember_pw())) {
			return memberDto;
		}else {
			return null;
		}
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("member.getseq");
	}

	@Override
	public String checkGrade(MemberDto memberDto) {
		
		return sqlSession.selectOne("member.checkgrade",memberDto);
	}

	@Override
	public void changepw(MemberDto memberDto) {
		
		sqlSession.update("member.changepw", memberDto);
		
	}


}
