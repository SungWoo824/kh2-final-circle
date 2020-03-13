package com.kh.circle.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.repository.PayDao;
import com.kh.circle.repository.TeamDao;

@Controller
@RequestMapping("/plan")
public class PlanOptionController {
@Autowired
PayDao payDao;

@Autowired
TeamDao teamDao;

	@GetMapping("/list")
	public String list(@RequestParam String team_name,
			   @RequestParam int team_no,
			   @RequestParam String team_domain,Model model, HttpSession session) {
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		
		String user_id=(String) session.getAttribute("member_email");
		int one_month=payDao.getQty1((String) session.getAttribute("member_email"));
		int six_month=(int) payDao.getQty6((String) session.getAttribute("member_email"));
		int one_year=(int) payDao.getQty12((String) session.getAttribute("member_email"));
		
		
		if(payDao.getCountList((String) session.getAttribute("member_email")).size()>0) {
			payDao.updatePayCount(one_month, six_month, one_year, user_id);
		}else {
			payDao.insertPayCount(one_month,six_month,one_year,user_id);
		};
		model.addAttribute("oneMonth", payDao.oneMonth(user_id));
		model.addAttribute("sixMonth", payDao.sixMonth(user_id));
		model.addAttribute("oneYear", payDao.oneYear(user_id));
		
		return "plan/list";
	}
	
	@GetMapping("/change_auth")
	public String change_auth(@RequestParam String team_name,
			   @RequestParam int team_no,
			   @RequestParam String team_domain,
				HttpSession session, Model model) {
		//팀 이름 넘겨줘야 함 
		model.addAttribute("team_name", team_name);
		
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		
		//팀 테이블 정보 리스트 출력
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		
		//팀 멤버 정보 출력
		model.addAttribute("teamMemberDto", teamDao.teamMemberInfo((int)session.getAttribute("member_no"), team_no));

		//반복문 . 참여멤버리스트 출력( 이너조인 : 이메일 , 멤버 등급 , 멤버 포지션 , 멤버어쓰, 멤버이름)
		model.addAttribute("memberList",teamDao.memberList(team_no));
		
		//소유자인지 아닌지 확인
		model.addAttribute("position", teamDao.checkPosition((int) session.getAttribute("member_no"), team_no));
		
		model.addAttribute("minor", teamDao.minorPosition(team_no));
		
		return "plan/change_auth";
	}
	
	@PostMapping("/change_auth")
	public String change_auth(@RequestParam String team_name,
			 					@RequestParam int team_no,
			 					@RequestParam String team_domain, 
			 					HttpSession session, 
			 					Model model, 
			 					@RequestParam List<Integer> changeAuth,
			 					@RequestParam List<String> term) {
		
		for(int i=0; i<term.size(); i++) {
			if(term.get(i).equals("1개월권")) {
				payDao.changeAuth1((String) session.getAttribute("member_email"));
				payDao.upadteUsed((String) session.getAttribute("member_email"), term.get(i));
			}else if(term.get(i).equals("6개월권")) {
				payDao.changeAuth6((String) session.getAttribute("member_email"));
				payDao.upadteUsed((String) session.getAttribute("member_email"), term.get(i));
			}else {
				payDao.changeAuth12((String) session.getAttribute("member_email"));
				payDao.upadteUsed((String) session.getAttribute("member_email"), term.get(i));
			}
		}
		
		for(int i=0; i<changeAuth.size(); i++) {
			TeamMemberDto teamMemberDto = TeamMemberDto.builder()
					.member_no(changeAuth.get(i))
					.team_no(team_no)
					.member_auth("정회원")
					.term(term.get(i))
					.build();
			teamDao.changeAuth(teamMemberDto);	
		}
		return "redirect:./change_auth?team_no="+team_no+"&team_name="+team_name+"&team_domain="+team_domain;
	}
	
}
