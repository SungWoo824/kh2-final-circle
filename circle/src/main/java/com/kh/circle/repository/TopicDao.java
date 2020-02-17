package com.kh.circle.repository;

import java.util.List;

import com.kh.circle.entity.TopicDto;
import com.kh.circle.entity.TopicMemberDto;
import com.kh.circle.vo.TopicRestVO;

public interface TopicDao {

	int getSequence();
	void topicCreate(TopicDto topicDto);
	void topicMemberInsert(TopicMemberDto topicMemberDto);
	int teamTopicFirst(int team_no);
	TopicDto topicChange(int topic_no);

	List<TopicMemberDto> topicMemberList(int topic_no);
	void editTopic(TopicDto topicDto);
	void outTopic(int topic_no,int member_no);
	void inviteTopic(TopicMemberDto topicMemberDto);
	void topicMasterChange(int topic_no, int member_no);
}
