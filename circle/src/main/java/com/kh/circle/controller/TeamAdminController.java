package com.kh.circle.controller;
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
import com.kh.circle.repository.TeamDao;

@Controller
@RequestMapping("/team_admin")
public class TeamAdminController {
	
	@Autowired private TeamDao teamDao;
	@Autowired private SqlSession sqlSession;
	
	//팀관리 페이지 메인 
	@GetMapping("/team_manager_team")
	public String team_manager_team(@RequestParam String team_name,
									@RequestParam int team_no,
									@RequestParam String team_domain,
									@ModelAttribute TeamDto teamDto,
									Model model) {
		
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_no", team_no);
		model.addAttribute("team_domain", team_domain);
		model.addAttribute("getDetail", teamDao.teamDetail(team_no));
		
		
		return "team_admin/team_manager_team";
	}
	
	//팀 이름 변경하기 
	@PostMapping("/edit_team_name")
	public String edit_team_name(@RequestParam String team_name,
								 @RequestParam int team_no,
								 @RequestParam String team_domain,
								 Model model) {
		
		model.addAttribute("team_no", team_no);
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_domain", team_domain);
		
		teamDao.editTeamName(team_name, team_no);
		return "redirect:./team_manager_team";
	}
	
	//팀 도메인 변경하기
	@PostMapping("/edit_team_domain")
	public String edit_team_domain(@RequestParam String team_domain,
								   @RequestParam int team_no,
								   @RequestParam String team_name,
								   Model model) {
		model.addAttribute("team_domain", team_domain);
		model.addAttribute("team_no", team_no);
		model.addAttribute("team_name", team_name);
		teamDao.editTeamDomain(team_domain, team_no);
		return "redirect:./team_manager_team";
		
	}
	
	//팀 삭제하기
	@PostMapping("/edit_team_delete")
	public String edit_team_delete(@RequestParam int team_no) {
		
		teamDao.teamDelete(team_no);
		return "redirect:../member/mypage";
	}
	
	//팀이름 변경 중복검사 rest컨트롤러
		@GetMapping("/check")
		@ResponseBody
		public String check(@RequestParam String team_name, String team_domain) {
			//검사를 수행

			int count = sqlSession.selectOne("team.check",team_name);
			if(count>0) return "Y"; //있으면
			else return "N";
		}
		
	//팀도메인 변경  중복검사 rest컨트롤러
		@GetMapping("/check2")
		@ResponseBody
		public String check2(@RequestParam String team_domain) {
			//검사를 수행

			int count = sqlSession.selectOne("team.check2",team_domain);
			if(count>0) return "Y"; //있으면
			else return "N";
		}


}
