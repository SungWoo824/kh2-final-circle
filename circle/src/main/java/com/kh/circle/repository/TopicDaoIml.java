package com.kh.circle.repository;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public void mailInviteTopic(TopicMemberDto topicMemberDto) {
		sqlSession.insert("topic.mailInviteTopic", topicMemberDto);
	}

	public List<TopicDto> teamTopicList(int team_no) {
		
		return sqlSession.selectList("topic.teamTopicList", team_no);
	}

	public List<TopicMemberDto> topicMemberList(int topic_no) {
		return sqlSession.selectList("topic.topicMemberList",topic_no);
	}
	
	@Override
	public void editTopic(TopicDto topicDto) {
		sqlSession.update("topic.editTopic",topicDto);
	}

	@Override
	public void inviteTopic(TopicMemberDto topicMemberDto) {
		sqlSession.insert("topic.inviteTopic", topicMemberDto);
	}
	

	@Override
	public void inviteMember(List<Integer> list, int team_no, int topic_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("list", list);
		param.put("team_no", team_no);
		param.put("topic_no", topic_no);
		sqlSession.insert("topic.inviteMember",param);
	}
	

	@Override
	public void topicMasterChange(int topic_no, int member_no) {
		Map<String, Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("topic_no", topic_no);
		sqlSession.update("topic.topicMasterChange",param);
	}
	
	@Override
	public void outTopic(int topic_no, int member_no) {
		Map<String, Integer> param = new HashMap<>();
		param.put("member_no", member_no);
		param.put("topic_no",topic_no);
		sqlSession.delete("topic.outTopic", param);
	}

	@Override
	public List<TopicMemberDto> inviteTopicList(int team_no,int topic_no) {
		Map<String, Integer> param = new HashMap<>();
		param.put("team_no", team_no);
		param.put("topic_no",topic_no);
		return sqlSession.selectList("topic.inviteTopicList",param);

	}


	@Override
	public void deleteTopic(int topic_no, int team_no) {
		Map<String, Integer> param = new HashMap<>();
		param.put("team_no", team_no);
		param.put("topic_no",topic_no);
		sqlSession.delete("topic.deleteTopic", param);
	}

	@Override
	public List<TopicMemberDto> topicMasterList(int member_no) {
		return sqlSession.selectList("topic.topicMasterList",member_no);
	}

	

}
