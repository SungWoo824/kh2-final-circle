package com.kh.circle.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.repository.TopicDao;

public class TopicServiceImpl implements TopicService{

	@Autowired
	private TopicDao topicDao;
	
	
	@Override
	public void topicCreate(TopicDto topicDto) {
		
		int topicCreate_no = topicDao.getSequence();
		topicDto.setTopic_no(topicCreate_no);
		topicDao.topicCreate(topicDto);
		
	}

}
