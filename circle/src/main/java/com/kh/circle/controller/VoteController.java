package com.kh.circle.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;
import com.kh.circle.repository.VoteCreateDao;
import com.kh.circle.service.SeqService;
import com.kh.circle.vo.VoteVO;


@Controller
@RequestMapping("/chat")
public class VoteController {
	
	@Autowired
	private VoteCreateDao voteCreateDao;
	@Autowired
	private SeqService seqService;
	
	@GetMapping("/vote_detail")
	public String detail(@RequestParam("vote_create_no") int vote_create_no, Model model, HttpSession session) {
//		, @RequestParam("team_no") int team_no, @RequestParam("topic_no") int topic_no
		model.addAttribute("no", vote_create_no);
		model.addAttribute("voteDetail", voteCreateDao.getVoteDetail(vote_create_no));
		model.addAttribute("voteCategoryDetail", voteCreateDao.getVoteCategoryDetail(vote_create_no));
		model.addAttribute("member_no", session.getAttribute("member_no") );
		model.addAttribute("memberName", voteCreateDao.getMemberName((int) session.getAttribute("member_no")));
		model.addAttribute("compare", voteCreateDao.compare(vote_create_no,(int) session.getAttribute("member_no")));
		model.addAttribute("complete", voteCreateDao.complete(vote_create_no, (int) session.getAttribute("member_no")));
		model.addAttribute("status", voteCreateDao.status(vote_create_no));
		if(voteCreateDao.selectNullCheck(vote_create_no).size() != 0) {
			model.addAttribute("maxcount", voteCreateDao.maxcount(vote_create_no));			
		}
		return "chat/vote_detail";
	}
	
//	@GetMapping("/vote_list")
//	public String list(Model model, HttpSession session) {
//		model.addAttribute("voteList", voteCreateDao.getVoteList());	
//		model.addAttribute("member_no", session.getAttribute("member_no"));
//		return "chat/topic_main";
//	}
	
	@GetMapping("/vote_create")
	public String create(Model model, HttpSession session, @RequestParam("team_no") int team_no) {
		model.addAttribute("topicList", voteCreateDao.getTopicList());
		model.addAttribute("member_no", session.getAttribute("member_no"));
		return "chat/vote_create";
	}
	
	@PostMapping("/vote_create")
	public String create(@ModelAttribute VoteVO vote, HttpSession session, @RequestParam("team_no") int team_no, @RequestParam("topic_no") int topic_no) {
//		session.setAttribute("member_no", 21);
		int seq = seqService.getSequence();
		List<VoteCategoryDto> dto = vote.getCategory();
		VoteDto vdto = VoteDto.builder()
				.vote_create_title(vote.getVote_create_title())
				.vote_create_detail(vote.getVote_create_detail())
				.vote_create_plural(vote.getVote_create_plural())
				.vote_create_status(vote.getVote_create_status())
				.vote_create_date(vote.getVote_create_date())
				.vote_create_time(vote.getVote_create_time())
				.vote_create_topic(vote.getVote_create_topic())
				.vote_create_userno((int) session.getAttribute("member_no"))
				.vote_create_team_no(team_no)
				.build();	
		voteCreateDao.create(vdto, seq);
		for(VoteCategoryDto vcdto : dto) {
			voteCreateDao.createCategory(vcdto, seq);
		}
		return "redirect:./topic_main?team_no="+team_no+"&topic_no="+topic_no;
	}
	
	@GetMapping("/voteselect")
	public String selection(@RequestParam("member_no") int member_no, @RequestParam("vote_create_no") int vote_create_no, @RequestParam("vote_category_content") String content, @RequestParam("vote_select_true") String selection, @RequestParam("member_name") String name, @RequestParam("team_no") int team_no, @RequestParam("topic_no") int topic_no) {
		
		voteCreateDao.selection(member_no, vote_create_no, content, selection, name);
		
//		return "redirect:./detail?vote_create_no="+vote_create_no;
		return "redirect:./vote_result?member_no="+member_no+"&team_no="+team_no+"&topic_no="+topic_no+"&vote_create_no="+vote_create_no;	
	}
	
	@GetMapping("/vote_result")
	public String result(@RequestParam("vote_create_no") int vote_create_no, HttpSession session, Model model, @RequestParam("member_no") int member_no, @RequestParam("team_no") int team_no, @RequestParam("topic_no") int topic_no) {
//		voteCreateDao.compare(member_no);
//		model.addAttribute("compare", voteCreateDao.compare(member_no));
//		System.out.println(voteCreateDao.compare(member_no));
		model.addAttribute("no", vote_create_no);
		model.addAttribute("voteDetail", voteCreateDao.getVoteDetail(vote_create_no));
		model.addAttribute("voteCategoryDetail", voteCreateDao.getVoteCategoryDetail(vote_create_no));
		model.addAttribute("member_no", session.getAttribute("member_no") );
		model.addAttribute("memberName", voteCreateDao.getMemberName((int) session.getAttribute("member_no")));
		model.addAttribute("compare", voteCreateDao.compare(vote_create_no,(int) session.getAttribute("member_no")));
		model.addAttribute("status", voteCreateDao.status(vote_create_no));
		if(voteCreateDao.selectNullCheck(vote_create_no).size() != 0) {
			model.addAttribute("maxcount", voteCreateDao.maxcount(vote_create_no));			
		}	
		return "chat/vote_result";
	}
	
	@GetMapping("/closevote")
	public String close(HttpSession session, @RequestParam("vote_create_no") int a, @RequestParam("team_no") int c, @RequestParam("topic_no") int d) {
		
		voteCreateDao.close(a);
		return "redirect:./vote_result?vote_create_no="+a+"&member_no="+session.getAttribute("member_no")+"&team_no="+c+"&topic_no="+d;
	}
}
