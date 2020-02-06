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
	
	//팀 생성하기 
	@GetMapping("/create")
	public String create() {
		
		return "team/create";
	}
	
	//팀 생성 등록이 완료되면 팀메인 페이지로 가는 컨트롤러
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
	
	//팀 메인 컨트롤러
	@GetMapping("/main")
	public String main() {
		return "team/main";
	}

		
	
	//invite1 가기
	@GetMapping("/invite1")
	public String invite1() {
		return "team/invite1";
	}
	
		
	//invite2 가기
	@GetMapping("/invite2") 
	public String invite2() {
		return "team/invite2";
	}

	@GetMapping("/send")
	@ResponseBody
	public String send(@RequestParam String email, HttpSession session) {
//		인증번호를 세션이든 DB든 어디에 저장
//		String cert = "123456";
		String cert = randomService.generateCertificationNumber(6);
		session.setAttribute("cert", cert);
		return emailService.sendCertMessage(email, cert); 	
	}
	
	@GetMapping("/confirm1")
	public String confirm1() {
		return "team/confirm1";
	}
	
	@PostMapping("/invite2")
	public String invite2(@RequestParam String cert_email) throws MessagingException
	{ 	teamEmailService.sendConfirmMessage(cert_email);
	return "redirect:main";
		
	}
	
	@GetMapping("/confirm2")
	public String confirm2(@RequestParam String cert_email,
							@RequestParam String cert_no,
							HttpServletResponse response
							) {
		//필요한 작업 
		// - 사용자가 이메일에서 링크를 누르면 이곳으로 들어온다 
		// - 들어오면서 정상적인 링크라면 cert_no라는 파라미터와 member_email이라는 파라미터를 가지고 온다 
		// - 위의 두 파라미터를 받아서 DB에 검증을 실시 
		// - 위의 인증결과와 무관하게 해당 이메일의 인증정보를 모두 삭제 
		
		boolean enter = teamCertDao.check3(cert_email,cert_no);
//		teamCertDao.delete(member_email);
		if(!enter) {
			//team_cert에 데이터가 확인되지 않을 경우 에러 코드 송출
			//다시 같은 페이지 재접속 방지를 위해서
			response.setStatus(403);
			return "team/invite3";	
			}	
		else {	//도메인 주소는 맞다면 
				teamCertDao.delete(cert_email);	
				return "team/confirm2";
			}
			
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

