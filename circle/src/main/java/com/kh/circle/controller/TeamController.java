package com.kh.circle.controller;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.repository.TeamDao;

@Controller
@RequestMapping("/team")
public class TeamController { 
	

	@Autowired
	private TeamDao teamDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	//팀 생성하기 
	@GetMapping("/create")
	public String create() {
		
		return "team/create";
	}
	
	//팀 생성 등록이 완료되면 팀메인 페이지로 가는 컨트롤러
	@PostMapping("/create")
	public String create(@ModelAttribute TeamDto teamDto) {
		int team_no =teamDao.getSequence();
		teamDto.setTeam_no(team_no);
		teamDao.teamCreate(teamDto);
		
		return "redirect:main";
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
	


}
