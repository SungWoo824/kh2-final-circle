package com.kh.circle.service;

import javax.mail.MessagingException;

public interface TeamEmailService {

	String sendInviteMessage(String cert_email , String cert_no);

	void sendConfirmMessage(String cert_email,int team_no, int topic_no) throws MessagingException;

}
