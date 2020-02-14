package com.kh.circle.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.circle.vo.ChatVo;

public class Team{
	private Map<Integer,Topic> topicList = new HashMap<>();
	
	//방에 신규인원을 추가하는 메소드
	public void add(WebSocketSession session, ChatVo chatVo) throws IOException {
		Topic topic = new Topic();
		boolean exist = topicList.containsKey(chatVo.getTopic_no());
		if(!exist) {
			Topic room = new Topic();
			topicList.put(chatVo.getTopic_no(), room);
		}
		topicList.get(chatVo.getTopic_no()).add(session);
		
		
	}
	
	//방에 있는 인원을 삭제하는 메소드
	public void remove(WebSocketSession session, ChatVo chatVo) throws IOException {
		topicList.get(chatVo.getTopic_no()).remove(session);
		if(topicList.get(chatVo.getTopic_no()).isEmpty()) {
			topicList.remove(chatVo.getTopic_no());
		}
	}
	
	//방에 있는 인원에게 메시지를 전송하는 메소드
	public void broadcast(WebSocketSession user, ChatVo chatVo) throws IOException {
		
		topicList.get(chatVo.getTopic_no()).broadcast(user, chatVo.getChat_content());
	}

	//방 인원수를 알려주는 메소드
	public int count() {
		return topicList.size();
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