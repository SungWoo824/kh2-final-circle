package com.kh.circle.controller;


import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.repository.TeamCertDao;
//github.com/SungWoo824/kh2-final-circle
import com.kh.circle.repository.TeamDao;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.service.EmailService;
import com.kh.circle.service.RandomService;
//import com.kh.circle.service.TeamEmailService;
import com.kh.circle.service.TeamEmailService;
import com.kh.circle.service.TeamService;

//github.com/SungWoo824/kh2-final-circle

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/team")
@Slf4j

public class TeamController { 
	
	@Autowired
	private TeamCertDao teamCertDao;	
	@Autowired
	private TeamEmailService teamEmailService;
	@Autowired
	private EmailService emailService;	
	@Autowired
	private RandomService randomService;	
	@Autowired
	private TeamDao teamDao;	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	//팀 생성하기 페이지 
	@GetMapping("/create")
	public String create() {
		
		return "team/create";
	}
	
	//팀 생성을 하는 컨트롤러 / 생성 후 topic창으로 연결 
	@PostMapping("/create")
	public String create(@ModelAttribute TeamDto teamDto,
						HttpSession session) {
		int team_no =teamDao.getSequence();
		int topic_no = topicDao.getSequence();
		teamDto.setTeam_no(team_no);
		teamDao.teamCreate(teamDto);
		teamDao.teamMemberCreate((int)session.getAttribute("member_no"), team_no);
		TopicDto topicDto = TopicDto.builder()
				.topic_no(topic_no).topic_name("공지사항")
				.topic_confidential("0")
				.topic_explain("이 토픽은 모든 정회원이 자동으로 참여되며 나갈 수 없는 기본 토픽입니다. 정회원 모두에게 전달해야하는 내용을 전송할 수 있으며 준회원은 기본 토픽에 참여할 수 없습니다.")
				.build();
		
		topicDao.topicCreate(topicDto);
		TopicMemberDto topicMemberDto = TopicMemberDto.builder().member_no((int) session.getAttribute("member_no")).team_no(team_no).topic_no(topic_no).build();
		
		topicDao.topicMemberInsert(topicMemberDto);
		
		return "redirect:../chat/topic_main?team_no="+team_no+"&topic_no="+topic_no;
//		return "redirect:../";	//redirec로 설정해야 원하는url 주소로 바뀜
	}
	
	//팀생성 이름 중복검사 rest컨트롤러
	@GetMapping("/check")
	@ResponseBody
	public String check(@RequestParam String team_name, String team_domain) {
		//검사를 수행

		int count = sqlSession.selectOne("team.check",team_name);
		if(count>0) return "Y"; //있으면
		else return "N";
	}
	//팀생성-도메인 이름 중복검사 rest컨트롤러
	@GetMapping("/check2")
	@ResponseBody
	public String check2(@RequestParam String team_domain) {
		//검사를 수행

		int count = sqlSession.selectOne("team.check2",team_domain);
		if(count>0) return "Y"; //있으면
		else return "N";
	}
	
	//invite_create 초대하기 버튼 

	@GetMapping("/invite_create") 
	public String invite_create(@RequestParam int team_no,
								Model model) {
		model.addAttribute("team_no", team_no);
		return "team/invite_create";
	}
	
	
	
	
	//토픽 메인 화면에서 보이는 '팀초대하기' 버튼과 연결된 jsp
	@GetMapping("/main")
	public String main(@RequestParam int team_no,
					   Model model) {	
		model.addAttribute("team_no", team_no); //team_no이름으로 team_no를 파라미터값으로 넘기겠다
		return "team/main";
	}
	
	//modal_invite1 초대하기 모달 화면 1과 연결된 jsp 
	@GetMapping("/modal_invite1")
	public String modal_invite1(@RequestParam(value="team_no") int team_no,
			Model model) {
	
		model.addAttribute("team_no", team_no);
		return "team/modal_invite1";
	}
	
	

		
	
	

		
	//modal_invite2 가기 초대하기 모달 화면 2
	@GetMapping("/modal_invite2") 
	public String modal_invite2(@RequestParam int team_no,
								Model model) {
		model.addAttribute("team_no", team_no);
		return "team/modal_invite2";
	}

	
	
	
	
	
	//modal_invite3 가기 초대하기 모달 화면 3
	@GetMapping("/modal_invite3") 
	public String modal_invite3() {
		return "team/modal_invite3";
	}
	
	
	//인증 번호6자리를 보낼 수 있는 컨트롤러 / 현재 team에서 사용하지 않는 메소드 
	@GetMapping("/send")
	@ResponseBody
	public String send(@RequestParam String email, HttpSession session) {
//		인증번호를 세션이든 DB든 어디에 저장
//		String cert = "123456";
		String cert = randomService.generateCertificationNumber(6);
		session.setAttribute("cert", cert);
		return emailService.sendCertMessage(email, cert); 	
	}
	
	
	//멤버 초대 이메일 전송하는 컨트롤러 
	@PostMapping("/modal_invite2")
	public String modal_invite2(@RequestParam String cert_email,
								@RequestParam int team_no
								) throws MessagingException
	{ 	

		teamEmailService.sendConfirmMessage(cert_email,team_no);
	return "redirect:result";
		
	}
	


	@Autowired
	private TeamService teamService;
	
	@GetMapping("/connect")
	public String connect(@RequestParam int team_no,
							Model model) {
		int topic_no =topicDao.teamTopicFirst(team_no);
		List<TopicDto> topicList = teamService.teamTopicList(team_no);
		
		model.addAttribute("team_no", team_no);
		model.addAttribute("topic_no", topic_no);
		model.addAttribute("topicList", topicList);
		return "redirect:../chat/topic_main";
	}
}

