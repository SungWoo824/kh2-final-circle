package com.kh.circle.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.circle.repository.ChatDao;
import com.kh.circle.vo.ChatVo;

public class TeamServer extends TextWebSocketHandler{
	
	private Map<Integer,Team> teamList = new HashMap<>();
	
	public static final int enter = 0;
	public static final int exit = 1;
	public static final int mess = 2;
	
	private ObjectMapper mapper = new ObjectMapper();

	@Autowired
	private ChatDao chatDao;

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		ChatVo data = mapper.readValue(payload, ChatVo.class);
		int status = data.getStatus();
		
		if(status==enter) {
			int team_no = data.getTeam_no();
			boolean exist = teamList.containsKey(team_no);
			if(!exist) {
				Team room = new Team();
				teamList.put(team_no, room);
			}
			teamList.get(team_no).add(session,data);
		} else if (status == exit) {
			int team_no = data.getTeam_no();
			teamList.get(team_no).remove(session, data);
			if(teamList.get(team_no).isEmpty()) {
				teamList.remove(team_no);
			}
		} else if(status == mess) {
			int team_no = data.getTeam_no();
			data.setMember_no((int)session.getAttributes().get("member_no"));
			chatDao.chatDataSave(data);
			
			teamList.get(team_no).broadcast(session, data);
			teamList.get(team_no).count(session, data);
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
	}

	
}
