package com.kh.circle.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import com.kh.circle.entity.TeamDto;
import com.kh.circle.entity.TopicDto;
import com.kh.circle.vo.ChatCountVo;

public interface TeamService {
	void create(TeamDto teamDto);
//	List<TopicDto> teamTopicList(int team_no);
	int timeDifference(int term) throws ParseException;
	List<TopicDto> teamTopicList(int team_no,int member_no);
	List<ChatCountVo> memberChatCount(int team_no,int member_no);

}
