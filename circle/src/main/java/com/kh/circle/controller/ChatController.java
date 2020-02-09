package com.kh.circle.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.service.TeamService;

@Controller
@RequestMapping("/chat")
public class ChatController {

	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int team_no,
							@RequestParam int topic_no,
							Model model) {
		List<TopicDto> topicList = teamService.teamTopicList(team_no);
		topic_no =topicDao.teamTopicFirst(team_no);
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("topicList", topicList);
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
	
	@Autowired
	private TeamService teamService;
	
	@GetMapping("/topic")
	public String topic(@RequestParam int topic_no,
						@RequestParam int team_no,
						Model model) {
		
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("team_no", team_no);
		model.addAttribute("topic_no", topic_no);
		
		return "redirect:./topic_main";
	}
	
	
}
