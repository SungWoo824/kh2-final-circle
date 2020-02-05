package com.kh.circle.service;

import javax.mail.MessagingException;

public interface TeamEmailService {

	String sendInviteMessage(String email, String cert_no);

	void sendConfirmMessage(String member_email) throws MessagingException;

}
