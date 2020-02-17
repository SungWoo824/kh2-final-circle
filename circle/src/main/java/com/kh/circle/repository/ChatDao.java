package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.vo.ChatVo;

public interface ChatDao {
	void chatDataSave(ChatVo chatVo);
	List<ChatVo> topicChatList(int topic_no);
}
