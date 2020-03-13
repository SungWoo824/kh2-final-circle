package com.kh.circle.controller;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.circle.entity.DriveFileDto;
import com.kh.circle.entity.MemberDto;
import com.kh.circle.entity.MemberProfileDto;
import com.kh.circle.entity.TeamMemberDto;
import com.kh.circle.entity.TodoListDto;
import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.repository.ChatDao;
import com.kh.circle.repository.MemberDao;
import com.kh.circle.repository.TeamCertDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.repository.TodoListDao;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.repository.VoteCreateDao;
import com.kh.circle.service.TeamEmailService;
import com.kh.circle.service.TeamService;

import com.kh.circle.vo.ChatFileVo;
import com.kh.circle.vo.ChatVo;

import com.kh.circle.vo.TodoListJoinVO;
import com.kh.circle.vo.TopicRestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j

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
	private ChatDao chatDao;
	
	@Autowired
	private VoteCreateDao voteCreateDao;
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private TodoListDao todoListDao;

	@GetMapping("/chat")
	public String chat(@RequestParam int topic_no) {
		
		return "chat/chat";
	}

	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int team_no,
							@RequestParam int topic_no,
							@ModelAttribute TodoListDto todoListDto,
							@ModelAttribute TodoListJoinVO todoListJoinVO,
							Model model, HttpSession session) {
		List<TopicDto> topicList = teamService.teamTopicList(team_no,(int)session.getAttribute("member_no"));
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("topicList", topicList);
		model.addAttribute("memberChatCount", teamService.memberChatCount(team_no,(int)session.getAttribute("member_no")));
		model.addAttribute("topicChatList", chatDao.topicChatList(topic_no));

		//투표기능관련 코드
		model.addAttribute("voteList", voteCreateDao.getVoteList());	
		model.addAttribute("member_no", session.getAttribute("member_no"));
		model.addAttribute("team_no", team_no);


		//멤버 리스트 
		model.addAttribute("memberList",teamDao.memberList(team_no));
		
		//토픽 멤버리스트
		List<TopicMemberDto> topicMemberList = topicDao.topicMemberList(topic_no);
		model.addAttribute("topicMemberList", topicMemberList);
		
		//토픽 초대리스트
		List<TopicMemberDto> inviteTopicList = topicDao.inviteTopicList(team_no,topic_no);
		model.addAttribute("inviteTopicList", inviteTopicList);
		
		//팀 멤버 관련
		model.addAttribute("countTeamMember", teamDao.countTeamMember(team_no));
		
		//투두리스트 관련
		int member_no = (int)session.getAttribute("member_no");	
			//할일 목록 출력
			model.addAttribute("todoPerAll", todoListDao.todoPerAll(team_no,member_no));
			
			//할일 개수 출력
			model.addAttribute("countTodo", todoListDao.countTodo(team_no, member_no));
			
			//완료 개수 출력
			model.addAttribute("countDone", todoListDao.countDone(team_no, member_no));
			



			
		return "chat/topic_main";
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
	

	@Autowired
	private TeamService teamService;
	
	@GetMapping("/topic")
	public String topic(@RequestParam int team_no,
						Model model) {
		int topic_no = topicDao.teamTopicFirst(team_no);
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("team_no", team_no);
		model.addAttribute("topic_no", topic_no);
		
		return "redirect:./topic_main";
	}

	//중복검사
	@GetMapping("/topic_namecheck")
	@ResponseBody
	public String topic_name_check(@ModelAttribute TopicRestVO topicRestVo) {

		int count = sqlSession.selectOne("topic.nameCheck",topicRestVo);

		if(count>0) return "Y";
		else return "N";
		
	}

	//소희 : 멤버 초대 이메일 전송하는 컨트롤러 
	@PostMapping("/topic_main")
	public String topic_main(@RequestParam String cert_email,
							@RequestParam int team_no,
							@RequestParam int topic_no) throws MessagingException{ 
	
	teamEmailService.sendConfirmMessage(cert_email,team_no,topic_no);
	return "redirect:../chat/topic_main?team_no="+team_no+"&topic_no="+topic_no;	
}
	
	//이메일 수신 결과 컨트롤러
	@GetMapping("/email_result")
	@ResponseBody
	public String email_result() {
	return "chat/email_result";
}
	
	//이메일 링크를타고 들어오는 페이지
	@GetMapping("/invite_success")
	public String invite_success(@RequestParam String cert_email,
							@RequestParam String cert_no,
							@RequestParam int team_no,
							@RequestParam int topic_no,
							Model model, HttpServletResponse response) {
//필요한 작업 
// - 사용자가 이메일에서 링크를 누르면 이곳으로 들어온다 
// - 들어오면서 정상적인 링크라면 cert_no라는 파라미터와 member_email이라는 파라미터를 가지고 온다 
// - 위의 두 파라미터를 받아서 DB에 검증을 실시 
// - 위의 인증결과와 무관하게 해당 이메일의 인증정보를 모두 삭제 
//	model.addAttribute("teamDto",teamDto.getTeam_name());
//	teamDto.getTeam_name();
	
	//뷰에 데이터 출력하기 
	model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		
	boolean enter = teamCertDao.check3(cert_email,cert_no);
//	teamCertDao.delete(member_email);
	if(!enter) {
		//team_cert에 데이터가 확인되지 않을 경우 에러 코드 송출
		//다시 같은 페이지 재접속 방지를 위해서
		response.setStatus(403);
		return "chat/invite_expired";
		}else {	//정확한 주소로 잘 들어왔다면 DB team_cert에 데이터 삭제후 중복접속 방지 / 그리고 성공 페이지로(confirm2)페이지로 이동
				teamCertDao.delete(cert_email);	
				return "chat/invite_success";
		}	
}
		
	//이메일 초대로유저 로그인창
	@GetMapping("/invite_signin")
	public String invite_signin(@RequestParam String team_no,
							    @RequestParam String topic_no,
							    Model model) {

	model.addAttribute("team_no",team_no);
	model.addAttribute("topic_no",topic_no);
		return "chat/invite_signin";
}
		
	//이메일 초대 유저 로그인 하기 
	@PostMapping("/invite_signin")
	public String invite_signin(@RequestParam String member_email,
				   				@RequestParam String member_pw,
				   				@RequestParam String team_no,
				   				@RequestParam String topic_no,
				   				HttpSession session, Model model) {
		//회원 정보가 확인되면 로그인 됨
		MemberDto memberDto = memberDao.signin(member_email,member_pw); 
			if(memberDto != null) {
				session.setAttribute("member_email", memberDto.getMember_email());
				session.setAttribute("member_no", memberDto.getMember_no());
				session.setAttribute("member_grade", memberDto.getMember_grade());
				model.addAttribute("topic_no", topic_no);
				model.addAttribute("team_no", team_no);
				return "redirect:./team_member_regist";
			}
		else {	//회원정보가 없다면 회원가입 페이지로
			return "redirect:./invite_signup";
		}
}

	//이메일 링크를 통해 들어왔을 때 회원가입
	@GetMapping("/invite_signup")
	public String invite_signup(@RequestParam String cert_email,
								@RequestParam String team_no,
								@RequestParam String topic_no,
								Model model) {
	model.addAttribute("cert_email",cert_email);
	model.addAttribute("team_no",team_no);
	model.addAttribute("topic_no",topic_no);
		return "chat/invite_signup";
}
		
	//링크 회원가입 버튼 누르기 
	@PostMapping("/invite_signup")
	public String invite_signup(@RequestParam String team_no,
								@RequestParam String topic_no,
								@ModelAttribute MemberDto memberDto,
								@RequestParam MultipartFile file,
								Model model) throws IllegalStateException, IOException {
			
	model.addAttribute("team_no", team_no);
	model.addAttribute("topic_no", topic_no);
	MemberProfileDto memberProfileDto = MemberProfileDto.builder().member_profile_uploadname(file.getOriginalFilename()).member_profile_filesize(file.getSize()).build();
	memberDao.signup(memberDto, memberProfileDto, file);
		return "redirect:./invite_signin";
}

	//팀 멤버로 등록하는 페이지 접속
	@GetMapping("/team_member_regist")
	public String team_member_regist(@RequestParam int team_no,
									@RequestParam int topic_no,
									Model model) {
	model.addAttribute("topic_no", topic_no);
	model.addAttribute("team_no", team_no);
		return "chat/team_member_regist";
}
		
	//가입하기 버튼 누른 후 기존 멤버인지 중복검사하는 곳 
	@PostMapping("/team_member_check")
	public String team_member_check(@ModelAttribute TeamMemberDto teamMemberDto,
									@RequestParam int team_no,
									@RequestParam int topic_no,
									HttpSession session, Model model) {
	model.addAttribute("team_no", team_no);
	model.addAttribute("topic_no", topic_no);
	int member_no = (int) session.getAttribute("member_no");

			boolean enter = teamDao.teamMemberCheck(member_no, team_no);
			if(!enter) { //db에 데이터가 확인되지 않을 경우 / db에 등록됨 
		         //팀멤버로 추가
		         teamDao.teamMemberCreate2(member_no, team_no);
		         //토픽 멤버추가 
		        TopicMemberDto topicMemberDto = TopicMemberDto.builder()
		                                 .member_no((int) session.getAttribute("member_no"))
		                                 .team_no(team_no)
		                                 .topic_no(topic_no)
		                                 .build();
		        
			    
		    //담은 디티오에 반환 
		        topicDao.mailInviteTopic(topicMemberDto);
		    

		      return "redirect:../chat/topic_main";
		}else { //db에 데이터가 확인 될 경우 / 회원 리스트 보여줌 
			  return "redirect:../member/mypage";
		}

}

	
	
	

//
//		model.addAttribute("team_no", team_no);
//
//		return "chat/todo_list_create";
//}



	
		//토픽 정보변경(토픽소유자만)
		@PostMapping("/edittopic")
		public String editTopic(@ModelAttribute TopicDto topicDto, @RequestParam int team_no) {
			topicDao.editTopic(topicDto);
			return "redirect:/chat/topic_main?team_no="+team_no+"&topic_no="+topicDto.getTopic_no();
		}
		
		//토픽소유자 나가기(선택멤버 토픽소유자로 변경하고 나가기)
		@PostMapping("/topic_masterchange")
		public String topicMasterChange(@RequestParam int team_no, 
																	@RequestParam int topic_no, 
																	@RequestParam int member_no,
																	HttpSession session,
																	Model model) {
			topicDao.topicMasterChange(topic_no,member_no);
			topicDao.outTopic(topic_no, (int)session.getAttribute("member_no"));
			model.addAttribute("team_no", team_no);
			model.addAttribute("member_no", member_no);
			model.addAttribute("topic_no",topic_no);
			return "redirect:/member/mypage";
		}
		
		
		//토픽멤버 나가기(토픽소유자 제외)
		@GetMapping("/outtopic")
		public String outTopic(@RequestParam int topic_no, 
												@RequestParam(defaultValue="") int team_no,
												HttpSession session,
												Model model) {
			topicDao.outTopic(topic_no, (int)session.getAttribute("member_no"));
			model.addAttribute("team_no", team_no);
			model.addAttribute("topic_no",topic_no);
			return "redirect:/member/mypage";//팀의 다른 토픽 또는 기본토픽으로 이동
		}
		
		

		//토픽 초대(같은 토픽에 참여하고있지 않은 팀 리스트)
		@PostMapping("/invitetopic")
		public String topicInvite(@RequestParam List<Integer> member_no, 
													@RequestParam int team_no, 
													@RequestParam int topic_no,
													Model model) { 
			topicDao.inviteMember(member_no, team_no, topic_no);
			model.addAttribute("team_no",team_no);
			model.addAttribute("topic_no",topic_no);
			
			return "redirect:/chat/topic_main";
			
		}

		
		
		//토픽 삭제
		@GetMapping("/deletetopic")
		public String deletetopic(@RequestParam int topic_no,
													@RequestParam int team_no, 
													HttpSession session,
													Model model) {
			topicDao.deleteTopic(topic_no,team_no);
			topicDao.outTopic(topic_no, (int)session.getAttribute("member_no"));
			model.addAttribute("team_no",team_no);
			model.addAttribute("topic_no",topic_no);
			model.addAttribute("member_no",session.getAttribute("member_no"));
			return "redirect:/chat/topic_main";//팀의 다른 토픽 또는 기본토픽으로 이동
		}
		
		@PostMapping("fileupload")
		@ResponseBody
		public int fileupLoad(@RequestParam MultipartFile file,
								@ModelAttribute ChatFileVo chatFileVo,
								HttpSession	session) throws IllegalStateException, IOException {
			int chat_no = sqlSession.selectOne("chat.getSequence");
			ChatVo chatVo = ChatVo.builder().chat_no(chat_no).topic_no(chatFileVo.getTopic_no())
					.member_no(chatFileVo.getMember_no()).team_no(chatFileVo.getTeam_no())
					.member_no((int)session.getAttribute("member_no")).chat_content(file.getOriginalFilename()).status(4).build();
			
			sqlSession.insert("chat.insert", chatVo);

			int chat_file_no = sqlSession.selectOne("chat.getFileSequence");
			chatFileVo.setChat_file_no(chat_file_no);
			chatFileVo.setChat_no(chat_no);
			chatFileVo.setMember_no((int)session.getAttribute("member_no"));
			chatFileVo.setChat_file_uploadname(file.getOriginalFilename());
			chatFileVo.setChat_file_size(file.getSize());
			
			chatDao.chatFileUpload(chatFileVo, file);
			
			return chatFileVo.getChat_file_no();
		}
		
		@GetMapping("/download")
		   public void download(@RequestParam int chat_no,
		         HttpServletResponse resp) throws IOException {
		      ChatFileVo chatFileVo = sqlSession.selectOne("chat.chatImagePreview", chat_no);
		      
		      File target = new File("D:/upload/kh2e/chatFile",String.valueOf(chatFileVo.getChat_file_no()));
		      byte[] data = FileUtils.readFileToByteArray(target);
		      
		      resp.setHeader("Content-Type", "application/octet=stream; charset=UTF-8");
		      resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(chatFileVo.getChat_file_uploadname(), "UTF-8")+"\"");
		      resp.setHeader("Content-Length", String.valueOf(chatFileVo.getChat_file_size()));

		      resp.getOutputStream().write(data);
		   }
		
		@GetMapping("filedownload")
		@ResponseBody
		public ResponseEntity<ByteArrayResource> download(@RequestParam int chat_file_no) throws IOException{
			ChatFileVo chatFileVo = chatDao.chatFileDownload(chat_file_no);
			byte[] data = chatDao.getUploadNo(chatFileVo.getChat_file_no());
			ByteArrayResource resource = new ByteArrayResource(data);
			return ResponseEntity.ok()
					.contentType(MediaType.APPLICATION_OCTET_STREAM)
					.contentLength(chatFileVo.getChat_file_size())
					.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
					.header(HttpHeaders.CONTENT_DISPOSITION, 
							makeDispositionString(chatFileVo.getChat_file_uploadname()))
					.body(resource);
		}
		
		private String makeDispositionString(String fileUploadName) throws UnsupportedEncodingException {
			StringBuffer buffer= new StringBuffer();
			buffer.append("attachment;");
			buffer.append("filename=");
			buffer.append("\"");
			buffer.append(URLEncoder.encode(fileUploadName,"UTF-8"));
			buffer.append("\"");
			
			return buffer.toString();
		
	}

}

