package com.kh.circle.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;
import com.kh.circle.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/signup")
	public String signup() {
		
		return "member/signup";
	}
	
	@PostMapping("/signup")
	public String signup(@ModelAttribute MemberDto memberDto,
						 @RequestParam MultipartFile file) {
		
		MemberProfileDto memberProfileDto = MemberProfileDto.builder().member_profile_uploadname(file.getOriginalFilename()).member_profile_filesize(file.getSize()).build();
		memberDao.signup(memberDto, memberProfileDto);
		
		
		return "redirect:./signup_success";
	}
	
	@GetMapping("/signin")
	public String signin() {
		
		return "member/signin";
	}
	
	@PostMapping("/signin")
	public String signin(@ModelAttribute MemberDto memberDto, HttpSession session) {
		
		if(memberDao.signin(memberDto)!=null) {
			String member_grade = memberDao.checkGrade(memberDto);
			session.setAttribute("member_email", memberDto.getMember_email());
			session.setAttribute("member_grade", member_grade);
			return "redirect:../";
		}else {
			return "redirect:./signin?error";
		}
	}
	
	@GetMapping("/signout")
	public String signout(HttpSession session) {
		session.removeAttribute("member_email");
		session.removeAttribute("member_grade");
		
		return "redirect:../";
	}
}
