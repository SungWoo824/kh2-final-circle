package com.kh.circle.websocket;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

public class Topic {
	//방에 접속한 사용자 목록
		private Set<WebSocketSession> userList = new HashSet<>();
	
		//방에 신규인원을 추가하는 메소드
		public void add(WebSocketSession session) throws IOException {
			userList.add(session);
			
		}
		
		//방에 있는 인원을 삭제하는 메소드
		public void remove(WebSocketSession session) throws IOException {
			userList.remove(session);
			
		}
		
		//방에 있는 인원에게 메시지를 전송하는 메소드
		public void broadcast(WebSocketSession user, String text) throws IOException {
			String id = (String) user.getAttributes().get("member_name");
			TextMessage message = new TextMessage("["+id+"] "+text);
			int count = 1;
			for(WebSocketSession session : userList) {
				session.sendMessage(message);
			}
			for(WebSocketSession session : userList) {
				
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
