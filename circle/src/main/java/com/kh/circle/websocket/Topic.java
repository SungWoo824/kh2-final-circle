package com.kh.circle.websocket;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.circle.vo.ChatVo;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class Topic {
	//방에 접속한 사용자 목록
		private Set<WebSocketSession> userList = new HashSet<>();
	
		//방에 신규인원을 추가하는 메소드
		public void add(WebSocketSession session) throws IOException {
			userList.add(session);
			toString();
		}
		
		//방에 있는 인원을 삭제하는 메소드
		public void remove(WebSocketSession session) throws IOException {
			userList.remove(session);
			toString();
		}
		
		//방에 있는 인원에게 메시지를 전송하는 메소드
		public void broadcast(WebSocketSession user, ChatVo chatVo) throws IOException {
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(chatVo);
			TextMessage message = new TextMessage(json);
			
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
