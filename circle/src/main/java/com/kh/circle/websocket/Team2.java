//package com.kh.circle.websocket;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//
//import com.kh.circle.vo.ChatVo;
//
//public class Team2 {
//	//방에 접속한 사용자 목록
//	private Map<Integer,Topic> topicList = new HashMap<>();
//	
//	//방에 있는 인원에게 메시지를 전송하는 메소드
//	public void broadcast(WebSocketSession user, ChatVo data) throws IOException {
//		String id = (String) user.getAttributes().get("member_email");
//		TextMessage message = new TextMessage("["+id+"] "+text);
//		
//		for(WebSocketSession session : userList) {
//			session.sendMessage(message);
//		}
//	}
//
//	//방 인원수를 알려주는 메소드
//	public int count() {
//		return userList.size();
//	}
//	
//	//방이 비어있는지를 확인하는 메소드
//	public boolean isEmpty() {
//		return count() == 0;
//	}
//	
//	@Override
//	public String toString() {
//		return "[count = "+count()+"]";
//	}
//}

//package com.kh.circle.websocket;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.Map;
//import java.util.Set;
//
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import com.kh.circle.vo.ChatVo;
//
//public class Team extends TextWebSocketHandler{
//	private Map<Integer,Topic> topicList = new HashMap<>();
//	
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		
//	}
//
//	//방에 신규인원을 추가하는 메소드
//	public void add(WebSocketSession session) throws IOException {
//		ChatVo chatVo = ChatVo.builder().chat_content("접속").build();
//		topicList.get(chatVo.getTopic_no()).add(session);
//		topicList.get(chatVo.getTopic_no()).broadcast(session, chatVo.getChat_content());
//		
//	}
//	
//	//방에 있는 인원을 삭제하는 메소드
//	public void remove(WebSocketSession session) throws IOException {
//		ChatVo chatVo = ChatVo.builder().chat_content("접속 종료").build();
//		topicList.get(chatVo.getTopic_no()).add(session);
//		topicList.get(chatVo.getTopic_no()).broadcast(session, chatVo.getChat_content());
//	}
//	
//	//방에 있는 인원에게 메시지를 전송하는 메소드
//	public void broadcast(WebSocketSession user, ChatVo chatVo) throws IOException {
//		topicList.get(chatVo.getTopic_no()).add(user);
//		String id = (String) user.getAttributes().get("member_email");
//		TextMessage message = new TextMessage("["+id+"] "+chatVo.getChat_content());
//		topicList.get(topic_no).broadcast(session, data.getChat_content());
//		for(WebSocketSession session : userList) {
//			session.sendMessage(message);
//		}
//	}
//
//	//방 인원수를 알려주는 메소드
//	public int count() {
//		return topicList.size();
//	}
//	
//	//방이 비어있는지를 확인하는 메소드
//	public boolean isEmpty() {
//		return count() == 0;
//	}
//	
//	@Override
//	public String toString() {
//		return "[count = "+count()+"]";
//	}
//}
