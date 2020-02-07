package com.kh.circle.controller;

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

import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.repository.TeamCertDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.service.TeamEmailService;
import com.kh.circle.vo.TopicRestVO;

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/chat")
public class ChatController {

	@Autowired 
	private TeamEmailService teamEmailService;
	
	@Autowired
	private TeamDao teamDao;
	
	@Autowired
	private TeamCertDao teamCertDao;
	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private SqlSession sqlSession;

	
	@GetMapping("/chat")
	public String chat(@RequestParam int topic_no) {
		
		return "chat/chat";
	}
	
	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int team_no,
							@RequestParam int topic_no) {
		return "chat/topic_main";
	}
	
	@GetMapping("/topic_create")
	public String topic_create() {
		return "chat/topic_create";
	}
	
	@PostMapping("/topic_create")
	public String topic_create( @ModelAttribute TopicDto topicDto, HttpSession session,@RequestParam int team_no) {
		//topic_create
		int topicCreate_no = topicDao.getSequence();
		topicDto.setTopic_no(topicCreate_no);
		topicDao.topicCreate(topicDto);
		
		//topic_member_create
		TopicMemberDto topicMemberDto = TopicMemberDto.builder()
				.topic_no(topicCreate_no)
				.member_no((int) session.getAttribute("member_no"))
				.team_no(team_no).build();
		topicDao.topicMemberInsert(topicMemberDto);
		
		return "redirect:../chat/topic_main?team_no="+team_no+"&topic_no="+topicCreate_no;
		
	}
	
	//중복검사
	@GetMapping("/topic_namecheck")
	@ResponseBody
	public String topic_name_check(@ModelAttribute TopicRestVO topicRestVo) {
//		System.out.println(topicRestVo.getTeam_no());
//		int count = 1;
		int count = sqlSession.selectOne("topic.nameCheck",topicRestVo);
		System.out.println(count);
		System.out.println(topicRestVo);
		if(count>0) return "Y";
		else return "N";
		
	}
	//소희 멤버초대 
	@GetMapping("/invite_create")
	public String invite_create() {
		return "chat/invite_create";
	}
	
//	@PostMapping("/invite_create")
//	public String invite_create( @ModelAttribute TopicDto topicDto, HttpSession session,@RequestParam int team_no) {
//		//invite_create
//		int topicCreate_no = topicDao.getSequence();
//		topicDto.setTopic_no(topicCreate_no);
//		topicDao.topicCreate(topicDto);
//		
//		//topic_member_create
//		TopicMemberDto topicMemberDto = TopicMemberDto.builder()
//				.topic_no(topicCreate_no)
//				.member_no((int) session.getAttribute("member_no"))
//				.team_no(team_no).build();
//		topicDao.topicMemberInsert(topicMemberDto);
//		
//		return "redirect:../chat/topic_main?team_no="+team_no+"&topic_no="+topicCreate_no;
//		
//	}
	
	//소희 : 멤버 초대 이메일 전송하는 컨트롤러 
	@PostMapping("/topic_main")
	public String topic_main(@RequestParam String cert_email,
								@RequestParam int team_no,
								@RequestParam int topic_no
								) throws MessagingException
	{ 	

		teamEmailService.sendConfirmMessage(cert_email,team_no,topic_no);
	return "redirect:result";
		
	}
	
//	@GetMapping("/invite_success")
//	public String invite_success(@RequestParam String cert_email,
//								 @RequestParam String cert_no,
//								 @RequestParam int team_no,
//								 HttpServletResponse response
//							) {
//		//필요한 작업 
//		// - 사용자가 이메일에서 링크를 누르면 이곳으로 들어온다 
//		// - 들어오면서 정상적인 링크라면 cert_no라는 파라미터와 member_email이라는 파라미터를 가지고 온다 
//		// - 위의 두 파라미터를 받아서 DB에 검증을 실시 
//		// - 위의 인증결과와 무관하게 해당 이메일의 인증정보를 모두 삭제 
//		
//		boolean enter = teamCertDao.check3(cert_email,cert_no);
////		teamCertDao.delete(member_email);
//		if(!enter) {
//			//team_cert에 데이터가 확인되지 않을 경우 에러 코드 송출
//			//다시 같은 페이지 재접속 방지를 위해서
//			response.setStatus(403);
//			return "team/invite_expired";	
//			}	
//		else {	//정확한 주소로 잘 들어왔다면 DB team_cert에 데이터 삭제후 중복접속 방지 / 그리고 성공 페이지로(confirm2)페이지로 이동
//				teamCertDao.delete(cert_email);	
//				return "redirect:invite_success";
//			}
//			
//		}
//	
	
	
	
	
	
}
