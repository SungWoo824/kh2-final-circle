package com.kh.circle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/chat")
public class ChatController {

	
	@GetMapping("/chat")
	public String chat(@RequestParam int topic_no) {
		
		return "chat/chat";
	}
	
	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int topic_no) {
		return "chat/topic_main";
	}
	
	@GetMapping("/topic_new")
	public String topic_new() {
		return "chat/topic_new";
	}
	
//	@PostMapping("/topic_new")
//	public String topic_new(@RequestParam) {
//		return "redirect:chat/topic_main";
//	}
	
	
}
