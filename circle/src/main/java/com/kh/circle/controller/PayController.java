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
	//여기서 view로 파라미터를 보내서 다시 받아와야함
	public String pay_detail() {
		return "pay/pay_detail";
	}
	
	@PostMapping("/pay_detail")
	public String pay_detail(@ModelAttribute PayReadyVO vo, HttpSession session, Model model,
									@RequestParam int team_no,
									@RequestParam String team_name,
									@RequestParam String team_domain) throws URISyntaxException {
		CirclePayReadyReturnVO result = payService.ready(vo);
		session.setAttribute("tid", result.getTid());//trade id 를 전달
		session.setAttribute("ready", vo);//결제 요청정보를 전달
		model.addAttribute("member_email", session.getAttribute("member_email"));
		
		//주소 이동을 위한 세션값 저장
		session.setAttribute("team_no", team_no);
		session.setAttribute("team_name", team_name);
		session.setAttribute("team_domain", team_domain);
		
		return "redirect:" + result.getNext_redirect_pc_url();
	}
	@GetMapping("/fail")
	public String fail() {
		return "pay/fail";
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
		
		int team_no = (int) session.getAttribute("team_no");
		String team_name = (String) session.getAttribute("team_name");
		String team_domain = (String) session.getAttribute("team_domain");
		
		session.removeAttribute("team_no");
		session.removeAttribute("team_name");
		session.removeAttribute("team_domain");
		
		return "redirect:../plan/list?team_no="+team_no+"&team_name="+team_name+"&team_domain="+team_domain;
	}
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private TeamDao teamDao;
	
	@GetMapping("/list")
	public String list(Model model, HttpSession session, @RequestParam String team_name, @RequestParam int team_no, @RequestParam String team_domain) {
		model.addAttribute("list", payDao.list((String)session.getAttribute("member_email")));
		model.addAttribute("teamlist", teamDao.teamList((int)session.getAttribute("member_no")));
		model.addAttribute("teamDto", teamDao.teamDetail(team_no));
		
		return "pay/list";
	}
	
	@GetMapping("/revoke")
	public String revoke(@RequestParam String team_name,
								@RequestParam int team_no,
								@RequestParam String team_domain,
								@RequestParam int no, Model model) throws URISyntaxException {
		
		PayRevokeReturnVO vo = payService.revoke(no);
		payDao.changeStatus(no);
		return "redirect:../plan/list?team_no="+team_no+"&team_name="+team_name+"&team_domain="+team_domain;
	}
}
