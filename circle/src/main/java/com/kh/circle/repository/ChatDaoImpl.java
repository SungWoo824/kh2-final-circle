package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.vo.ChatVo;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void chatDataSave(ChatVo chatVo) {
		sqlSession.insert("chat.insert", chatVo);
	}

	@Override
	public List<ChatVo> topicChatList(int topic_no) {
		
		return sqlSession.selectList("chat.topicChatList", topic_no);
	}

	@Override
	public List<Integer> memberContainTopic(ChatVo chatVo) {
		
		return sqlSession.selectList("chat.memberContainTopic", chatVo);
	}
	
}
