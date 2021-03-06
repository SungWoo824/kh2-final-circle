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
import com.kh.circle.repository.TeamDao;



@Service
public class TeamEmailServiceImpl implements TeamEmailService {
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private TeamCertDao teamCertDao;
	
	@Autowired
	private TeamDao teamDao;
	
	@Autowired
	private RandomService randomService;

	@Override
	public String sendInviteMessage(String cert_email,String cert_no) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			String[] to = {cert_email};
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
	public void sendConfirmMessage(String cert_email, int team_no, int topic_no) throws MessagingException {
		//랜덤 번호를 3자리 생성
		String cert_no = randomService.generateCertificationNumber(3);
		
		//DB에 랜덤번호 / 이메일 / 시간을 저장
		teamCertDao.regist(TeamCertDto.builder()
									    .cert_email(cert_email)
									    .cert_no(cert_no)
									  	.build());
		
		//이메일 전송 
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		helper.setTo(cert_email);
		helper.setSubject("[Cilcle]팀 멤버에 초대합니다");
		
		//주소 생성
//		String url = "http://localhost:8080/circle/chat/invite_success?cert_email="+cert_email&cert_no="+cert_no+";
		String url = ServletUriComponentsBuilder
						.fromCurrentContextPath()
						.port(8080)
						.path("/chat/invite_success")
						.queryParam("cert_email", cert_email)
						.queryParam("cert_no",cert_no)
						.queryParam("team_no",team_no)
						.queryParam("topic_no", topic_no)
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
