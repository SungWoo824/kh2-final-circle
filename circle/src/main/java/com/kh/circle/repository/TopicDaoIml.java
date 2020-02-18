package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;

@Repository
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

	@Override
	public TopicDto topicChange(int topic_no) {
		return sqlSession.selectOne("topic.topicChange", topic_no);
	}

	@Override
	public void inviteTopic(TopicMemberDto topicMemberDto) {
	    sqlSession.insert("topic.inviteTopic",topicMemberDto);
	   }
	
	

}
