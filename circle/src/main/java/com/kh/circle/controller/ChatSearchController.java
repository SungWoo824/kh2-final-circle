package com.kh.circle.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.repository.ChatSearchDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatSearchController {
@Autowired
ChatSearchDao chatSearchDao;

	@PostMapping("/chat_search")
	public String search(@RequestParam String keyword,
						@RequestParam String topic_name,
						@RequestParam int team_no,
						@RequestParam int term,
						HttpSession session, Model model) {
//		if(topic_name.equals("all")) {
//			model.addAttribute("allList", chatSearchDao.searchAll(team_no, keyword));
//			log.info("alllist={}", chatSearchDao.searchAll(team_no, keyword));
//		}else if(!topic_name.equals("all")) {
//			model.addAttribute("allList", chatSearchDao.searchByTopic(team_no, topic_name, keyword));
//			log.info("topic={}", chatSearchDao.searchByTopic(team_no, topic_name, keyword));
//		}
		
		switch(term) {
		case 0: 
			if(topic_name.equals("all")) {
				model.addAttribute("allList", chatSearchDao.searchAll(team_no, keyword));
			}else {
				model.addAttribute("allList", chatSearchDao.searchByTopic(team_no, topic_name, keyword));
			}
			break;
		
		case 7:
			if(topic_name.equals("all")) {
				model.addAttribute("allList", chatSearchDao.searchAllByDate(team_no, term, keyword));
			}else {
				model.addAttribute("allList", chatSearchDao.searchByTopicAndDate(team_no, term, topic_name, keyword));
			}
			break;
		
		case 30:
			if(topic_name.equals("all")) {
				model.addAttribute("allList", chatSearchDao.searchAllByDate(team_no, term, keyword));
			}else {
				model.addAttribute("allList", chatSearchDao.searchByTopicAndDate(team_no, term, topic_name, keyword));
			}
			break;
		
		case 90:
			if(topic_name.equals("all")) {
				model.addAttribute("allList", chatSearchDao.searchAllByDate(team_no, term, keyword));
			}else {
				model.addAttribute("allList", chatSearchDao.searchByTopicAndDate(team_no, term, topic_name, keyword));
			}
			break;
		}

		return "chat/search_result";
	}
}
