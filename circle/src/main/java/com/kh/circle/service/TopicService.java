package com.kh.circle.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.repository.TopicDao;

@Service
public class TopicService implements TopicDao{

	@Autowired
	private TopicDao topicDao;
	
	
	@Override
	public void TopicNew(TopicDto topicDto) {

		
	}

	
	
}
