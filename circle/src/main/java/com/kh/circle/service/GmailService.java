package com.kh.circle.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class GmailService implements EmailService{

	@Autowired
	private JavaMailSender sender;
	
	@Override
	public String sendCertMessage(String email, String cert) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			String[] to = {email};
			message.setTo(to);
			message.setSubject("[Cricle] 본인 인증을 위한 이메일입니다.");
			message.setText("인증번호 : " + cert);
			sender.send(message);
			
			return "success";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
}
