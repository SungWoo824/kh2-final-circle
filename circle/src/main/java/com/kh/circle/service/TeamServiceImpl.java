package com.kh.circle.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;
import com.kh.circle.vo.ChatCountVo;
import com.kh.circle.vo.ChatVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public void create(TeamDto teamDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TopicDto> teamTopicList(int team_no, int member_no) {
		Map<String,Integer> param = new HashMap<>();
		param.put("team_no", team_no);
		param.put("member_no", member_no);
		return sqlSession.selectList("topic.teamTopicList", param);
	}

	@Override
	public List<ChatCountVo> memberChatCount(int team_no, int member_no) {
		List<TopicDto> topicList = teamTopicList(team_no,member_no);
		List<ChatCountVo> chatCount = new ArrayList<>();
		for(TopicDto topicDto : topicList) {
			log.info("topicDto = {}", topicDto);
			ChatVo enterChatVo = ChatVo.builder().member_no(member_no).topic_no(topicDto.getTopic_no()).status(0).build();
			log.info("enterChatVo = {}", enterChatVo);
			ChatVo exitChatVo = ChatVo.builder().member_no(member_no).topic_no(topicDto.getTopic_no()).status(1).build();
			log.info("exitChatVo = {}", exitChatVo);
			int enter;
			int exit;
			if(sqlSession.selectOne("topic.topicStatusSearch", enterChatVo)==null) {
				enter = 0;
			}else {
				enter = sqlSession.selectOne("topic.topicStatusSearch", enterChatVo);				
			}
			if(sqlSession.selectOne("topic.topicStatusSearch", exitChatVo)==null) {
				exit=0;
			}else {
				exit = sqlSession.selectOne("topic.topicStatusSearch", exitChatVo);				
			}
			
			Map<String,Integer> param = new HashMap<>();
			param.put("topic_no", exitChatVo.getTopic_no());
			param.put("exit", exit);
			
			ChatCountVo chatCountVo;
			if(enter>exit) {
				chatCountVo = ChatCountVo.builder().topic_no(topicDto.getTopic_no()).count(0).build();
				chatCount.add(chatCountVo);
			}else {
				int count = sqlSession.selectOne("topic.topicChatCount", param);
				chatCountVo = ChatCountVo.builder().topic_no(topicDto.getTopic_no()).count(count).build();
				chatCount.add(chatCountVo);
			}
		}
		return chatCount;
	}

}
