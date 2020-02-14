package com.kh.circle.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.repository.TeamDao;

@Controller
@RequestMapping("/team_admin")
public class TeamAdminController {
	
	@Autowired private TeamDao teamDao;
	
	//팀관리 페이지 메인 
	@GetMapping("/team_manager_team")
	public String team_manager_team(@RequestParam String team_name,
									@RequestParam int team_no,
									@ModelAttribute TeamDto teamDto,
									Model model) {
		
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_no", team_no);
		model.addAttribute("getDetail", teamDao.teamDetail(team_no));
		teamDao.editTeamName(team_name,team_no);
		
		return "team_admin/team_manager_team";
	}
	
	@PostMapping("/team_manager_team")
	public String team_manger_team() {
		
		
		
		return "redirect:../member/mypage";
	}

}
