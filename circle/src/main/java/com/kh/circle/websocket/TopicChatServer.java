package com.kh.circle.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.circle.vo.ChatVo;

public class TopicChatServer extends TextWebSocketHandler{
	
	private Map<Integer,Room> roomList = new HashMap<>();
	
	public static final int enter = 0;
	public static final int exit = 1;
	public static final int mess = 2;
	
	private ObjectMapper mapper = new ObjectMapper();


	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		ChatVo data = mapper.readValue(payload, ChatVo.class);
		int status = data.getStatus();
		
		if(status==enter) {
			int topic_no = data.getTopic_no();
			boolean exist = roomList.containsKey(topic_no);
			if(!exist) {
				Room room = new Room();
				roomList.put(topic_no, room);
			}
			
			roomList.get(topic_no).add(session);
		} else if (status == exit) {
			int topic_no = data.getTopic_no();
			roomList.get(topic_no).remove(session);
			if(roomList.get(topic_no).isEmpty()) {
				roomList.remove(topic_no);
			}
		} else if(status == mess) {
			int topic_no = data.getTopic_no();
			roomList.get(topic_no).broadcast(session, data.getChat_content());
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
	}

	
}
