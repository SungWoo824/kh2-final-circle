package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;

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

	@Override
	public void topicMemberInsert(TopicMemberDto topicMemberDto) {
		sqlSession.insert("topic.topicMemberInsert", topicMemberDto);
	}

	@Override
	public int teamTopicFirst(int team_no) {
		return sqlSession.selectOne("topic.teamTopicFirst", team_no);
	}
	
	

}
