package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.ChatSearchDto;

public interface ChatSearchDao {
	
	List<ChatSearchDto> searchAll(int team_no, String keyword);
	List<ChatSearchDto> searchByTopic(int team_no, String topic_name, String keyword);
	List<ChatSearchDto> searchAllByDate(int team_no, int term, String keyword);
	List<ChatSearchDto> searchByTopicAndDate(int team_no, int term, String topic_name, String keyword);
	
}
