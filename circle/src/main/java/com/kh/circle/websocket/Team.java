package com.kh.circle.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.WebSocketSession;

import com.kh.circle.repository.ChatDao;
import com.kh.circle.repository.TopicDao;
import com.kh.circle.vo.ChatVo;

public class Team{
	private Map<Integer,Topic> topicList = new HashMap<>();
	
	@Autowired
	private TopicDao topicDao;
	@Autowired
	private ChatDao chatDao;
	//방에 신규인원을 추가하는 메소드
	public void add(WebSocketSession session, ChatVo chatVo) throws IOException {
		
		List<Integer> containList = chatDao.memberContainTopic(chatVo);
		for(int topic_no : containList) {
			boolean exist = topicList.containsKey(topic_no);
			
			if(!exist) {
				Topic room = new Topic();
				topicList.put(chatVo.getTopic_no(), room);
			}
			
			topicList.get(chatVo.getTopic_no()).add(session);
		}
		
	}
	
	//방에 있는 인원을 삭제하는 메소드
	public void remove(WebSocketSession session, ChatVo chatVo) throws IOException {
		List<Integer> containList = chatDao.memberContainTopic(chatVo);
		for(int topic_no : containList) {
			topicList.get(topic_no).remove(session);
			
			if(topicList.get(topic_no).isEmpty()) {
				topicList.remove(topic_no);
			}
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
