package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.TopicDto;

public class TopicDaoIml implements TopicDao{

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void topicCreate(TopicDto topicDto) {
		sqlSession.insert("topic.topicCreate",topicDto);
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("topic.getSeq");
	}

}
