package com.kh.circle.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.circle.repository.TeamDao;

public class DriveInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	TeamDao teamDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int member_no = (int) session.getAttribute("member_no");
		int team_no = Integer.parseInt(request.getParameter("team_no"));
		
		if(!(teamDao.teamMemberCheck(member_no, team_no))) {
			response.sendRedirect(request.getContextPath()+"/error/403");
			return false;
		}
		
		return true;
	}


	
}
