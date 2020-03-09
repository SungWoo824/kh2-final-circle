package com.kh.circle.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.circle.repository.PayDao;
import com.kh.circle.repository.TeamDao;
import com.kh.circle.service.PayService;
import com.kh.circle.vo.CirclePayReadyReturnVO;
import com.kh.circle.vo.CirclePaySuccessReadyVO;
import com.kh.circle.vo.CirclePaySuccessReturnVO;
import com.kh.circle.vo.PayReadyVO;
import com.kh.circle.vo.PayRevokeReturnVO;

@Controller
@RequestMapping("/pay")
public class PayController {
	
	@Autowired
	private PayService payService;
	
	@GetMapping("/pay_detail")
	public String pay_detail() {
		return "pay/pay_detail";
	}
	
	@PostMapping("/pay_detail")
	public String pay_detail(@ModelAttribute PayReadyVO vo, HttpSession session, Model model) throws URISyntaxException {
		CirclePayReadyReturnVO result = payService.ready(vo);
		session.setAttribute("tid", result.getTid());//trade id 를 전달
		session.setAttribute("ready", vo);//결제 요청정보를 전달
		model.addAttribute("member_email", session.getAttribute("member_email"));
		
		return "redirect:" + result.getNext_redirect_pc_url();
	}
	@GetMapping("/success")
	public String success(@RequestParam String pg_token, HttpSession session, Model model) throws URISyntaxException {
		String tid = (String) session.getAttribute("tid");
		PayReadyVO vo = (PayReadyVO)session.getAttribute("ready");
		
		CirclePaySuccessReadyVO data = CirclePaySuccessReadyVO.builder()
															.cid("TC0ONETIME")
															.tid(tid)
															.partner_order_id(vo.getPartner_order_id())
															.partner_user_id(vo.getPartner_user_id())
															.pg_token(pg_token)
															.price(vo.getPrice())
															.term(vo.getTerm())
														.build();
		CirclePaySuccessReturnVO result = payService.approve(data);
		
		session.removeAttribute("tid");
		session.removeAttribute("ready");
		model.addAttribute("result", result);
		
		return "pay/success";
	}
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private TeamDao teamDao;
	
	@GetMapping("/list")
	public String list(Model model, HttpSession session,@RequestParam(value="aid", defaultValue = "0") String aid, @RequestParam String team_name, @RequestParam int team_no, @RequestParam String team_domain) {
		model.addAttribute("list", payDao.getList());
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		model.addAttribute("status", payDao.checkStatus(aid));
		return "pay/list";
	}
	
	@GetMapping("/revoke")
	public String revoke(@RequestParam String team_name,
								@RequestParam int team_no,
								@RequestParam String team_domain,
								@RequestParam int no, Model model) throws URISyntaxException {
		
		PayRevokeReturnVO vo = payService.revoke(no);
		String aid = vo.getAid();
		return "redirect:../plan/list?team_no="+team_no+"&team_name="+team_name+"&team_domain="+team_domain+"&aid="+aid;
	}
}
