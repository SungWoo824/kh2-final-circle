package com.kh.circle.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.repository.TopicDao;

@Controller
@RequestMapping("/chat")
public class ChatController {

	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@GetMapping("/chat")
	public String chat(@RequestParam int topic_no) {
		
		return "chat/chat";
	}
	
	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int team_no,
							@RequestParam int topic_no) {
		return "chat/topic_main";
	}
	
	@GetMapping("/topic_create")
	public String topic_create() {
		return "chat/topic_create";
	}
	
	@PostMapping("/topic_create")
	public String topic_create(TopicDto topicDto) {
		int topicCreate_no = topicDao.getSequence();
		topicDto.setTopic_no(topicCreate_no);
		topicDao.topicCreate(topicDto);
		return "redirect:topic_main?topic_no="+topicCreate_no;
	}
	
	
}
