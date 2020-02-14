package com.kh.circle.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.kh.circle.vo.ChatVo;

public class Team {
	private Set<WebSocketSession> userList = new HashSet<>();
	
	//방에 신규인원을 추가하는 메소드
	public void add(WebSocketSession session) throws IOException {
		userList.add(session);
		ChatVo chatVo = ChatVo.builder().chat_content("접속").build();
		broadcast(session, chatVo);
	}
	
	//방에 있는 인원을 삭제하는 메소드
	public void remove(WebSocketSession session) throws IOException {
		userList.remove(session);
		ChatVo chatVo = ChatVo.builder().chat_content("접속 종료").build();
		broadcast(session, chatVo);
	}
	
	//방에 있는 인원에게 메시지를 전송하는 메소드
	public void broadcast(WebSocketSession user, ChatVo chatVo) throws IOException {
		String id = (String) user.getAttributes().get("member_email");
		TextMessage message = new TextMessage("["+id+"] "+chatVo.getChat_content());
		
		for(WebSocketSession session : userList) {
			session.sendMessage(message);
		}
	}

	//방 인원수를 알려주는 메소드
	public int count() {
		return userList.size();
	}
	
	//방이 비어있는지를 확인하는 메소드
	public boolean isEmpty() {
		return count() == 0;
	}
	
	@Override
	public String toString() {
		return "[count = "+count()+"]";
	}
}
