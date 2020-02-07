package com.kh.circle.repository;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;

public interface TopicDao {

	int getSequence();
	void topicCreate(TopicDto topicDto);
	void topicMemberInsert(TopicMemberDto topicMemberDto);
	int teamTopicFirst(int team_no);
	TopicDto topicChange(int topic_no);
}
