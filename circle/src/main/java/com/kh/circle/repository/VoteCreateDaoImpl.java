package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;

public class VoteCreateDaoImpl implements VoteCreateDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getSequence() {
		return sqlSession.selectOne("vote.getseq");
	}
	@Override
	public void create(VoteDto voteDto) {
		sqlSession.insert("vote.create", voteDto);
		int no = getSequence();
		
		
	}

	
	
}
