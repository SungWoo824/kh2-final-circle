package com.kh.circle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.repository.ManagerDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/manager")
@Slf4j
public class ManagerController {
	
	@Autowired
	private ManagerDao managerDao;
	
	
	@GetMapping("/member")
	public ModelAndView member(ModelAndView mav,
						@RequestParam String type,
						@RequestParam String value) {

			mav.addObject("memberList", managerDao.memberList(type, value));
			mav.setViewName("manager/member");
	
		return mav;
	}
}
