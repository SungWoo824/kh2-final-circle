package com.kh.circle.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;
import com.kh.circle.repository.MemberDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.service.EmailService;
import com.kh.circle.service.RandomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private TeamDao teamDao;
	
	@GetMapping("/signup")
	public String signup() {
		
		return "member/signup";
	}
	
	@PostMapping("/signup")
	public String signup(@ModelAttribute MemberDto memberDto,
						 @RequestParam MultipartFile file) throws IllegalStateException, IOException {
		
		MemberProfileDto memberProfileDto = MemberProfileDto.builder().member_profile_uploadname(file.getOriginalFilename()).member_profile_filesize(file.getSize()).build();
		memberDao.signup(memberDto, memberProfileDto, file);
		
		
			return "redirect:./signup_success";
	}
	
	@GetMapping("/signup_success")
	public String signupSuccess() {
		
		return "member/signup_success";
	}
	
	@GetMapping("/signin")
	public String signin() {
		
		return "member/signin";
	}
	
	@PostMapping("/signin")
	public String signin(@RequestParam String member_email,
						@RequestParam String member_pw,
						HttpSession session) {
		MemberDto memberDto = memberDao.signin(member_email,member_pw);
		if(memberDto!=null) {
			session.setAttribute("member_email", memberDto.getMember_email());
			session.setAttribute("member_no", memberDto.getMember_no());
			session.setAttribute("member_grade", memberDto.getMember_grade());
			return "redirect:./mypage";
		}else {
			return "redirect:./signin?error";
		}
	}
	
	@GetMapping("/signout")
	public String signout(HttpSession session) {
		session.removeAttribute("member_email");
		session.removeAttribute("member_grade");
		session.removeAttribute("member_no");
		
		return "redirect:../";
	}
	
	@GetMapping("/findpw")
	public String findpw() {
		
		return "member/findpw";
	}
	
	@Autowired
	private RandomService random;

	@Autowired
	private EmailService emailService;
	
	@GetMapping("send")
	@ResponseBody
	public String send(@RequestParam String email,
				HttpSession session) {
		String cert = random.generateCertificationNumber(6);
		log.info(cert);
		session.setAttribute("cert", cert);
		session.setAttribute("email", email);
		
		return emailService.sendCertMessage(email, cert);
	}
	
	@GetMapping("validate")
	@ResponseBody
	public String validate(@RequestParam String cert,
						HttpSession session) {
		String origin = (String) session.getAttribute("cert");
		if(origin.equals(cert)) {
			session.removeAttribute("cert");
			return "success";
		} else {
			return "fail";
		}
	}
	
	@GetMapping("changepw")
	public String changepw() {
		
		return "member/changepw";
	}
	
	@PostMapping("changepw")
	public String changepw(HttpSession session,
						@RequestParam String change_pw) {
		MemberDto memberDto = MemberDto.builder().member_email((String)session.getAttribute("email")).member_pw(change_pw).build();
		
		memberDao.changepw(memberDto);
		
		return "redirect:./signin";
	}
	
	@GetMapping("mypage")
	public ModelAndView mypage(ModelAndView mav,
							HttpSession session) {
		mav.addObject("memberDto", memberDao.info((String)session.getAttribute("member_email")));
		mav.addObject("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		mav.setViewName("member/mypage");
		
		return mav;
	}
	
	@GetMapping("modify")
	public String modify(HttpSession session,
						Model model){
		model.addAttribute("memberDto", memberDao.info((String)session.getAttribute("member_email")));
		int profile_no=memberDao.memberProfileNo((int)session.getAttribute("member_no"));
		model.addAttribute("profile_no", profile_no);
		return "member/modify";
	}
	
	@PostMapping("mypagechangepw")
	public String myPageChangepw(HttpSession session,
						@RequestParam String change_pw) {
		MemberDto memberDto = MemberDto.builder().member_email((String)session.getAttribute("member_email"))
				.member_pw(change_pw).build();
		
		memberDao.changepw(memberDto);
		
		return "redirect:./modify";
	}
	
	@GetMapping("checkpw")
	@ResponseBody
	public String myPageCheckpw(@RequestParam String member_pw,
								HttpSession session) {
		MemberDto memberDto = memberDao.signin((String)session.getAttribute("member_email"), member_pw);
		
		if(memberDto!=null) {	
			return "success";
		}else {
			return "fail";
		}
		
	}
	@PostMapping("mypagechangename")
	public String myPageChangeName(@RequestParam String member_name,
									HttpSession session) {
		memberDao.memberChangeName((String)session.getAttribute("member_email"), member_name);
		
		return "redirect:./modify";
	}
	
	@PostMapping("mypagedeletemember")
	public String myPageDeleteMember(HttpSession session) {
		int profile_no = memberDao.memberProfileNo((int)session.getAttribute("member_no"));
		memberDao.memberDelete((String)session.getAttribute("member_email"));
		File target = new File("D:/upload/kh2e/memberProfile/"+profile_no);
		target.delete();
		return "redirect:./signout";
	}
	
	@GetMapping("/download")
	   public void download(@RequestParam int member_no,
	         HttpServletResponse resp) throws IOException {
	      MemberProfileDto memberProfileDto = memberDao.getMemberProfile(member_no);
	      
	      File target = new File("D:/upload/kh2e/memberProfile",String.valueOf(memberProfileDto.getMember_no()));
	      byte[] data = FileUtils.readFileToByteArray(target);
	      
	      resp.setHeader("Content-Type", "application/octet=stream; charset=UTF-8");
	      resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(memberProfileDto.getMember_profile_uploadname(), "UTF-8")+"\"");
	      resp.setHeader("Content-Length", String.valueOf(memberProfileDto.getMember_profile_filesize()));

	      resp.getOutputStream().write(data);
	   }
	@PostMapping("mypagechangeprofile")
	public String myPageChangeProfile(@RequestParam MultipartFile member_profile,
									HttpSession session) throws IllegalStateException, IOException {
		MemberProfileDto memberProfileDto = MemberProfileDto.builder()
				.member_profile_uploadname(member_profile.getOriginalFilename())
				.member_profile_filesize(member_profile.getSize()).build();
		
		memberDao.changeProfile(member_profile, memberProfileDto,(int)session.getAttribute("member_no"));
		
		return "redirect:./modify";
	}
}
