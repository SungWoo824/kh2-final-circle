package com.kh.circle.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.TopicDto;

public class TopicDaoIml implements TopicDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void TopicNew(TopicDto topicDto) {
		sqlSession.insert("topic.newTopic",topicDto);
	}

}
