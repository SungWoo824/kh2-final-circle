package com.kh.circle.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class SeqServiceImpl implements SeqService{
	@Autowired
	private SqlSession sqlSession;
	public int getSequence() {
		return sqlSession.selectOne("vote.getseq");
	}
}
