package com.kh.circle.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Integer> memberContainTopic(int member_no, int team_no) {
		Map<String,Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("team_no", team_no);
		
		return sqlSession.selectList("chat.memberContainTopic", param);
	}
	
}
