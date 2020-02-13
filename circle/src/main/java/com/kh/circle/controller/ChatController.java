package com.kh.circle.controller;


import java.util.List;
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
import com.kh.circle.repository.TopicDao;
import com.kh.circle.repository.VoteCreateDao;
import com.kh.circle.service.TeamService;

import com.kh.circle.vo.TopicRestVO;


import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/chat")
public class ChatController {

	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private VoteCreateDao voteCreateDao;
	@Autowired
	private SqlSession sqlSession;

	@GetMapping("/chat")
	public String chat(@RequestParam int topic_no) {
		
		return "chat/chat";
	}

	@GetMapping("/topic_main")
	public String topic_main(@RequestParam int team_no,
							@RequestParam int topic_no,
							Model model, HttpSession session) {
		List<TopicDto> topicList = teamService.teamTopicList(team_no);
		
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("topicList", topicList);
		//투표기능관련 코드
		model.addAttribute("voteList", voteCreateDao.getVoteList());	
		model.addAttribute("member_no", session.getAttribute("member_no"));
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
	

	@Autowired
	private TeamService teamService;
	
	@GetMapping("/topic")
	public String topic(@RequestParam int topic_no,
						@RequestParam int team_no,
						Model model) {
		
		model.addAttribute("topicDto", topicDao.topicChange(topic_no));
		model.addAttribute("team_no", team_no);
		model.addAttribute("topic_no", topic_no);

		return "redirect:./topic_main";
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

	
	
}
