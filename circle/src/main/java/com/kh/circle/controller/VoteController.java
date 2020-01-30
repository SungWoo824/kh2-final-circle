package com.kh.circle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/vote")
public class VoteController {
	
	@GetMapping("/list")
	public String list() {
		return "vote/list";
	}
	
	@GetMapping("/create")
	public String create() {
		return "vote/create";
	}
}
