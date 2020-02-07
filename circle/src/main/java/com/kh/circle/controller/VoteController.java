package com.kh.circle.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.circle.entity.VoteCategoryDto;
import com.kh.circle.entity.VoteDto;
import com.kh.circle.repository.VoteCreateDao;
import com.kh.circle.service.SeqService;
import com.kh.circle.vo.VoteVO;


@Controller
@RequestMapping("/vote")
public class VoteController {
	
	@Autowired
	private VoteCreateDao voteCreateDao;
	
	@Autowired
	private SeqService seqService;
	
	@GetMapping("/detail")
	@ResponseBody
	public String detail(@RequestParam("vote_create_no") String vote_create_no) {
		return "vote/detail?vote_create_no="+vote_create_no;
	}
	
	@GetMapping("/list")
	public String list(Model model) {
//		List<voteDto>voteList = voteCreateDao.getVoteList();
		model.addAttribute("voteList", voteCreateDao.getVoteList());
		System.out.println(voteCreateDao.getVoteList());
		return "vote/list";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("topicList", voteCreateDao.getTopicList());
		return "vote/create";
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute VoteVO vote, HttpSession session) {
		session.setAttribute("member_no", 1);
		int seq = seqService.getSequence();
		List<VoteCategoryDto> dto = vote.getCategory();
		VoteDto vdto = VoteDto.builder()
				.vote_create_title(vote.getVote_create_title())
				.vote_create_detail(vote.getVote_create_detail())
				.vote_create_anonymous(vote.getVote_create_anonymous())
				.vote_create_plural(vote.getVote_create_plural())
				.vote_create_status(vote.getVote_create_status())
				.vote_create_date(vote.getVote_create_date())
				.vote_create_time(vote.getVote_create_time())
				.vote_create_topic(vote.getVote_create_topic())
				.vote_create_userno((int) session.getAttribute("member_no"))
				.build();	
		voteCreateDao.create(vdto, seq);
		for(VoteCategoryDto vcdto : dto) {
			voteCreateDao.createCategory(vcdto, seq);
		}

		return "redirect:./list";
	}
}