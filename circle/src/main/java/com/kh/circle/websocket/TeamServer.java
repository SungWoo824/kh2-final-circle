package com.kh.circle.websocket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.circle.repository.ChatDao;
import com.kh.circle.vo.ChatVo;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class TeamServer extends TextWebSocketHandler{
	
	private Map<Integer,Team> teamList = new HashMap<>();
	
	public static final int enter = 0;
	public static final int exit = 1;
	public static final int mess = 2;
	public static final int alert = 3;
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
			
			data.setMember_no((int)session.getAttributes().get("member_no"));
			data.setChat_content("");
			chatDao.chatDataSave(data);
			
			if(!exist) {
				Team room = new Team();
				teamList.put(team_no, room);
			}
			List<Integer> containList = chatDao.memberContainTopic(data.getMember_no(),data.getTeam_no());
			teamList.get(team_no).add(session,data,containList);
			
		} else if (status == exit) {
			int team_no = data.getTeam_no();
			data.setMember_no((int)session.getAttributes().get("member_no"));
			data.setChat_content("");
			
			List<Integer> containList = chatDao.memberContainTopic(data.getMember_no(),data.getTeam_no());
			teamList.get(team_no).remove(session, data, containList);
			chatDao.chatDataSave(data);
			if(teamList.get(team_no).isEmpty()) {
				teamList.remove(team_no);
			}
			
		} else if(status == mess) {
			int team_no = data.getTeam_no();
			data.setMember_name((String)session.getAttributes().get("member_name"));
			data.setMember_no((int)session.getAttributes().get("member_no"));
			chatDao.chatDataSave(data);
			List<Integer> containList = chatDao.memberContainTopic(data.getMember_no(),data.getTeam_no());
			
			teamList.get(team_no).broadcast(session, data, containList);
			
		}
	}
	

	
}
