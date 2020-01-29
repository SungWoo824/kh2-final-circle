package com.kh.circle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.circle.entity.TeamDto;

@Controller
//@RequestMapping("/**.circle.com")
public class TeamController { 
	
	//팀 생성하기 
	@GetMapping("/teamcreate")
	public String create() {
		return "create";
	}
	
	@PostMapping("/teamcreate")
	public String create(@ModelAttribute TeamDto teamDto) {
		return "redirect:./";
	}


}
