package com.kh.circle.controller;
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

import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.repository.MemberDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.service.TeamService;

@Controller
@RequestMapping("/team_admin")
public class TeamAdminController {
	
	@Autowired private TeamDao teamDao;
	@Autowired private SqlSession sqlSession;
	@Autowired private MemberDao memberDao;

	
	

	//논소유자: 팀관리 페이지 메인
	@GetMapping("/member_manager_team")
	public String team_member_team(@RequestParam String team_name,
								   @RequestParam int team_no,
								   @RequestParam String team_domain,
								   
								   HttpSession session,
							       Model model) {
		//팀 테이블 정보 출력
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		
//		model.addAttribute("teamDto", teamDao.teamDetail((int)session.getAttribute("member_no")));
//		model.addAttribute("memberDto", memberDao.info((String)session.getAttribute("member_email")));
		model.addAttribute("memberDto", memberDao.info((String)session.getAttribute("member_email")));
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		
		return "team_admin/member_manager_team";
	}
	
	//소유자 : 팀관리 페이지 메인 
	@GetMapping("/owner_manager_team")
	public String owner_manager_team(@RequestParam String team_name,
									@RequestParam int team_no,
									@RequestParam String team_domain,
									HttpSession session,
									Model model) {
	
		//팀 테이블 정보 리스트 출력
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		//팀 멤버 정보 출력
		model.addAttribute("teamMemberDto", teamDao.teamMemberinfo((int)session.getAttribute("member_no")));
		//비밀번호 확인 할때 이메일 세션 가져오기 
		model.addAttribute("memberDto", memberDao.info((String)session.getAttribute("member_email")));
		
		return "team_admin/owner_manager_team";
	}
	
	@GetMapping("/owner_manager_member")
	public String owner_manager_member(@RequestParam String team_name,
								  	   @RequestParam int team_no,
									   @RequestParam String team_domain,
									   HttpSession session,
									   Model model) {
		
		model.addAttribute("team_name", team_name);
		//팀 테이블 정보 리스트 출력
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		//팀 멤버 정보 출력
		model.addAttribute("teamMemberDto", teamDao.teamMemberinfo((int)session.getAttribute("member_no")));
		
		
		return "team_admin/owner_manager_member";
	}
	
	@GetMapping("/owner_manager_per")
	public String owner_manager_mper(@RequestParam String team_name,
										@RequestParam int team_no,
										@RequestParam String team_domain,
										HttpSession session,
										Model model) {
		//팀 테이블 정보 리스트 출력
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		//팀 멤버 정보 출력
		model.addAttribute("teamMemberDto", teamDao.teamMemberinfo((int)session.getAttribute("member_no")));
				
		
		return "team_admin/owner_manager_per";
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
		return "redirect:./owner_manager_team";
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
		return "redirect:./owner_manager_team";
		
	}
	
	//팀 삭제하기
	@PostMapping("/edit_team_delete")
	public String edit_team_delete(@RequestParam int team_no) {
		
		teamDao.teamDelete(team_no);
		return "redirect:../member/mypage";
	}
	
	//논소유 : 팀 탈퇴하기
		@PostMapping("/edit_team_exit")
		public String edit_team_exit(@ModelAttribute TeamMemberDto teamMemberDto,
									@ModelAttribute TopicMemberDto topicMemberDto
									
									) {
			
			
			//탈퇴 할때 team_no와 member_no 필요 
//			model.addAttribute("team_no", team_no);
//			
//			int member_no = (int)session.getAttribute("member_no");
			
			//팀 멤버와 토픽멤버에서 동시 탈퇴 / 팀은 유지됨 
			teamDao.teamExit(teamMemberDto);
			teamDao.topicExit(topicMemberDto);
			
			return "redirect:../member/mypage";
		}
	
	//비밀번호 확인 
	@GetMapping("checkpw")
	@ResponseBody
	public String checkpw(@RequestParam String member_pw,
						 HttpSession session) {
		MemberDto memberDto = memberDao.signin((String)session.getAttribute("member_email"), member_pw);
		if(memberDto!=null) {	
			return "success";
		}else {
			return "fail";
		}
		
	
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
