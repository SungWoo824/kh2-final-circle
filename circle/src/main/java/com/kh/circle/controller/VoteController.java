package com.kh.circle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;
import com.kh.circle.repository.VoteCreateDao;


@Controller
@RequestMapping("/vote")
public class VoteController {
	
	@Autowired
	private VoteCreateDao voteCreateDao;
	
	@GetMapping("/list")
	public String list() {
		return "vote/list";
	}
	
	@GetMapping("/create")
	public String create() {
		return "vote/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute VoteDto voteDto) {
		voteCreateDao.create(voteDto);
		
		return "redirect:./list";
	}
}
