package com.kh.circle.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.ChatSearchDto;

public class ChatSearchDaoImpl implements ChatSearchDao{
@Autowired
SqlSession sqlSession;

	@Override
	public List<ChatSearchDto> searchAll(int team_no, String keyword) {
		ChatSearchDto chatSearchDto = ChatSearchDto.builder()
				.team_no(team_no)
				.keyword(keyword)
				.build();
		
		return sqlSession.selectList("search.all", chatSearchDto);
	}

	@Override
	public List<ChatSearchDto> searchByTopic(int team_no, String topic_name, String keyword) {
		
		ChatSearchDto chatSearchDto = ChatSearchDto.builder()
				.team_no(team_no)
				.topic_name(topic_name)
				.keyword(keyword)
				.build();
		
		return sqlSession.selectList("search.byTopic", chatSearchDto);
	}

	@Override
	public List<ChatSearchDto> searchAllByDate(int team_no, int term, String keyword) {
		
		ChatSearchDto chatSearchDto = ChatSearchDto.builder()
				.team_no(team_no)
				.term(term)
				.keyword(keyword)
				.build();
		
		return sqlSession.selectList("search.allByDate", chatSearchDto);
	}

	@Override
	public List<ChatSearchDto> searchByTopicAndDate(int team_no, int term, String topic_name, String keyword) {

		ChatSearchDto chatSearchDto = ChatSearchDto.builder()
				.team_no(team_no)
				.term(term)
				.topic_name(topic_name)
				.keyword(keyword)
				.build();
		
		return sqlSession.selectList("search.topicByDate", chatSearchDto);
	}
}
