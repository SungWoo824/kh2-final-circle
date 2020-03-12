package com.kh.circle.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.circle.repository.ChatDao;

public class ChatInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	ChatDao chatDao;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int member_no = (int) session.getAttribute("member_no");
		int topic_no = Integer.parseInt(request.getParameter("topic_no"));
		
		if(!chatDao.isContainChatMember(member_no, topic_no)) {
			response.sendRedirect(request.getContextPath()+"/error/403");
			return false;
		}
		return true;
	}
	
}
