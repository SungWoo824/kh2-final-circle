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
import com.kh.circle.service.PayService;
import com.kh.circle.vo.CirclePayReadyReturnVO;
import com.kh.circle.vo.CirclePaySuccessReadyVO;
import com.kh.circle.vo.CirclePaySuccessReturnVO;
import com.kh.circle.vo.PayReadyVO;

@Controller
@RequestMapping("/pay")
public class PayController {
	
	@Autowired
	private PayService payService;
	
	@GetMapping("/planoption")
	public String plan() {
		return "pay/planoption";
	}
	
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
		
		session.removeAttribute("tid");
		session.removeAttribute("ready");
		
		CirclePaySuccessReadyVO data = CirclePaySuccessReadyVO.builder()
															.cid("TC0ONETIME")
															.tid(tid)
															.partner_order_id(vo.getPartner_order_id())
															.partner_user_id(vo.getPartner_user_id())
															.pg_token(pg_token)
														.build();
		CirclePaySuccessReturnVO result = payService.approve(data);
		model.addAttribute("result", result);
		
		return "pay/success";
	}
	
	@Autowired
	private PayDao payDao;
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", payDao.getList());
		return "pay/list";
	}
}
