package com.kh.circle.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ManagerAuthInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Object member_grade = session.getAttribute("member_grade");
		
		if(member_grade==null) {
			response.sendRedirect(request.getContextPath()+"/member/signin");
			return false;
		}
		
		return true;
	}

	
}
