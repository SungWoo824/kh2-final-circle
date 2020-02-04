package com.kh.circle.repository;

import com.kh.circle.entity.TopicDto;

public interface TopicDao {

	int getSequence();
	
	void topicCreate(TopicDto topicDto);
}
