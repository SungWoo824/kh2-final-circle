package com.kh.circle.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.circle.entity.TeamCertDto;
import com.kh.circle.repository.TeamCertDao;



@Service
public class TeamEmailServiceImpl implements TeamEmailService {
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private TeamCertDao teamCertDao;
	
	@Autowired
	private RandomService randomService;

	@Override
	public String sendInviteMessage(String member_email, String cert_no) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			String[] to = {member_email};
			message.setTo(to);
			message.setSubject("[Circle] 인증을 위한 이메일입니다.");
			message.setText("멤버로 초대합니다");
			sender.send(message);
			return "success";
		}
		catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@Transactional
	@Override
	public void sendConfirmMessage(String member_email) throws MessagingException {
		//랜덤 번호를 3자리 생성
		String cert_no = randomService.generateCertificationNumber(3);
		
		//DB에 랜덤번호 / 이메일 / 시간을 저장
		teamCertDao.regist(TeamCertDto.builder()
										.cert_no(cert_no)
									  .member_email(member_email)
									  	.build());
		//이메일 전송 
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		helper.setTo(member_email);
		helper.setSubject("[Cilcle]팀 멤버에 초대합니다");
		
		//주소 생성
//		String url = "http://localhost:8080/sts21/pw/change?cert_no="+cert_no+"&member_email="+member_email;
		String url = ServletUriComponentsBuilder
						.fromCurrentContextPath()
						.port(8080)
						.path("/team/confirm2")
						.queryParam("cert_no",cert_no)
						.queryParam("member_email", member_email)
						.toUriString();
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("<h1>초대가입을 위해 하단 링크를 누르세요<h1>");
		buffer.append("<h2>");
		buffer.append("<a href='");
		buffer.append(url);
		buffer.append("'>이동");
		buffer.append("</a>");
		buffer.append("</h2>");
		
		helper.setText(buffer.toString(), true);
		sender.send(message);
		
	}
	
}
