package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void signup(MemberDto memberDto,MemberProfileDto memberProfileDto) {
		int no = getSequence();
		memberDto.setMember_no(no);
		sqlSession.insert("member.signup", memberDto);
		memberProfileDto.setMember_no(no);
		sqlSession.insert("member_profile.insert",memberProfileDto);
	}

	@Override
	public MemberDto signin(MemberDto memberDto) {
		memberDto = sqlSession.selectOne("member.signin", memberDto);
		return memberDto;
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
